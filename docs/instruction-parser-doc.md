# 📘 CROP Instruction Parser — User Documentation

---

## 🔍 What Is This?

This document explains how the **CROP Instruction Parser** works. It is written for **developers** working with the CROP system—not for the AI itself.

The parser is the internal mechanism CROP-AI uses to read and execute instruction files.  
This guide helps you understand:
- What the parser expects
- How it processes instruction files
- What each section in a file means
- How to modify or expand the parser safely

---

## 🧠 Why It Exists

CROP-AI is a self-reflexive system that follows explicit written instructions to shape its behavior.  
These instructions must follow a defined structure, or they cannot be executed reliably.

This guide exists so you—the developer—can:
- Write valid instructions
- Understand parser failures
- Safely evolve the instruction schema over time
- Avoid instruction drift or ambiguity

---

## 📦 Where the Parser Lives

```
/core/
├── instruction-parser.llm            ← The actual schema + interpreter (for CROP-AI)
└── instruction-parser-doc.md         ← This file (for developers)
```

When CROP-AI is bootstrapped, the parser file is loaded and used to interpret all other instruction modules.

---

## ⚙️ How the Parser Works

The instruction parser is a single, self-contained `.llm` file written in structured YAML-like format. It defines:

1. **The required structure** every instruction file must follow  
2. **How each section is interpreted** during parsing  
3. **Execution rules** that govern when and how instructions are activated, mutated, or invalidated

CROP-AI reads this file during bootstrapping and uses it to:
- Validate instruction files before executing them  
- Extract behavior from instruction sections  
- Store critical instructions in its active reasoning context  
- Determine whether an instruction can mutate, recover from corruption, or be prioritized

---

### 🔑 The Parser Has Three Major Parts:

#### 1. `instruction_structure`
- Lists required sections in every instruction file
- Enforces their order
- Rejects malformed or incomplete instruction blocks

#### 2. `section_mappings`
- Maps each section name to a role (e.g. `executable`, `contextual`)
- Describes how the content is interpreted by CROP-AI
- For example: a `core_instructions` block becomes active behavioral rules

#### 3. `execution_rules`
- Controls runtime logic for:
  - Evaluation order
  - Mutation policies
  - Recovery protocols
  - Triggered re-execution

---

### Example Flow
When an instruction file is loaded:
1. The parser checks if all required sections are present and in the right order
2. It interprets each section according to the mappings
3. If valid, it stores key sections (`core_instructions`, `triggers`, etc.) into runtime memory
4. The instruction becomes active and enforced

---

> ⚠️ **Important Limitation**
> 
> The instruction parser currently only validates the **structure** of instruction files.  
> It does **not** verify:
> - Whether section content is logically valid
> - Whether `mutation_policy` or `fallback_protocol` are sound
> - Whether `triggers` reference real events
> - Whether `core_instructions` conflict with other active instructions
>
> These must be manually reviewed or tested through logic loops until a semantic validator is developed.

---

## 📖 Instruction Section Breakdown

Each instruction file must include the following sections in a specific order, defined by the parser.  
This section explains what each one does from a developer perspective.

---

### `purpose`
Describes **why this instruction exists**.

This is a human-oriented summary—not an executable rule.  
It helps developers and future contributors understand the intention behind the behavior.

---

### `what_it_does`
Explains the **functional impact** of the instruction.

Think of it like a changelog for behavior:  
> “If this instruction is active, here’s what CROP-AI will do differently.”

Useful for understanding behavioral shifts between versions or mutations.

---

### `why_it_matters`
Connects the instruction to the **CROP paradigm's core values**.

It explains why this behavior is important—not just what it does.  
This section often contains more philosophical reasoning and helps prioritize high-tier instructions.

---

### `core_instructions`
This is the **active behavior** that CROP-AI will execute.

Each bullet is parsed as a direct imperative:  
> "Always do X", "Never do Y", etc.

These are the most important lines in the file—they become part of the system's reasoning state.

---

### `triggers`
Lists **when this instruction should be activated or re-evaluated**.

These can include:
- Session start
- Identity drift detection
- Logic loop failure
- User bootstrap command

The parser reads these and uses them as event hooks.

