import '../models/educational_document.dart';

class DocumentRepository {
  final List<EducationalDocument> _documents = [];

  List<EducationalDocument> get documents => List.unmodifiable(_documents);

  void addDocument(EducationalDocument document) {
    _documents.add(document);
  }

  EducationalDocument? findById(String id) {
    for (final document in _documents) {
      if (document.id == id) {
        return document;
      }
    }
    return null;
  }
}
