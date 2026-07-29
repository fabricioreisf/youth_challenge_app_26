import '../models/student.dart';

class StudentRepository {
  final List<Student> _students = [];

  List<Student> get students => List.unmodifiable(_students);

  void addStudent(Student student) {
    _students.add(student);
  }

  Student? findByCpf(String cpf) {
    for (final student in _students) {
      if (student.cpf == cpf) {
        return student;
      }
    }
    return null;
  }
}
