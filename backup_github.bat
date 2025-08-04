@echo off
REM Script para Backup Automático no GitHub
REM Execute este arquivo sempre que quiser salvar mudanças

echo 🚀 PointCam Pro - Backup Automático
echo.

REM Adicionar todas as mudanças
echo 📦 Adicionando arquivos...
git add .

REM Solicitar descrição da mudança
set /p "message=💬 Descreva a mudança (ou pressione Enter para mensagem padrão): "
if "%message%"=="" set "message=Atualização automática - %date% %time%"

REM Fazer commit
echo 💾 Fazendo commit...
git commit -m "%message%"

REM Enviar para GitHub
echo 🌐 Enviando para GitHub...
git push

echo.
echo ✅ Backup concluído com sucesso!
echo 🔗 Acesse: https://github.com/hansfrings1-sys/my_app
echo.
pause
