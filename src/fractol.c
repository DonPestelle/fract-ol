/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fractol.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: pestelle <pestelle@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/31 11:41:37 by pestelle          #+#    #+#             */
/*   Updated: 2024/05/31 12:27:18 by pestelle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "../include/fractol.h"

int main(int ac, char *av[])
{
	t_fractol	fractal;
	if ((2 == ac && !ft_strncmp(av[1], "mandebrot", 10)) 
			|| (4 == ac && !ft_strncmp(av[1], "julia", 5)))
	{
		fractal_init(&fractal);
		fractal_render(&fractal);
		mlx_loop(fractal.mlx_connection); mlx_ptr:
	}	

	else
	{
		putstr_fd(ERROR_MESSAGEm STDERR_FILENO);
		exit(EXIT_FAILURE);
	}
}
