//: Playground - noun: a place where people can play

import Cocoa

// Represents a Normal Developer
struct Developer {
    let id: String //any Identifier for this developer
    let xYears: Int //Years of Experience
    let projects: Int // Projects worked on.
    let pLangs: Int //Programming languages known
    
    init(id: String, years xYears: Int, projects: Int, langsKnown pLangs: Int) {
        self.id = id
        self.xYears = xYears
        self.projects = projects
        self.pLangs = pLangs
    }
}

// Represents a Developer who's parameters have been normalized
struct NormalizedDeveloper {
    let id: String //any Identifier for this developer
    let xYears: Double //Years of Experience
    let projects: Double // Projects worked on.
    let pLangs: Double //Programming languages known
    
    init(id: String, years xYears: Double, projects: Double, langsKnown pLangs: Double) {
        self.id = id
        self.xYears = xYears
        self.projects = projects
        self.pLangs = pLangs
    }
    
    init(developer: Developer) {
        self.init(id: developer.id, years: Double(developer.xYears), projects: Double(developer.projects), langsKnown: Double(developer.pLangs))
    }
}

func calculateExperienceOf(developer: NormalizedDeveloper, yearWeight: Double = 0.6, projectsWeight: Double = 0.3, langsWeight: Double = 0.1) -> Double {
//    assert((yearWeight + projectsWeight + langsWeight) == 1.0)
    
    return yearWeight * Double(developer.xYears) + projectsWeight * Double(developer.projects) + langsWeight * Double(developer.pLangs)
}


func getMean(items: [Double]) -> Double {
    return items.reduce(0.0) { $0 + $1 } / Double(items.count)
}

func normalize(_ value: Double, _ mean: Double, _ max: Double, _ min: Double) -> Double {
    return abs(value - mean)/(max - min)
}

func normalize(developer: Developer, withYearMean yearMean: Double, withProjectMean projectMean: Double, withLangsMean langsMean: Double, withMax max: Double, withMin min: Double) -> NormalizedDeveloper {
    
    let newYear = normalize(Double(developer.xYears), yearMean, max, min)
    let newProjects = normalize(Double(developer.projects), projectMean, max, min)
    let newLangs = normalize(Double(developer.pLangs), langsMean, max, min)
    
    return NormalizedDeveloper(id: developer.id, years: newYear, projects: newProjects, langsKnown: newLangs)
}

// This is main algorithm function
// Returns a pair of developers
func makePairFrom(developers: [Developer]) -> [[NormalizedDeveloper]]?{
    
    guard !developers.isEmpty else {
        return nil
    }
    
    if developers.count == 1 {
        return [[NormalizedDeveloper(developer: developers[0])]]
    }
    
    let yearsMean = getMean(items: developers.map { Double($0.xYears)})
    let projectsMean = getMean(items: developers.map { Double($0.projects)})
    let langsMean = getMean(items: developers.map { Double($0.pLangs)})
    
    
    //normalize and sort
    let sortedDevelopers = developers.map { (developer) -> NormalizedDeveloper in
        return normalize(developer: developer, withYearMean: yearsMean, withProjectMean: projectsMean, withLangsMean: langsMean, withMax: 1.0, withMin: 0.0)
    }.sorted {
        calculateExperienceOf(developer: $0) < calculateExperienceOf(developer: $1)
    }
    
    var developerPairs = [[NormalizedDeveloper]]();
    
    let totalDevs = developers.count
    let pairCount = totalDevs / 2
    
    //pair developers
    for i in 1...pairCount {
        var currentPair = [NormalizedDeveloper]()
        currentPair.append(sortedDevelopers[i-1])
        currentPair.append(sortedDevelopers[totalDevs - i])
        
        developerPairs.append(currentPair)
    }
    
    //add the middle (most average) developer to the last pair if odd devs
    if totalDevs%2 == 1 {
        let lastIdx = developerPairs.count-1
        developerPairs[lastIdx].append(sortedDevelopers[pairCount])
    }
    
    return developerPairs
}

//Sample Test Code
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
