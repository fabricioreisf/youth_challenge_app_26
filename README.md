# Youth Challenge Blockchain 2026

## Documentação Escolar Unificada

Protótipo desenvolvido para o **Youth Challenge Blockchain**, iniciativa do **UNICEF**, **Superteam Brasil** e **Blockchain.RIO**.

O projeto demonstra como a tecnologia blockchain pode ser utilizada para garantir autenticidade, rastreabilidade e segurança no compartilhamento de documentos escolares de crianças e adolescentes durante processos como matrícula, transferência e validação de certificados.

---

## Problema

Atualmente, documentos escolares podem ser:

- perdidos durante mudanças de escola;
- difíceis de validar entre diferentes instituições;
- suscetíveis a fraudes;
- burocráticos para responsáveis e gestores.

Além disso, escolas utilizam sistemas diferentes, dificultando a interoperabilidade.

---

## Nossa solução

A plataforma funciona como uma camada de confiança entre instituições de ensino.

Os documentos permanecem armazenados pelos sistemas das escolas, enquanto a blockchain registra informações de verificação, como:

- Hash criptográfico do documento;
- Data de emissão;
- Instituição responsável;
- Histórico de validações;
- Comprovantes de autenticidade.

Dessa forma, qualquer escola autorizada pode verificar rapidamente a autenticidade de um documento sem depender de processos manuais.

---

## Funcionalidades da demonstração

- Cadastro de alunos
- Registro de documentos escolares
- Geração de certificados (hash)
- Solicitação de documentos entre escolas
- Verificação da autenticidade de registros

---

## Tecnologias

- Flutter
- Dart
- Material Design 3
- Blockchain (conceito)
- Solana Attest (planejado)

---

## Como executar

### Pré-requisitos

- Flutter SDK
- Git

### Clonar o projeto

```bash
git clone https://github.com/fabricioreisf/youth_challenge_app_26.git
```

### Entrar na pasta

```bash
cd youth_challenge_app_26
```

### Instalar as dependências

```bash
flutter pub get
```

### Executar

```bash
flutter run
```

Escolha **Chrome** como dispositivo para executar a versão web.
