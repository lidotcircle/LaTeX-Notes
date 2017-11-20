###            Makefile for each LaTeX project.           ###

ifeq ($(OS), Windows_NT)
	cc=pdflatex
	rm=del
	touch=type nul >>
else
	cc=xelatex
	rm=rm -f
	touch=touch
endif
mkidx=makeindex

TEX_FILE:=./$(PROJECT).tex
PDFOUTPUT:=$(PROJECT).pdf
INDEX_IND:=./$(PROJECT).ind
INDEX_IDX:=./$(PROJECT).idx

all : $(PDFOUTPUT)

$(PDFOUTPUT) : $(INDEX_IND) $(TEX_FILE)
	$(cc) $(TEX_FILE)

$(INDEX_IND) : $(INDEX_IDX)
	$(mkidx) $(INDEX_IDX)

$(INDEX_IDX) : FORCE
	$(touch) $(INDEX_IDX)

$(TEX_FILE) :


clean : FORCE
	@echo Clean Project -- $(PROJECT) && \
		$(rm) *.pdf *.idx *.log *.aux *.toc *.ilg *.ind *.mk 

FORCE :
