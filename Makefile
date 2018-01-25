##################################################################
#       A Makefile for build all latex in sub-directories        #
##################################################################

ifeq ($(OS), Windows_NT)
	cd=chdir
	cp=cp
	rm=del
	rm_pdf=$(rm) *pdf 2> nul
	mv=move
else
	cd=cd
	cp=cp
	rm=rm -f
	rm_pdf=$(rm) *pdf
	mv=mv
endif

mk_for_dir=FILE.mk

projects=$(patsubst %/, %, $(sort $(dir $(wildcard */*))))
dirs=$(patsubst %, %/src, $(projects))

all : $(projects)

$(projects) : FORCE
	@$(cp) $(mk_for_dir) $@/src && $(cd) $@/src && echo $@ &&\
		$(MAKE) -f $(mk_for_dir) --eval "PROJECT=$@" all && \
		$(MAKE) -f $(mk_for_dir) --eval "PROJECT=$@" all && \
		$(rm) $(mk_for_dir) && $(mv) $@.pdf ../.. > nul

FORCE:

clean : FORCE
	@echo Remove all pdf file && $(rm_pdf) && \
		echo $(join Clean over!, $(foreach dir, $(dirs), \
		$(info $(shell $(cp) $(mk_for_dir) $(dir) && \
		$(cd) $(dir) && $(MAKE) -f $(mk_for_dir) \
		--eval "PROJECT=$(patsubst %/src, %, $(dir))" clean))))
