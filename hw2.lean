-- 1
section
  variable A : Type
  variable f : A → A
  variable P : A → Prop
  variable  h : ∀x, P x → P (f x)

  example : ∀y, P y → P (f (f y)) :=
  assume y,
  assume Py,
  have Pfy : P (f y), from h y Py,
  show P (f (f y)), from h (f y) Pfy
end

-- 2
section
  variable U : Type
    variables A B : U → Prop
    example : (∀ x, A x ∧ B x) → ∀ x, A x :=
    assume h1 : (∀ x, A x ∧ B x),
    assume x,
    have AxBx : A x ∧ B x, from h1 x,
    show A x, from and.elim_left AxBx
end

-- 3
section
  variable U : Type
  variables A B C : U → Prop

  variable h1 : ∀x, A x ∨ B x
  variable h2 : ∀x, A x → C x
  variable h3 : ∀x, B x → C x

  example : ∀x, C x :=
  assume x, 
  or.elim (h1 x) 
      (assume Ax, h2 x Ax)
      (assume Bx, h3 x Bx)
end

-- 4
open classical

axiom not_iff_not_self (P : Prop) : ¬(P ↔ ¬P)

example (Q : Prop) : ¬(Q ↔ ¬Q) :=
not_iff_not_self Q

section
  variable Person : Type
  variable shaves : Person → Person → Prop
  variable barber : Person
  variable h : ∀x, shaves barber x ↔ ¬shaves x x

  example : false :=
  (not_iff_not_self (shaves barber barber)) (h barber)
end

-- 5
section
  variable U : Type
  variables A B : U → Prop

  example : (∃x, A x) → ∃x, A x ∨ B x :=
  assume exAx, 
  exists.elim exAx $
  assume x Ax, 
  have A x v B x, from or.inl Ax, 
  exists.intro x ‹A x ∨ B x›
end

-- 6
section
  variable U : Type
  variables A B : U → Prop

  variable h1 : ∀x, A x → B x
  variable h2 : ∃x, A x

  example : ∃x, B x :=
  exists.elim h2 $
  assume x Ax, 
  exists.intro x (h1 x Ax)
end

-- 7
section
  variable  U : Type
  variables A B C : U → Prop

  example (h1 : ∃x, A x ∧ B x) (h2 : ∀x, B x → C x) :
      ∃x, A x ∧ C x :=
    exists.elim h1 $
    assume x AxBx,
    have A x, from and.elim_left AxBx,
    have B x, from and.elim_right AxBx,
    have C x, from h2 x ‹B x›,
    exists.intro x ⟨‹A x›, ‹C x›⟩
end

-- 8
section
  variable  U : Type
  variables A B C : U → Prop

  example : (¬∃x, A x) → ∀x, ¬A x :=
  assume h1 : ¬ ∃ x, A x,
    assume x,
    assume : A x,
    have h2 : ∃ x, A x, from exists.intro x ‹A x›,
    show false, from h1 h2

-- 9
section
  variable  U : Type
  variables A B C : U → Prop

   example : (∀ x, ¬ A x) → ¬ ∃ x, A x :=
    assume h1 : ∀ x, ¬ A x,
    assume h2 : ∃ x, A x,
    exists.elim h2 $
    assume x (_ : A x),
    have ¬ A x, from h1 x,
    show false, from ‹¬ A x› ‹A x›
end

-- 10
section
  variable  U : Type
  variables R : U → U → Prop

  example : (∃x, ∀y, R x y) → ∀y, ∃x, R x y :=
  sorry
end
