" https://github.com/koalaman/shellcheck/wiki/SC2119
" https://github.com/koalaman/shellcheck/wiki/SC2029
let g:ale_sh_shellcheck_exclusions = 'SC2119,SC2029'
let g:ale_yaml_yamllint_options='-d "{extends: default, rules: {line-length: disable, document-start: disable, indentation: disable, comments-indentation: disable}}"'
let g:ale_nasm_nasm_options='-f elf64'
let g:ale_python_flake8_options='--config ~/.config/flake8'
let g:ale_solidity_solc_options='--base-path / --include-path node_modules'

" disable some linters - done with coc
let g:ale_linters_ignore = ['hls', 'javac', 'shellcheck']
let g:ale_linters = {'python': [], 'solidity': [], 'ansible': []}

" ALE appearance  ▸▪
let g:ale_sign_warning = '▪'
let g:ale_sign_style_warning = '▪'
let g:ale_sign_error = '▪'
let g:ale_sign_style_error = '▪'
let g:ale_echo_msg_format = '[%linter%] %severity%% code%: %s'
let g:ale_virtualtext_cursor = 0
