# Elicitação de Requisitos — Sistema Unificado de Documentação Escolar
### Youth Challenge Blockchain 2026 (UNICEF Brasil + Blockchain.RIO)

> Documento construído a partir da proposta da equipe + anotações da mentoria. Onde a mentoria já decidiu algo, o requisito reflete isso diretamente; onde ainda está em aberto, está sinalizado na seção 7.

---

## 1. Visão geral e escopo

**Ideia central:** um app web/mobile que permite a escolas cadastrarem documentos escolares de alunos (identificados por CPF) e solicitarem documentos de outras escolas dentro de um sistema unificado nacional, usando blockchain apenas como camada de **validação/"carimbo"** dos documentos — não como local de armazenamento deles.

Vale registrar um ponto de contexto que muda a forma de priorizar: o Youth Challenge Blockchain 2026 é explicitamente um **ideathon — competição de ideias, não de código**. Isso não invalida o plano de vocês de fazer mockup navegável + uma chamada real à blockchain (é uma ótima forma de se diferenciar), mas significa que o "protótipo funcional" é um diferencial de pitch, não uma exigência do edital. Por isso, organizei os requisitos em três camadas de prioridade para facilitar a decisão de escopo com o tempo curto que vocês têm:

| Tag | Camada | O que significa |
|---|---|---|
| 🟢 | **MVP Demo** | Precisa existir como tela navegável no mockup. Pode ser simulado/mockado. |
| 🔵 | **Protótipo funcional** | O que vale a pena fazer *funcionar de verdade* — é onde entra a chamada real à blockchain que a mentoria pediu para mostrar. |
| ⚪ | **Visão de produto** | Faz parte da narrativa do pitch ("onde isso pode chegar"), mas não precisa existir no dia da apresentação. |

---

## 2. Atores / Stakeholders

- **Aluno / criança** — titular dos dados e dos documentos escolares.
- **Responsável legal** — quem consente e autoriza tratamento de dados da criança (obrigatório pela LGPD, ver seção 4).
- **Escola de origem** — instituição que cadastrou/emitiu o documento originalmente.
- **Escola de destino** — instituição que solicita os documentos ao sistema unificado (ex.: em caso de transferência ou nova matrícula).
- **Secretaria de Educação (municipal/estadual/MEC)** — potencial integrador/gestor de política pública no futuro.
- **Verificador externo** — qualquer terceiro (outra escola, universidade, empregador) que precisa confirmar a autenticidade de um documento sem ter acesso direto ao sistema.
- **Administrador do sistema** — monitoramento.

---

## 3. Requisitos Funcionais

### Módulo 1 — Cadastro e Identidade

| ID | Requisito | Prioridade |
|---|---|---|
| RF01 | Cadastro de instituição de ensino, com validação de dados institucionais (CNPJ / código INEP) | 🟢 |
| RF02 | Perfis de acesso por função dentro da escola (secretaria, direção, admin), com permissões distintas | 🔵 |
| RF03 | Autenticação de usuários da escola (login/senha; idealmente 2FA na versão funcional) | 🟢 |
| RF04 | Cadastro de aluno vinculado ao CPF, com busca nacional para evitar duplicidade entre escolas | 🟢 |
| RF05 | Vínculo obrigatório entre o cadastro do aluno e um responsável legal (nome, CPF, comprovação de vínculo) | 🟢 |

### Módulo 2 — Documentos e "carimbo" em blockchain

