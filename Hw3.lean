import data.set
open set

-- 1. Replace "sorry" in these examples.
section
  variable {U : Type}
  variables A B C : set U

  example : ∀ x, x ∈ A ∩ C → x ∈ A ∪ B :=
  assume x : U,
  assume h1 : x ∈ A ∩ C,
  have h2 : x ∈ A, from and.elim_left h1,
  show x ∈ A ∪ B, from or.inl h2

  example : ∀ x, x ∈ (A ∪ B)ᶜ → x ∈ Aᶜ :=
  assume x : U,
  assume ha : x ∈ (A ∪ B)ᶜ,
  show ¬ (x ∈ A), from
    assume hb : (x ∈ A),
    have hc : x ∈ A ∪ B, from or.inl hb,
    show false, from ha hc  
end

-- 2. Replace "sorry" in the last example.
section
  variable {U : Type}

  /- defining "disjoint" -/
  def disj (A B : set U) : Prop := ∀ ⦃x⦄, x ∈ A → x ∈ B → false

  example (A B : set U) (h : ∀ x, ¬ (x ∈ A ∧ x ∈ B)) : disj A B :=
  assume x,
  assume h1 : x ∈ A,
  assume h2 : x ∈ B,
  have h3 : x ∈ A ∧ x ∈ B, from and.intro h1 h2,
  show false, from h x h3

  -- notice that we do not have to mention x when applying
  --   h : disj A B
  example (A B : set U) (h1 : disj A B) (x : U) (h2 : x ∈ A) (h3 : x ∈ B) : false :=
  h1 h2 h3

  -- the same is true of ⊆
  example (A B : set U) (x : U) (h : A ⊆ B) (h1 : x ∈ A) : x ∈ B :=
  h h1

  example (A B C D : set U) (h1 : disj A B) (h2 : C ⊆ A) (h3 : D ⊆ B) : disj C D :=
  assume x,
  assume ha : x ∈ C,
  assume hb : x ∈ D,
  h1 (h2 ha) (h3 hb)
end

-- 3. Prove the following facts about indexed unions and
-- intersections, using the theorems Inter.intro, Inter.elim,
-- Union.intro, and Union.elim listed above.
section
  variables {I U : Type}
  variables {A : I → set U}

  theorem Inter.intro {x : U} (h : ∀ i, x ∈ A i) : x ∈ ⋂ i, A i :=
  by simp; assumption

  theorem Inter.elim {x : U} (h : x ∈ ⋂ i, A i) (i : I) : x ∈ A i :=
  by simp at h; apply h

  theorem Union.intro {x : U} (i : I) (h : x ∈ A i) : x ∈ ⋃ i, A i :=
  by {simp, existsi i, exact h}

  theorem Union.elim {P : Prop} {x : U}
  (h1 : x ∈ ⋃ i, A i) (h2 : ∀ (i : I), x ∈ A i → P) : P :=
  by {simp at h1, cases h1 with i h, exact h2 i h}
end

section
  variables {I U : Type}
  variables (A : I → set U) (B : I → set U) (C : set U)

  example : (⋂ i, A i) ∩ (⋂ i, B i) ⊆ (⋂ i, A i ∩ B i) :=
  assume x : U,
  assume ha : x ∈ ((⋂ i, A i) ∩ (⋂ i, B i)),
  show x ∈ (⋂ i, A i ∩ B i), from
    Inter.intro $
      have hb : x ∈ (⋂ i, A i), from and.elim_left ha,
      have hc : x ∈ (⋂ i, B i), from and.elim_right ha,
      assume i : I,
      have hd : x ∈ (A i), from Inter.elim hb i,
      have he : x ∈ (B i), from Inter.elim hc i,
      show x ∈ (A i ∩ B i), from and.intro hd he

  example : C ∩ (⋃i, A i) ⊆ ⋃i, C ∩ A i :=
  assume x : U,
  assume ha : x ∈ C ∩ (⋃i, A i),
  have hb : x ∈ C, from and.elim_left ha,
  have hc : x ∈ ⋃i, A i, from and.elim_right ha,
  Union.elim hc $
    assume i : I,
    assume hd : x ∈ A i,
    have he : x ∈ C ∩ A i, from and.intro hb hd,
    show x ∈ ⋃i, C ∩ A i, from Union.intro i he
end

