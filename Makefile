# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pestelle <pestelle@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/27 13:07:29 by pestelle          #+#    #+#              #
#    Updated: 2024/05/27 13:20:44 by pestelle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROGRAM = fractol
CC 		= cc
CFLAGS		= -Wall -Wextra -Werror -Ofast -fsanitize=address -g
DFLAGS		= -MMD -MF $(@:.o=.d)
UNAME 		= $(shell uname)

ifeq ($(UNAME), Darwin)
	MLXFLAGS = -framework Cocoa -framework OpenGL -framework IOKit
endif
ifeq ($(UNAME), Linux)
	MLXFLAGS = -ldl -lglfw -pthread -lm
endif

SOURCES_PATH	= ./src

OBJECTS_PATH 	= ./build

INCLUDE_PATH	= ./include

MLX_PATH    = ./libs/MLX42

MLX	=	$(MLX_PATH)/build/libmlx42.a

HEADER		= $(INCLUDE_PATH)/fractor.h

SOURCES = fractol.c

OBJECTS		= $(addprefix $(OBJECTS_PATH)/, ${SOURCES:.c=.o})

DEPENDENCIES		= $(addprefix $(OBJECTS_PATH)/, ${SOURCES:.c=.d})

all: $(PROGRAM) 

-include $(DEPENDENCIES)

$(PROGRAM):	$(OBJECTS) $(MLX)
			@$(CC) $(CFLAGS) $(DFLAGS) -I $(INCLUDE_PATH) $^ $(MLXFLAGS) -o $@
			@echo $@ Done

$(MLX):
			@echo Building $@
			@cmake $(MLX_PATH) -B $(MLX_PATH)/build && make -C $(MLX_PATH)/build 

$(OBJECTS_PATH)/%.o: 	$(SOURCES_PATH)/%.c $(HEADER) Makefile
			@echo Compiling $<
			@mkdir -p $(dir $@)
			@$(CC) $(CFLAGS) $(DFLAGS) -c $< -o $@ -I $(INCLUDE_PATH) -I $(MLX_PATH)/include

clean:
			@echo $@
			@make $@ -C $(MLX_PATH)/build 
			@rm -rf $(OBJECTS_PATH)

fclean:		clean
			@echo $@
			@rm -rf $(PROGRAM)

re:			fclean all

.PHONY:		all clean fclean re banner $(MLX)
