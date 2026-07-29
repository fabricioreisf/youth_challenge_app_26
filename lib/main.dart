import 'package:flutter/material.dart';
import 'repositories/document_repository.dart';
import 'repositories/student_repository.dart';
import 'services/attestation_service.dart';
import 'models/document_request.dart';
import 'models/educational_document.dart';
import 'models/student.dart';

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
  final StudentRepository _studentRepository = StudentRepository();
  final DocumentRepository _documentRepository = DocumentRepository();
  final AttestationService _attestationService = AttestationService();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _studentRepository.addStudent(Student(
      id: 'student-1',
      name: 'Ana Beatriz Souza',
      cpf: '123.456.789-00',
      guardianName: 'Maria Souza',
      guardianCpf: '111.222.333-44',
      schoolName: 'Escola Municipal de Ensino Fundamental',
    ));
    _documentRepository.addDocument(EducationalDocument(
      id: 'doc-1',
      studentId: 'student-1',
      type: 'Histórico',
      title: 'Histórico escolar',
      fileName: 'historico-ana.pdf',
      hash: _attestationService.createHash('historico-ana.pdf'),
      attestationId: _attestationService.createAttestationId('historico-ana.pdf'),
      status: 'registrado',
      createdAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      OverviewPage(
        onNavigate: (index) => setState(() => _selectedIndex = index),
        onStartDemo: () => setState(() => _selectedIndex = 1),
      ),
      SchoolRegistrationPage(
        studentRepository: _studentRepository,
        documentRepository: _documentRepository,
        attestationService: _attestationService,
      ),
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
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Escola'),
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
  final VoidCallback onStartDemo;

  const OverviewPage({required this.onNavigate, required this.onStartDemo, super.key});

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
          'Uma demo navegável para mostrar como uma escola registra alunos, carimba documentos e solicita transferências com consentimento.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          key: const ValueKey('start-demo-button'),
          onPressed: onStartDemo,
          icon: const Icon(Icons.play_arrow_outlined),
          label: const Text('Iniciar demo'),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Cadastro do aluno',
          subtitle: 'Registrar a instituição e o fluxo inicial do aluno.',
          icon: Icons.school_outlined,
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

  const _SectionCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class SchoolRegistrationPage extends StatefulWidget {
  const SchoolRegistrationPage({required this.studentRepository, required this.documentRepository, required this.attestationService, super.key});

  final StudentRepository studentRepository;
  final DocumentRepository documentRepository;
  final AttestationService attestationService;

  @override
  State<SchoolRegistrationPage> createState() => _SchoolRegistrationPageState();
}

class _SchoolRegistrationPageState extends State<SchoolRegistrationPage> {
  final _schoolController = TextEditingController(text: 'Escola Municipal de Ensino Fundamental');
  final _studentController = TextEditingController(text: 'Ana Beatriz Souza');
  final _cpfController = TextEditingController(text: '123.456.789-00');
  final _guardianController = TextEditingController(text: 'Maria Souza');
  final _guardianCpfController = TextEditingController(text: '111.222.333-44');
  String _status = 'Pronto para registrar o aluno.';

  @override
  void dispose() {
    _schoolController.dispose();
    _studentController.dispose();
    _cpfController.dispose();
    _guardianController.dispose();
    _guardianCpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Cadastro do aluno', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Cadastro da escola', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Registre os dados principais do aluno no sistema.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 12),
        Text('Cadastre a instituição, o aluno e o responsável legal para dar início ao fluxo de documentos.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        TextField(controller: _schoolController, decoration: const InputDecoration(labelText: 'Nome da escola')),
        const SizedBox(height: 12),
        TextField(controller: _studentController, decoration: const InputDecoration(labelText: 'Nome do aluno')),
        const SizedBox(height: 12),
        TextField(controller: _cpfController, decoration: const InputDecoration(labelText: 'CPF')),
        const SizedBox(height: 12),
        TextField(controller: _guardianController, decoration: const InputDecoration(labelText: 'Responsável legal')),
        const SizedBox(height: 12),
        TextField(controller: _guardianCpfController, decoration: const InputDecoration(labelText: 'CPF do responsável')),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            final student = Student(
              id: 'student-${DateTime.now().millisecondsSinceEpoch}',
              name: _studentController.text.trim(),
              cpf: _cpfController.text.trim(),
              guardianName: _guardianController.text.trim(),
              guardianCpf: _guardianCpfController.text.trim(),
              schoolName: _schoolController.text.trim(),
            );
            widget.studentRepository.addStudent(student);
            widget.documentRepository.addDocument(EducationalDocument(
              id: 'doc-${DateTime.now().millisecondsSinceEpoch}',
              studentId: student.id,
              type: 'Histórico',
              title: 'Histórico escolar',
              fileName: '${student.name.toLowerCase().replaceAll(RegExp(r'\\s+'), '-')}.pdf',
              hash: widget.attestationService.createHash(student.cpf),
              attestationId: widget.attestationService.createAttestationId(student.cpf),
              status: 'registrado',
              createdAt: DateTime.now(),
            ));
            setState(() => _status = 'Aluno e documento registrados com carimbo de validação.');
          },
          icon: const Icon(Icons.school_outlined),
          label: const Text('Registrar escola e aluno'),
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
