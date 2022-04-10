variables A B C D : Prop

example : A ∧ (A → B) → B :=
assume var : A ∧ (A → B),
--gives you a and b 
-- now gotta put them in implication form
show B, from (and.right var) (and.left var)


example : A → ¬(¬A ∧ B) :=
assume varA: A,  
assume varB: ¬A ∧ B,
show false, from (and.left varB)
varA

example : ¬(A ∧ B) → (A → ¬B) :=
assume h1: ¬(A ∧ B), 
assume h2: A, 
assume h3: B,
--
show false, from h1 (and.intro h2 h3)

section
example (h₁ : A ∨ B) (h₂ : A → C) (h₃ : B → D) : C ∨ D :=
show C ∨ D, from or.elim h₁ 
(assume h4: A, show C ∨ D, from or.inl (h₂ h4)) 
(assume h5: B, show C ∨ D, from or.inr (h₃ h5))
end

section
example (h : ¬A ∧ ¬B) : ¬(A ∨ B) :=
assume h1: A ∨ B, 
show false, from or.elim (h1)
(assume h3: A, show false, from and.left h h3)
(assume h4: B, show  false, from and.right h h4)
end

section
example : ¬(A ↔ ¬A) :=
show ¬(A ↔ ¬A), from 
  (assume h1: A ↔ ¬A, show false, from
      (have hNotA: ¬A, from
        (assume hA: A, (iff.mp h1 hA) hA), hNotA (iff.mpr h1 hNotA))
        )
end 