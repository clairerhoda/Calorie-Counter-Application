//
//  ContentView.swift
//  CalorieCounter_CPSC411
//
//  Created by Claire Rhoda on 5/7/21.
//

import SwiftUI

struct FacultyDO {
    var firstName : String
    var lastName : String
    var cwid : Int
}

struct CaloriesCalculate : Codable {
    var totalCalories : String = ""
}

struct ContentView: View {
    
    @State private var gender: String = ""
    @State private var currentWeight: String = ""
    @State private var height: String = ""
    @State private var goalWeight: String = ""
    @State private var age: String = ""
    @State private var calorieTotal: String = ""
    @State private var btnStr: String = "Calculate Calories"
    @State private var BMR : Double = 0
    @State private var calories : Double = 0
    
    var body: some View {
        let lightPink = Color(red: 0.9294, green: 0.6196, blue: 0.5922)
        let lighterPink = Color(red: 0.9686, green: 0.8706, blue: 0.8745)
        NavigationView {
            VStack{
                Text("Welcome").font(Font.custom("Charter-Black", size: 25))
                TextField("Please Enter Your Gender", text: $gender).padding(.all, 3)
                    .background(lighterPink)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Please Enter Your Current Weight", text: $currentWeight)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.all, 3)
                    .background(lighterPink).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Please Enter Your Height (in inches)", text: $height)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.all, 3)
                    .background(lighterPink).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Please Enter Age", text: $age)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.all, 3)
                    .background(lighterPink).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Please Enter Goal Weight", text: $goalWeight)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.all, 3)
                    .background(lighterPink).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.bottom, 10)
                NavigationLink(destination: DetailView(calories: CaloriesCalculate(totalCalories: calorieTotal)).onAppear(){
                    if (gender != "" && currentWeight != "" && height != "" && age != "" && goalWeight != "") {
                        calorieTotal = self.calculateCalories(gender: gender, weight: Double(currentWeight)!, height: Double(height)!, age: Double(age)!, goalWeight: Double(goalWeight)!)
                    }else{
                        calorieTotal = "Enter the correct inputs!"
                    }
                   
                }) {
                    Text("Calculate Calories").foregroundColor(.black)
                    .font(Font.custom("Charter-Black", size: 16)).padding(5).border(Color.black).background(lightPink)
                }
            }.padding(.bottom, 130)
        }
    }
    
    func calculateCalories(gender: String, weight: Double, height: Double, age: Double, goalWeight: Double)-> String {
        var genderCheck = false;
        if (gender == "male" || gender == "Male" || gender == "MALE"){
            BMR = (4.536 * weight) + (15.88 * height) - (5 * age) + 5
            genderCheck = true;
        }
        
        if (gender == "female" || gender == "Female" || gender == "FEMALE"){
            BMR = (4.536 * weight) + (15.88 * height) - (5 * age) - 161
            genderCheck = true;
        }
        
        if (genderCheck == false) {
            return "Enter Male or Female for gender input!"
        }

        if (weight > goalWeight){
            calories = (BMR * 1.55) - 500
        }
        
        if (weight == goalWeight){
            calories = (BMR * 1.55)
        }
        
        if (weight < goalWeight){
            calories = (BMR * 1.55) + 500
        }
        genderCheck = false;
        return String(Int(calories))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
