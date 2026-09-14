{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Code formatters
    # Language servers
    cabal-install # Haskell builder
    clang-tools
    eslint
    ghc # Haskell compiler
    gofumpt # Go formatter
    gopls # Go
    haskell-language-server
    lua
    lua-language-server # Lua
    marksman
    nixd # Nix
    nixpkgs-fmt # Nix formatter
    python314
    rust-analyzer # Rust
    rustfmt # Rust formatter
    shfmt # Shell script formatter
    sqls # SQL
    stack # Haskell builder
    stylelint # CSS/SCSS linter
    stylua # Lua formatter
    superhtml
    svelte-language-server
    tailwindcss-language-server # Tailwind
    taplo
    tinymist
    typescript-language-server
    vscode-langservers-extracted
  ];
}
