# Tasks: Sistema unificado de documentação escolar

**Input**: Design documents from [spec.md](spec.md) and [plan.md](plan.md)

**Prerequisites**: plan.md (required), spec.md (required for user stories)

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare the Flutter project structure for the feature MVP.

- [ ] T001 Create the feature directory structure under lib/features and test/unit for the new implementation
- [ ] T002 [P] Create shared model classes for student, guardian, educational document, document request, and verification record in lib/models/
- [ ] T003 [P] Create repository abstractions for student and document flows in lib/repositories/

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Establish the core app shell and supporting services that all user stories depend on.

- [ ] T004 Refactor lib/main.dart into a navigation shell that can host feature pages without breaking the existing demo flow
- [ ] T005 Implement a simple app theme and shared UI scaffolding under lib/core/theme/
- [ ] T006 Implement a mock data layer and in-memory repository service for the MVP demo
- [ ] T007 Implement an attestation service stub in lib/services/attestation_service.dart for hash generation and verification proof handling
- [ ] T008 Implement a consent service in lib/services/consent_service.dart to enforce guardian approval requirements

---

## Phase 3: User Story 1 - Cadastrar e registrar documentos escolares (Priority: P1) 🎯 MVP

**Goal**: Allow a school to register a student, link a guardian, and attach an educational document to the student profile.

**Independent Test**: A school staff user can complete registration and document upload with no backend dependency and see the resulting student and document record in the UI.

### Tests for User Story 1

- [ ] T009 [P] [US1] Add widget test for student registration flow in test/widget/student_registration_test.dart
- [ ] T010 [P] [US1] Add widget test for document registration flow in test/widget/document_registration_test.dart

### Implementation for User Story 1

- [ ] T011 [P] [US1] Create the student registration screen under lib/features/students/
- [ ] T012 [P] [US1] Create the document registration screen under lib/features/documents/
- [ ] T013 [US1] Wire the student form to the student repository and persist the record in the mock data layer
- [ ] T014 [US1] Wire the document form to the document repository and generate a verifiable hash for the uploaded document
- [ ] T015 [US1] Add validation for CPF, required guardian linkage, and required document metadata
- [ ] T016 [US1] Add a visible status message showing the student registration and document attestation state

**Checkpoint**: User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Solicitar e liberar documentos entre escolas (Priority: P1)

**Goal**: Allow a destination school to request documents and require consent before sharing them.

**Independent Test**: A request can be created, approved or denied, and the outcome is visible in the UI without manual coordination.

### Tests for User Story 2

- [ ] T017 [P] [US2] Add widget test for document request creation in test/widget/document_request_test.dart
- [ ] T018 [P] [US2] Add widget test for approval and denial flow in test/widget/request_decision_test.dart

### Implementation for User Story 2

- [ ] T019 [P] [US2] Create the request workflow screen under lib/features/requests/
- [ ] T020 [US2] Implement document request creation and status tracking in the repository and UI
- [ ] T021 [US2] Implement approval and denial actions that enforce guardian consent before sharing
- [ ] T022 [US2] Add an audit view or status log for request history and decision events

**Checkpoint**: User Story 2 should work independently and show a complete transfer request lifecycle.

---

## Phase 5: User Story 3 - Verificar autenticidade de um documento (Priority: P2)

**Goal**: Allow a verifier to inspect a document proof and confirm whether the document is authentic.

**Independent Test**: A verifier can enter a student identifier or document reference and receive a clear authenticity result.

### Tests for User Story 3

- [ ] T023 [P] [US3] Add widget test for verification success path in test/widget/verification_success_test.dart
- [ ] T024 [P] [US3] Add widget test for verification failure path in test/widget/verification_failure_test.dart

### Implementation for User Story 3

- [ ] T025 [P] [US3] Create the verification screen under lib/features/verification/
- [ ] T026 [US3] Implement verification logic that compares the presented document hash with the stored attestation record
- [ ] T027 [US3] Add a public-facing summary message and visual success or failure state
- [ ] T028 [US3] Add support for showing the attestation identifier and timestamp in the UI

**Checkpoint**: User Story 3 should be independently testable and deliver value to verifiers.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improve the demo experience and ensure the feature is consistent and testable.

- [ ] T029 [P] Update documentation in README.md and the feature spec folder with the demo flow
- [ ] T030 [P] Refactor shared widgets and remove duplicated UI code across the feature screens
- [ ] T031 Run the Flutter test suite and fix any regressions in the new feature flows
