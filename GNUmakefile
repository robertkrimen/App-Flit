.PHONY: all test clean distclean dist data

all: data test

data:
	./script/datify jquery source/jquery-plugin.json > lib/App/Flit/Source/jquery/Data.pm
	./script/datify jquery source/builtin.json > lib/App/Flit/Source/builtin/Data.pm

dist:
	rm -rf inc META.y*ml
	perl Makefile.PL
	$(MAKE) -f Makefile dist

install distclean tardist: Makefile
	$(MAKE) -f $< $@

test: Makefile
	TEST_RELEASE=1 $(MAKE) -f $< $@

Makefile: Makefile.PL
	perl $<

clean: distclean

reset: clean
	perl Makefile.PL
	$(MAKE) test
