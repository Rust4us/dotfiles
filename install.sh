#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[!] Instalando dotfiles de Rust4us..."

# Crea symlinks para los archivos de home
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# Crea la carpeta config si no existe
mkdir -p ~/.config

# Crea symlinks para las configs
for dir in "$DOTFILES_DIR/config"/*/; do
  name=$(basename "$dir")
  ln -sf "$dir" ~/.config/"$name"
  echo "✓ $name"
done

echo ""
echo "[+] Dotfiles instalados! Reinicia la terminal."

