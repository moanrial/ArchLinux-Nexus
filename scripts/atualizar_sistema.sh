# atualizar_sistema.sh - Atualização do sistema e limpeza de pacotes antigos

atualizar_sistema() {
log_section "Atualização e manutenção do sistema."

if ! confirmar; then
info "Atualização cancelada pelo utilizador."
return
fi

info "A atualizar o sistema..."
sudo pacman -Syu --noconfirm

info "A remover pacotes órfãos (desnecessários)..."

echo "[1/2] A remover dependências órfãs..."
orphans=$(pacman -Qdtq)
if [[ -n "$orphans" ]]; then
  sudo pacman -Rns --noconfirm $orphans
else
  info "Nenhum pacote órfão encontrado."
fi

info "[2/2] A limpar cache de pacotes antigos..."
sudo paccache -r -k2

sucesso "Sistema atualizado e limpo com sucesso."
sleep 1.5
}