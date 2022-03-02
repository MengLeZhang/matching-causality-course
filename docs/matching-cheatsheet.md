# Matching Cheat Sheet/ Page
Author: Meng Le Zhang
__Versions__ This is living document that I keep updated. Point out my mistakes, add more stuff.
Version:
0.1. For course 3/3/2022


<!-- TOC -->

- [Matching Cheat Sheet/ Page](#matching-cheat-sheet-page)
- [Basics](#basics)
  - [Common maths notation](#common-maths-notation)
  - [Basic stats lingo](#basic-stats-lingo)
  - [Potential outcomes framework (Estimands)](#potential-outcomes-framework-estimands)
- [The design: Choosing what $X$ to match on](#the-design-choosing-what-x-to-match-on)
- [Matching (the stats part of an estimator)](#matching-the-stats-part-of-an-estimator)
  - [Steps for matching](#steps-for-matching)
  - [Matching terms](#matching-terms)
  - [How do we do the matching (method)?](#how-do-we-do-the-matching-method)
  - [How do we measure closeness (distance)?](#how-do-we-measure-closeness-distance)
  - [Misc Matching options](#misc-matching-options)
  - [Coarsened exact matching](#coarsened-exact-matching)
- [Misc. R stuff](#misc-r-stuff)
- [Resources](#resources)
  - [Much better resources for matching and the MatchIt package](#much-better-resources-for-matching-and-the-matchit-package)
  - [FAQS:](#faqs)
    - [What if I have more than one treatment group/ continuous treatment?](#what-if-i-have-more-than-one-treatment-group-continuous-treatment)

<!-- /TOC -->


# Basics

## Common maths notation

- $E(Y)$. Expected value of $Y$. More or less a fancy of saying the mean of $Y$.
- $\mu_Y$. See above. Common way of denoting the mean of $Y$.
- $E(Y|X = x)$. The expected value (i.e. mean) of $Y$ when $X$ takes a certain value $x$. Example: $E(Y|X=1)$ is the expected value of $Y$ when $X$ is 1.


---

## Stats lingo

![](assets/markdown-img-paste-20220221142618161.png)
Example: Estimand (L) versus Estimate (R). We don't know what method (i.e. estimator) the artist used to recreate the picture on the right.

- __Estimand__ The thing you are trying to estimate (estimand). The thing you are trying to study (e.g. what is the effect of this policy on health).

- __Estimator__ The method or rule you use to try to get an estimate of your __estimand__ Matching is an estimator (or rather part of an estimator).

- __Estimate__ The results that you get from your estimator.

Two examples of estimators:
- Conducting randomised trials and taking the difference in average outcomes between the treatment and control groups.
- Using [Paul the Octopus](https://en.wikipedia.org/wiki/Paul_the_Octopus) to predict the results of the 2010 world cup.


- __Bias__ Is your _estimator_ expected to be equal to your _estimand_? If yes, then your _estimator_ is _unbiased_. If no, then it is _biased_ and the bias is equal to the expected value of your _estimand_ minus your _estimator_.

- __Efficiency__ From sample to sample, how much do your estimates vary? Think of this as how noisy your estimator is (see standard errors). The major things affecting this are sample size and the variance of your variable of interest.

Example: The average age in the UK is the __estimand__. Taking the average age of five people at random in the UK is an __unbiased estimator__ of the average UK age (which is the estimand). It is a somewhat __inefficient estimator__ as there is a lot of variance when you take the average age of only five people.

---

## Potential outcomes framework (Estimands)


|           | Sex |   | Outcome (if treated) | Outcome (if not treated) | Is actually treated? | Outcome (in real life) |
|-----------|-----|---|----------------------|--------------------------|----------------------|------------------------|
| Liam.     | M   |   | 1                    | 0                        | T                    | 1                      |
| Noah.     | M   |   | 1                    | 1                        | F                    | 1                      |
| Oliver.   | M   |   | 0                    | 0                        | T                    | 0                      |
| Amelia.   | F   |   | 1                    | 0                        | F                    | 0                      |
| Isabella. | F   |   | 0                    | 1                        | T                    | 0                      |
| Mia.      | F   |   | 1                    | 0                        | F                    | 0                      |

Assume that we can magically observe people's outcomes in worlds where they both do and don't get the treatment.

- __Average Treatment Effect (ATE)__ . The average difference between outcomes in parallel worlds where a person was not treated vs not treated. For example:

  $$\frac{(1 - 0) +  (1-1) + (0 - 0) + (1 - 0) + (0 - 1) + (1- 0 )}{6}$$

This is identical to differencing the average of the two outcome cols.

- __Average Treatment Effect on the Treated (ATT, various acronyms used)__. The average difference in outcomes for those _in the treatment group_ (e.g. Liam, Oliver, Isabella).

- __Average Treatment Effect on the Untreated (ATU, various acronyms used)__. The average difference in outcomes for those were actually in the treatment group.

- __Intention to Treat (ITT) effect__. The average difference in outcomes for those who were _assigned_ to receive the treatment (regardless of whether they were treated). If everyone assigned treatment also got the treatment then the __ITT = ATT__. Perfect compliance rarely happens.

---

# The design: Choosing what $X$ to match on

> Whether the context be policy analysis or any other form of empirical research, the logic of inference is summarized by the relationship:
>   _assumption + data => conclusions_
> Manski (2010)

__Research design, Identification strategy__ For causal inference, this is what you to get causal estimates. For experimenters, this is your experiment. For non-experimental studies, this is:
- natural experiment where treatment is randomised (whether intentional or not)
- quasi-experiment where the selection mechanism is entirely (or mostly) known and observed. Examples include regression discontinuity designs.

__Checklist and questions to ask yourself__
- Why do I believe that selection into the treatment is random after conditioning on $X$? Is this an assumption of convenience?
- Are there variables $X_{other}$ that _shouldn't_ affect selection into the treatment? You can use these to check your assumptions.
- Are there outcomes $Y_{other}$ that shouldn't be affected by the treatment? Best $Y_{other}$ are outcomes that are affected by confounder that may also affect treatment status. The outcome pre-treatment is an excellent candidate.
-  Avoid data mining. Avoid saying that $X_{other}$ _shouldn't_ affect selection _after_ you've seen the results.
- Always doubt yourself and gather evidence to try to refute your assumptions. Avoid fooling yourself.
- You will fail more times than you succeed; learn and move on. Failure is part of the scientific process. Nine times out of ten, pursuing research based on poor evidence is a waste of your talent and time.

---

# Matching (the stats part of an estimator)

There's at least two schools of though on matching. We'll cover one: the use of matching as a kind of data cleaning step. The goal of matching is to balance $X$.

## Steps for matching
From Stuart (2010):
1. Defining “closeness”: the distance measure used to determine whether one case is a good match for another,
2. Implementing a matching method, given that measure of closeness,
3. Assessing the quality of the resulting matched samples, and perhaps iterating with Steps (1) and (2) until well-matched samples result, and
4. Analysis of the outcome and estimation of the treatment effect, given the matching done in Step (3).


## Matching terms

- __Matching variables (usually called $X$)__ These are variables on which you want to do the matching.

- __Balance__ The treatment and control groups are balanced with respect to $X$ if the distribution of $X$ is the same across both groups. In the case of a single $X$, check univariate statistics. If there are multiple variable $X_1$, $X_2$ etc, check that the multivariate distributions (e.g. correlation between $X1$ and $X2$) are the same across the treatment and control.

- __Common support__ The treatment and control groups have some overlap in their values of $X$ (or whatever you choose to match on, see next section). For example, if every member of the treatment group has a value of $X$ over 0 and every member of the control group has $X < 0 $, there is no common support.

## How do we do the matching (method)?
Option called `method` in `matchit()`.

__Exact matching__ `method = 'exact'`: Matching on exact values of $X$. Example: if age and sex were the matching variables, we would match people with the _exact_ same age and sex. Use this if you can.

__Coarsened Exact matching (CEM)__ `method = 'cem'`. Use a rule to band variables. Then performs exact matching. Use this if you can't do exact matching.

__Nearest neighbour matching__ `method = 'nearest'`: Match each treatment case to their $k$ nearest neighour(s) by the distance measure (see distance).

__Genetic matching__ `method = 'genetic'`: A form of nearest neighbour matching. Basically, magic: too difficult to understand. Final balance is usually good though.

More options and full explanations: `?matchit` and see linked documents.


## How do we measure closeness (distance)?
Option called `distance` in `matchit()`.

__Mahalanobis distance__ `distance = 'mahalanobis'`: Based on Mahalanobis distance. This is a bit like euclidean distance but accounts for correlation between your matching variables $X_1$, $X_2$ etc. Also accounts for different scaling.

__Propensity Score__: Match on the predicted probability of being in the treatment group (or some other score value). The predictions come from a statistic model that uses $X$ as the predictors. Common ones are:
- logistic regression `distance = 'glm'`: Bog standard logit model where:
   $$log(odds(Treated)) = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + ...$$
- classification tree `distance = 'rpart'`
- random forest `distance = 'randomforest'`

__Insert custom distance__ `distance = .` You can supply your own distance sources to match on (e.g. your own derived propensity scores). Replace `.` with the name of the distance vector (e.g. an object called `thisVector`).

For all options check out: `help(topic = 'distance', package = 'MatchIt')`

## Misc Matching options


__Calipers__ Should we only find matches within a certain distance? This distance is called the caliper. Used for some distance options (e.g. propensity scores). This is to avoid bad matches. The option `caliper = .` define the size of the caliper and `caliper.std = .` defines whether the unit of measurement is standard deviation. For example, if the distance was a propensity score $P$ and we want the caliper to be 20% of the standard deviation of $P$ then we use: `caliper = 0.2, caliper.std = T`. If our distance measure was $age$ (custom distance) and we wanted matches with a less than 4 year age difference: `caliper = 4, caliper.std = F`.

__Discarding cases__ `discard = .`. Prior to matching, do we discard cases that fall outside the region of common support (see common support above)?  `discard = 'treat'` discards treatment cases outside of common support. `discard = 'both'` discards both treatment and control cases outside of common support. Default is `discard = 'none'`: nothing is discarded.

__Ratio__ `ratio = .`: For each treatment case, what is the maximum number of matched control cases we should use?. Example: `ratio = 1` for one-to-one (ala pairwise) matching; this is the default. There are diminishing returns to having more matched control cases and higher risks of bias from including dissimilar cases. `ratio = 4` is a nice upper limit.

More options and full explanations: `?matchit`


__subclass, substrata__ Group of cases that were matched to each other.

---

# Misc. R stuff

__list__: R object that literally a collection of other R objects. For example, item one can be a dataframe, item two can be a vector and so forth.

Useful for organising stuff and doing coding tricks. A dataframe in R is basically a special type of list.

````
thisList <- list() # makes a empty list object
thisList[[1]] <- 1
thisList[[2]] <- data.frame(id = 1:10, someVar = 5:14)

## Check an item in a list
thisList[[2]] ## check 2nd item

## Store using a name
thisList$objName <- 'someStuff'
thisList$objName ## what we saved

````

---

# Resources


## Much better resources for matching and the MatchIt package


Excellent reviews:

- Ho, Daniel E., Kosuke Imai, Gary King, and Elizabeth A. Stuart. Nonparametric Preprocessing for Parametric Causal Inference’. Journal of Statistical Software 42, no. 8 (2011). https://doi.org/10.18637/jss.v042.i08.

- Stuart E. A. (2010). Matching methods for causal inference: A review and a look forward. Statistical science : a review journal of the Institute of Mathematical Statistics, 25(1), 1–21. https://doi.org/10.1214/09-STS313




## FAQS:

### What if I have more than one treatment group/ continuous treatment?
Set up multiple comparisons of the ATT for each treatment group. Example: calculate ATT for treatment group 1 vs 2, group 1 vs 3 so forth. For each comparison, define the target treatment group and target 'control' then match. For continuous treatments, you can band the treatment variable and treat as if it was a muliple treatment group situtation.
Check the literature for much more complicated way to do this.
