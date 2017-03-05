# Developer Pairing Algorithm

This is an algorithm for pairing developers with different levels of experience and background.

## How is works
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
Then the first is paired with the last and the second is paired with the second to the last and one and one.