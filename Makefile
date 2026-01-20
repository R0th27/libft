# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htoe <htoe@student.42bangkok.com>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/01/13 21:58:53 by htoe              #+#    #+#              #
#    Updated: 2026/01/21 02:37:42 by htoe             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#library_name
NAME = libft.a

#compiler
CC = cc
CFLAGS = -Wall -Wextra -Werror -Iinclude
AR = ar rcs

#make CFLAGS+"-DBUFFER_SIZE=custom" for customize BUFFER_SIZE during gnl

#source_files
SRCS = ${wildcard srcs/additional/*.c srcs/libc/*.c srcs/ft_printf/*.c srcs/get_next_line/*.c}
BSRCS = ${wildcard srcs/linkedlist/*.c}
OBJS = ${SRCS:srcs/%.c=objs/%.o}
BOBJS = ${BSRCS:srcs/%.c=objs/%.o}

#pattern rules
objs/%.o: srcs/%.c
	@mkdir -p ${dir $@}
	@${CC} ${CFLAGS} -c $< -o $@

${NAME}: ${OBJS}
	@${AR} ${NAME} ${OBJS}

all: ${NAME}

#bonus rule
bonus: ${OBJS} ${BOBJS}
	@${AR} ${NAME} ${OBJS} ${BOBJS}

#cleaning up
clean:
	@rm -rf objs

fclean: clean
	@rm -f ${NAME}

re: fclean all

.PHONY: all clean fclean re bonus
