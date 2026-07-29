import 'package:flutter/material.dart';

final List<Map<String, String>> mockStudents = [
  {'name': 'Ana Beatriz Souza', 'cpf': '123.456.789-00', 'certificate': 'hash-cert-001'},
  {'name': 'Bruno Henrique Lima', 'cpf': '234.567.890-11', 'certificate': 'hash-cert-002'},
  {'name': 'Carla Mendes Rocha', 'cpf': '345.678.901-22', 'certificate': 'hash-cert-003'},
  {'name': 'Diego Almeida Costa', 'cpf': '456.789.012-33', 'certificate': 'hash-cert-004'},
  {'name': 'Eduarda Nunes Pinto', 'cpf': '567.890.123-44', 'certificate': 'hash-cert-005'},
  {'name': 'Felipe Tavares Cruz', 'cpf': '678.901.234-55', 'certificate': 'hash-cert-006'},
  {'name': 'Giovana Pereira Dias', 'cpf': '789.012.345-66', 'certificate': 'hash-cert-007'},
  {'name': 'Henrique Barros Silva', 'cpf': '890.123.456-77', 'certificate': 'hash-cert-008'},
  {'name': 'Isabela Ferreira Gomes', 'cpf': '901.234.567-88', 'certificate': 'hash-cert-009'},
  {'name': 'João Pedro Azevedo', 'cpf': '012.345.678-99', 'certificate': 'hash-cert-010'},
];

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
      const StudentFormPage(),
      const DocumentFormPage(),
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
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Aluno'),
          NavigationDestination(icon: Icon(Icons.upload_file_outlined), selectedIcon: Icon(Icons.upload_file), label: 'Documentos'),
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
          'Visão geral',
          key: const ValueKey('welcome-title'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Acesse os módulos abaixo para consultar, registrar e solicitar documentos escolares.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Cadastro do aluno',
          subtitle: 'Registrar dados principais do aluno e vincular o responsável.',
          icon: Icons.person_add_alt_1_outlined,
          onTap: () => onNavigate(1),
        ),
        _SectionCard(
          title: 'Documentos',
          subtitle: 'Consultar e registrar certificados e registros escolares.',
          icon: Icons.upload_file_outlined,
          onTap: () => onNavigate(2),
        ),
        _SectionCard(
          title: 'Solicitações',
          subtitle: 'Enviar pedidos de documentos entre unidades escolares.',
          icon: Icons.swap_horiz_outlined,
          onTap: () => onNavigate(3),
        ),
        _SectionCard(
          title: 'Verificação',
          subtitle: 'Validar a autenticidade de um registro a partir do CPF ou do certificado.',
          icon: Icons.verified_outlined,
          onTap: () => onNavigate(4),
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
  String _searchResult = '';

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
        Text('Registre os dados principais do aluno no sistema.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _studentController, decoration: const InputDecoration(labelText: 'Nome do aluno')),
        const SizedBox(height: 12),
        TextField(controller: _cpfController, decoration: const InputDecoration(labelText: 'CPF')),
        const SizedBox(height: 12),
        TextField(controller: _responsibleController, decoration: const InputDecoration(labelText: 'Responsável legal')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            final cpf = _cpfController.text.trim();
            final match = mockStudents.firstWhere(
              (student) => student['cpf'] == cpf,
              orElse: () => {'name': '', 'cpf': '', 'certificate': ''},
            );
            setState(() {
              _status = match['name']!.isNotEmpty ? 'Aluno localizado e vinculado ao registro.' : 'Aluno cadastrado no sistema.';
              _searchResult = match['name']!.isNotEmpty ? 'Último certificado: ${match['certificate']}' : '';
            });
          },
          icon: const Icon(Icons.person_add_alt_1_outlined),
          label: const Text('Salvar aluno'),
        ),
        const SizedBox(height: 16),
        Text(_status, style: Theme.of(context).textTheme.bodyMedium),
        if (_searchResult.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(_searchResult, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
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
  final _nameController = TextEditingController(text: 'registro-escolar.pdf');
  String _hash = 'Aguardando geração do certificado.';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Documentos', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Selecione o tipo, carregue o arquivo e registre o certificado associado ao aluno.', style: Theme.of(context).textTheme.bodyLarge),
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
          label: const Text('Registrar certificado'),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Certificado registrado', style: Theme.of(context).textTheme.titleMedium),
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
        Text('Solicitações', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Uma unidade escolar pode solicitar acesso ao documento e a liberação segue o fluxo interno de aprovação.', style: Theme.of(context).textTheme.bodyLarge),
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
        Text('Verificação', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Use o CPF ou o certificado para validar o registro do aluno no sistema.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _hashController, decoration: const InputDecoration(labelText: 'CPF ou certificado')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => setState(() => _isVerified = _hashController.text.isNotEmpty),
          icon: const Icon(Icons.verified_outlined),
          label: const Text('Validar registro'),
        ),
        const SizedBox(height: 16),
        Card(
          color: _isVerified ? Colors.green.shade50 : Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _isVerified ? 'Registro localizado com sucesso.' : 'Ainda não há validação para este registro.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
