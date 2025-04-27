let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/nixos
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/nixos/home/desktop/rofi.nix
badd +22 ~/nixos/home/desktop/default.nix
badd +72 ~/nixos/system/software/programs.nix
badd +175 ~/nixos/home/desktop/waybar.nix
badd +36 ~/nixos/system/software/stylix.nix
badd +13 ~/nixos/system/localization/users.nix
badd +22 ~/nixos/system/configuration.nix
badd +17 ~/nixos/system/software/audio.nix
badd +68 ~/nixos/home/terminal/kitty.nix
badd +13 ~/nixos/flake.nix
badd +32 ~/nixos/home/default.nix
badd +90 ~/nixos/home/desktop/hyprland.nix
badd +7 ~/nixos/home/desktop/hypridle.nix
badd +11 ~/nixos/home/desktop/hyprpaper.nix
badd +19 ~/nixos/home/ui/default.nix
badd +2 ~/nixos/system/hardware/default.nix
badd +24 ~/nixos/system/hardware/backlight.nix
argglobal
%argdel
edit ~/nixos/home/desktop/waybar.nix
argglobal
balt ~/nixos/home/default.nix
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 175 - ((12 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 175
normal! 033|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
