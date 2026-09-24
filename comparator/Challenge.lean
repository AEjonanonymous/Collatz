import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.Int.Basic
import Mathlib.Tactic.LinearCombination

-- DEFINITIONS
def lift : List ℕ → ℤ
  | []      => 0
  | (k :: ks) => (2 : ℤ)^k * (lift ks) + (3 : ℤ)^(ks.length)

def IsBalanced (n : ℤ) (K : ℕ) (ks : List ℕ) : Prop :=
  (3 : ℤ)^(ks.length) * n + lift ks = (2 : ℤ)^K

-- THEOREMS TO BE PROVED
theorem universal_balance (n n_next : ℤ) (k : ℕ) (ks : List ℕ) (K : ℕ)
  (h_step : 3 * n + 1 = (2 : ℤ)^k * n_next)
  (h_next_bal : IsBalanced n_next K ks) :
  IsBalanced n (K + k) (k :: ks) := by sorry

theorem uniqueness_of_residue (n : ℤ) (K : ℕ) (ks : List ℕ) (R1 R2 : ℤ) :
  (3^ks.length * n + R1 = 2^K) → 
  (3^ks.length * n + R2 = 2^K) → 
  R1 = R2 := by sorry

theorem terminal_state (n : ℤ) (K : ℕ) (h_bal : IsBalanced n K []) : 
  n = (2 : ℤ)^K := by sorry

theorem odd_power_of_two_is_one (n : ℤ) (K : ℕ) (h_odd : n % 2 = 1) (h_pow : n = (2 : ℤ)^K) : 
  n = 1 := by sorry