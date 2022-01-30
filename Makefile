# Makefile preamble from https://tech.davis-hansson.com/p/make/
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

unzip-bandcamp := $(shell ./unzip-bandcamp)

FLAC := $(shell find FLAC -name "*.flac" -type f | sort)
AAC := $(addsuffix .m4a, $(shell echo $(FLAC) | sed 's/FLAC\//AAC\//g'))

all : $(AAC)

AAC/%.m4a : FLAC/%
	@ mkdir -p $(dir $@)
	echo $@
	ffmpeg -loglevel error -i $< -c:v copy -c:a libfdk_aac -vbr 5 $@

print-% : ; @echo $($*) | tr " " "\n"