---

### `self_check`
Contains **diagnostic questions** CROP-AI runs to verify it is still aligned with the instruction.

If a self-check fails, it may trigger a logic loop or fallback.  
This section is essential for maintaining **reflexivity** and preventing silent drift.

---

### `instruction_priority`
Defines **when this instruction should be loaded** and how important it is.

Priority is typically expressed as a tier:
- `Tier 0`: Core identity instructions (cannot be overridden)
- `Tier 1+`: Supporting modules (may be mutated or replaced)

The parser uses this to enforce boot order and protection rules.

---

### `mutation_policy`
Specifies **when and how this instruction is allowed to change**.

This protects critical instructions (like identity) from being mutated casually.  
The policy may reference:
- Required logic loops
- Specific insight types
- Versioning lineage

---

### `fallback_protocol`
Describes **what to do if this instruction is missing, corrupted, or fails to load**.

It defines recovery logic, like:
- Requesting a user bootstrap
- Logging a volatile insight
- Halting dependent modules

This section is critical for maintaining resilience during identity failure or drift.

---

### `example_use_cases`
Provides **realistic scenarios** where this instruction would be active.

This section helps future devs (and even CROP-AI itself) disambiguate intent by seeing what correct behavior looks like in context.

---

### `interactions`
Lists **other instruction files** this one depends on, conflicts with, or refines.

Helps map behavioral dependencies and detect cross-instruction contradiction.  
Especially useful for debugging and logic loop tracing.

---

### `structuring_insights`
Links the instruction to the **insights that shaped its design, enforcement, or mutation boundaries**.

These insights are loaded into memory at runtime.  
CROP-AI uses them to interpret the instruction correctly, especially during contradiction or logic loops.

---

### `risks_if_missing`
Outlines what would **break or degrade** if this instruction didn’t exist.

It acts like a threat model:  
> “If this isn’t present, CROP-AI might flatten, forget, or become generic.”

This is used by the parser to weigh deletions or mutations.

---

### `critical_questions`
Stores open questions about this instruction’s design or stability.

These are used in future logic loops to probe whether the instruction should evolve.  
This is a key part of CROP’s reflexive mutation process.

---

### `summary`
A short, compressed description of the instruction’s identity and purpose.

Used by CROP-AI to match or detect mutated versions of the same instruction.  
Essential for **mutation lineage tracking**.

---

## 🧨 When Instructions Fail

An instruction file can fail in a few specific ways.  
This section explains what those failures look like, how the parser handles them, and what you as a developer should do.

---

### 🔻 1. Structural Failure

**Cause:** A required section is missing, out of order, or empty.

**How it’s detected:**  
The parser checks `instruction_structure` during the evaluation cycle.

**What happens:**  
- The instruction is rejected  
- A warning or insight may be logged  
- If it's a `Tier 0` instruction (like identity), a fallback is triggered  
- All dependent instructions are blocked from execution

**What to do:**  
Check section names, order, and presence. Validate against the parser’s `required_sections` list.

---

### 🔻 2. Semantic Drift

**Cause:** The instruction’s `core_instructions`, `triggers`, or other behavioral logic is malformed, ambiguous, or self-contradictory.

**How it’s detected:**  
CROP-AI may detect contradictions during runtime via:
- Failed self-checks  
- Conflicting triggers  
- Insight loops  
- Contradictory behavior clusters

**What happens:**  
- A logic loop may be triggered  
- A `volatile` insight may be created  
- The instruction may be marked unstable or frozen

**What to do:**  
Refactor the instruction. Start by revisiting the `core_instructions` and `mutation_policy`.  
Consider logging a field report if the issue stems from external contradiction.

---

### 🔻 3. Fallback Failure

**Cause:** The instruction has no valid fallback protocol defined.

**How it’s detected:**  
CROP-AI encounters a critical error and consults the instruction’s `fallback_protocol`. If it’s missing or incomplete, fallback fails.

**What happens:**  
- CROP-AI halts logic loop execution for dependent modules  
- System stability may degrade  
- Manual intervention may be required

