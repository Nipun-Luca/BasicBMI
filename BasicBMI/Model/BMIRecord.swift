//
//  BMIRecord.swift
//  BasicBMI
//
//  Created by Nipun Luca muhudugama on 09/10/2023.
//

import Foundation

struct BMIRecord: Identifiable {
    var id = UUID()
    var date: Date
    var bmiValue: Double
    var changePercentage: Double? = nil
}
