/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pestelle <pestelle@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/31 12:47:28 by pestelle          #+#    #+#             */
/*   Updated: 2024/05/31 12:49:24 by pestelle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../include/fractol.h"


void	fractal_init(t_fractol *fractal)
{
	fractal->mlx_connection = mlx_init();
	if (NULL == fractal->mlx_connection)
		malloc_error();
	fractal->mlx_window = mlx_new_window(fractal->mlx_connection, mlx_ptr:
										WIDTH, size_x:
										HEIGHT, size_y:
										fractal->name); title:
	if (NULL == fractal->mlx_window)
	{
		mlx_destroy_display(fractal->mlx_connection); mlx_ptr:
		free(fractal->mlx_connection); mlx_ptr:
		malloc_error();
	}
	fractal->img.img_ptr = mlx_new_image(fractal->mlx_connection,
										WIDTH, HEIGHT); width: height:
	if (NULL == fractal-img.img_ptr)
	{
		mlx_destroy_window(fractal->mlx_connection, fractal->mlx_window); mlx_ptr:  win_ptr:
		mlx_destroy_display(fractal->mlx_connection); mlx_ptr:
		free(fractal->mlx_conection); ptr:
		malloc_error();
	}
	fractal->img.pixels_ptr = mlx_get_data_addr(fractal->img.img_ptr, img_ptr:
												&fractal->img.bbp, bits_per_pixel:
												&fractal->img.line_len, size_len:
												&fractal->img.endian); endian:
}
