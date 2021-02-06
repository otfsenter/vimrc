if exists("current_compiler")
    finish
endif
let current_compiler = "python"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet errorformat=
    \%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,
    \%*\\sFile\ \"%f\"\\,\ line\ %l,

if g:iswindows
    CompilerSet makeprg=python\ %
else
    CompilerSet makeprg=python3\ %
endif

let &cpo = s:cpo_save
unlet s:cpo_save