| ID | Requisito | Prioridade |
|---|---|---|
| RF06 | Upload de documentos escolares (histórico, declaração de matrícula, certificado de conclusão, boletim) | 🟢 |
| RF07 | Geração automática de hash criptográfico do arquivo no momento do upload | 🔵 |
| RF08 | Ancoragem do hash como *attestation* on-chain (a escola atua como emissora/*issuer*) — **este é o "chamado na blockchain" que a mentoria pediu para aparecer na demo** | 🔵 |
| RF09 | Armazenamento do arquivo original em banco de dados/storage tradicional, nunca on-chain, vinculado ao hash ancorado | 🟢 |
| RF10 | Consulta dos documentos de um aluno por CPF, dentro de um fluxo autorizado (ver RNF05) | 🟢 |
| RF11 | Verificação pública de autenticidade de um documento (ex.: via QR code), comparando o hash do arquivo apresentado com o hash ancorado on-chain | 🔵 |
| RF12 | Emissão de certificado/histórico digital em PDF com selo de verificação e QR/link para o registro on-chain | 🟢 |

### Módulo 3 — Solicitação e transferência entre escolas

| ID | Requisito | Prioridade |
|---|---|---|
| RF13 | Escola de destino solicita documentos do sistema unificado informando o CPF do aluno (ex.: nova matrícula) | 🟢 |
| RF14 | Escola de origem e/ou responsável legal precisa aprovar explicitamente a liberação antes do compartilhamento (consentimento) | 🟢 |
| RF15 | Trilha de auditoria de toda solicitação e liberação de documento (quem pediu, quando, para quem foi liberado) | 🔵 |

### Módulo 4 — Carteira e NFT de certificado (ideia "possível" da mentoria)

| ID | Requisito | Prioridade |
|---|---|---|
| RF16 | Criação automática de carteira custodiada para cada aluno cadastrado, sem exigir que o usuário entenda de blockchain | ⚪ |
| RF17 | Emissão de um NFT/attestation representando cada certificado concluído, vinculado à carteira do aluno | ⚪ (bom "efeito wow" se sobrar tempo) |

### Módulo 5 — Mídia descentralizada (referência ao Tape)

| ID | Requisito | Prioridade |
|---|---|---|
| RF18 | Armazenamento de fotos/documentos de identificação em rede de storage descentralizada de baixo custo, como alternativa ao storage tradicional em escala nacional | ⚪ |

### Módulo 6 — Administração

| ID | Requisito | Prioridade |
|---|---|---|
| RF19 | Painel de administração do sistema unificado (aprovação/suspensão de escolas) | ⚪ |
| RF20 | Dashboard de auditoria com link direto para a transação/registro na blockchain (explorer) — bom argumento visual de transparência no pitch | 🔵 |

### Módulo 7 — Demo do ideathon

| ID | Requisito | Prioridade |
|---|---|---|
| RF21 | Telas navegáveis cobrindo o fluxo: cadastro → upload → "carimbo" na blockchain → solicitação por outra escola → verificação pública | 🟢 |
| RF22 | Tela mostrando, ao vivo, a chamada real à blockchain (transação sendo enviada/confirmada), sustentando tecnicamente o pitch | 🔵 |

---

## 4. Requisitos Não Funcionais

| ID | Requisito | Categoria |
|---|---|---|
| RNF01 | Conformidade com a LGPD, com atenção ao Art. 14 (dados de crianças exigem consentimento específico e destacado de responsável legal) | Segurança/Privacidade |
| RNF02 | Alinhamento com o Estatuto da Criança e do Adolescente (ECA) quanto à proteção de dados e imagem de menores | Segurança/Privacidade |
| RNF03 | Nenhum dado pessoal ou documento é armazenado diretamente on-chain — apenas hash/attestation (*privacy by design*) | Segurança/Privacidade |
| RNF04 | Criptografia em trânsito (TLS) e em repouso para documentos e dados pessoais no banco tradicional | Segurança/Privacidade |
| RNF05 | Controle de acesso à consulta por CPF: apenas usuários autenticados com vínculo/solicitação válida podem consultar dados de uma criança — **CPF sozinho não deve ser a única barreira de acesso** | Segurança/Privacidade |
| RNF06 | Log de auditoria completo (idealmente imutável) de todo acesso a dados de menores | Segurança/Privacidade |
| RNF07 | Custo de ancoragem por documento significativamente menor que manter redundância/imutabilidade equivalente só em cloud tradicional | Desempenho/Custo |
| RNF08 | Emissão de certificado responde em poucos segundos, mesmo com a confirmação on-chain rodando de forma assíncrona | Desempenho |
| RNF09 | Consulta e emissão de documentos continuam funcionando mesmo com a rede blockchain temporariamente lenta/indisponível (ancoragem fica "pendente" sem travar o uso) | Disponibilidade |
| RNF10 | Alta disponibilidade em períodos de matrícula (picos sazonais no início do ano letivo) | Disponibilidade |
| RNF11 | Arquitetura capaz de escalar para o volume da educação básica brasileira (dezenas de milhões de alunos) | Escalabilidade |
| RNF12 | Operável por funcionários de secretaria escolar sem qualquer conhecimento prévio de blockchain | Usabilidade |
| RNF13 | Interface acessível (WCAG) e responsiva (web + mobile) | Usabilidade |
| RNF14 | Estrutura de dados compatível/mapeável com sistemas do MEC (Educacenso/INEP) para integração futura | Interoperabilidade |
| RNF15 | Qualquer parte interessada consegue verificar publicamente a autenticidade de um "carimbo" sem depender de confiar cegamente na instituição emissora | Auditabilidade/Confiança |
| RNF16 | Camada de storage tradicional desacoplada do provedor de blockchain escolhido, para permitir trocar de rede sem perder o histórico ancorado | Portabilidade |

---

## 5. Regras de negócio (diretamente da conversa com a mentoria)

- Blockchain **nunca** guarda o documento em si — só valida (hash/attestation).
- O documento original **sempre** fica em banco de dados tradicional (cloud), nunca on-chain.
- Todo documento salvo recebe automaticamente um "carimbo" on-chain (prova de existência + timestamp), permitindo consulta rápida e verificação futura.
- Carteiras são custodiadas pela plataforma — o usuário final não precisa interagir diretamente com conceitos de blockchain ("a pessoa nem sabe de nada, mas tá lá salvo").

---

## 6. Onde os links da mentoria se encaixam

**[attest.solana.com](https://attest.solana.com)** — é o **Solana Attestation Service (SAS)**: um protocolo aberto onde um **emissor confiável** (a escola) cria uma *attestation* (uma prova assinada) vinculada à carteira de um **titular** (o aluno), e qualquer **verificador** pode confirmar essa prova sem acessar o dado original. Esse modelo *issuer → holder → verifier* casa exatamente com o que a mentoria descreveu: a escola "carimba" o documento na blockchain (RF08), e outra escola ou terceiro verifica sem precisar confiar cegamente em um servidor central (RNF15). É a peça técnica mais natural para RF08 e RF11.

**[tape.network](https://tape.network)** — é a **Tape Network** (ex-Tapedrive): storage de objetos nativo do Solana, que ancora os registros de escrita no ledger mas guarda o dado pesado (imagens, vídeo, arquivos) fora da cadeia principal, com custo bem menor que gravar bytes diretamente on-chain. Faz sentido como resposta técnica ao "tape: guardar fotos onchain" (RF18) — mas note que ainda é **storage**, não é a peça de validação; a lógica de "carimbo"/prova continua sendo função do SAS, não do Tape.

Sobre o "por que blockchain?" do pitch, a mentoria já trouxe dois argumentos (custo reduzido em escala vs. cloud, e imutabilidade). Vale considerar um terceiro, comum nesse tipo de proposta e que reforça o caso de uso "sistema unificado entre milhares de escolas": **confiança descentralizada** — a verificação de um documento não depende de confiar em um único servidor de uma única escola ou empresa, o que importa quando o sistema conecta instituições diferentes, com níveis de infraestrutura muito diferentes, em todo o Brasil.

---

## 7. Pontos em aberto (para decidir com a equipe/mentoria)

1. **A carteira é da escola ou do aluno?** Tecnicamente, a escola faz mais sentido como *issuer* de cada attestation. Para a narrativa de "certificado que a criança carrega para a vida toda", o aluno/responsável faz mais sentido como *holder*. Uma saída comum: carteira custodiada pela plataforma **em nome do aluno**, com a escola atuando só como emissora de cada carimbo — coerente com a própria observação da mentoria ("a pessoa nem sabe de nada, mas tá lá salvo").
2. **Comprometer-se com Solana especificamente**, já que os dois links apontam para esse ecossistema, ou manter o pitch mais agnóstico ("qualquer chain compatível")?
3. **Quem paga o custo da transação (gas)?** Recomendo modelo subsidiado pela plataforma/escola (comum em soluções B2G com blockchain), para que família e aluno nunca precisem ter criptoativos.
4. **Corte exato do MVP de demo**: quais RFs entram só como mockup navegável (🟢) e qual(is) precisam mesmo funcionar com chamada real (🔵)? A tabela da seção 3 já é um ponto de partida para essa conversa.
5. **Tape entra na demo ou fica só citado como próximo passo no pitch?** Dado o prazo curto, uma opção segura é deixá-lo como visão de produto (⚪) e focar o tempo de dev no SAS.
6. **Segurança do "CPF como chave de busca"**: como impedir que qualquer escola  consulte o histórico de qualquer criança só sabendo o CPF dela? Precisa de uma camada extra de autorização — por exemplo, só liberar dados após uma solicitação formal aceita pela escola de origem ou pelo responsável (RF14 já aponta essa direção, mas vale deixar isso explícito no pitch como um cuidado de proteção à criança, o que é literalmente o tema do desafio).

---

## 8. Roteiro sugerido para a demo

1. Cadastro de escola/aluno (mockup) — 🟢
2. Upload de um documento por uma escola fictícia (mockup) — 🟢
3. **Chamada real à blockchain criando o "carimbo"** do documento — momento técnico central do pitch — 🔵
4. Uma segunda escola solicitando aquele aluno via CPF (mockup) — 🟢
5. Verificação pública mostrando "documento autêntico ✅", comparando hash local com hash on-chain — 🔵
6. Fechamento explicando "por que blockchain": custo, imutabilidade e confiança entre instituições
