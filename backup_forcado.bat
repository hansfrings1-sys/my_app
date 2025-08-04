@echo off
echo 🚀 PointCam Pro - Backup FORÇADO
echo.

REM Limpar credenciais antigas
echo 🧹 Limpando credenciais antigas...
git config --global --unset credential.helper
git config --global credential.helper manager

REM Verificar diretório atual
echo 📂 Diretório atual: %CD%

REM Verificar status do Git
echo 📊 Status do repositório:
git status

echo.
echo 📦 Adicionando arquivos...
git add .

echo 💾 Fazendo commit...
git commit -m "Backup automático - %date% %time%"

echo.
echo 🌐 Enviando para GitHub (pode solicitar login)...
echo ⚠️  SE APARECER JANELA DE LOGIN:
echo 👤 Username: hansfrings1-sys
echo 🔑 Password: Sua senha do GitHub
echo.

REM Tentar push com timeout
timeout /t 3 /nobreak
git push -u origin main

echo.
if %errorlevel% == 0 (
    echo ✅ Backup concluído com sucesso!
    echo 🔗 Acesse: https://github.com/hansfrings1-sys/my_app
) else (
    echo ❌ Erro no backup - Tente GitHub Desktop
    echo 📥 Download: https://desktop.github.com/
)

echo.
pause
