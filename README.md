# matching-workshop
Author: Meng Le Zhang

# How to use?

What stuff is:
- start with 00 requirements.R to check you have the right packages
- raw course notes are in /docs. Vist the cheatsheet at: https://menglezhang.github.io/matching-causality-course/matching-cheatsheet.html
- code used for demoing just begin with a number (01, 02, etc)
- boilerplate code for copy+pasting+tweaking begins with the name template (template01 etc)
- data used for the course begins

# Exercise
Calculate several estimates for the treatment effect from the NSW using the data in the /data folder:
- makefile01 NSW+controls no outcome.rds
- makefile01 NSW+controls outcome only.rds

The outcome is wages in 1978 (re78) and the program is described in /docs

Do not use the file:
- makefile01 NSW complete.rds (if I forgot to get rid of it)

Save them and have a think about which treatment effects are the most credible. Ask yourself why:
- [ ] DO NOT USE THE SIZE OR DIRECTION OF THE TREATMENT EFFECT -- THIS IS BAD SCIENCE
- [ ] read docs/data-readme (https://menglezhang.github.io/matching-causality-course/data-readme.html)
- [ ] check difference in the pre-treatment outcome re75
- [ ] check balance statistics
- [ ] use any other methodological knowledge you may have

The first two points are so important that I'll repeat them twice.
- [ ] DO NOT USE THE SIZE OR DIRECTION OF THE TREATMENT EFFECT
- [ ] read docs/data-readme (https://menglezhang.github.io/matching-causality-course/data-readme.html)



# Empirical research

[![](https://mermaid.ink/img/pako:eNqVVU1vEzEQ_SvDSpxoQ4ETARqVpio9ICQK4rDpwVlPslb8sdjerKJN_juz9nq3jRoEycGO_ebN1_OkzQrDMZtma8uqEn7MF3qhgT6uXsYj59kaL_LvSBvrZw8f4n1RYrG50yuTcwPKWASOHgsvtgiNsZuHIxicn1_Cnq082ggXdLh3Rm7ZUmJ7zWrHJPyuyY0wGroL7G5mh0iEmj8f2pv8vlvAaJzCHJ1Y6ycxXjlXq6ojdW1hyGmtudBrKIyqJIUsd7DRptGzAzxvFSP_CO8vXpJri_shp7_hL4_w86vbnFvWAIOK-RK4YJSEAqZ5ZHhI6SV45Ok2ZsN2-5XQTF53d6dg2vgIPQpwtGxdXVH9u6hSXcfLSKTNa8V2SzxNEnE7dC_2a_Rz5llOK3DahGyMEhRH7anAOCR1sn1v-_b5xkzhK_NFSc1JDez5g8cgvwDIwxZUAvd946H3t8ZwohRSwhKlwG2ntP5uNoTzL9ghz_3o-n-ttXlcxz7_gS1gCrNl1uVhEcyjA29ibrBkDqmeiTQ9qWAQbaVxqNG5nCM1CMeDhE2_AzywfjFNQqcKgkJfGg6vQAlXTMBEIfccySpmFNKhyCTTRS-Sz_FHe0ehlxiF0AP401fVI4fajIU8BerK342LoDzXfiMHNsIc4GQ9gcqit8i8Qj2orpf2aPcodAefKDj-xPUgUXheo--SRkuLNGRuaERRUahESacnPYXniAM-b0rq8DaMQI4SdqYGKTbYV3oExu52LL9QrEvvcosK1RLtFGpHEzaeUsdG3TyeuL1VoGms8PizasMKdRUeKadxeTjOfPxmZ5lCq5jg9NfQdqhFRqVXuMimtOXMbhbZQh8IV1fUcLzhwhubTVdMOjzLWO3N_U4Xw0FEzePQ608PfwAWc0LX)](https://mermaid.live/edit#pako:eNqVVU1vEzEQ_SvDSpxoQ4ETARqVpio9ICQK4rDpwVlPslb8sdjerKJN_juz9nq3jRoEycGO_ebN1_OkzQrDMZtma8uqEn7MF3qhgT6uXsYj59kaL_LvSBvrZw8f4n1RYrG50yuTcwPKWASOHgsvtgiNsZuHIxicn1_Cnq082ggXdLh3Rm7ZUmJ7zWrHJPyuyY0wGroL7G5mh0iEmj8f2pv8vlvAaJzCHJ1Y6ycxXjlXq6ojdW1hyGmtudBrKIyqJIUsd7DRptGzAzxvFSP_CO8vXpJri_shp7_hL4_w86vbnFvWAIOK-RK4YJSEAqZ5ZHhI6SV45Ok2ZsN2-5XQTF53d6dg2vgIPQpwtGxdXVH9u6hSXcfLSKTNa8V2SzxNEnE7dC_2a_Rz5llOK3DahGyMEhRH7anAOCR1sn1v-_b5xkzhK_NFSc1JDez5g8cgvwDIwxZUAvd946H3t8ZwohRSwhKlwG2ntP5uNoTzL9ghz_3o-n-ttXlcxz7_gS1gCrNl1uVhEcyjA29ibrBkDqmeiTQ9qWAQbaVxqNG5nCM1CMeDhE2_AzywfjFNQqcKgkJfGg6vQAlXTMBEIfccySpmFNKhyCTTRS-Sz_FHe0ehlxiF0AP401fVI4fajIU8BerK342LoDzXfiMHNsIc4GQ9gcqit8i8Qj2orpf2aPcodAefKDj-xPUgUXheo--SRkuLNGRuaERRUahESacnPYXniAM-b0rq8DaMQI4SdqYGKTbYV3oExu52LL9QrEvvcosK1RLtFGpHEzaeUsdG3TyeuL1VoGms8PizasMKdRUeKadxeTjOfPxmZ5lCq5jg9NfQdqhFRqVXuMimtOXMbhbZQh8IV1fUcLzhwhubTVdMOjzLWO3N_U4Xw0FEzePQ608PfwAWc0LX)

# Misc:

```{mermaid}
graph TD

    subgraph stage0[Restart?];
    checkInfo[do more detective work]
    checkInfo --> |after more info|solvable{Causal question solveable?}
    end

    subgraph stage1[Stage one: Design];
    checkAssumptions{confounding completely known?}
    checkAssumptions --> |< 90% sure|checkInfo
    checkAssumptions --> |> 90% sure|checkDAG[draw a path diagram and check]

    checkDAG --> |DAG okay|finalCheck
    checkDAG --> |DAG not okay|checkInfo
    finalCheck{super sure?}
    finalCheck --> |no/maybe|checkInfo
    finalCheck --> |yes!|getData[get data and omit outcome]

    end

    subgraph stage2[Stage two: Matching];
    getData --> startMatch[start matching]
    designGood[Still believe in design?]

    designGood[Still believe in design?] --> |yes|startMatch
    designGood[Still believe in design?] --> |no|checkInfo

    startMatch --> covars[covariates to match based on design]
    covars --> closeness[define closeness]
    closeness --> matchHow[define matching method + misc. options]
    matchHow --> |check balance|checkBalance{Is the data balanced?}
    checkBalance --> |no|designGood
    checkBalance --> |yes|moreChecks{Other checks e.g. pretreatment outcome}
    moreChecks --> |checks = bad|designGood

    end

    subgraph stage3[Stage three: Estimation];
    moreChecks --> |checks = okay|estimation[whatever model you like]
    estimation --> checkWeights[remember: use weights + covariates]
    checkWeights --> writeUp{write up and done}

    end

```
