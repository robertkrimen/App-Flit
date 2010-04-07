.PHONY: all test build

test:
	prove t

all: data test

data:
	./script/datify source/builtin.json source/jquery-plugin.json > \
		lib/App/Flit/Source/Data.pm

build:
	dzil $@
