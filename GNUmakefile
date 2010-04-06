.PHONY: all test build

all: data test

data:
	./script/datify jquery source/jquery-plugin.json > lib/App/Flit/Source/jquery/Data.pm
	./script/datify jquery source/builtin.json > lib/App/Flit/Source/builtin/Data.pm

build test:
	dzil $@
