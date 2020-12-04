REBAR=./bin/rebar3

all: compile

clean:
	@echo "Running rebar3 clean..."
	@$(REBAR) clean

compile:
	@echo "Running rebar3 compile..."
	@$(REBAR) as compile compile

eunit:
	@echo "Running rebar3 eunit..."
	@$(REBAR) do eunit -cv

.PHONY: clean compile eunit
