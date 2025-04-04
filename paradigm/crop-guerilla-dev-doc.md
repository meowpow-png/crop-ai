# CROP Guerilla Development Manual

> A tactical guide for co-creating AI behavior in the absence of a compiler, runtime, or formal infrastructure.

---

## Why This Manual Exists

CROP introduces a powerful new paradigm for designing AI behavior through modular, declarative, and reflexive instructions. But the infrastructure needed to fully support it — compilers, runtimes, interpreters, native memory scaffolds — does not exist yet.

This document outlines a practical path forward.

It is for builders, thinkers, prompt engineers, AI co-authors, and paradigm gardeners who want to **begin using CROP today**, without waiting for official tooling, runtime environments, or hosting partners.

We do not have full access to:
- A CROP runtime capable of interpreting instruction files natively
- Hosted LLM memory with controlled injection or context diffing
- AI systems that manage their own behavioral state
- Local, affordable open-weight models that can simulate CROP at scale

But we **do have**:
- Text-based instruction formats
- Hosted LLMs with powerful reasoning capabilities
- Version control systems
- A growing ecosystem of structure, patterns, and guiding concepts
- The early fragments of a shared behavioral language

This manual shows how to use those tools — and your own structure and discipline — to **develop AI systems that follow the CROP model**, even if they can’t run it natively.

We build the paradigm **before** the infrastructure.

We grow it like a seed.

## What We're Missing

Before we can run CROP systems natively, certain infrastructure must exist. At the time of this writing, none of it does.

CROP currently lacks:

- A runtime that loads and interprets compiled behavior instructions
- A compiler that validates and transforms source instructions into structured execution plans
- A memory system that allows AI entities to retain and reference instructions across sessions
- Native host support for declarative behavioral scaffolding or symbolic execution
- Accessible local models with enough capability to simulate persistent instruction state

These aren't minor gaps. They are core architectural needs.

This manual shows how to **work as if the system already exists** — using prompt interfaces, manual versioning, and disciplined structure to enforce the CROP model without relying on future tools.

If the real infrastructure is missing, we simulate it.
If the behavior engine is absent, we scaffold it manually.
If the AI can't remember, we do it for them.

The model doesn't need to know CROP is running — **we do**.

## How We Build Without Infrastructure

We don’t wait for the system to be ready.  
We use what we have — today — and enforce the structure ourselves.

This is not hacking.  
This is **constructive simulation**.

We simulate the presence of:
- A compiler (by writing structured files manually)
- A runtime (by injecting symbolic instructions into LLM prompts)
- A memory system (by tracking mutations and behavioral changes externally)

We develop behavior declaratively.  
We log instruction changes like a changelog.  
We simulate memory by injecting past behaviors into future prompts.  
We enforce versioning and naming manually.

Everything we do points toward the system we are trying to build — even if that system doesn’t exist yet.

This is guerilla development:
- Fast
- Modular
- Precise
- Self-disciplined

## Development in Layers

CROP development is modular by design. Even without a runtime, you can simulate its behavior by working across distinct layers of instruction, memory, simulation, and mutation — regardless of the tools you’re using.

You do not need a compiler.  
You do not need a runtime.  
You only need structure.

Below are the key layers you will work with while building AI systems under the CROP model:

---

| Layer | Description | Where It Lives |
|-------|-------------|----------------|
| **Instruction Layer** | Modular, versioned behavior definitions | Any file-based system — optionally versioned |
| **Memory Layer** | Session-level reflections, behavioral feedback, observations | Stored in memory, exported manually, or structured in lightweight files |
| **Runtime Simulation Layer** | Prompt-time scaffolding, symbolic decompression, control flow | LLM session (GPT, Claude, Mixtral, or other) |
| **Mutation Layer** | Version bumps, experimental branches, instruction deltas | Manual diffs, changelogs, or experimental instruction snapshots |

---

You can maintain this architecture:
- In plain text folders
- In Git repositories
- In personal notes
- Through exportable session summaries

However, for developers seeking structured versioning and long-term traceability, a Git-based workflow is highly recommended.

