//
//  DetailView.swift
//  Created by Claire Rhoda on 5/7/21.
//
//  Created by Claire Rhoda on 5/7/21.
//
//
//  DetailView.swift
//

import SwiftUI

struct DetailView: View {
    var calories : CaloriesCalculate
    @State private var btnStr: String = "Calculate Calories"
    @State private var caloriesEaten : String = ""
    @State private var totalEaten : String?

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        let lightPink = Color(red: 0.9294, green: 0.6196, blue: 0.5922)
        let lighterPink = Color(red: 0.9686, green: 0.8706, blue: 0.8745)
        VStack {
            if calories.totalCalories == "Enter the correct inputs!" || calories.totalCalories == "Enter Male or Female for gender input!"{
                Text(totalEaten ?? calories.totalCalories).foregroundColor(.red)
                    .font(Font.custom("Charter-Black", size: 16)).multilineTextAlignment(.center)
            }
            if calories.totalCalories != "Enter the correct inputs!" && calories.totalCalories != "Enter Male or Female for gender input!"{
                Text("Total Calories Available to Consume").foregroundColor(.black).padding(.bottom, 10)
                    .font(Font.custom("Charter-Black", size: 20)).multilineTextAlignment(.center)
                Text(totalEaten ?? calories.totalCalories).foregroundColor(lightPink)
                    .font(Font.custom("Charter-Black", size: 25)).shadow(color: lighterPink, radius: 1)

                TextField("Add calories of food item here", text: $caloriesEaten)
                    .font(Font.custom("Charter-Black", size: 14)).padding(.all, 3)
                    .background(lighterPink).padding(.horizontal, 20)
                    .foregroundColor(.black).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.bottom, 10)
                HStack{
                    Button(action: {
                        btnStr = "Calculating"
                        if caloriesEaten != ""{
                            self.totalEaten = subtractCalories(caloriesEaten: Int(caloriesEaten)!, totalCalories: Int(self.totalEaten ?? calories.totalCalories)!)
                        }
                        btnStr = "Calculate Calories"
                        caloriesEaten = ""

                    }, label: {
                        Text("\(btnStr)").foregroundColor(.black)
                            .font(Font.custom("Charter-Black", size: 16)).padding(5).border(Color.black)
                    }).background(lightPink).padding(.trailing, 10)
                }.frame(maxWidth: .infinity, alignment: Alignment.trailing)
            }
            
        }.padding(.bottom, 25).navigationBarItems(leading: HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()

            }, label: {
                Text("< Alter Data").foregroundColor(.black)
                    .font(Font.custom("Charter-Black", size: 16)).shadow(color: lightPink, radius: 1)
            })
        })
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
    func subtractCalories(caloriesEaten: Int, totalCalories: Int)-> String {
        var newCalories : Int;
        newCalories = totalCalories - caloriesEaten

        if (newCalories < 0) {
            newCalories = 0
        }
        return String(newCalories)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(calories: CaloriesCalculate(totalCalories: "0"))
    }
}
