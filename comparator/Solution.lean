import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.Int.Basic
import Mathlib.Tactic.LinearCombination

def lift : List ℕ → ℤ
  | []      => 0
  | (k :: ks) => (2 : ℤ)^k * (lift ks) + (3 : ℤ)^(ks.length)

def IsBalanced (n : ℤ) (K : ℕ) (ks : List ℕ) : Prop :=
  (3 : ℤ)^(ks.length) * n + lift ks = (2 : ℤ)^K

theorem universal_balance (n n_next : ℤ) (k : ℕ) (ks : List ℕ) (K : ℕ)
  (h_step : 3 * n + 1 = (2 : ℤ)^k * n_next)
  (h_next_bal : IsBalanced n_next K ks) :
  IsBalanced n (K + k) (k :: ks) :=
by
  unfold IsBalanced lift
  set m := ks.length
  have h_len : (k :: ks).length = m + 1 := by simp [List.length, m]
  rw [h_len]
  have h_pow3 : (3 : ℤ)^(m + 1) = 3 * (3 : ℤ)^m := by ring
  rw [h_pow3]
  unfold IsBalanced at h_next_bal
  linear_combination (3 : ℤ)^m * h_step + (2 : ℤ)^k * h_next_bal

theorem uniqueness_of_residue (n : ℤ) (K : ℕ) (ks : List ℕ) (R1 R2 : ℤ) :
  (3^ks.length * n + R1 = 2^K) → 
  (3^ks.length * n + R2 = 2^K) → 
  R1 = R2 :=
by
  intro h1 h2
  have h : 3^ks.length * n + R1 = 3^ks.length * n + R2 := by rw [h1, h2]
  linarith

theorem terminal_state (n : ℤ) (K : ℕ) (h_bal : IsBalanced n K []) : 
  n = (2 : ℤ)^K :=
by
  unfold IsBalanced lift at h_bal
  simp at h_bal
  exact h_bal

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