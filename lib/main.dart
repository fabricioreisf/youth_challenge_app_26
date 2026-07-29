import 'package:flutter/material.dart';

void main() {
  runApp(const YouthChallengeApp());
}

class YouthChallengeApp extends StatelessWidget {
  const YouthChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Documentação Escolar Unificada',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DemoNavigationPage(),
    );
  }
}

class DemoNavigationPage extends StatefulWidget {
  const DemoNavigationPage({super.key});

  @override
  State<DemoNavigationPage> createState() => _DemoNavigationPageState();
}

class _DemoNavigationPageState extends State<DemoNavigationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      OverviewPage(onNavigate: (index) => setState(() => _selectedIndex = index)),
      const SchoolFormPage(),
      const StudentFormPage(),
      const DocumentFormPage(),
      const BlockchainPage(),
      const RequestPage(),
      const VerificationPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentação Escolar Unificada'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Visão geral'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Escola'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Aluno'),
          NavigationDestination(icon: Icon(Icons.upload_file_outlined), selectedIcon: Icon(Icons.upload_file), label: 'Docs'),
          NavigationDestination(icon: Icon(Icons.fact_check_outlined), selectedIcon: Icon(Icons.fact_check), label: 'Blockchain'),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined), selectedIcon: Icon(Icons.swap_horiz), label: 'Solicitações'),
          NavigationDestination(icon: Icon(Icons.verified_outlined), selectedIcon: Icon(Icons.verified), label: 'Verificação'),
        ],
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const OverviewPage({required this.onNavigate, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Visão geral da demo',
          key: const ValueKey('welcome-title'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'A navegação está aberta para qualquer ordem. Explore os módulos abaixo e monte a demo da forma que preferir.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Cadastro da escola',
          subtitle: 'Incluir escola, CNPJ e dados institucionais.',
          icon: Icons.school_outlined,
          onTap: () => onNavigate(1),
        ),
        _SectionCard(
          title: 'Cadastro do aluno',
          subtitle: 'Vincular aluno, CPF e responsável legal.',
          icon: Icons.person_add_alt_1_outlined,
          onTap: () => onNavigate(2),
        ),
        _SectionCard(
          title: 'Upload de documentos',
          subtitle: 'Registrar histórico, boletim e certificados.',
          icon: Icons.upload_file_outlined,
          onTap: () => onNavigate(3),
        ),
        _SectionCard(
          title: 'Carimbo na blockchain',
          subtitle: 'Emitir a attestation e mostrar o registro.',
          icon: Icons.fact_check_outlined,
          onTap: () => onNavigate(4),
        ),
        _SectionCard(
          title: 'Solicitações',
          subtitle: 'Conceder ou solicitar documentos entre escolas.',
          icon: Icons.swap_horiz_outlined,
          onTap: () => onNavigate(5),
        ),
        _SectionCard(
          title: 'Verificação pública',
          subtitle: 'Validar a autenticidade do documento.',
          icon: Icons.verified_outlined,
          onTap: () => onNavigate(6),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class SchoolFormPage extends StatefulWidget {
  const SchoolFormPage({super.key});

  @override
  State<SchoolFormPage> createState() => _SchoolFormPageState();
}

class _SchoolFormPageState extends State<SchoolFormPage> {
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _inepController = TextEditingController();
  final _contactController = TextEditingController();
  String _status = 'Pronto para cadastrar a escola.';

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _inepController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Cadastro da escola', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Preencha os dados institucionais para abrir o fluxo da demo.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome da escola')),
        const SizedBox(height: 12),
        TextField(controller: _cnpjController, decoration: const InputDecoration(labelText: 'CNPJ')),
        const SizedBox(height: 12),
        TextField(controller: _inepController, decoration: const InputDecoration(labelText: 'Código INEP')),
        const SizedBox(height: 12),
        TextField(controller: _contactController, decoration: const InputDecoration(labelText: 'Contato responsável')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            setState(() {
              _status = 'Escola cadastrada com sucesso para a demo.';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro da escola concluído.')),
            );
          },
          icon: const Icon(Icons.save_alt_rounded),
          label: const Text('Salvar cadastro'),
        ),
        const SizedBox(height: 16),
        Text(_status, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _studentController = TextEditingController();
  final _cpfController = TextEditingController();
  final _responsibleController = TextEditingController();
  String _status = 'Aguardando cadastro do aluno.';

  @override
  void dispose() {
    _studentController.dispose();
    _cpfController.dispose();
    _responsibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Cadastro do aluno', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('O fluxo permite incluir aluno, CPF e responsável em qualquer ordem.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _studentController, decoration: const InputDecoration(labelText: 'Nome do aluno')),
        const SizedBox(height: 12),
        TextField(controller: _cpfController, decoration: const InputDecoration(labelText: 'CPF')),
        const SizedBox(height: 12),
        TextField(controller: _responsibleController, decoration: const InputDecoration(labelText: 'Responsável legal')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            setState(() {
              _status = 'Aluno vinculado com sucesso ao fluxo.';
            });
          },
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('Salvar aluno'),
        ),
        const SizedBox(height: 16),
        Text(_status, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class DocumentFormPage extends StatefulWidget {
  const DocumentFormPage({super.key});

  @override
  State<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends State<DocumentFormPage> {
  String _selectedType = 'Boletim';
  final _nameController = TextEditingController(text: 'documento-demo.pdf');
  String _hash = 'Aguardando geração do hash.';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Upload de documentos', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Selecione o tipo, carregue o arquivo e gere o hash para o carimbo.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: _selectedType,
          decoration: const InputDecoration(labelText: 'Tipo de documento'),
          items: const [
            DropdownMenuItem(value: 'Boletim', child: Text('Boletim')),
            DropdownMenuItem(value: 'Histórico', child: Text('Histórico')),
            DropdownMenuItem(value: 'Declaração', child: Text('Declaração')),
            DropdownMenuItem(value: 'Certificado', child: Text('Certificado')),
          ],
          onChanged: (value) => setState(() => _selectedType = value ?? _selectedType),
        ),
        const SizedBox(height: 12),
        TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome do arquivo')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            final generated = 'sha256:${_selectedType.toLowerCase()}-${_nameController.text.hashCode.toRadixString(16)}';
            setState(() => _hash = generated);
          },
          icon: const Icon(Icons.generating_tokens_outlined),
          label: const Text('Gerar hash simulado'),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hash gerado', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                SelectableText(_hash),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BlockchainPage extends StatefulWidget {
  const BlockchainPage({super.key});

  @override
  State<BlockchainPage> createState() => _BlockchainPageState();
}

class _BlockchainPageState extends State<BlockchainPage> {
  bool _isStamped = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Carimbo na blockchain', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Esta tela simula a emissão da attestation para a demo.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status do registro', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(_isStamped ? 'Registro criado com sucesso.' : 'Aguardando criação do carimbo.'),
                const SizedBox(height: 8),
                Text(_isStamped ? 'tx-demo-2026-07-29' : 'Sem transação enviada ainda.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => setState(() => _isStamped = true),
          icon: const Icon(Icons.fact_check_outlined),
          label: const Text('Criar carimbo'),
        ),
      ],
    );
  }
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _cpfController = TextEditingController();
  final _requestController = TextEditingController();
  String _status = 'Aguardando solicitação.';

  @override
  void dispose() {
    _cpfController.dispose();
    _requestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Solicitação entre escolas', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('A outra escola pode pedir acesso ao documento e a liberação passa por consentimento.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _cpfController, decoration: const InputDecoration(labelText: 'CPF do aluno')),
        const SizedBox(height: 12),
        TextField(controller: _requestController, decoration: const InputDecoration(labelText: 'Motivo da solicitação')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            setState(() => _status = 'Solicitação enviada para aprovação.');
          },
          icon: const Icon(Icons.send_outlined),
          label: const Text('Enviar solicitação'),
        ),
        const SizedBox(height: 16),
        Text(_status, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _hashController = TextEditingController();
  bool _isVerified = false;

  @override
  void dispose() {
    _hashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Verificação pública', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Use o hash ou a referência de transação para validar a autenticidade do documento.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _hashController, decoration: const InputDecoration(labelText: 'Hash ou transação')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => setState(() => _isVerified = _hashController.text.isNotEmpty),
          icon: const Icon(Icons.verified_outlined),
          label: const Text('Validar documento'),
        ),
        const SizedBox(height: 16),
        Card(
          color: _isVerified ? Colors.green.shade50 : Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _isVerified ? 'Documento autenticado com sucesso.' : 'Ainda não há validação para este registro.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