-- 4. Prove the following fact about power sets. You can use the
-- theorems subset.trans and subset.refl
section
  variable  {U : Type}
  variables A B C : set U

  -- For this exercise these two facts are useful
  example (h1 : A ⊆ B) (h2 : B ⊆ C) : A ⊆ C :=
  subset.trans h1 h2

  example : A ⊆ A :=
  subset.refl A

  example (h : A ⊆ B) : powerset A ⊆ powerset B :=
  assume x,
  assume h1 : x ∈ powerset A,
  have h2 : x ⊆ A, from h1,
  have h3 : x ⊆ B, from subset.trans h2 h,
  show x ∈ powerset B, from h3

  example (h : powerset A ⊆ powerset B) : A ⊆ B :=
  have ha : A ⊆ A, from subset.refl A,
  have hb : A ∈ powerset A, from ha,
  have hb : A ∈ powerset B, from h hb,
  show A ⊆ B, from hb
end

-- 5. Replace the sorry commands in the following proofs to show that
-- we can create a partial order R'​ out of a strict partial order R.
section
  parameters {A : Type} {R : A → A → Prop}
  parameter (irreflR : irreflexive R)
  parameter (transR : transitive R)

  local infix < := R

  def R' (a b : A) : Prop := R a b ∨ a = b
  local infix ≤ := R'

  theorem reflR' (a : A) : a ≤ a :=
  have a = a, from rfl,
  or.inr ‹a = a›

  theorem transR' {a b c : A} (h1 : a ≤ b) (h2 : b ≤ c): a ≤ c :=
  or.elim h1
      (assume : a < b,
          or.elim h2
              (assume : b < c,
                  have a < c, from transR ‹a < b› ‹b < c›,
                  show a ≤ c, from or.inl ‹a < c›)
              (assume : b = c,
                  show a ≤ c, from ‹b = c› ▸ h1))
      (assume : a = b,
          have b = a, from symm ‹a = b›,
          show a ≤ c, from ‹b = a› ▸ h2)

  theorem antisymmR' {a b : A} (h1 : a ≤ b) (h2 : b ≤ a) : a = b :=
  or.elim h1
      (assume : a < b,
          or.elim h2
              (assume : b < a,
                  have a < a, from transR ‹a < b› ‹b < a›,
                  have false, from irreflR a ‹a < a›,
                  show a = b, from false.elim this)
              (assume : b = a,
                  show a = b, from symm ‹b = a›))
      (assume : a = b, this)
end

-- 6
section
  parameters {A : Type} {R : A → A → Prop}
  parameter (reflR : reflexive R)
  parameter (transR : transitive R)

  def S (a b : A) : Prop := R a b ∧ R b a

  example : transitive S :=
  assume a b c : A,
  assume h1 : S a b,
  assume h2 : S b c,
  have h3 : R a b, from h1.left,
  have h4 : R b c, from h2.left,
  have h5 : R a c, from transR h3 h4,
  have h6 : R b a, from h1.right,
  have h7 : R c b, from h2.right,
  have h8 : R c a, from transR h7 h6,
  show S a c, from ⟨h5, h8⟩
end

-- 7. Only one of the following two theorems is provable. Figure out
-- which one is true, and replace the sorry command with a complete
-- proof.
section
  parameters {A : Type} {a b c : A} {R : A → A → Prop}
  parameter (Rab : R a b)
  parameter (Rbc : R b c)
  parameter (nRac : ¬ R a c)

  -- not true!!
  theorem R_is_strict_partial_order : irreflexive R ∧ transitive R :=
  sorry

  -- this one true!! 
  theorem R_is_not_strict_partial_order : ¬(irreflexive R ∧ transitive R) :=
  assume h1 : irreflexive R ∧ transitive R,
  have h2 : transitive R, from h1.right,
  have h3 : R a c, from h2 Rab Rbc,
  show false, from nRac h3
end

-- 8
section
  open nat

  example : 1 ≤ 4 :=
  have 1 ≤ 2, from le_succ 1,
  have 2 ≤ 3, from le_succ 2,
  have 3 ≤ 4, from le_succ 3,
  have 1 ≤ 3, from le_trans ‹1 ≤ 2› ‹2 ≤ 3›,
  show 1 ≤ 4, from le_trans ‹1 ≤ 3› ‹3 ≤ 4›
end