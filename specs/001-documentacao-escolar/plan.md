# Implementation Plan: Sistema unificado de documentação escolar

**Branch**: `001-documentacao-escolar` | **Date**: 2026-07-29 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from [spec.md](spec.md)

## Summary

Construir um MVP de demonstração em Flutter para registrar alunos, associar documentos escolares, criar uma prova de integridade, solicitar compartilhamento entre escolas e validar autenticidade de forma navegável. A implementação prioriza uma demo convincente para o ideathon, mantendo a blockchain como camada de validação e sem armazenar documentos diretamente na cadeia.

## Technical Context

**Language/Version**: Dart SDK 3.12.2+ with Flutter

**Primary Dependencies**: Flutter Material, Flutter test, no additional package required for the MVP

**Storage**: Demo repository with in-memory/mock data initially; future backend or cloud storage can replace it without changing the UI flow

**Testing**: Widget tests and unit tests with flutter_test

**Target Platform**: Web and mobile (Flutter multi-platform)

**Project Type**: Mobile/Web application

**Performance Goals**: Smooth demo navigation and screen transitions; no production-scale SLA required for the MVP

**Constraints**: Must preserve privacy, require guardian consent before sharing, and avoid storing raw documents on-chain

**Scale/Scope**: MVP focused on one school workflow, one student profile, one document type, and one transfer request scenario

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] The feature keeps blockchain as a validation layer and never stores raw documents on-chain.
- [x] The feature requires explicit guardian consent before document sharing.
- [x] The implementation can be delivered as a navigable demo even without a full production backend.
- [x] Core user flows should be testable through widget and unit tests.

No constitutional violations were identified for this MVP scope.

## Project Structure

### Documentation (this feature)

```text
specs/001-documentacao-escolar/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md
```

### Source Code (repository root)

```text
lib/
├── core/
│   └── theme/
├── models/
│   ├── student.dart
│   ├── guardian.dart
│   ├── educational_document.dart
│   ├── document_request.dart
│   └── verification_record.dart
├── repositories/
│   ├── student_repository.dart
│   └── document_repository.dart
├── services/
│   ├── attestation_service.dart
│   └── consent_service.dart
├── features/
│   ├── overview/
│   ├── students/
│   ├── documents/
│   ├── requests/
│   └── verification/
└── main.dart

test/
├── unit/
├── widget/
└── integration/
```

**Structure Decision**: The existing single-file Flutter UI will be refactored into feature modules under lib/features, with domain models in lib/models and reusable services in lib/services. This keeps the demo easy to navigate while making the flow extensible for later backend integration.

## Implementation Phases

1. Refactor the existing demo shell into a feature-based app structure and create shared domain models.
2. Implement student registration and guardian linkage screens backed by a repository abstraction.
3. Implement document upload, hash generation, and a pluggable attestation service for the proof-of-existence flow.
4. Implement request, approval, and audit operations for document sharing between schools.
5. Add verification screens and tests for the main happy paths and edge cases.

## Complexity Tracking

No complexity exceptions are required for this plan.
