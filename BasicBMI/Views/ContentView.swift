//
//  ContentView.swift
//  BasicBMI
//
//  Created by Nipun Luca muhudugama on 01/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert: Bool = false
    @StateObject var viewModel = BMIViewModel()
    @FocusState private var fieldIsFocused: Bool

    var body: some View {
        
        ZStack {
            Color.brown
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Basic BMI Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    
                
                TextField("Enter height (m)", text: $viewModel.height)
                    .focused($fieldIsFocused)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.black)
                TextField("Enter weight (kg)", text: $viewModel.weight)
                    .focused($fieldIsFocused)
                    .keyboardType(.decimalPad)
                    .padding()
                    .border(Color.black)
                
                DatePicker("Select Date", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
            
                Button(action: {
                    viewModel.calculateBMI()
                    fieldIsFocused = false
                }) {
                    Text("Calculate BMI")
                }
                .padding()

                
                Text("BMI Records")
                    .font(.headline)
                
                ScrollView {
                    List(viewModel.bmiRecords) { record in
                        HStack(spacing: 10) {
                            Text("\(record.date, formatter: DateFormatter.shortDate)")
                            
                            Text(String(format: "%.2f", record.bmiValue))
                            
                            
                        }
                    }
                }
                /*
                List(viewModel.bmiRecords) { record in
                    VStack(alignment: .leading){
                        Text(record.date, format:
                                Date.FormatStyle().day().month().year())
                        Text("BMI: \(String(format: "%.2f", record.bmiValue))")
                        
                        if let changePercentage = record.changePercentage {
                            Text("Change: \(String(format: "%.2f", changePercentage))%")
                        }
                        Text(viewModel.classifyBMI(BMI: record.bmiValue))
                            .font(.subheadline)
                            .foregroundStyle(Color.blue)
                    }
                }
                .background(.gray)
                .cornerRadius(5.0)
                .scrollContentBackground(.hidden)
                 */
            }
            .padding()
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text("Please enter valid numeric values for height and weight."), dismissButton: .default(Text("Try Again")))
        }
    }
}

#Preview {
    ContentView()
}
