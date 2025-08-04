# 🌐 Como Acessar o PointCam Pro em Outra Máquina

## 📋 **Pré-requisitos na Nova Máquina**

### 1. 🔧 **Instalar Flutter**
- **Download**: [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)
- **Extrair** para `C:\flutter` (ou pasta de sua preferência)
- **Adicionar ao PATH**: `C:\flutter\bin`
- **Verificar**: `flutter doctor`

### 2. 🔧 **Instalar Git**
- **Download**: [https://git-scm.com/download/win](https://git-scm.com/download/win)
- **Instalar** com configurações padrão
- **Verificar**: `git --version`

### 3. 🔧 **Instalar Visual Studio Code** (opcional)
- **Download**: [https://code.visualstudio.com/](https://code.visualstudio.com/)
- **Extensões recomendadas**: Flutter, Dart

## 📥 **Baixar o Projeto do GitHub**

### **Método 1: Clone via Git (Recomendado)**
```bash
# Navegar para pasta desejada
cd C:\Users\%USERNAME%\Documents

# Clonar o repositório
git clone https://github.com/hansfrings1-sys/my_app.git

# Entrar na pasta
cd my_app
```

### **Método 2: Download ZIP**
1. **Acesse**: [https://github.com/hansfrings1-sys/my_app](https://github.com/hansfrings1-sys/my_app)
2. **Clique**: "Code" > "Download ZIP"
3. **Extrair** o arquivo para pasta desejada
4. **Renomear** pasta para `my_app`

## 🚀 **Configurar e Executar o Projeto**

### **1. Instalar Dependências**
```bash
# Navegar para pasta do projeto
cd C:\Users\%USERNAME%\Documents\my_app

# Instalar dependências Flutter
flutter pub get

# Verificar setup
flutter doctor
```

### **2. Compilar e Executar**
```bash
# Para desenvolvimento (com hot reload)
flutter run -d windows

# Para build de release
flutter build windows --release

# Executar build compilado
.\build\windows\x64\runner\Release\timecard_app.exe
```

## 🔄 **Manter Sincronizado com GitHub**

### **Baixar Atualizações**
```bash
# Baixar últimas mudanças
git pull origin main

# Instalar novas dependências (se houver)
flutter pub get

# Recompilar se necessário
flutter build windows --release
```

### **Enviar Mudanças de Volta**
```bash
# Usar o script automático
.\backup_github.ps1

# OU manualmente:
git add .
git commit -m "Mudanças feitas em outra máquina"
git push origin main
```

## 🔑 **Configurar Git na Nova Máquina**

```bash
# Configurar usuário (mesmo do GitHub)
git config --global user.name "hansfrings1-sys"
git config --global user.email "hansfrings1@gmail.com"

# Verificar configuração
git config --global --list
```

## 📱 **Estrutura de Pastas Recomendada**

```
C:\Users\SeuUsuario\Documents\
└── my_app\                    # ← Projeto clonado aqui
    ├── lib\
    │   └── main.dart
    ├── pubspec.yaml
    ├── backup_github.ps1      # ← Scripts de backup
    ├── backup_github.bat
    └── build\                 # ← Executáveis compilados
```

## 🔧 **Solução de Problemas Comuns**

### **Flutter não reconhecido**
```bash
# Adicionar Flutter ao PATH:
# 1. Tecla Windows + R
# 2. Digite: sysdm.cpl
# 3. Aba "Avançado" > "Variáveis de Ambiente"
# 4. Em "Path" adicione: C:\flutter\bin
```

### **Git não reconhecido**
- Reiniciar terminal/VS Code após instalar Git
- Verificar se Git foi adicionado ao PATH

### **Erro de permissões**
```bash
# Executar PowerShell como administrador
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### **Problemas de dependências**
```bash
# Limpar cache e reinstalar
flutter clean
flutter pub get
```

## 🌟 **Fluxo Completo para Nova Máquina**

### **📋 Checklist Rápido:**
- [ ] Flutter instalado e funcionando
- [ ] Git instalado e configurado
- [ ] Projeto clonado do GitHub
- [ ] Dependências instaladas (`flutter pub get`)
- [ ] Projeto compilando (`flutter build windows`)
- [ ] App executando (`flutter run -d windows`)

### **🚀 Comandos Resumidos:**
```bash
# 1. Clone
git clone https://github.com/hansfrings1-sys/my_app.git
cd my_app

# 2. Setup
flutter pub get
flutter doctor

# 3. Execute
flutter run -d windows
```

## 🔗 **Links Úteis**

- **🏠 Seu Repositório**: [https://github.com/hansfrings1-sys/my_app](https://github.com/hansfrings1-sys/my_app)
- **📖 Flutter Docs**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **🔧 Git Download**: [https://git-scm.com/downloads](https://git-scm.com/downloads)
- **💻 VS Code**: [https://code.visualstudio.com/](https://code.visualstudio.com/)

---

**💡 Dica**: Mantenha sempre o mesmo usuário Git configurado em todas as máquinas para facilitar sincronização!
