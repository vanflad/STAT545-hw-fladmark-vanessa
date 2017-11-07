all: words.en.length

words.en.crlf.txt:
		curl -o words.en.text http://www-01.sil.org/linguistics/wordlist/english
		
words.en.txt: words.en.crlf.text
		tr -d '\r' <words.en.crlf.txt >words.en.text
		
words.en.length: words.en.text
		awk '{print length}' words.en.text >words.en.text
		
