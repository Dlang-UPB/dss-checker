#.PHONY: all clean run pack build-pre build-post

#SHELL:=/bin/bash -ix -O expand_aliases
#SHELL:=/bin/bash -i
SHELL:=/bin/bash --rcfile ~/.bashrc

all: build-pre test_1 test_2 test_3 test_4 test_5

build-pre:

test_1: dss_test.d hashtable.d
	@dmd -w -main -g -unittest -version=TEST1 dss_test.d hashtable.d -of=test_1

test_2: dss_test.d hashtable.d
	@dmd -w -main -g -unittest -version=TEST2 dss_test.d hashtable.d -of=test_2

test_3: dss_test.d hashtable.d
	@dmd -w -main -g -unittest -version=TEST3 dss_test.d hashtable.d -of=test_3

test_4: dss_test.d hashtable.d
	@dmd -w -main -g -unittest -version=TEST4 dss_test.d hashtable.d -of=test_4

test_5: dss_test.d hashtable.d
	@dmd -w -main -g -unittest -version=TEST5 dss_test.d hashtable.d -of=test_5

clean:
	rm -f *~ test_[1-5]* dss_test.o dss_test
