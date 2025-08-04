# Script PowerShell para Backup Automático no GitHub
# Execute: .\backup_github.ps1

Write-Host "🚀 PointCam Pro - Backup Automático" -ForegroundColor Cyan
Write-Host ""

# Verificar se estamos em um repositório Git
if (-not (Test-Path ".git")) {
    Write-Host "❌ Erro: Não é um repositório Git!" -ForegroundColor Red
    exit 1
}

# Adicionar todas as mudanças
Write-Host "📦 Adicionando arquivos..." -ForegroundColor Yellow
git add .

# Solicitar descrição da mudança
$message = Read-Host "💬 Descreva a mudança (ou pressione Enter para mensagem padrão)"
if ([string]::IsNullOrWhiteSpace($message)) {
    $message = "Atualização automática - $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
}

# Fazer commit
Write-Host "💾 Fazendo commit..." -ForegroundColor Yellow
git commit -m $message

# Verificar se há mudanças para commit
$gitStatus = git status --porcelain
if ([string]::IsNullOrWhiteSpace($gitStatus)) {
    Write-Host "⚠️  Nenhuma mudança detectada!" -ForegroundColor Yellow
} else {
    # Enviar para GitHub
    Write-Host "🌐 Enviando para GitHub..." -ForegroundColor Yellow
    git push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Backup concluído com sucesso!" -ForegroundColor Green
        Write-Host "🔗 Acesse: https://github.com/hansfrings1-sys/my_app" -ForegroundColor Cyan
    } else {
        Write-Host "❌ Erro ao enviar para GitHub!" -ForegroundColor Red
    }
}

Write-Host ""
Read-Host "Pressione Enter para sair"
