Title: The End of Every Hailstone: A Formally Verified Structural Parity Proof of the Collatz Conjecture

Description:

This manuscript provides a machine-verified proof of the Collatz Conjecture, established through the Principle of Structural Parity. Departing from traditional probabilistic or analytical descent models, this work demonstrates that the 3n+1 map is a subtraction engine designed to eliminate 3-adic complexity through a disguised algebraic tautology.

The Tautology Revealed:

The core of the proof reveals that every odd integer n is definitionally bound to the identity:

3^m n + R = 2^K

Through the formalization in Lean 4, we establish that:

3n (Cancels): The ternary growth is an algebraic transient systematically eliminated by the map.

2^K is (Forced-to-balance): The power-of-two target acts as a structural constraint, not a random destination.

Identity (1=1): Once the m layers of complexity are filtered out, 1 is the only mathematically legal configuration for an odd integer within the system.
