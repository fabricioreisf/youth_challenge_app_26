## Plano de implementação — MVP da demo de documentação escolar

Objetivo: entregar uma demo navegável e tecnicamente convincente do fluxo completo de cadastro, upload, carimbo em blockchain, solicitação entre escolas e verificação pública, alinhada à elicitação de requisitos.

### Escopo do MVP
- Incluir telas para cadastro de aluno com CPF, vínculo com responsável, upload de documento, emissão de carimbo, solicitação entre escolas e verificação pública.
- Priorizar o fluxo de demo descrito em RF21 e RF22, com chamada real à blockchain para o carimbo e verificação.
- Manter o armazenamento do arquivo original em banco tradicional e não on-chain.
- Não incluir NFT, Tape, painel administrativo completo ou integrações avançadas no primeiro ciclo.

### Fases de execução
1. Definição e estrutura do MVP
   - Definir telas essenciais, dados mínimos e fluxo de navegação.
   - Escolher a estratégia de autenticação demo e o modelo de consentimento para responsável.
   - MVP usa uma camada de mock com endpoint de demonstração.

2. Fundamentos do app
   - Estruturar o projeto Flutter com navegação por telas, estado compartilhado e camada de serviços.
   - Criar modelos de dados para escola, aluno, responsável, documento, solicitação e registro on-chain.
   - Implementar armazenamento local ou backend simplificado para sustentar a demo.

3. Fluxo principal da demo
   - Tela de cadastro de aluno e responsável.
   - Tela de upload e seleção de tipo de documento.
   - Tela de confirmação de emissão com geração de hash e envio para o registro on-chain.
   - Tela de solicitação de documentos para outra escola.
   - Tela de verificação pública com comparação de hash e status do registro.

4. Integração blockchain
   - Implementar a camada de serviço para gerar hash do documento.
   - Criar o fluxo de emissão de attestation com chamada real ao serviço escolhido.
   - Expor o status da transação e o link de verificação para a demo.
   - Garantir fallback gracioso caso a rede esteja lenta.

5. Polimento e validação
   - Ajustar UX para ser claro e rápido em uma apresentação curta.
   - Preparar conteúdo visual de apoio, QR code e explicações de pitch.
   - Validar todos os passos da demo em sequência sem erros.

### Entregáveis esperados
- App com fluxo completo de demo, navegável e convincente.
- Registro de hash/attestation com evidência visual na interface.
- Tela de verificação pública com resultado claro.
- Documento preparado para apresentação em pitch.

### Critérios de aceite
- A demo completa o fluxo cadastro → upload → carimbo → solicitação → verificação em menos de 10 minutos.
- O app mostra claramente que o documento original fica fora da blockchain.
- A chamada blockchain é visível e explicável para o público.
- A interface é simples o suficiente para ser compreendida por um público não técnico.

### Pontos de atenção
- Priorizar clareza de narrativa sobre o problema e a solução.
- Evitar escopo excessivo de backend, permissões complexas e integrações não essenciais.
- Ter um plano de contingência para falha de rede no dia da apresentação.
