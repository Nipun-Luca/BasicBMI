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
    
    func calculateBMI(){
        if let heightValue = Double(height), let weightValue = Double(weight), heightValue > 0, weightValue > 0{
            let BMI = weightValue / (heightValue * heightValue)
            
            var changePercentage: Double?
            if let lastRecord = bmiRecords.last {
                changePercentage = ( (BMI - lastRecord.bmiValue / lastRecord.bmiValue) * 100 )
            }
            
            let record = BMIRecord(date: selectedDate, bmiValue: BMI, changePercentage: changePercentage)
            bmiRecords.append(record)
        }
        
        height = ""
        weight = ""
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
