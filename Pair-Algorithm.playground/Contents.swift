//: Playground - noun: a place where people can play

import Cocoa

struct Developer {
    let id: String //any Identifier for this developer
    let xYears: Int //Years of Experience
    let projects: Int // Projects worked on.
    let pLangs: Int //Programming languages known
    
    init(id: String, _ xYears: Int, _ projects: Int, _ pLangs: Int) {
        self.id = id
        self.xYears = xYears
        self.projects = projects
        self.pLangs = pLangs
    }
}

struct NormalizedDeveloper {
    let id: String //any Identifier for this developer
    let xYears: Double //Years of Experience
    let projects: Double // Projects worked on.
    let pLangs: Double //Programming languages known
    
    init(id: String, _ xYears: Double, _ projects: Double, _ pLangs: Double) {
        self.id = id
        self.xYears = xYears
        self.projects = projects
        self.pLangs = pLangs
    }
}

func calculateExperienceOf(developer: NormalizedDeveloper, yearWeight: Double = 0.6, projectsWeight: Double = 0.3, langsWeight: Double = 0.1) -> Double {
    assert((yearWeight + projectsWeight + langsWeight) == 1.0)
    
    return yearWeight * Double(developer.xYears) + projectsWeight * Double(developer.projects) + langsWeight * Double(developer.pLangs)
}

func getMean(items: [Double]) -> Double {
    
    return items.reduce(0.0) { $0 + $1 } / Double(items.count)
}

func normalize(_ value: Double, _ mean: Double, _ max: Double, _ min: Double) -> Double {
    return (value - mean)/(max - min)
}

func normalize(developer: Developer, withYearMean yearMean: Double, withProjectMean projectMean: Double, withLangsMean langsMean: Double, withMax max: Double, withMin min: Double) -> NormalizedDeveloper {
    
    let newYear = normalize(Double(developer.xYears), yearMean, max, min)
    let newProjects = normalize(Double(developer.projects), projectMean, max, min)
    let newLangs = normalize(Double(developer.pLangs), langsMean, max, min)
    
    return NormalizedDeveloper(id: developer.id, newYear, newProjects, newLangs)
}

// This is main algorithm function
// Returns a pair of developers
func makePairFrom(developers: [Developer]) -> [[NormalizedDeveloper]]{
    
    if developers.count == 1 {
        return [[developers[0]]]
    }
    
    let yearsMean = getMean(items: developers.map { Double($0.xYears)})
    let projectsMean = getMean(items: developers.map { Double($0.projects)})
    let langsMean = getMean(items: developers.map { Double($0.pLangs)})
    
    
    
    let sortedDevelopers = developers.map { (developer) -> NormalizedDeveloper in
        return normalize(developer: developer, withYearMean: yearsMean, withProjectMean: projectsMean, withLangsMean: langsMean, withMax: 1.0, withMin: 0.0)
    }.sorted { (devA, devB) -> Bool in
        return calculateExperienceOf(developer: devA) < calculateExperienceOf(developer: devB)
    }
    
    var developerPairs = [[NormalizedDeveloper]]();
    
    var currentPair: [Developer]
    let pairCount = developers.count / 2
    
    //TODO: Pair sortedDevelopers and return
    
    return developerPairs
}

