# Developer Pairing Algorithm

This is an algorithm for pairing developers with different levels of experience and background.

## How it works
It calculates the experience of all developer's in a list, and then pairs the developers in order of increasing and reducing complexity.

### Developer Experience Algorithm
Three parameters are used to calculate a developer's experience.
1. Years of Experience (`xYears`).
2. Total No. of Projects worked on (`projects`).
3. No. of programming languages known (`pLangs`).

The developer's experience is then calculated with the formulae:
```
experience = (0.6 * xYears) + (0.3 * projects) + (0.1 * pLangs) 
```

Note that an extra step is actually taken to normalize `xYears`, `projects` and `pLangs` to the range of 1.0 - 0.0.

### Pairing Algorithm
The list of Developers are then sorted according to their calculated `experience`.
Then the first is paired with the last and the second is paired with the second to the last and on and on.

## Example Usage
```swift
let testDevelopers: [Developer] = [
    Developer(id: "Perfect", years: 3, projects: 15, langsKnown: 5),
    Developer(id: "Jubril", years: 2, projects: 50, langsKnown: 4),
    Developer(id: "Amarachi", years: 1, projects: 5, langsKnown: 4),
    Developer(id: "Sao", years: 3, projects: 20, langsKnown: 4)
]

let listOfPairs = makePairFrom(developers: testDevelopers)
for pairedDevelopers in listOfPairs! {
    print("---Paired Team---")
    for devs in pairedDevelopers {
        print(devs)
    }
}
```

The output of the above code would be of the form:
```swift
---Paired Team---
NormalizedDeveloper(id: "Sao", xYears: 0.75, projects: 2.5, pLangs: 0.25)
NormalizedDeveloper(id: "Jubril", xYears: 0.25, projects: 27.5, pLangs: 0.25)
---Paired Team---
NormalizedDeveloper(id: "Perfect", xYears: 0.75, projects: 7.5, pLangs: 0.75)
NormalizedDeveloper(id: "Amarachi", xYears: 1.25, projects: 17.5, pLangs: 0.25)
```

