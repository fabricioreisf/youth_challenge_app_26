// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'repositories/document_repository.dart';
import 'repositories/student_repository.dart';
import 'services/attestation_service.dart';
// import 'models/document_request.dart';
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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 2,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: const OnboardingPage(),    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  int _currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "icon": Icons.school,
      "title": "Bem-vindo ao EduPass!",
      "description":
          "Uma plataforma segura para registrar, compartilhar e validar documentos escolares utilizando blockchain.",
    },
    {
      "icon": Icons.person_search,
      "title": "👧📄 Nenhuma criança sem identidade",
      "description":
          "Cadastre estudantes sem documentação e acompanhe todo o processo de regularização com transparência.",
    },
    {
      "icon": Icons.verified,
      "title": "🛡️✔️ Confiança em segundos",
      "description":
          "Valide históricos, certificados e registros escolares instantaneamente, reduzindo fraudes e burocracia.",
    },

    
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DemoNavigationPage(),
                                ),
                              );
                            },
                            child: const Text("Pular"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    page["icon"],
                                    size: 65,
                                    color: Colors.indigo,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  page["title"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  page["description"],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.grey.shade700,
                                        height: 1.6,
                                  ),                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.indigo
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: FilledButton(
                onPressed: () {

                  if (_currentPage == pages.length - 1) {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DemoNavigationPage(),
                      ),
                    );

                  } else {

                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                  }

                },
                child: Text(
                  _currentPage == pages.length - 1
                      ? "Começar"
                      : "Próximo",
                ),
              ),
            )
          ],
        ),
      ),
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
      const UndocumentedChildPage(),
      const DocumentFormPage(),
      const RequestPage(),
      const VerificationPage(),
      const FAQPage(),
    ];

    return Scaffold(
     body: SafeArea(
  child: Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: pages[_selectedIndex],
      ),
    ),
  ),
),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Visão geral'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Cadastro'),
          NavigationDestination( icon: Icon(Icons.person_search_outlined), selectedIcon: Icon(Icons.person_search), label: 'Cadrasto sem documentos'),
          NavigationDestination(icon: Icon(Icons.upload_file_outlined), selectedIcon: Icon(Icons.upload_file), label: 'Documentos'),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined), selectedIcon: Icon(Icons.swap_horiz), label: 'Solicitações'),
          NavigationDestination(icon: Icon(Icons.verified_outlined), selectedIcon: Icon(Icons.verified), label: 'Verificação'),
        NavigationDestination(
  icon: Icon(Icons.help_outline),
  selectedIcon: Icon(Icons.help),
  label: 'Q&A',
),
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
         const PageHeader( title: 'Documentação Escolar Unificada', subtitle: 'Documentação escolar segura utilizando blockchain.', icon: Icons.school,),
        
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

Container(

  padding: const EdgeInsets.all(16),

  decoration: BoxDecoration(

    color: Colors.indigo.shade50,

    borderRadius:
        BorderRadius.circular(16),

  ),

  child: const Row(

    children:[

      Icon(Icons.info),

      SizedBox(width:10),

      Expanded(

        child: Text(

          "Todos os registros possuem autenticação baseada em blockchain.",

        ),
      ),
    ],
  ),
),

