import data.nat.basic
open nat

-- 1
example : ∀ m n k : nat, m * (n + k) = m * n + m * k :=
begin
  intros m n k,
  induction m,
  rw zero_mul,
  rw zero_mul,
  rw zero_mul,
  rw succ_mul,
  rw succ_mul,
  rw succ_mul,
  rw ← add_assoc,
  rw ← add_assoc,
  rw add_right_comm,
  rw m_ih,
  rw add_comm,
  rw add_assoc,
  rw add_assoc,
  rw add_assoc,
  rw add_left_comm
end

-- 2
example : ∀ n : nat, 0 * n = 0 :=
begin
  intro n,
  induction n,
  refl,
  rw mul_succ,
  rw n_ih
end

-- 3
example : ∀ n : nat, 1 * n = n :=
begin
  intro n,
  induction n,
  rw mul_zero,
  rw mul_succ,
  rw n_ih
end

-- 4
example : ∀ m n k : nat, (m * n) * k = m * (n * k) :=
begin
  intros m n k,
  induction k,
  rw mul_zero,
  rw mul_zero,
  rw mul_zero,
  rw mul_succ,
  rw mul_succ,
  rw left_distrib,
  rw k_ih
end

-- 5
example : ∀ m n : nat, m * n = n * m :=
begin
  intros m n,
  induction m,
  rw mul_zero,
  rw zero_mul,
  rw mul_succ,
  rw succ_mul,
  rw m_ih
end
