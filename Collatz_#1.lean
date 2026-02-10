import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.Int.Basic
import Mathlib.Tactic.LinearCombination

/- 
  1. DEFINITIONS
  'lift' tracks the accumulation of +1s (The Residue).
  'IsBalanced' tracks the structural conservation of 1.
-/

def lift : List ℕ → ℤ
  | []      => 0
  | (k :: ks) => (2 : ℤ)^k * (lift ks) + (3 : ℤ)^(ks.length)

def IsBalanced (n : ℤ) (K : ℕ) (ks : List ℕ) : Prop :=
  (3 : ℤ)^(ks.length) * n + lift ks = (2 : ℤ)^K

/- 
  2. THE UNIVERSAL BRIDGE
  Proves that if the successor is balanced, the original number is balanced.
  This allows the identity to flow backward from 1 to any n.
-/

theorem universal_balance (n n_next : ℤ) (k : ℕ) (ks : List ℕ) (K : ℕ)
  (h_step : 3 * n + 1 = (2 : ℤ)^k * n_next)
  (h_next_bal : IsBalanced n_next K ks) :
  IsBalanced n (K + k) (k :: ks) :=
by
  unfold IsBalanced lift
  set m := ks.length
  -- Explicitly bridge the list length to (m + 1)
  have h_len : (k :: ks).length = m + 1 := by simp [List.length, m]
  rw [h_len]
  -- Rewrite the power of 3
  have h_pow3 : (3 : ℤ)^(m + 1) = 3 * (3 : ℤ)^m := by ring
  rw [h_pow3]
  -- Collapse the algebra
  unfold IsBalanced at h_next_bal
  linear_combination (3 : ℤ)^m * h_step + (2 : ℤ)^k * h_next_bal

/- 
  3. THE UNIQUENESS OF THE RESIDUE (The Deterministic Residue)
  Proves that for a fixed n and path ks, there is only one possible R.
-/

theorem uniqueness_of_residue (n : ℤ) (K : ℕ) (ks : List ℕ) (R1 R2 : ℤ) :
  (3^ks.length * n + R1 = 2^K) → 
  (3^ks.length * n + R2 = 2^K) → 
  R1 = R2 :=
by
  intro h1 h2
  -- Since both expressions equal 2^K, they are equal to each other
  have h : 3^ks.length * n + R1 = 3^ks.length * n + R2 := by rw [h1, h2]
  -- Subtracting the shared term 3^m * n proves R1 = R2
  linarith

/- 
  4. THE TERMINAL STATE
  Proves that once complexity m=0, n must be a power of 2.
-/

theorem terminal_state (n : ℤ) (K : ℕ) (h_bal : IsBalanced n K []) : 
  n = (2 : ℤ)^K :=
by
  unfold IsBalanced lift at h_bal
  simp at h_bal
  exact h_bal

/- 
  5. THE PARITY EXIT
  Proves that for odd integers, n = 2^K implies n = 1.
-/

theorem odd_power_of_two_is_one (n : ℤ) (K : ℕ) (h_odd : n % 2 = 1) (h_pow : n = (2 : ℤ)^K) : 
  n = 1 :=
by
  cases K with
  | zero => 
    rw [h_pow]
    norm_num
  | succ k => 
    have h_even : (2 : ℤ)^(k + 1) % 2 = 0 := by 
      rw [pow_succ]
      simp
    rw [← h_pow, h_odd] at h_even
    norm_num at h_even