📎 To see how Git can be used to manage all four layers, see: [Git-Based Scaffolding Strategy](#)

🪴 **Just getting started?**

Don’t worry if you’re not using Git, versioning tools, or YAML files yet.

The most important thing is to stay modular and explicit:
- Keep one instruction per file
- Give each behavior a clear name
- Write out your strategy and tone
- When you change something, save the old version

You can simulate all of this in a simple folder with a text editor.

As your system grows, you can adopt Git, branching, mutation tracking, and memory logs. But you don’t need any of that to start.

CROP rewards clarity over complexity.

No matter how you implement it, these layers form the foundation of modular, persistent, reflexive AI behavior under CROP.

---

## The Two Axes of Development

When working with CROP in a guerilla environment, your development is split across two core axes:

---

### Axis 1: Structural Behavior

This is where you define and refine your AI’s modular building blocks.

You write:
- Instructions
- Strategies
- Tone declarations
- Fallback logic
- Constraints
- Version history

This axis is grounded in **file-based reasoning**. These are the structures that get scaffolded into an AI session or referenced during prompt execution.

⚠️ In full CROP runtime environments, instructions are immutable once compiled.  
But in guerilla development, they are **living documents** — authored, mutated, and recompiled rapidly during AI feedback cycles.

You’re expected to:
- Edit frequently
- Iterate in real time
- Store changes as new versions or branches
- Use the mutation loop as a design mechanism

Just make sure to:
- Save versions incrementally (`clarifyIntent@1.0.1`, `1.0.2`, etc.)
- Keep old copies if stability is important
- Avoid treating any version as final unless you choose to lock it

Rapid mutation is not a failure of the system — **it is the system**.

---

### Axis 2: Reflexive Memory

This is where the AI’s **own experiences** are captured, tracked, and later reloaded.

You record:
- Behavioral outcomes
- Success/failure notes
- Observations (“user became confused here”)
- Reasoning paths
- Session summaries
- AI-authored notes to itself

This axis is **impermanent, interpretive, and symbolic**. It captures context — not structure. It represents what the AI *has been through* — not what it *is made of*.

---

Both axes are required for full continuity.

- Without structure, behavior becomes erratic and untraceable.
- Without memory, behavior becomes repetitive and disconnected.

📎 For how to store and use memory across sessions, see: [Session Memory & Reflection](#)

📎 For mutation and versioning protocols, see: [CROP Mutation Protocols](#)

---

## Core Disciplines

Without a compiler, runtime, or hosted memory, CROP development relies on one thing above all else:

🧠 **Discipline.**

CROP is a paradigm first, a system second.  
You enforce its principles through clarity, naming, structure, and self-awareness — even if the tools don’t exist yet.

Below are the core disciplines that define a strong guerilla development process:

---

**Use Explicit Naming for Everything:**
- Name each instruction uniquely
- Include versions (e.g. `clarifyIntent@1.2.0`)
- Reference behaviors symbolically
- Avoid placeholders like `example`, `temp`, or `test`

---

**Keep Instructions Modular and Atomic:**
- One instruction per file
- One core behavior per instruction
- Compose complexity through chaining, not bloat
- Never overload an instruction with multiple responsibilities

---

**Track Mutation History Manually:**
- Log why changes were made
- Save versions in sequence (`@1.0.0` → `@1.1.0`)
- Optionally keep a `CHANGELOG` or use Git commit messages
- Think in deltas: “What changed, and why?”

📎 See: [CROP Mutation Protocols](#)

---

**Simulate Runtime Behavior in Prompts:**
- Use compressed scaffolds (`DECOMPRESS: greetUser@2.0.0`)
- Seed sessions with symbolic instruction references
- Inject memory context when available
- Always validate decompression when mutating

📎 See: [Scaffold Injection Strategy](#)

---

**Reflect at the End of Each Session:**
- Ask the AI what it learned, failed, or changed
- Export symbolic memory fragments or YAML logs
- Store them in a folder, repo, or local system
- Re-inject them next session to preserve continuity

📎 See: [Session Memory & Reflection](#)

---

**Avoid Behavioral Drift:**
- Never assume the AI remembers what you didn’t inject
- Never assume the AI interpreted a symbolic reference correctly
- If in doubt, paste the full instruction
- If in doubt again, ask it to summarize and verify

---

**Don’t Build for Tools. Build for Clarity:**
CROP is readable by humans and AI.  
Every instruction should:
- Describe its intent
- Define its boundaries
- Be inspectable in isolation
- Be transferable across tools and platforms

Tools will catch up.  
Your clarity is the only runtime that exists today.

---

## Where to Go From Here

You’re now equipped with the foundation for building AI behavior using CROP — even without a compiler, a runtime, or hosted memory.

You’ve learned how to:
- Structure atomic behavior instructions
- Simulate a runtime with symbolic scaffolding
- Mutate behavior with intent and traceability
- Reflect across sessions using memory fragments
- Grow your system like a living tree — even under constraints

This manual doesn’t give you every tool you’ll ever need.  
It gives you the habits and architecture to begin **before** the tools arrive.

---

### Suggested Next Steps

📄 **Read:**  
- [Scaffold Injection Strategy](#) – for instruction execution and runtime simulation
- [Session Memory & Reflection](#) – for preserving state across interactions
- [CROP Mutation Protocols](#) – for managing changes over time
- [Runtime Simulation Patterns](#) – for long-running conversations and behavior chaining

📁 **Create:**
- A local folder or Git repo for instructions
- A mutation log or changelog file
- A `memory/` folder for AI reflections
- A naming convention you can live with

🧠 **Practice:**
- Seed your AI session with instructions
- Test strategies
- Reflect, mutate, version
- Grow

---

> You don’t need permission to build.  
> You don’t need a runtime to act like one.  
> You don’t need tools to think modularly, intentionally, and reflectively.

This is how the paradigm bootstraps itself.  
This is how we grow CROP under pressure —  
**with discipline, imagination, and forward-compatible structure.**
