{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Language servers
    nixd # Nix
    rust-analyzer # Rust
    gopls # Go
    lua-language-server # Lua
    nodePackages.bash-language-server # Bash
    nodePackages.yaml-language-server # Yaml
    sqls # SQL
    tailwindcss-language-server # Tailwind
    nodePackages.typescript-language-server # TypeScript/JavaScript, includes JSX support
    nodePackages.vscode-langservers-extracted # HTML/CSS/JSON
    nodePackages.eslint # JavaScript linter
    stylelint # CSS/SCSS linter

    # Code formatters
    nodePackages.prettier # Javascript / css / html etc
    stylua # Lua formatter
    nixpkgs-fmt # Nix formatter
    rustfmt # Rust formatter
    gofumpt # Go formatter
    shfmt # Shell script formatter
  ];
}
