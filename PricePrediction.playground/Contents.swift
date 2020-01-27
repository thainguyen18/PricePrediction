import CreateML
import Foundation

 let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/thainguyen/Desktop/house-prices.json"))

 let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

 let params = MLBoostedTreeRegressor.ModelParameters(maxIterations: 500)
 let pricer = try MLBoostedTreeRegressor(trainingData: trainingData, targetColumn: "value", parameters: params)

let evaluationMetrics = pricer.evaluation(on: testingData)
print(evaluationMetrics.rootMeanSquaredError)
print(evaluationMetrics.maximumError)

let metadata = MLModelMetadata(author: "Thai Nguyen", shortDescription: "A model trained to predict house prices.", version: "1.0")
try pricer.write(to: URL(fileURLWithPath: "/Users/thainguyen/Desktop/HousePrices.mlmodel"), metadata: metadata)
