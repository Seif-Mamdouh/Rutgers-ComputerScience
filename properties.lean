-- Not 
[Unicode: ¬      Ascii: not    Lean: \not, \neg]

-- And 
[Unicode: /\      Ascii: /\     Lean: /and]

-- or 
[Unicode: \/      Ascii: or \/   Lean: \or]

-- implication
[Unicode:  →      Ascii: ->      Lean: \to, \r, \imp]

-- bi-implication
[Unicode: ↔   Ascii:  <->        Lean: \iff, \lr]

-- forall
[Unicode: ∀   Ascii: forall       Lean: \all]

--exists
[Unicode: ∃   Ascii: exists      Lean:\ex]

--fun 
[Unicode: λ   Ascii: fun         Lean: \lam, \fun]

-- not equal
[Unicode:≠    Ascii: ~=      Lean; \ne]


The two expressions represent, respectively, these two proofs:

A ∧ ¬ B

Notice that in this way of representing natural deduction proofs, there are no “free floating” hypotheses. 
Every hypothesis has a label. In Lean, we will typically use expressions like h, h1, h2, … to label hypotheses, 
but you can use any identifier you want.


variables A B : Prop
variable h : A ∧ ¬ B

#check and.intro (and.right h) (and.left h)

If h1 is a proof of A and h2 is a proof of B, then and.intro h1 h2 is a proof of A ∧ B. So we can continue the example above. 



Notice that in this way of representing natural deduction proofs, there are no “free floating” hypotheses. 
Every hypothesis has a label. In Lean, we will typically use expressions like h, h1, h2, … to label hypotheses, but 
you can use any identifier you want.

If h1 is a proof of A and h2 is a proof of B, then and.intro h1 h2 is a proof of A ∧ B. So we can continue the example above:

try it!
variables A B : Prop
variable h : A ∧ ¬ B

#check and.intro (and.right h) (and.left h)