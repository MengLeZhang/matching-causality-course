# Matching Cheat Sheet
Author: Meng Le Zhang

# Overview

A quick reference to matching and what it is.

# The basics

## Maths

- $E(Y)$. Expect value of $Y$. More or less a fancy of saying the mean of $Y$.
- $\mu_Y$. See above. Common way of denoting the mean of $Y$.
- $E(Y|X = x)$. The expected value (i.e. mean) of $Y$ when $X$ takes a certain value $x$. Example: $E(Y|X=1)$ is the expected value of $Y$ when $X$ is 1.


# Precursor

![](assets/markdown-img-paste-20220221142618161.png)
Example: Estimand (R) versus Estimate (L). We don't know what method (i.e. estimator) the artist was using to produce the final results.

- __Estimand__ The thing you are trying to estimate (estimand). The thing you are trying to study (e.g. what is the effect of this policy on health).

- __Estimator__ The method or rule you use to try to get an estimate of your __estimand__ Matching is an estimator (or rather part of an estimator).

- __Estimate__ The results that you actually get from your estimator.

Two examples of estimators:
- Conducting randomised trials and taking the difference in average outcomes between the treatment and control groups.
- Using [Paul the Octopus](https://en.wikipedia.org/wiki/Paul_the_Octopus) to predict the results of the 2010 world cup.



- __Bias__ Is your _estimator_ expected to be equal to your _estimand_? If yes, then your _estimator_ is _unbiased_. If no, then it is _biased_ and the bias is equal to the expected value of your _estimand_ minus your _estimator_.

- __Efficiency__ From sample to sample, how much do your estimates vary? Think of this as how noisy your estimator is. This is captured by your standard errors. The big things affecting this are sample size and the variance of your variable of interest.

Example: The average age in the UK is the __estimand__. Taking the average age of five people at random in the UK is an __unbiased estimator__ of the average UK age (which is the estimand). It is a somewhat __inefficient estimator__ as there is a lot of variance when you take the average of age only five people.



# Potential outcomes framework (Estimands)


|           | Sex |   | Outcome (if treated) | Outcome (if not treated) | Is actually treated? | Outcome (in real life) |
|-----------|-----|---|----------------------|--------------------------|----------------------|------------------------|
| Liam.     | M   |   | 1                    | 0                        | T                    | 1                      |
| Noah.     | M   |   | 1                    | 1                        | F                    | 1                      |
| Oliver.   | M   |   | 0                    | 0                        | T                    | 0                      |
| Amelia.   | F   |   | 1                    | 0                        | F                    | 0                      |
| Isabella. | F   |   | 0                    | 1                        | T                    | 0                      |
| Mia.      | F   |   | 1                    | 0                        | F                    | 0                      |

Assume that we can magically observe peoples outcomes in worlds where they both do and don't get the treatment.

- __Average Treatment Effect (ATE)__ . The average difference between in outcomes in parallel worlds where a person was not treated vs not treated. For example:

  $$\frac{(1 - 0) +  (1-1) + (0 - 0) + (1 - 0) + (0 - 1) + (1- 0 )}{6}$$

This is identifical to differencing the average of the two outcome cols.

- __Average Treatment Effect on the Treated (ATT, various acronyms used)__. The average difference in outcomes for those _in the treatment group_ (e.g. Liam, Oliver, Isabella).

- __Average Treatment Effect on the Untreated (ATU, various acronyms used)__. The average difference in outcomes for those were actually in the treatment group.

- __Intention to Treat (ITT) effect__. The average difference in outcomes for those who were _assigned_ to receive the treatment (regardless of whether they actually were treated). If everyone who was assigned also got the treatment then the __ITT = ATT__. Perfect compliance rarely happens.


# Matching (as part of an estimator)

There's at least two schools of though on matching. We'll cover one: the use of matching as a kind of data cleaning step. The goal of matching is to balance $X$.

- __Matching variables (usually called $X$)__ These are variables on which you want to do the matching.

- __Balance__ The treatment and control groups are balanced with respect to $X$ if the distribution of $X$ is the same across both group. In the case of a single $X$, check univariate statistics. If there are multiple variable $X_1$, $X_2$ etc, check that the multivariate distributions (e.g. correlation between $X1$ and $X2$) are the same across the treatment and control.

- __Common support__ The treatment and control groups have some overlap in their values of $X$ (or whatever you choose to match on, see next section). For example, if every member of the treatment group has a value of $X$ over 0 and every member of the control group has $X < 0 $ then there is no common support.


## Choosing what $X$ to match on

Almost every statistical method has a variation of this assumption: you cannot escape it. This is 90% of what makes a research design work. Don't believe this just because of convenience (i.e. have data now, justify results later); you will regret it.

## Steps for matching

Steps:
1. Choose your Estimand. For this example, we choose the __ATT__
2. What are your matching variables $X$. For example, sex.
3. Pick your matching method. This is like picking a Subway sandwich and there's options:
- do we transform $X$ then match on the results (exact, propensity score)
- how close do we want the matches to be (nearest neighbour, caliper, substrata, optimal)
4. Check for balance in $X$
5. Use the matched result in whatever routine you want (e.g. regression models)


## Exact matching

The original and most unbiased. Matching on exact values
