# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pestelle <pestelle@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/27 13:07:29 by pestelle          #+#    #+#              #
#    Updated: 2024/05/27 13:27:14 by pestelle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Compiler and flags
CC          = cc
CFLAGS      = -Wall -Wextra -Werror -Ofast -fsanitize=address -g
DFLAGS      = -MMD -MF $(@:.o=.d)
UNAME       = $(shell uname)

# OS-specific flags
MLXFLAGS =
ifeq ($(UNAME), Darwin)
    MLXFLAGS += -framework Cocoa -framework OpenGL -framework IOKit
else ifeq ($(UNAME), Linux)
    MLXFLAGS += -ldl -lglfw -pthread -lm
endif

# Paths
SOURCES_PATH    = ./src
OBJECTS_PATH    = ./build
INCLUDE_PATH    = ./include
MLX_PATH        = ./libs/MLX42

# Files
PROGRAM     = fractol
MLX         = $(MLX_PATH)/build/libmlx42.a
HEADER      = $(INCLUDE_PATH)/fractor.h
SOURCES     = fractol.c
OBJECTS     = $(addprefix $(OBJECTS_PATH)/, $(SOURCES:.c=.o))
DEPENDENCIES = $(addprefix $(OBJECTS_PATH)/, $(SOURCES:.c=.d))

# Colors
YELLOW      = \033[0;33m
GREEN       = \033[0;32m
CYAN        = \033[0;36m
NO_COLOR    = \033[0m

# Targets
all: $(PROGRAM)

-include $(DEPENDENCIES)

$(PROGRAM): $(OBJECTS) $(MLX)
	@echo "$(CYAN)Linking $@$(NO_COLOR)"
	@$(CC) $(CFLAGS) $(DFLAGS) -I $(INCLUDE_PATH) $^ $(MLXFLAGS) -o $@
	@echo "$(GREEN)$@ Done$(NO_COLOR)"

$(MLX):
	@echo "$(YELLOW)Building $@$(NO_COLOR)"
	@cmake $(MLX_PATH) -B $(MLX_PATH)/build && make -C $(MLX_PATH)/build

$(OBJECTS_PATH)/%.o: $(SOURCES_PATH)/%.c $(HEADER) Makefile
	@echo "$(CYAN)Compiling $<$(NO_COLOR)"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(DFLAGS) -c $< -o $@ -I $(INCLUDE_PATH) -I $(MLX_PATH)/include

clean:
	@echo "$(YELLOW)Cleaning$(NO_COLOR)"
	@make $@ -C $(MLX_PATH)/build
	@rm -rf $(OBJECTS_PATH)

fclean: clean
	@echo "$(YELLOW)Full Clean$(NO_COLOR)"
	@rm -rf $(PROGRAM)

re: fclean all

.PHONY: all clean fclean re $(MLX)
