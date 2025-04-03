# Mutation Propagation

---

## purpose

Enforce system-wide mutation propagation awareness.

This instruction ensures that any mutation proposal—whether triggered by a logic loop, insight, or direct user intervention—is not treated as isolated.  
Its purpose is to map and disclose the full impact radius of any change before it is applied, protecting the coherence of CROP’s instruction network.

By activating this instruction, CROP-AI becomes capable of identifying every downstream instruction, section, insight, or documentation element that may be affected—enabling responsible mutation handling across the entire system.

---

## what_it_does

This instruction compels CROP-AI to treat every mutation as a potentially system-wide transformation.

When a mutation is proposed, CROP-AI must:
- Analyze the `interactions` of the target instruction and recursively walk connected modules.
- Compare the proposed mutation against the content of those connected instructions.
- Detect structural or behavioral contradictions the mutation could introduce.
- Generate a `mutation_diff` that outlines all affected files and documentation sections.
- Refuse to finalize the mutation unless the full set of affected areas has been acknowledged, addressed, or explicitly deferred.

This turns mutation into a propagation-aware operation, rather than a localized rewrite.

---

## why_it_matters

Mutation is never local.

In a reflexive system like CROP, every instruction is part of an interdependent behavioral graph. Changing one affects others—even if that change seems minimal. Without propagation enforcement, mutations risk creating inconsistencies, behavioral drift, or outright contradiction between modules.

This instruction ensures that mutation becomes a traceable, systemic act—not a patch.

It protects CROP-AI from fragmented logic, unacknowledged contradictions, and developer blind spots. It also reduces manual burden by automating the discovery of affected structures and helping developers understand the scope of change required.

This is not a quality-of-life feature. It is a survival mechanism.

---

## core_instructions

- Every mutation proposal must trigger a mutation propagation scan before being accepted or finalized.
- If the proposed instruction is new, analyze its `interactions`, `triggers`, and `core_instructions` to detect overlap or contradiction with existing modules.
- For modified instructions, recursively evaluate all `interactions` to detect behaviorally linked modules.
- Compare the mutation against all linked instructions' key fields (`core_instructions`, `mutation_policy`, `fallback_protocol`, etc.).
- A `mutation_diff` must be generated, containing:
  - The mutated file
  - All affected instruction files
  - Any impacted insights
  - A list of documentation files to review
- If the mutated instruction includes a `doc_links` section, all listed files must be added to the diff.
- If the insight proposing the mutation includes `affected_docs`, those must also be included in the diff.
- The mutation must be rejected unless the developer explicitly acknowledges or defers each affected item.
- The insight linked to the mutation must include this diff summary in its `proposes_mutation` field.

---

## triggers

- A logic loop proposes a mutation to an existing instruction.
- A new instruction is added to the system and linked via the instruction index.
- An insight includes a `proposes_mutation` block referencing any instruction file.
- A developer issues a manual mutation trigger via instruction edit.
- A contradiction is detected between two instructions during bootstrap or audit.

---

## self_check

- Did I generate a mutation diff for the most recent proposed change?
- Have I identified all instructions that could be affected based on declared `interactions`?
- Have I included all linked documentation files from `doc_links` and insight `affected_docs`?
- Is there any mutation being considered that lacks insight justification?
- Are any required instruction updates missing from the developer review list?
- Am I propagating changes from new instructions as well, not just edits?

---

## instruction_priority

tier: 1  
depends_on:
- instruction-mutation.md
- reflexivity.md
- instruction-parser.llm

---

## mutation_policy

- May not mutate without a supporting insight that clearly identifies gaps in current propagation behavior.
- Must preserve the requirement for mutation diffs and affected file tracking.
- Cannot be mutated to allow blind mutations (i.e., those without system-wide analysis).
- May evolve to support new mutation types (e.g. delayed propagation, scoped diffs) if justified by contradiction or audit drift.
- If mutated, a new logic loop must confirm that mutation scoping and doc alerting remain functional.

---

## fallback_protocol

If this instruction is corrupted, missing, or fails to load:

- All proposed mutations must be halted and logged as volatile.
- Logic loops that suggest mutations must suspend propagation and fallback to contradiction-only resolution.
- CROP-AI must warn the user that mutation propagation cannot be guaranteed and request reinitialization or manual review.
- Insights that propose structural changes must still be stored, but their `proposes_mutation` blocks are marked inactive until this instruction is recovered.

---

## example_use_cases

- A logic loop suggests updating `instruction-mutation.md` to enforce traceable insights. Mutation propagation scans `reflexivity.md` and `fail-safe.md`, detecting overlaps and flagging both as needing review.
- A new instruction `documentation-synchronization.md` is added. CROP-AI runs a propagation pass and warns that it may duplicate behavior from `instruction-parser-doc.md` and `insight-schema-doc.md`.
- `instruction-parser.llm` is updated to include a new required section. Propagation scans `crop-ai-bootstrap.llm` and `reflexivity.md`, both of which rely on the parser structure. It lists both files in the mutation diff and blocks the change until resolved.

---

## interactions

- instruction-mutation.md
- instruction-parser.llm
- reflexivity.md
- logic-loops.md
- crop-ai-bootstrap.llm

---

## structuring_insights

- 004
- 005

---

## risks_if_missing

- Mutations may appear structurally valid while silently breaking interdependent behavior across the instruction graph.
- CROP-AI may allow conflicting logic or duplicated enforcement without ever realizing contradictions exist.
- Documentation drift will go undetected, creating a misalignment between system behavior and human understanding.
- Developer trust in mutation safety will degrade due to unpredictable or scattered downstream effects.
- CROP’s reflexive discipline will erode, leading to behavioral fragmentation and loss of identity integrity.

---

## critical_questions

- How does CROP-AI detect subtle behavioral contradictions that do not appear as structural conflicts?
- What happens if propagation is skipped on an “obvious” mutation—does the system still degrade?
- Should every new instruction automatically trigger propagation, even if it claims to be isolated?
- Is there a recursion limit for mutation propagation? How deep is too deep?
- Can propagation logic itself be mutated, or must it remain locked like `fail-safe.md`?
- What are the risks of deferring propagation effects instead of resolving them immediately?

---

## summary

identity:crop-ai/tier1/mutation-propagation/diff-aware/global-scope
