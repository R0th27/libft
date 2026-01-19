# libft

## Overview

**libft** is a handcrafted static C library that reimplements core components of the C standard library and extends them with higher-level utilities and a complete linked-list API.

Rather than focusing solely on API compatibility, this project emphasizes **low-level correctness, explicit memory ownership, and composable design**. Every function is written from scratch with careful attention to pointer semantics, allocation lifetimes, and predictable behavior.

This library is intended as a **foundational dependency** for larger C projects such as formatted output systems, file parsers, and data-structure–heavy applications.

---

## Project Structure

```bash

.
├── include
│   └── libft.h			# Public API
├── srcs
│   ├── libc			# Reimplementation of standard C functions
│   ├── additional		# Higher-level string and utility functions
│   └── linkedlist		# Bonus: generic linked list API
├── Makefile
├── README.md

```

The project follows a strict separation between **interface** (`include/`) and **implementation** (`srcs/`), enabling clean integration as a static library.

---

## Implemented Features

### 1. Libc Reimplementation

Located in `srcs/libc/`

#### Memory Handling

* `ft_memset`
* `ft_memcpy`
* `ft_memmove`
* `ft_memcmp`
* `ft_memchr`
* `ft_bzero`
* `ft_calloc`

#### String Handling

* `ft_strlen`
* `ft_strdup`
* `ft_strchr`
* `ft_strrchr`
* `ft_strncmp`
* `ft_strlcpy`
* `ft_strlcat`
* `ft_strnstr`

#### Character Classification

* `ft_isalpha`
* `ft_isdigit`
* `ft_isalnum`
* `ft_isascii`
* `ft_isprint`

#### Case Conversion

* `ft_toupper`
* `ft_tolower`

#### Conversion

* `ft_atoi`

> All functions are implemented **without calling their libc equivalents** (e.g. `strlen`, `memcpy`, etc.), except for allowed system calls such as `malloc`, `free`, and `write`.

---

### 2. Additional Utility Functions

Located in `srcs/additional/`

Higher-level helpers commonly required in real-world C projects:

* `ft_split` – string tokenization with full cleanup on partial failure
* `ft_strjoin`, `ft_strtrim`, `ft_substr`
* `ft_itoa`
* `ft_strmapi`, `ft_striteri`
* File-descriptor output helpers:

  * `ft_putchar_fd`
  * `ft_putstr_fd`
  * `ft_putendl_fd`
  * `ft_putnbr_fd`

These functions emphasize:

* Explicit heap allocation and ownership
* Single-responsibility logic
* Deterministic cleanup paths
* No hidden reallocations or side effects

---

### 3. Bonus: Linked List API

A generic singly-linked list implementation:

```c
typedef struct s_list
{
    void            *content;
    struct s_list   *next;
}   t_list;
```

Implemented operations:

#### Creation & Insertion

* `ft_lstnew`
* `ft_lstadd_front`
* `ft_lstadd_back`

#### Traversal & Size

* `ft_lstsize`
* `ft_lstlast`
* `ft_lstiter`

#### Memory Management

* `ft_lstdelone`
* `ft_lstclear`

#### Functional Mapping

* `ft_lstmap`

This module demonstrates:

* Advanced pointer usage (`t_list **`)
* Ownership transfer via function pointers
* Safe destruction patterns
* Failure-aware list transformations

---

### 4. Formatted Output (`ft_printf`)

A custom implementation of the standard `printf` function, designed as a reusable, self-contained formatting module and later integrated into `libft`.

Supported features include:

* Variadic argument handling (`<stdarg.h>`)
* Common conversion specifiers:
  `c`, `s`, `d`, `i`, `u`, `x`, `X`, `p`, `%`
* Direct output via the `write` system call
* Precise character counting and return-value semantics matching `printf`

The implementation is internally modular, with parsing, formatting, and output responsibilities clearly separated. Helper routines are kept private to the module and are not exposed through the public `libft` API.

> The full standalone implementation and development history are available in the dedicated [**ft_printf repository**](https://github.com/R0th27/ft_printf)

---

## Implementation Philosophy

### Design Decisions

* Functions assume **valid input unless specified otherwise**, matching standard libc behavior
* Undefined behavior is **not defensively guarded** unless required by the specification
* NULL handling is explicitly documented for higher-level helpers
* No global state is used
* Every heap allocation has a **single, well-defined owner**

---

### Internal Helpers Are Isolated and Purpose-Built

Complex routines are decomposed into **small, static helpers**, such as:

* `ft_countwords`
* `ft_copywords`
* `ft_free`

These helpers are:

* File-local (`static`)
* Non-exported
* Designed to reduce cognitive load
* Written to perform exactly one task

---

### Strings Construction with explicit length calculation

Functions such as `ft_itoa`, `ft_split`, and `ft_strjoin` are implemented using:

* Explicit length or digit counting
* Pre-sized allocations
* Stack-based temporary buffers where appropriate
* No recursion
* No intermediate heap allocations unless strictly necessary

This avoids unnecessary passes over data and keeps memory usage predictable.

---

## Usage

The Makefile supports:

* `make` — **libc** + **additional functions** only
* `make bonus` — **libc** + **additional** + **linked list** API

The build produces a **single static library**:

```
libft.a
```

Bonus objects are **additive**, not separate, ensuring:

* No symbol duplication
* Predictable linking behavior
* Seamless use as a dependency in external projects

---

## Key Technical Skills

* Manual memory management in C
* Pointer arithmetic and indirection
* API design with clear ownership semantics
* Static library creation and linkage
* Modular project organization
* Separation between interface and implementation
* Writing libc-compatible behavior without libc dependencies

---
