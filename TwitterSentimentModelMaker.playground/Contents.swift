import Cocoa
import CreateML

var str = "Hello, playground"
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/alexis/Code/iOS/Twittermenti/twitter-sanders-apple3.csv"))

let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metaData = MLModelMetadata(author: "Alexis Garza", shortDescription: "A model trained to classify sentiment analisys", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/alexis/Code/iOS/Twittermenti/TweetSentimentClassifer.mlmodel"))
