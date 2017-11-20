##################################################################
#       A Makefile for build all latex in sub-directories        #
##################################################################

ifeq ($(OS), Windows_NT)
	cd=chdir
	cp=cp
	rm=del
	rm_pdf=$(rm) *pdf 2> nul
else
	cd=cd
	cp=cp
	rm=rm -f
	rm_pdf=$(rm) *pdf
endif

mk_for_dir=FILE.mk

dirs=$(patsubst %/, %/src, $(sort $(dir $(wildcard */*))))

all : $(dirs)

$(dirs) : FORCE
	@$(cp) $(mk_for_dir) $@ && $(cd) $@ && echo $@ &&\
		$(MAKE) -f $(mk_for_dir) --eval "PROJECT=$(patsubst %/src, %, $@)" all && \
		$(MAKE) -f $(mk_for_dir) --eval "PROJECT=$(patsubst %/src, %, $@)" all && \
		$(rm) $(mk_for_dir) && $(cp) $(patsubst %/src, %, $@).pdf ../..

FORCE:

test : FORCE
	echo $(foreach dir, $(dirs), $(shell echo $(dir)))

clean : FORCE
	@echo Remove all pdf file && $(rm_pdf) && \
		echo $(join Clean over!, $(foreach dir, $(dirs), \
		$(info $(shell $(cp) $(mk_for_dir) $(dir) && \
		$(cd) $(dir) && $(MAKE) -f $(mk_for_dir) \
		--eval "PROJECT=$(patsubst %/src, %, $(dir))" clean))))
