//
//  BMIViewModel.swift
//  BasicBMI
//
//  Created by Nipun Luca muhudugama on 09/10/2023.
//

import Foundation

class BMIViewModel: ObservableObject {
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var selectedDate: Date = Date()
    @Published var bmiRecords: [BMIRecord] = []
    
    private let userDefaults = UserDefaults.standard
    private let bmiRecordsKey = "BMIRecordsKey"
    
    init(){
        loadStoredBMIRecords()
    }
    
    func updateStoredBMIRecords() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(bmiRecords) {
            if let jsonString = String(data: encoded, encoding: .utf8) {
                print("JSON String representation of encoded data: \(jsonString)")
            }
            
            userDefaults.set(encoded, forKey: bmiRecordsKey)
        }
    }
    
    func loadStoredBMIRecords() {
        if let data = userDefaults.data(forKey: bmiRecordsKey) {
            print("bmiRecords... before decoding....\(data)")
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([BMIRecord].self, from: data) {
                bmiRecords = decoded.sorted(by: { $0.date < $1.date })
                print("decoded data ...\(decoded)")
            }
        }
    }
    
    func calculateBMI(){
        if let heightValue = Double(height), let weightValue = Double(weight), heightValue > 0, weightValue > 0{
            let BMI = weightValue / (heightValue * heightValue)
            let record = BMIRecord(date: selectedDate, bmiValue: BMI)
            
            bmiRecords.append(record)
            bmiRecords.sort(by: { $0.date < $1.date })
            
            for index in 1..<bmiRecords.count {
                let previousRecord = bmiRecords[index - 1]
                let changePercentage = ( (bmiRecords[index].bmiValue - previousRecord.bmiValue) / previousRecord.bmiValue) * 100
                bmiRecords[index].changePercentage = changePercentage
            }
            
            updateStoredBMIRecords()
        }
    }
        
    func classifyBMI(BMI: Double) -> String{
        if BMI < 18.5 {
            return "Underweight"
        } else if BMI < 24.9 {
            return "Normal weight"
        } else if BMI < 29.9 {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
}
