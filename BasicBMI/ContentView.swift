//
//  ContentView.swift
//  BasicBMI
//
//  Created by Nipun Luca muhudugama on 01/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var BMI: Double = 0.0
    @State private var BMImessage: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        
        ZStack {
            Color.brown
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Basic BMI Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    
                
                TextField("Enter height (m)", text: $height)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.black)
                TextField("Enter weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.black)
                
                Button(action: calculateBMI, label: {
                    Text("Calculate BMI")
                })
                .padding()
                
                Text("BMI: \(String(format: "%.2f", BMI))")
                    .font(.headline)
                
                Text(BMImessage)
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .padding()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text("Please enter valid numeric values for height and weight."), dismissButton: .default(Text("Try Again")))
        }
    }
    
    func calculateBMI(){
        if let heightValue = Double(height), let weightValue = Double(weight), heightValue > 0, weightValue > 0{
            BMI = weightValue / (heightValue * heightValue)
            
            if BMI < 18.5 {
                BMImessage = "Underweight"
            } else if BMI < 24.9 {
                BMImessage = "Normal weight"
            } else if BMI < 29.9 {
                BMImessage = "Overweight"
            } else {
                BMImessage = "Obese"
            }
        } else {
            BMI = 0
            BMImessage = ""
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
