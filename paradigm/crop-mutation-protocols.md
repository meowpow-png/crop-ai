# 🌿 CROP Mutation Protocols

CROP defines three core pathways for updating, evolving, and versioning instruction sources. These are known as **Mutation Protocols** — structured flows that determine **who initiates a change**, **how it is processed**, and **who approves it**.

Mutation is a core component of co-authorship with AI. These protocols ensure that updates remain **intentional**, **trackable**, and **safe**, whether initiated by a human or the AI entity itself.

---

## 🪴 1. TILLING – Human-Owned Mutation

**Tag:** `CROP-M:TILL`

### What it does
TILLING is the canonical, manual path for mutating instruction files. Humans author and own all changes to source code and manually compiles output.

### How it works
- The developer edits source files
- They manually decide when to version bump
- Compilation is run via CLI or editor
- AI is reloaded with updated compiled files

### Mutation Phases
1. Human author proposes and edits source
2. Optional review or test scaffold
3. Human compiles code
4. Instruction becomes active at runtime

### Benefits
- Maximum control
- Best for high-assurance use cases
- Easily version-controlled (Git, etc)

### Risks / Limitations
- Slow iteration cycle
- Requires deep human involvement
- Not reflexive — AI cannot evolve itself

---

## 🌱 2. SPROUTING – AI-Self Mutation

**Tag:** `CROP-M:SPROUT`

### What it does
SPROUTING allows the AI to autonomously propose, version, compile, and even activate compiled instructions — entirely without human input.

### How it works
- AI detects a flaw, gap, or optimization opportunity
- AI drafts source code
- AI compiles it into classes
- It may queue it or activate it immediately (if permitted)

### Mutation Phases
1. Internal prompt reflection / behavioral trace
2. Source mutation drafted
3. Compiler triggered programmatically
4. Classes stored or loaded into runtime

### Benefits
- Lightning-fast adaptation
- Self-healing instruction runtime
- Enables emergent capabilities

### Risks / Limitations
- Can lead to behavioral drift if unregulated
- Difficult to audit or test in real-time
- Must be sandboxed in most production systems

---

## 🌿 3. GRAFTING – AI-Proposed, Human-Governed

**Tag:** `CROP-M:GRAFT`

### What it does
GRAFTING is the hybrid protocol that enables AI reflexivity **with human authority**. AI proposes a mutation and version bump, but requires your approval to proceed.

### How it works
- AI suggests source file update and explains it's reasoning
- You review the suggestion inline in chat
- You approve, reject, or revise it
- If approved, AI compiles new classes
- You decide whether to activate it immediately

### Mutation Phases
1. AI proposes source mutation
2. Human reviews or edits it
3. AI compiles via internal pipeline
4. Human authorizes activation or queuing

### Benefits
- Combines fast iteration with safety
- AI remains explainable and co-authored
- Enables real-time collaboration with behavior traceability

### Risks / Limitations
- Still requires human attention for critical updates
- Requires UI/CLI support for mutation review
- Needs test coverage to validate safety before activation

---

## 📊 Comparison Table

| Protocol   | Origin        | Compiler | Activation | Speed     | Safety     | Use Case                   |
|------------|---------------|----------|------------|-----------|------------|-----------------------------|
| TILLING    | Human          | Manual   | Manual     | 🟡 Medium | 🟢 High    | Production / CI systems     |
| SPROUTING  | AI-self        | Auto     | Optional   | 🟢 Fast   | 🔴 Risky   | Experimental / sandboxing   |
| GRAFTING   | AI-proposed    | Delegated| Optional   | 🟢 Fast   | 🟢 Balanced| Co-authoring / rapid dev    |

---

These protocols are **not mutually exclusive**. A single system can support all three, toggled by trust level, stage, or environment.

Use TILLING in prod.  
Use SPROUTING in test labs.  
Use GRAFTING in design phase with AI.