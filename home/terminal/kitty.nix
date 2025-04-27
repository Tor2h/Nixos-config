{ inputs, lib, config, pkgs, ... }: {
  imports = [ ];

  programs.kitty = {
    enable = true;

    # Environment vars
    environment = { };

    extraConfig = ''
      # window_border_width 5
      # window_margin_width 10
      # window_padding_width 20
      # background_opacity 0.85
    '';

    # Font
    font.size = lib.mkForce 16;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --theme=base16";
      "cd.." = "cd ..";
      grep = "grep --color=auto";
      jctl = "journalctl -p 3 -xb"; # get the error messages from journalctl
      ls = "eza -lhF --color=always --icons --sort=size --group-directories-first";
      q = "exit";
      rg = "rg --sort path --no-ignore --hidden"; # search content with ripgrep
      rm = "rm -i";
      "vi" = "nvim";
      "lg" = "lazygit";
    };
    initContent = ''
            autoload -Uz vcs_info

            precmd() { vcs_info }

            # Format the vcs_info_msg_0_ variable
            zstyle ':vcs_info:git:*' formats "%b"

            setopt prompt_subst

            function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	yazi "$@" --cwd-file="$tmp"
      	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		builtin cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }

    '';
    # PROMPT="%B%F{#${config.lib.stylix.colors.base0C}}% "" ❯ %f"
    # RPROMPT='%F{#${config.lib.stylix.colors.base0C}}''${vcs_info_msg_0_}'
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableTransience = true;
    settings = {
      add_newline = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
