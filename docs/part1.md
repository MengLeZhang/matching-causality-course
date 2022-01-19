# Part one: Research design

Also known as the identification strategy for economists.

# Summary
- What we want to know is if _doing_ a change in _T_ changes _Y_
- Difference between a structural model/ causal model/ and the techniques we use to estimate those models
- Concentrating on one type of natural experiment:
  - What variables do we need
  - what variables do we not use
  - how can we check robustness
- Next steps: Matching as a general all purpose technique for adjusting for confounding


# What is this course about?

Causality does not really have involve experiments or any of that stuff. However, it is very convenient to use the language of experiments to describe causal research designs. So when I say treatment _T_ I refer to the key variable or intervention that we are interested in. This can be an actual intervention that we can action, like a policy or drug, or something like biological sex that we can only really alter in a thought experiment. Most of this course is about estimating the effects of _T_ on outcomes _Y_ without experiments using observational data (i.e. data from ).

Causality can be about i) whether a change in _T_ changes _Y_ or ii) whether _T_ caused a change in _Y_. The former is refered to as the effects of causes (where _X_ is the cause) whilst the latter is known as the causes of effects (where _Y_ is the effect). Let's use the quality of school buildings as an example. I'll explain why later. The question does better school buildings lead to better exam results is an example of the former. The degree to which the inequality in exams results across schools can be attributed to school buildings is an example of the latter.

In this course, we are concerned about the effects of causes although the two questions are related. Clearly if changes in school buildings never has an effect on exam outcomes then it cannot be a cause of current inequalities in education.

Why would we want to know if changing _T_ affect _Y_? For me, it mainly boils down to action; we want to know what works so we put forward actions to change the world (check out the afterword to Judea Pearl's book causality; it's great). In a world of limited resources, we also need to know how one course of action measures up others. Better school buildings might improve educational outcomes but is it the most cost-effective way to improve exam results. We might see better results from just giving kids free breakfast clubs. We can't possibly decide unless we know the effect of both these interventions (and their costs).

First let me introduce the terms I will use. Since the same terms are used in same or similar ways in elsewhere in other textbooks or subject areas, I've also noted down what other names you may know them as.

Term used in this course  | Meaning   | Synonyms
--|---|--
Research design  | What you are going to do answer your causal question  | Identification Strategy
Treatment _T_ | The thing we are interested in changing under ideal conditions/ experiment/ thought experiment. Literally the most important thing in your design.    |  _X_ is somtimes used instead of _T_
Confounder _X_  | Variable that complicates the causal relationship between out treatment and outcome. Usually a common cause that determines both our treatment and outcome. Often this is unobserved.   | _U_ is a common variable used to denote confounders
Outcome of interest _Y_  | The thing that is changed by the treatment. There can be more than one outcome of interest.  |
Mediators _M_ | Thing changed by the treatment that goes on to also change the outcome. For instance, better school buildings (_T_) lead to better teaching (_M_) which lead to better results (_Y_)   |   |

# What is causality?

The history of causality it pretty interesting -- but most of it is largely irrelevant to the applied sciences. Take it from me -- I've got a philosophy degree. The modern interpretation of causality -- or rather the causes of effect which is one type of causality -- lies in the counterfactual model of causality. There is nothing particularly quantitative about the counterfactual model; it just involves ask the question 'what would happen if'.

Imagine one parallel reality where an action _T_ happened and another reality where _T_ did not happen but nothing else was changed. If some time later _Y_ differs across the two worlds, then we would say that _T_ has a causal effect on _Y_. Using our example so far, what would happen if School A got a brand new school building? Would that improve the exam results of its pupils? To answer this, we need to do a thought experiment and imagine a counterfactual world where everything is the same except that School A did get a brand new building. In that counterfactual world, if we observed that exam scores were different then we would say that having a new school building caused changes in exam scores.

We can't directly observe parallel worlds. Howeverm in a bizzare tiwst, we can use the same statistical reasoning behind randomly sampling in surveys to infer what happens in parallel worlds. This reasoning underlies the Neyman-Rubin approach to the statistical analysis of cause and effect. 

## Randomisation and causality: Experiments are surveys of parallel realities

Say we want to know the mean of all exam scores (_Y_) for every pupil in England. As it happens, we can easily find this out due to digitised administrative data. However, if we had to collect this data ourselves it would be prohibitively expensive since there are millions of pupils in England. However, we can take a random sample of pupils and calculate the sample mean _Y_. Due to randomisation, this

In doing so, we effectively re-invented the randomised control trial. Note that none of the reasoning behind this model suggest that we have to _intentionally_ intervene to randomise who receives the treatment and who doesn't. This means that natural experiment -- under ideal conditions -- are equally valid ways to derive causal inference.

## Another approach: Judea Pearl and Directed Acyclic Graphs (Bayesian Networks)

Another way to think about causality is . The surprising thing about Pearl's approach is that it needs not involve randomisation to make inferences. To be fair, the machine approach to causality probably doesn't appeal so much to social scientists due to historical reasons. The early pioneers of Sociology practised a type of positivism that also invoked the machine analogy albiet in a different way.

The important thing about DAGs is that they give us a great framework to understand what to do when the treatment is not allocated completely at random.

I personally think Pearl's book is great but I do agree my colleagues that it is a bit dry. It only uses fairly simple maths (which is amazing) but quickly get . It's definitely a book that encourages you read and re-read early parts so that you can understand later part. Pearl himself gives you a guide about which order to read the chapters in if you are only interested in a particular topic  @WIP. It's also at least twice as readable as most econometrics textbook.

There's also another book on causality by @Robins but I haven't read it. It looks at least as dry as Pearl's book.


A causal model is only our working theory of what we think . Often we are only sure about a few aspects of the causal model. Luckily we
