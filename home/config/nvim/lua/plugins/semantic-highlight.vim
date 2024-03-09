" curl -s https://docs.oracle.com/javase/tutorial/java/nutsandbolts/_keywords.html | grep '<td.*><code>' | sed -E "s|.*<code>(.+)</code>.*|\'\1\'|" | sort | tr '\n' ','
let g:semanticBlacklistOverride = {
    \ 'java': [
    \ 'abstract','assert','boolean','break','byte','case','catch','char','class','const','continue','default','do','double','else','enum','extends','final','finally','float','for','goto','if','implements','import','instanceof','int','interface','long','native','new','package','private','protected','public','return','short','static','strictfp','super','switch','synchronized','this','throw','throws','transient','try','void','volatile','while',
    \ 'Boolean', 'Double', 'Float', 'Char', 'Long', 'Int', 'Short', 'Byte', 'String','true','false','null','var','List','ArrayList','LinkedList','Map','HashMap',
    \ ],
    \ 'nim': [
    \   'if', 'elif', 'else', 'for', 'while', 'in', 'proc', 'type', 'let', 'import', 'const', 'var', 'assert', 'string', 'int', 'seq', 'object', 'bool'
    \ ],
    \ 'lua': [
    \ 'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while',
    \ 'require'
    \ ],
    \ 'elixir': [
    \ 'true', 'false', 'nil', 'if', '_',
    \ 'when', 'and', 'or', 'not', 'in', 'case',
    \ 'fn', 'do', 'end', 'catch', 'rescue', 'after', 'else',
    \ 'defmodule', 'def', 'defp', 'use', 'end',
    \ ],
\ }

let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]

let g:semanticEnableFileTypes = {'python': 'python', 'lua': 'lua', 'css': 'css', 'nim': 'nim', 'java': 'java', 'haskell': 'haskell', 'ruby': 'ruby', 'javascript': 'javascript', 'elixir': 'elixir'}

" re-highlight on save
augroup SemanticHL
    autocmd FileType python,lua,css,java,nim,haskell,ruby,javascript,elixir
        \ autocmd! SemanticHL BufWritePost <buffer> :SemanticHighlight
augroup END
