/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fractol.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pestelle <pestelle@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/27 13:19:33 by pestelle          #+#    #+#             */
/*   Updated: 2024/05/31 12:31:01 by pestelle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FRACTOL_H
# define FRACTOL_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "MLX42/MLX42.h"
#include <math.h>
#include <unistd.h>
# define WITH_WINDOW 1042

typedef struct s_img {
	void	*img_ptr;
	char	*pixels_ptr;
	int		bpp;
	int		endian;
	int		line_len;
}				t_img;

typedef struct s_fractol
{
	//MLX
	void	*mlx_connection;
	void	*mlx_window;
	//IMG
	t_img	img;
}				t_fractol;

//***********************(FRACTOL.C)*************************//


//***********************(STR_UTILS.C)***********************//
int		ft_strncmp(char *s1, char *s2, int n);
void	putstr_fd(char *s, int fd);
#endif
