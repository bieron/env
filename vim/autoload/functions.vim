"filetype vim

"-------------------------------------------------
" NewFile
"-------------------------------------------------
fu! functions#NewFile()
    1d
	silent! 0r ~/.vim/templates/tpl.%:e
	silent! %s/FILENAME/\=expand("%:t:r")
	let s=expand('%:e')
	4
	if s == 's'
		7
	endif
endfunction

"-------------------------------------------------
" LocalDoc (F2)
"-------------------------------------------------
fu! functions#LocalDoc()
	if &ft =~ "perl"
		let s:browser="perldoc"
	else
		let s:browser="man"
	endif
	let s:word=expand("<cword>")
	let s:cmd = "silent !" . s:browser ." ". s:word
	redraw!
endfunction

"-------------------------------------------------
" Wiki (F3)
"-------------------------------------------------
fu! functions#Wiki()
	let s:browser="chromium"
	let s:word=expand("<cword>")
	let s:url="http://wikipedia.org/wiki/".s:word
	let s:cmd="silent !".s:browser." ".s:url
	execute s:cmd
	redraw!
endfunction

"-------------------------------------------------
" OnlineDoc (F4)
"-------------------------------------------------
fu! functions#OnlineDoc()
	if &ft=~"cpp" || &ft=~"c"
		let s:urltpl="http://www.cplusplus.com/search.do?q=%"
	elseif &ft=~"ruby"
		let s:urltpl="http://ruby-doc.org/core/classes/%.html"
	elseif &ft=~"perl"
		let s:urltpl="http://perldoc.perl.org/functions/%.html"
	else
		return
	endif
	let s:browser="chromium"
	let s:word=expand("<cword>")
	let s:url=substitute(s:urltpl, "%", s:word, "g")
	let s:cmd="silent !".s:browser." ".s:url
	execute s:cmd
	redraw!
endfunction

"-------------------------------------------------
" TidyIt (F5)
"-------------------------------------------------
fu! TidyIt()
    :%!perltidy -ce --continuation-indentation=4 -cti=0 -cpi=0 -l=350 --line-up-parentheses -pt=0 -sbt=1 -bt=0 -bbt=0 -nsbl -vt=0 -vtc=0 -sot -isbc -nolq -msc=4 -hsc -csc -csci=1 -cscp="+ end of:" -cscb -fsb='\#\<notidy' -fse='\#notidy\>' -bbs
"    if (search('__ @_'))
        :%s/__ @_/__@_/g
"    endif
endfunction

"-------------------------------------------------
" SwitchHls (F6)
"-------------------------------------------------
fu! SwitchHls()
	if &hls
		set nohls
	else
		set hls
	endif
endfunction

" vim: syntax=vim
