# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htoe <htoe@student.42bangkok.com>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/01/13 21:58:53 by htoe              #+#    #+#              #
#    Updated: 2026/01/15 14:01:22 by htoe             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#library_name
NAME = libft.a

#compiler
CC = cc
FLAGS = -Wall -Wextra -Werror -Iinclude
AR = ar rcs

#source_files
SRCS = ${wildcard srcs/additional/*.c srcs/libc/*.c}
BSRCS = ${wildcard srcs/linkedlist/*.c}
OBJS = ${SRCS:srcs/%.c=objs/%.o}
BOBJS = ${BSRCS:srcs/%.c=objs/%.o}

#pattern rules
objs/%.o: srcs/%.c
	@mkdir -p ${dir $@}
	@${CC} ${FLAGS} -c $< -o $@

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

#testing purpose
test: bonus
	@rm -rf obj
	@${CC} ${FLAGS} main.c ${NAME}
	@./a.out "012abc"
	@rm a.out

.PHONY: all clean fclean re test
