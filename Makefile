# Declaration of variables
CC = cc
CXX = g++
CC_FLAGS = -w
CXXFLGS = -00 -g
L_FLAGS = -lm

# File names
VERSION = 2.0
PLATFORM=osx
ARCHIVE = gpx-$(PLATFORM)-$(VERSION)
PREFIX = /usr/local
SOURCES = $(wildcard *.c)
SOURCES_CPP = $(wildcard *.cpp)
OBJECTS = $(SOURCES:.c=.o)
OBJECTS_CPP = $(SOURCES_CPP:.cpp=.o)

all: gpx

.PHONY: all

# Main target
gpx: $(OBJECTS)
	$(CXX) $(L_FLAGS) $(OBJECTS) $(OBJECTS_CPP) -o gpx

# To obtain object files
%.o: %.c
	$(CC) -c $(CC_FLAGS) $< -o $@
	$(CXX)  -c -o helper.o helper.cpp

# To remove generated files
clean:
	rm -f gpx $(OBJECTS) $(OBJECTS_CPP)
	rm -f $(ARCHIVE).tar.gz
	rm -f $(ARCHIVE).zip
	rm -f $(ARCHIVE).dmg

# To install program and supporting files
install: gpx
	test -d $(PREFIX) || mkdir $(PREFIX)
	test -d $(PREFIX)/bin || mkdir $(PREFIX)/bin
	install -m 0755 gpx $(PREFIX)/bin
#	test -d $(PREFIX)/share || mkdir $(PREFIX)/share
#	test -d $(PREFIX)/share/gpx || mkdir -p $(PREFIX)/share/gpx
#	for INI in *.ini; do \
#		install -m 0644 $$INI $(PREFIX)/share/gpx; \
#	done

# To make a distribution archive
release: gpx
	rm -rf $(ARCHIVE)	# Get rid of previous junk, if any.
	rm -f $(ARCHIVE).tar.gz
	rm -f $(ARCHIVE).zip
	rm -f $(ARCHIVE).dmg
	mkdir $(ARCHIVE)
	cp -r gpx examples scripts *.ini $(ARCHIVE)
	tar cf - $(ARCHIVE) | gzip -9c > $(ARCHIVE).tar.gz
	zip -r $(ARCHIVE).zip $(ARCHIVE)
	test -f /usr/bin/hdiutil && hdiutil create -format UDZO -srcfolder $(ARCHIVE) $(ARCHIVE).dmg
	rm -rf $(ARCHIVE)


# Run unit test
test: gpx
	./gpx lint.gcode
	python ./s3g-decompiler.py lint.x3g
