PDF=$(addsuffix .pdf, $(basename $(wildcard *.md)))

default: $(PDF)

%.pdf: %.md
	pandoc --to latex --latex-engine pdflatex -N -o $@ $< --template template.tex
