#pragma once

#include <stdint.h>
#include <stddef.h>

enum
{
    BLACK = 0,
    RED = 1,
    GREEN = 2,
    BLUE = 3,
    GREY = 4,
    ORANGE = 5
};

void print_clear();
void print_char(char character);
void print_str(char *string);
void print_set_color(uint8_t foreground, uint8_t background);