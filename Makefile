all: words.en.length

clean:
		rm -f words.en.txt words.en.length words.en.html

words.en.crlf.txt:
		curl -o words.en.text http://www-01.sil.org/linguistics/wordlists/english/wordlist/wordsEn.txt
		
words.en.txt: words.en.crlf.text
		tr -d '\r' <words.en.crlf.txt >words.en.text
		
words.en.length: words.en.text
		awk '{print length}' words.en.text >words.en.text
		
words.en.html: words.en.length
		Rscript -e 'rmarkdown::render("words.en.rmd")'
		
