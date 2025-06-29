# Limpeza dos logs e da pasta temporária.

limpeza_final() {
log_section "Limpar os ficheiros não necessários da instalação."

if ! confirmar; then
info "Limpeza cancelada pelo utilizador."
return
fi

TMP_DIR="./fedora-nexus"

# Verifica se existe a pasta ./.tmp e remove
if [ -d "$TMP_DIR" ]; then
info "[INFO] Limpeza de ficheiros temporários..."
rm -rf "$TMP_DIR"
fi

# Eliminar pacotes não necessários
sudo pacman -Rns --noconfirm yelp gnome-user-docs gnome-tour gnome-terminal epiphany

sucesso "Finalizado."
sleep 2
}