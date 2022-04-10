import data.set
import data.int.basic
open function int set
 
section
  def f (x : ℤ) : ℤ := x + 3
  def g (x : ℤ) : ℤ := -x
  def h (x : ℤ) : ℤ := 2 * x + 3
 
  -- 1
  example : injective h :=
  assume x1 x2,
  assume : 2 * x1 + 3 = 2 * x2 + 3,
  have h : 2 * x1 = 2 * x2, from add_right_cancel this,
  show x1 = x2, from mul_left_cancel₀ dec_trivial h
 
  -- 2
  example : surjective g :=
  assume f,
  have h : g (-f) = f, from 
    calc
      g (-f) = -(-f): rfl
      ... = f: neg_neg f,
      exists.intro (-f) h
 
  -- 3
  example (A B : Type) (u : A → B) (v1 : B → A) (v2 : B → A)
    (h1 : left_inverse v1 u) (h2 : right_inverse v2 u) : v1 = v2 :=
  funext
    (assume x,
      calc
        v1 x = v1 (u (v2 x)) : by rw h2
         ... = v2 x          : by rw h1)
end
 
-- 4
section
  variables {X Y : Type}
  variable f : X → Y
  variables A B : set X
 
  example : f '' (A ∩ B) ⊆ f '' A ∩ f '' B :=
  assume y,
  assume h : y ∈ f '' (A ∩ B),
  show y ∈ f '' A ∩ f '' B, from 
    exists.elim h $
        assume x z,
        have f x = y, from and.right z,
        have x ∈ A ∩ B, from and.left z,
        have x ∈ A, from and.left this,
        have y ∈ f '' A, from exists.intro x ⟨this, ‹f x = y›⟩,
        have x ∈ B, from and.right ‹x ∈ A ∩ B›,
        have y ∈ f '' B, from exists.intro x ⟨this, ‹f x = y›⟩,
        ⟨‹y ∈ f '' A›, ‹y ∈ f '' B›⟩
end