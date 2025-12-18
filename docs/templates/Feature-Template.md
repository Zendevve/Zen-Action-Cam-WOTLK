# Feature: {{FeatureName}}

Status: {{Draft / In Progress / Implemented / Deprecated}}
Owner: {{Owner or team}}
Created: {{YYYY-MM-DD}}
Links: {{Issues / tickets}}

---

## Purpose

{{Short description of the business problem and value.}}

---

## Scope

### In scope

- {{Item}}

### Out of scope

- {{Item}}

---

## Business Rules

- {{Rule 1}}
- {{Rule 2}}
- {{Rule 3}}

---

## User Flows

### Primary flows

1. {{Flow name}}
   - Actor: {{User / Service}}
   - Trigger: {{Trigger}}
   - Steps: {{Short list}}
   - Result: {{Outcome}}

### Edge cases

- {{Edge case}} → {{Expected behaviour}}

---

## System Behaviour

- Entry points: {{Slash commands / UI / events}}
- Reads from: {{SavedVariables / CVars}}
- Writes to: {{SavedVariables / CVars}}
- Side effects: {{Camera movement / UI updates}}
- Error handling: {{Rules and user-facing messages}}
- Performance: {{FPS impact expectations}}

---

## Diagrams

```mermaid
{{Mermaid diagram for main flow}}
```

---

## Verification (Mandatory: describe how to test)

### Test environment

- Environment: WoW 3.3.5a client + private server
- Data and reset: Fresh AddOns folder, delete WTF/Account/*/SavedVariables/ActionCam.lua
- External dependencies: Working WoW installation

### Test commands

- build: `msbuild Extensions.sln /p:Configuration=Release` (if DLL changes)
- test: Manual in-game verification
- format: Check Lua indentation

### Test flows

**Positive scenarios**

| ID | Description | Level | Expected result | Steps |
| --- | --- | --- | --- | --- |
| POS-001 | {{Happy path}} | Manual | {{Outcome}} | {{Step-by-step}} |

**Negative scenarios**

| ID | Description | Level | Expected result | Steps |
| --- | --- | --- | --- | --- |
| NEG-001 | {{Error case}} | Manual | {{Error message / fallback}} | {{Steps}} |

**Edge cases**

| ID | Description | Level | Expected result | Steps |
| --- | --- | --- | --- | --- |
| EDGE-001 | {{Boundary}} | Manual | {{Expected behaviour}} | {{Steps}} |

---

## Definition of Done

- Behaviour matches rules and flows in this document
- All test flows manually verified in-game
- No Lua errors in console (`/console scriptErrors 1`)
- No FPS degradation (>5% drop)
- Documentation updated
- Committed to repository

---

## References

- ADRs: {{Links}}
- Related features: {{Links}}
- Code: {{Main Lua files}}