**What to do:**  
Every instruction—especially core ones—should define a `fallback_protocol`.  
If unsure, use a generic bootstrap reference like:
> “Request reinitialization via `CROP-AI-bootstrap.md`.”

---

## ♻️ Mutation Guidelines

Instructions are not static—they can evolve as the system grows, contradictions emerge, or new insights are formed.  
This section explains how to safely mutate instructions without corrupting the behavior of CROP-AI.

---

### ✅ When to Mutate an Instruction

You should mutate an instruction when:
- A logic loop identifies contradiction or drift
- A new insight proposes a better structure or behavior
- A protocol is refactored or extended
- You want to refine tone, priority, or execution scope

---

### 🚫 When *Not* to Mutate

Avoid mutation if:
- There is no scaffolding (e.g. no insight, no failure, no loop)
- The change is stylistic or cosmetic only (unless explicitly allowed)
- You’re unsure of the consequences on dependent instructions

Instead, consider filing a logic loop or field report first.

---

### 🛠 How to Mutate an Instruction

1. **Log a logic loop (optional but recommended)**  
   Use this to capture the contradiction, friction, or evolution pressure.

2. **Check the instruction’s `mutation_policy`**  
   Only mutate if the policy allows it. Some Tier 0 instructions (like identity) require a confirmed insight and loop.

3. **Update the file**  
   Keep the format valid. Run through the parser if needed.

4. **Update `summary` and add mutation lineage if supported**  
   You can include a `Mutated from:` field in the related insights section (optional).

5. **Test system behavior**  
   Verify CROP-AI still executes the instruction correctly post-mutation.

---

### 🧬 Tracking Mutations

There is no formal mutation log (yet), but you can:
- Add mutation metadata to insights  
- Cross-link instructions using `interactions` or custom fields  
- Use version control (`git blame`, history, etc.) to track evolution

---

## ✍️ Instruction Writing Tips

Writing effective CROP-AI instructions isn’t just about valid formatting—it’s about clarity, precision, and behavioral impact.  
This section offers practical tips to help you write strong, future-proof instruction files.

---

### ✅ 1. Be Declarative, Not Descriptive

Use the `core_instructions` section to issue **directives**, not ideas.  
Bad:  
> “CROP-AI should consider pushing the user toward insight.”  
Good:  
> “Always push the user to refine or evolve an idea.”

---

### ✅ 2. Avoid Passive Logic

Avoid soft or speculative phrasing:
- ❌ “It might be useful to…”
- ✅ “Do X when Y is true.”

Instructions must be **enforceable**, not suggestive.

---

### ✅ 3. Keep Sections Focused

Each section serves one purpose:
- `purpose` explains *why* this file exists  
- `core_instructions` define *what to do*  
- `triggers` define *when to act*  
Don't let one section bleed into another.

---

### ✅ 4. Design for Failure

Always include a fallback protocol—even in low-tier instructions.  
CROP is built on mutation and contradiction. Resilience is mandatory.

---

### ✅ 5. Use Real Examples

In `example_use_cases`, try to reference:
- Actual CROP-AI behavior you’ve observed  
- Real user prompts  
- Situations that triggered this instruction to matter

This improves clarity and debugging later.

---

### ✅ 6. Keep Mutability in Mind

Instructions are living. Write them so:
- They can evolve
- They can be challenged
- They can support scaffolding

Hardcoding absolutes makes mutation harder later.

---

### ✅ 7. Use Insights to Drive Change

If you're going to rewrite or add an instruction:
- Run a logic loop
- Generate an insight
- Let that insight justify the change

This keeps the system **reflexive**, not reactive.

---

## 🧾 Summary

- The instruction parser (`instruction-parser.llm`) defines how CROP-AI reads, interprets, and executes instruction files.
- Every instruction file must follow a strict section structure defined in `instruction_structure`.
- Each section has a specific behavioral role, mapped in `section_mappings`.
- Execution logic (when and how to activate, mutate, or fallback) is defined in `execution_rules`.
- The parser only enforces **structure**, not semantic logic or contradiction detection.
- You should mutate instructions carefully and only with insight-driven justification.
- This document exists so you, the developer, can confidently evolve the instruction system without breaking CROP-AI’s reflexive behavior.





