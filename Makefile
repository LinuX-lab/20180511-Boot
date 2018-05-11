TGT=README.pdf

all: $(TGT)

clean:
	@rm $(TGT)

%.pdf:%.md
	@pandoc -o $@ $<
