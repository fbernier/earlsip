ERL_INCLUDE := $(shell erl -noshell -s init stop -eval "io:format(\"~ts/erts-~ts/include/\", [code:root_dir(), erlang:system_info(version)]).")
ERL_INTERFACE_INCLUDE := $(shell erl -noshell -s init stop -eval "io:format(\"~ts\", [code:lib_dir(erl_interface, include)]).")
ERL_INTERFACE_LIB := $(shell erl -noshell -s init stop -eval "io:format(\"~ts\", [code:lib_dir(erl_interface, lib)]).")

LIB := earlsip
CC := gcc
CFLAGS := -g -std=c11 $(WARNING_FLAGS) -Werror -O3 \
          -fPIC -shared \
          -I $(ERL_INCLUDE) -I $(ERL_INTERFACE_INCLUDE)
LDFLAGS := -L $(ERL_INTERFACE_LIB) -lei
TARGET := ../priv/$(LIB).so

all: deps
	mkdir -p ../priv
	$(CC) -o $(TARGET) $(CFLAGS) $(LDFLAGS) *.c

deps:
	@if git submodule status | egrep -q '^[-]|^[+]' ; then \
		git submodule update --init; \
	fi

clean:
	rm -rf $(TARGET) *.o
	git submodule deinit --all

.PHONY: clean
