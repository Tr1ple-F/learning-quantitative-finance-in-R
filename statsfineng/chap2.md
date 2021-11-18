# Chapter 2

## 2.4.2 Simulation

Number of iterations: **1e5**

Probability of 50000$ loss: **58.844%**

Probability of 100000$ profit: **38.775%**

Probability of loss: **59.518%**

Expected profit: **9922.63$**

Expected return on investment: **0.9989775** [^1]

## 2.4.3 Geometric random walks

Mean: **0.1002209**

Standard-Deviation: **0.1822596**

Problem 10: Discuss how the price series appear to have momentum. Is the
appearance of momentum real or an illusion?

Answer 10: The appearance of momentum is real, based on the exponential nature of returns. Since the returns are continuously compounded, for a series of positive random returns, the resulting exponential growth creates what seems to be momentum in stock fluctuation.

Problem 11: Explain what the code `c(120,120*exp(cumsum(logr)))` does.

Answer 11: The function combines the base value (120) with the vector to create a new vector of length n+1 with first value 120.

[^1]: Note this corresponds to an average loss, even though the strategy is expected to turn a profit. This is due to the fact that returns are time-adjusted. Since there are more losses than profits, the majority of the return will average below 1. Though the profits are nominally greater than the losses, the profits take longer to materialize and hence the time-adjustment wipes out those details.
