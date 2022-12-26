{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 6;
          y = 8;
          dynamic_padding = true;
        };
        decorations = "none";

        opacity = 0.8;
      };
      cursor.style.shape = "Underline";
      font = {
        size = 13.0;
        normal.family = "JetBrains Mono Nerd Font";
      };
    };
  };
}