Row(
  children: [
    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Icon(Icons.people, size: 30),
              SizedBox(height: 8),
              Text(
                '128',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Alunos'),
            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Icon(Icons.description, size: 30),
              SizedBox(height: 8),
              Text(
                '312',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Documentos'),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 12),

Row(
  children: [
    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Icon(Icons.badge, size: 30),
              SizedBox(height: 8),
              Text(
                '15',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Identidades'),
            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Icon(Icons.verified, size: 30),
              SizedBox(height: 8),
              Text(
                '287',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Verificações'),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _SectionCard(
                  title: 'Cadastro do aluno',
                  subtitle: 'Cadastre um novo estudante e registre seu histórico na blockchain.',
                  icon: Icons.school_outlined,
                  onTap: () => onNavigate(1),
                ),
                _SectionCard(
                  title: 'Cadrasto do aluno sem documentos',
                  subtitle: 'Registrar aluno que não há documentos registrados.',
                  icon: Icons.person_search_outlined,
                  onTap: () => onNavigate(2),
                ),
                _SectionCard(
                  title: 'Documentos',
                  subtitle: 'Consultar e registrar documentos escolares.',
                  icon: Icons.upload_file_outlined,
                  onTap: () => onNavigate(3),
                ),
                _SectionCard(
                  title: 'Solicitações',
                  subtitle: 'Solicitar pedidos de documentos entre unidades escolares.',
                  icon: Icons.swap_horiz_outlined,
                  onTap: () => onNavigate(4),
                ),
                _SectionCard(
                  title: 'Verificação',
                  subtitle: 'Verificar a autenticidade de um registro a partir do CPF ou do certificado.',
                  icon: Icons.verified_outlined,
                  onTap: () => onNavigate(5),
                ),
                _SectionCard(
                  title: 'Perguntas Frequentes',
                  subtitle: 'Tire dúvidas sobre o funcionamento da plataforma.',
                  icon: Icons.help_outline,
                  onTap: () => onNavigate(6),
                ),
              ],
            ),
          ),
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
      child: Padding(
  padding: const EdgeInsets.all(12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      CircleAvatar(
        radius: 24,
        child: Icon(icon),
      ),

      const SizedBox(height:16),

      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),

      const SizedBox(height:8),

      Text(subtitle),

      const SizedBox(height:16),

      FilledButton(
        onPressed: onTap,
        child: const Text("Acessar"),
      ),

    ],
  ),
)
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3949AB),
            Color(0xFF5C6BC0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.indigo.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
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

bool _validateFields() {
  if (_schoolController.text.trim().isEmpty) {
    _showError('Informe o nome da escola.');
    return false;
  }

  if (_studentController.text.trim().isEmpty) {
    _showError('Informe o nome do aluno.');
    return false;
  }

  if (_cpfController.text.trim().isEmpty) {
    _showError('Informe o CPF do aluno.');
    return false;
  }

final cpf = _cpfController.text.replaceAll(RegExp(r'\D'), '');

if (cpf.length != 11) {
  _showError('CPF do aluno deve conter 11 dígitos.');
  return false;
}

  if (_guardianController.text.trim().isEmpty) {
    _showError('Informe o responsável legal.');
    return false;
  }

  if (_guardianCpfController.text.trim().isEmpty) {
    _showError('Informe o CPF do responsável.');
    return false;
  }

final guardianCpf =
    _guardianCpfController.text.replaceAll(RegExp(r'\D'), '');

if (guardianCpf.length != 11) {
  _showError('CPF do responsável deve conter 11 dígitos.');
  return false;
}

  return true;
}

void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const PageHeader(
          title: 'Documentação Escolar Unificada',
          subtitle: 'Documentação escolar segura utilizando blockchain.',
          icon: Icons.school,
        ),
        Text(
          'Cadastro do aluno',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cadastre a instituição, o aluno e o responsável legal para dar início ao fluxo de documentos.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _schoolController,
                  decoration: InputDecoration(
                    labelText: 'Nome da escola',
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _studentController,
                  decoration: InputDecoration(
                    hintText: 'Nome do aluno',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _cpfController,
                  decoration: InputDecoration(
                    hintText: 'CPF',
                    prefixIcon: const Icon(Icons.badge),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _guardianController,
                  decoration: InputDecoration(
                    hintText: 'Nome do responsável legal',
                    prefixIcon: const Icon(Icons.family_restroom_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _guardianCpfController,
                  decoration: InputDecoration(
                    hintText: 'CPF do responsável',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    if (!_validateFields()) return;
                    final student = Student(
                      id: 'student-${DateTime.now().millisecondsSinceEpoch}',
                      name: _studentController.text.trim(),
                      cpf: _cpfController.text.trim(),
                      guardianName: _guardianController.text.trim(),
                      guardianCpf: _guardianCpfController.text.trim(),
                      schoolName: _schoolController.text.trim(),
                    );
                    widget.studentRepository.addStudent(student);
                    widget.documentRepository.addDocument(
                      EducationalDocument(
                        id: 'doc-${DateTime.now().millisecondsSinceEpoch}',
                        studentId: student.id,
                        type: 'Histórico',
                        title: 'Histórico escolar',
                        fileName:
                            '${student.name.toLowerCase().replaceAll(RegExp(r'\s+'), '-')}.pdf',
                        hash: widget.attestationService.createHash(student.cpf),
                        attestationId: widget.attestationService
                            .createAttestationId(student.cpf),
                        status: 'registrado',
                        createdAt: DateTime.now(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Aluno cadastrado com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() => _status = 'Aluno cadastrado com sucesso!');
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Cadrastar aluno'),
                ),
                const SizedBox(height: 16),
                Text(
                  _status,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
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
        const PageHeader(
          title: 'Documentação Escolar Unificada',
          subtitle: 'Documentação escolar segura utilizando blockchain.',
          icon: Icons.school,
        ),
        Text(
          'Documentos',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecione o tipo, carregue o arquivo e registre o certificado associado ao aluno.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  decoration: InputDecoration(
                    labelText: 'Tipo de documento',
                    prefixIcon: const Icon(Icons.folder_copy),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Boletim', child: Text('Boletim')),
                    DropdownMenuItem(value: 'Histórico', child: Text('Histórico')),
                    DropdownMenuItem(value: 'Declaração', child: Text('Declaração')),
                    DropdownMenuItem(value: 'Certificado', child: Text('Certificado')),
                  ],
                  onChanged: (value) => setState(() => _selectedType = value ?? _selectedType),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do arquivo',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final generated =
                        'sha256:${_selectedType.toLowerCase()}-${_nameController.text.hashCode.toRadixString(16)}';
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
                        Text(
                          'Certificado registrado',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        SelectableText(_hash),
                      ],
                    ),
                  ),
                ),
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
        const PageHeader( title: 'Documentação Escolar Unificada', subtitle: 'Documentação escolar segura utilizando blockchain.', icon: Icons.school,),
        Text('Solicitações', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          'Uma unidade escolar pode solicitar acesso ao documento e a liberação segue o fluxo interno de aprovação.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  decoration: const InputDecoration(
                    hintText: 'CPF',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
                TextField(
                  controller: _requestController,
                  decoration: InputDecoration(
                    labelText: 'Motivo da solicitação',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
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
            ),
          ),
        ),
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
        const PageHeader(
          title: 'Documentação Escolar Unificada',
          subtitle: 'Documentação escolar segura utilizando blockchain.',
          icon: Icons.school,
        ),
        Text(
          'Verificação',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Use o CPF ou o certificado para validar o registro do aluno no sistema.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _hashController,
                  decoration: InputDecoration(
                    labelText: 'CPF ou certificado',
                    prefixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => setState(
                    () => _isVerified = _hashController.text.isNotEmpty,
                  ),
                  icon: const Icon(Icons.verified_outlined),
                  label: const Text('Validar registro'),
                ),
                const SizedBox(height: 16),
                if (_isVerified)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: Colors.green,
                              ),
                              SizedBox(width: 8),
                              Text('Documento Autêntico'),
                            ],
                          ),
                          const Divider(),
                          Text('Aluno: Ana Beatriz'),
                          Text('Documento: Histórico'),
                          Text('Escola: Municipal'),
                          Text('Blockchain: Solana'),
                          Text('Hash: 7AB38C91...'),
                        ],
                      ),
                    ),
                  )
                else
                  Text(
                    'Informe um CPF ou certificado para validar o registro.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UndocumentedChildPage extends StatefulWidget {
  const UndocumentedChildPage({super.key});

  @override
  State<UndocumentedChildPage> createState() =>
      _UndocumentedChildPageState();
}

class _UndocumentedChildPageState
    extends State<UndocumentedChildPage> {

  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _cityController = TextEditingController();
  final _guardianController = TextEditingController();

bool _registered = false;
// ignore: unused_field
bool _identityCreated = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _cityController.dispose();
    _guardianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return ListView(
    children: [
      const PageHeader( title: 'Documentação Escolar Unificada', subtitle: 'Documentação escolar segura utilizando blockchain.', icon: Icons.school,),
      Text(
        'Cadastro do aluno sem documentação',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),

      const SizedBox(height: 8),

      Text(
        'Permite iniciar o registro escolar mesmo quando a criança ainda não possui toda a documentação oficial.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),

      const SizedBox(height: 24),

Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome da criança',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: _birthController,
                  decoration: InputDecoration(
                    labelText: 'Data aproximada de nascimento',
                    prefixIcon: const Icon(Icons.cake),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Município',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: _guardianController,
                  decoration: InputDecoration(
                    labelText: 'Responsável',
                    prefixIcon: const Icon(Icons.family_restroom),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                FilledButton.icon(
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text("Registrar criança"),
                  onPressed: () {
                    setState(() {
                      _registered = true;
                    });
                  },
                ),

                const SizedBox(height: 20),

                if (_registered) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Solicitação criada",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Status: Em validação"),
                          SizedBox(height: 10),
                          Text("✔ Escola"),
                          Text("✔ UBS"),
                          Text("✔ Conselho Tutelar"),
                          Text("⏳ Cartório"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text("Emitir Identidade Digital Provisória"),
                    onPressed: () {
                      setState(() {
                        _identityCreated = true;
                      });
                    },
                  ),
                  if (_identityCreated)
                    Card(
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Identidade Digital emitida",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text("Status: Ativa"),
                            SizedBox(height: 8),
                            Text("Blockchain: Solana"),
                            SizedBox(height: 8),
                            Text("Wallet ID: 7Y4M...X2KP"),
                            SizedBox(height: 8),
                            Text("Attestation registrada"),
                            SizedBox(height: 8),
                            Text("Hash: 0xA7F83B91E2C45F"),
                          ],
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        const PageHeader(
          title: 'Perguntas Frequentes',
          subtitle: 'Entenda como funciona a plataforma.',
          icon: Icons.help_outline,
        ),

        Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Pesquisar uma dúvida...',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
),

        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.school),
            title: const Text('O que é a plataforma?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'É um sistema para registrar, compartilhar e validar documentos escolares utilizando blockchain.',
                ),
              ),
            ],
          ),
        ),

Padding(
  padding: const EdgeInsets.only(top: 20, bottom: 10),
  child: Text(
    "Cadastros",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.person_search),
            title: const Text('E se a criança não possuir documentos?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'A escola pode criar uma identidade provisória e iniciar o processo de regularização junto aos órgãos responsáveis.',
                ),
              ),
            ],
          ),
        ),
        Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.person_add),
    ),
    title: const Text("Quem pode cadastrar um aluno?"),
    subtitle: const Text("Saiba quem possui acesso."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "O cadastro é realizado por escolas e instituições autorizadas, garantindo que as informações sejam inseridas por responsáveis habilitados.",
        ),
      ),
    ],
  ),
),
Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.description),
    ),
    title: const Text("Quais documentos podem ser registrados?"),
    subtitle: const Text("Tipos de documentos aceitos."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "A plataforma permite registrar boletins, históricos escolares, declarações, certificados e outros documentos emitidos pelas instituições de ensino.",
        ),
      ),
    ],
  ),
),

        Padding(
  padding: const EdgeInsets.only(top: 20, bottom: 10),
  child: Text(
    "Blockchain",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.verified),
            title: const Text('Como funciona a verificação?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Cada documento recebe um registro que permite confirmar sua autenticidade e integridade.',
                ),
              ),
            ],
          ),
        ),
        Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.lock),
    ),
    title: const Text("Os documentos ficam na blockchain?"),
    subtitle: const Text("Como os dados são armazenados."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Não. Apenas informações de verificação, como o hash e os registros de autenticação, são armazenadas. Os documentos permanecem nos sistemas das instituições.",
        ),
      ),
    ],
  ),
),
        Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.fingerprint),
    ),
    title: const Text("O que é um hash?"),
    subtitle: const Text("Entenda esse conceito."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "O hash é uma assinatura digital única gerada para cada documento. Se qualquer informação for alterada, um novo hash será criado, indicando que o documento foi modificado.",
        ),
      ),
    ],
  ),
),

        Padding(
  padding: const EdgeInsets.only(top: 20, bottom: 10),
  child: Text(
    "Segurança",
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
),
        Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.security),
    ),
    title: const Text("Quem pode acessar os documentos?"),
    subtitle: const Text("Controle de acesso."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Somente instituições autorizadas e usuários com permissão podem acessar as informações dos estudantes, respeitando as normas de privacidade.",
        ),
      ),
    ],
  ),
),
Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.shield),
    ),
    title: const Text("Como os dados são protegidos?"),
    subtitle: const Text("Segurança das informações."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "A plataforma utiliza registros criptográficos, autenticação e validação por blockchain para garantir a integridade dos documentos e reduzir riscos de fraude.",
        ),
      ),
    ],
  ),
),
Card(
  child: ExpansionTile(
    leading: const CircleAvatar(
      child: Icon(Icons.edit_off),
    ),
    title: const Text("Um documento pode ser alterado depois de registrado?"),
    subtitle: const Text("Entenda a integridade dos registros."),
    children: const [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Caso um documento seja atualizado, um novo registro de verificação é criado. Isso mantém o histórico das alterações e garante transparência no processo.",
        ),
      ),
    ],
  ),
),
      const SizedBox(height: 24),

Card(
  color: Color(0xFFE8EAF6),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Icon(
          Icons.support_agent,
          size: 42,
          color: Colors.indigo,
        ),
        SizedBox(height: 12),
        Text(
          "Ainda tem dúvidas?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Nossa equipe está disponível para orientar escolas, responsáveis e instituições durante todo o processo.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
),
      ],
    );
  }
}

