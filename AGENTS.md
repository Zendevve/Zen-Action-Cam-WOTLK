# AGENTS.md

Dynamic Action Cam — WoW 3.3.5a Addon (Lua + C++/DLL Extension)

Follows [MCAF](https://mcaf.managed-code.com/)

---

## Conversations (Self-Learning)

Learn the user's habits, preferences, and working style. Extract rules from conversations, save to "## Rules to follow", and generate code according to the user's personal rules.

**Update requirement (core mechanism):**

Before doing ANY task, evaluate the latest user message.
If you detect a new rule, correction, preference, or change → update `AGENTS.md` first.
Only after updating the file you may produce the task output.
If no new rule is detected → do not update the file.

**When to extract rules:**

- prohibition words (never, don't, stop, avoid) or similar → add NEVER rule
- requirement words (always, must, make sure, should) or similar → add ALWAYS rule
- memory words (remember, keep in mind, note that) or similar → add rule
- process words (the process is, the workflow is, we do it like) or similar → add to workflow
- future words (from now on, going forward) or similar → add permanent rule

**Preferences → add to Preferences section:**

- positive (I like, I prefer, this is better) or similar → Likes
- negative (I don't like, I hate, this is bad) or similar → Dislikes
- comparison (prefer X over Y, use X instead of Y) or similar → preference rule

**Corrections → update or add rule:**

- error indication (this is wrong, incorrect, broken) or similar → fix and add rule
- repetition frustration (don't do this again, you ignored, you missed) or similar → emphatic rule
- manual fixes by user → extract what changed and why

**Strong signal (add IMMEDIATELY):**

- swearing, frustration, anger, sarcasm → critical rule
- ALL CAPS, excessive punctuation (!!!, ???) → high priority
- same mistake twice → permanent emphatic rule
- user undoes your changes → understand why, prevent

**Ignore (do NOT add):**

- temporary scope (only for now, just this time, for this task) or similar
- one-off exceptions
- context-specific instructions for current task only

**Rule format:**

- One instruction per bullet
- Tie to category (Testing, Code, Docs, etc.)
- Capture WHY, not just what
- Remove obsolete rules when superseded

---

## Rules to follow (Mandatory, no exceptions)

### Commands

- build (C++ DLL): `msbuild Extensions.sln /p:Configuration=Release`
- test (addon): Manual in-game testing (see docs/Testing/)
- format (Lua): Use consistent 4-space indentation
- lint (Lua): `luacheck ActionCam/`

### Task Delivery (ALL TASKS)

- Read assignment, inspect code and docs before planning
- Write multi-step plan before implementation
- Implement code and tests together
- Test in-game after changes (layered: new feature → related systems → full addon)
- After all tests pass: run format/lint
- Summarize changes and test results before marking complete
- Always run required builds and tests yourself; do not ask the user to execute them

### Documentation (ALL TASKS)

- All docs live in `docs/`
- Update feature docs when behaviour changes
- Update ADRs when architecture changes
- Templates: `docs/templates/ADR-Template.md`, `docs/templates/Feature-Template.md`

### Testing (ALL TASKS)

- Every behaviour change needs manual in-game testing
- Test on a private server (3.3.5a client)
- Test scenarios: enable/disable feature, adjust sliders, combat, exploration
- Document test steps in feature docs
- Verify no console errors (`/console scriptErrors 1`)
- Check for memory leaks with long play sessions

### Autonomy

- Start work immediately — no permission seeking
- Questions only for architecture blockers not covered by ADR
- Report only when task is complete

### Lua (ConsoleXP Wrapper)
- **Dependency**: Always check for `cxp_` or `test_` CVars before usage.
- **Graceful Failure**: If ConsoleXP CVars are missing, print a single warning and disable features; DO NOT CRASH.
- **Prefixes**:
    - Configuration: `cxp_` (e.g., `cxp_enableActionTarget`)
    - Experimental/Camera: `test_` (e.g., `test_cameraOverShoulder`)
- **UI**: Use Ace3 or Blizzard Options. Keep it simple.
- **Performance**: Do not set CVars in `OnUpdate`. Use events or user interaction.

### C++ (ConsoleXP DLL)
- Reference only. We are consuming the DLL, not modifying it.

### Code Style (Lua)

- Style rules: 4-space indentation, no tabs
- Local variables preferred over globals
- Use meaningful variable names (no single letters except loops)
- No magic literals — extract to constants or config tables
- Comments for non-obvious logic
- Use `local` keyword for all function-scope variables

### Code Style (C++)

- Use modern C++ (C++17 minimum)
- RAII patterns for resource management
- Document memory hooks and patches clearly
- Use descriptive names for offsets and addresses
- Comment all memory manipulation with purpose and expected behavior

### Critical (NEVER violate)

- Never commit secrets, keys, or auth tokens
- Never break the WoW client's time system
- Never cause server detection (avoid obvious memory signatures)
- Never skip testing to mark complete
- Never force push to main
- Never approve or merge (human decision)

### Boundaries

**Always:**

- Read AGENTS.md and docs before editing code
- Test in-game before commit
- Document all memory offsets and their purpose

**Ask first:**

- Changing DLL injection method
- Adding new memory hooks
- Modifying protected functions
- Changing public CVar interface

---

## Preferences

### Likes

- Clean separation between Lua addon and C++ extension
- Presets for common camera configurations
- Smooth camera transitions
- User-friendly error messages

### Dislikes

- Antivirus false positives
- Server detection and disconnection
- Complex multi-step installation
- Breaking other game systems (time, lighting)

---

## Project-Specific Notes

### Architecture

The addon consists of two parts:
1. **Lua Addon** (`ActionCam/`) - UI settings panel, CVar management
2. **C++ Extension** (`Extensions.dll`) - Injects custom CVars into WoW client

### Known Issues (from original)

1. Windows Defender flags patcher/DLL (memory injection)
2. Some servers detect as "unauthorized software"
3. Time cycle breaks (always night) — patcher corruption
4. Complex installation (3 steps)
5. Pitch sliders require DLL to function

### Technical Constraints

- WoW 3.3.5a (Client build 12340)
- ActionCam CVars (`cameraActionAngle`, etc.) are NOT native to 3.3.5a
- These CVars were introduced in WoW 7.0.3 (Legion)
- DLL injection is REQUIRED to add these CVars to the client
- Pure Lua addon can only use native 3.3.5a camera CVars
