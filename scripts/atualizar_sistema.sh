# atualizar_sistema.sh - Atualização do sistema e limpeza de pacotes antigos

atualizar_sistema() {
log_section "Atualização e manutenção do sistema."

if ! confirmar; then
info "Atualização cancelada pelo utilizador."
return
fi

info "A atualizar o sistema..."
sudo pacman -Syu --noconfirm

info "A remover pacotes desnecessários..."
sudo pacman -Rdd $(pacman -Qdtq)

pacotes=(
avahi
v4l-utils
)

for pacote in "${pacotes[@]}"; do
if pacman -Q "$pacote" > /dev/null 2>&1; then
info "A remover: $pacote"
sudo pacman -Rns --noconfirm "$pacote"
info "$pacote removido!"
else
info "$pacote já não está instalado."
fi
done

sucesso "Sistema atualizado e limpo com sucesso."
sleep 1.5
}
