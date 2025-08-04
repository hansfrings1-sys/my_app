# timecard_app

A new Flutter project.

## Getting Started

# 📱 PointCam Pro - Sistema de Ponto Eletrônico

Sistema avançado de registro de ponto eletrônico desenvolvido em Flutter para Windows, com integração de câmera real para identificação e interface moderna.

## 🚀 Funcionalidades Principais

- ✅ **Câmera Real**: Preview em tempo real da webcam
- ✅ **Interface Imersiva**: Tela inteira dedicada à câmera
- ✅ **Botão "Registrar"**: Design moderno e intuitivo
- ✅ **Menu Inteligente**: Acesso rápido a todas as funcionalidades
- ✅ **Gerenciamento Completo**: Cadastro e remoção de funcionários
- ✅ **Relatórios em Tempo Real**: Visualização de registros do dia
- ✅ **Interface Responsiva**: Design elegante com Material Design

## 🎯 Como Usar

### Tela Principal (Câmera)
1. **Inicie o App**: Câmera ativa automaticamente
2. **Posicione o Rosto**: Olhe para a webcam
3. **Clique "Registrar"**: Botão centralizado na parte inferior
4. **Confirme**: Valide o registro de ponto

### Menu de Navegação
- **Clique no ícone de menu** (canto superior direito)
- **Gerenciar Funcionários**: Adicionar/remover funcionários
- **Relatórios**: Ver registros do dia atual

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.10+** - Framework multiplataforma
- **Camera Plugin 0.10.6** - Integração com webcam
- **Material Design 3** - Interface moderna
- **Windows Desktop** - Plataforma alvo

## 📋 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  camera: ^0.10.6
```

## 💻 Compilação e Execução

```bash
# Instalar dependências
flutter pub get

# Verificar setup
flutter doctor

# Compilar para Windows (Debug)
flutter build windows --debug

# Compilar para Windows (Release)
flutter build windows --release

# Executar diretamente
flutter run -d windows
```

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                 # Aplicação principal
├── TimecardHome             # Tela principal com câmera
├── EmployeeManagementScreen # Gerenciamento de funcionários
└── ReportsScreen           # Relatórios e estatísticas
```

## 🎨 Interface

### Tela Principal
- **Fundo preto** para melhor contraste da câmera
- **Preview em tempo real** da webcam
- **Status indicator** no topo com nome do app e usuário
- **Botão "Registrar"** centralizado na parte inferior
- **Menu de acesso** no canto superior direito

### Gerenciamento de Funcionários
- **Lista visual** com avatares e informações
- **Adicionar funcionários** com formulário simples
- **Remover funcionários** com confirmação
- **Interface intuitiva** com cards e FAB

### Relatórios
- **Visualização em tempo real** dos registros
- **Cards organizados** por funcionário
- **Informações detalhadas** de horários e ações

## 🔧 Configuração da Câmera

O sistema detecta automaticamente todas as webcams disponíveis:

### Solução de Problemas
1. **Câmera não aparece**:
   - Verifique se a webcam está conectada
   - Feche outras aplicações que usam câmera
   - Execute como administrador
   - Clique em "Tentar Novamente"

2. **Erro de inicialização**:
   - Reinicie o aplicativo
   - Verifique drivers da webcam
   - Teste a câmera em outros apps

## 🎉 Funcionalidades Recentes

### v1.1.0 - Agosto 2025
- ✅ Título atualizado para "PointCam Pro"
- ✅ Botão mudado de ícone para texto "Registrar"
- ✅ Menu de navegação adicionado
- ✅ Tela de gerenciamento de funcionários
- ✅ Tela de relatórios com dados mock
- ✅ Interface melhorada com design moderno

### v1.0.0 - Agosto 2025
- ✅ Integração com câmera real
- ✅ Interface de tela inteira
- ✅ Sistema básico de registro de ponto

## 📊 Status do Projeto

- **Compilação**: ✅ Funcional
- **Câmera**: ✅ Integrada
- **Interface**: ✅ Moderna
- **Navegação**: ✅ Implementada
- **Testes**: ✅ Em funcionamento

## 🚀 Próximas Funcionalidades

- [ ] Banco de dados SQLite persistente
- [ ] Exportação de relatórios
- [ ] Configurações avançadas
- [ ] Backup automático
- [ ] Múltiplos usuários simultâneos

---

**Desenvolvido com ❤️ em Flutter para Windows**

**Versão Atual**: 1.1.0 | **Data**: Agosto 2025 | **Status**: ✅ Ativo
