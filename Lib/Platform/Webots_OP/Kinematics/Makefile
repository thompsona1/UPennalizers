# Makefile used to build libraries

TARGETS = all clean
.PHONY: $(TARGETS)

CXX=g++
CC=gcc
LD=g++
STRIP=strip
CXXFLAGS= -O2 -fpic
LDFLAGS=

SHLIBEXT= so
LIBOPTS= -shared

ifndef OSTYPE
  OSTYPE = $(shell uname -s|awk '{print tolower($$0)}')
  #export OSTYPE
endif

ifeq ($(OSTYPE),linux)
  SHLIBEXT= so
  LIBOPTS= -shared
endif
ifeq ($(OSTYPE),darwin)
  SHLIBEXT= dylib
  LIBOPTS= -bundle -undefined dynamic_lookup
  CXXFLAGS= -O2
ifeq ($(MODE),32)
  CC=gcc -arch i386
  CXX=g++ -arch i386
  LD=g++ -arch i386
endif

endif

INCLUDE_DIRS = -I/usr/local/include -I/usr/include/lua5.1
LIB_DIR = /usr/local/lib

LIBNAME= DarwinOPKinematics

all:: kinematics

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDE_DIRS) -o $@ -c $<
%.o: %.cc
	$(CXX) $(CXXFLAGS) $(INCLUDE_DIRS) -o $@ -c $<
%.o: %.c
	$(CC) $(CXXFLAGS) $(INCLUDE_DIRS) -o $@ -c $<

kinematics:: luaDarwinOPKinematics.o DarwinOPKinematics.o Transform.o
	$(LD) $(LDFLAGS) -o $(LIBNAME).$(SHLIBEXT) $(LIBOPTS) $^ -L$(LIB_DIR) -lm

clean:
	rm -f *.$(SHLIBEXT) *.o
