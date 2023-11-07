# Makefile for building list_bridges binary and moving it to bin directory

# Compiler and compiler flags
CC = cc
CFLAGS = -Wall -O2 -pipe

# Source and destination directories
SRCDIR = src
BINDIR = bin

# Target binary name
TARGET = list_bridges

# Source file
SRC = $(SRCDIR)/list_bridges.c

# Destination binary path
BIN = $(BINDIR)/$(TARGET)

# Default target
all: $(BIN)

$(BIN): $(SRC)
	$(CC) $(CFLAGS) -o $(BIN) $(SRC) 

# Clean target for cleaning up the build
clean:
	rm -f $(BIN)

# Phony targets
.PHONY: all clean

