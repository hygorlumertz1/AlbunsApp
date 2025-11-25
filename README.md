# 📱 Aplicativo Mobile - Álbuns e Fotos

## Projeto de Desenvolvimento Mobile - Fase 2

---

## 📋 Sobre o Projeto

Aplicativo mobile desenvolvido em **React Native** para consumo da API gratuita JSONPlaceholder. O app permite visualizar usuários, seus álbuns de fotos e navegar pelas imagens com recursos de busca e filtros.

### 🎯 Funcionalidades Implementadas

#### ✅ Funcionalidades Macro
1. **Listagem de Usuários** - Exibe todos os usuários da API com informações detalhadas
2. **Listagem de Álbuns** - Mostra os álbuns do usuário selecionado
3. **Listagem de Fotos** - Grid de thumbnails das fotos de um álbum específico
4. **Foto Ampliada** - Visualização em tela cheia com título da foto

#### ✅ Funcionalidades Micro
- **Filtro por nome** - Busca em tempo real de usuários
- **Descrição de foto** - Exibição do título completo na tela ampliada
- **Loading states** - Indicadores visuais durante carregamento
- **Navegação intuitiva** - Botões de voltar em todas as telas

---

## 🛠️ Tecnologias Utilizadas

- **React Native** (Plataforma principal)
- **JavaScript/ES6+**
- **Fetch API** para consumo de dados
- **JSONPlaceholder API** (https://jsonplaceholder.typicode.com/)
- **Componentes Nativos**: FlatList, Modal, Image, TouchableOpacity, TextInput

---

## 📂 Estrutura do Projeto

```
AlbunsApp/
├── App.js                 # Arquivo principal com todas as telas
├── package.json           # Dependências do projeto
├── app.json              # Configurações do Expo
├── README.md             # Esta documentação
└── assets/               # Recursos do app
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

- Node.js instalado (v14 ou superior)
- npm ou yarn
- Expo CLI (recomendado) ou React Native CLI

### Instalação e Execução

#### Opção 1: Usando Expo (Recomendado)

```bash
# 1. Clone ou extraia o projeto
cd AlbunsApp

# 2. Instale as dependências
npm install

# 3. Inicie o projeto
npx expo start

# 4. Escaneie o QR code com o app Expo Go (Android/iOS)
# Ou pressione 'a' para Android ou 'i' para iOS
```

#### Opção 2: Usando React Native CLI

```bash
# 1. Entre na pasta do projeto
cd AlbunsApp

# 2. Instale as dependências
npm install

# 3. Para Android
npx react-native run-android

# 4. Para iOS (apenas Mac)
npx react-native run-ios
```

---

## 🎨 Fluxo de Navegação

```
┌─────────────────────┐
│  Tela 1: Usuários   │
│  - Lista usuários   │
│  - Campo de busca   │
└──────────┬──────────┘
           │ (clica usuário)
           ↓
┌─────────────────────┐
│  Tela 2: Álbuns     │
│  - Lista álbuns     │
│  - Botão voltar     │
└──────────┬──────────┘
           │ (clica álbum)
           ↓
┌─────────────────────┐
│  Tela 3: Fotos      │
│  - Grid thumbnails  │
│  - Botão voltar     │
└──────────┬──────────┘
           │ (clica foto)
           ↓
┌─────────────────────┐
│ Tela 4: Foto Grande │
│  - Imagem ampliada  │
│  - Título da foto   │
│  - Botão fechar     │
└─────────────────────┘
```

---

## 🔌 Endpoints da API Utilizados

### 1. Buscar Usuários
```
GET https://jsonplaceholder.typicode.com/users
```

### 2. Buscar Álbuns de um Usuário
```
GET https://jsonplaceholder.typicode.com/albums?userId={id}
```

### 3. Buscar Fotos de um Álbum
```
GET https://jsonplaceholder.typicode.com/photos?albumId={id}
```

---

## 📱 Telas do Aplicativo

### Tela 1 - Lista de Usuários
- **Componentes**: Header, SearchBar, FlatList
- **Funcionalidades**: 
  - Busca em tempo real por nome
  - Lista scrollável de usuários
  - Exibe nome, email e empresa
  - Avatar com inicial do nome

### Tela 2 - Álbuns do Usuário
- **Componentes**: Header com botão voltar, FlatList
- **Funcionalidades**:
  - Lista todos os álbuns do usuário selecionado
  - Mostra título do álbum
  - Indica quantidade de fotos (50)

### Tela 3 - Grid de Fotos
- **Componentes**: Header com botão voltar, FlatList (numColumns=3)
- **Funcionalidades**:
  - Grid 3 colunas de thumbnails
  - Imagens carregadas da API
  - Scroll vertical

### Tela 4 - Foto Ampliada
- **Componentes**: Modal, Image
- **Funcionalidades**:
  - Foto em alta resolução
  - Título da foto
  - Botão fechar (X)
  - Fundo preto para destaque


---

## 👨‍💻 Autor

**[Hygor Lumertz]**  
Disciplina: Desenvolvimento Mobile  
Data: Novembro 2025
