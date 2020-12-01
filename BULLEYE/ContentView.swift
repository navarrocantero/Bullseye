//
//  ContentView.swift
//  BULLEYE
//
//  Created by navarrocantero on 28/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible : Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in:1...100)
    @State var round: Int = 0
    @State var totalScore: Int = 0
    
    struct LabelStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content.foregroundColor(Color.white)
                .shadow(color:Color.black,radius:5,x:2,y:3 )
                .font(Font.custom("Arial Rounded MT Bold",size:18))
        }
    }
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
            VStack{
                // TARGET ROW
                Spacer()
                HStack{
                    Text("Put the bullseye close as you can to:").modifier(LabelStyle())
                    Text("\(self.target)")
                    
                }
                Spacer()
                HStack{
                    Text("1").modifier(LabelStyle())
                    
                    Slider(value: self.$sliderValue,in:1...100 )
                    Text("100").modifier(LabelStyle())
                    
                }
                Spacer()
                // SLIDER
                Button(action: {
                    print("Button ")
                    
                    self.alertIsVisible = true
                }) {
                    Text("HITME") .background(Image("Button")).modifier(LabelStyle())
                }
                
                .alert(isPresented:$alertIsVisible){ () -> Alert in
                    return Alert(title: Text("Hello there!"), message: Text("The slider's value is  \(sliderValueRounded()).\n" +
                                                                                "You scored \(pointsForCurrentRound()) points this round."), dismissButton: .default(Text("AWESOME")){
                                                                                    
                                                                                    round+=1
                                                                                    totalScore += pointsForCurrentRound()
                                                                                    self.target = Int.random(in: 1...100)
                                                                                })
                    
                }
                //BUTTON ROW
                HStack{
                    Button(action: {
                        self.round = 1
                        self.totalScore = 0
                        
                    }, label: {
                        Text("Start Over")
                    })
                    .background(Image("Button")).modifier(LabelStyle())
                    Spacer()
                    Text("Score: \(totalScore)").modifier(LabelStyle())
                    
                    Text("Round:\(self.round)").modifier(LabelStyle())
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("info")
                    }) .background(Image("Button")).modifier(LabelStyle())
                }.padding(.bottom,20)
            }
        }.background(Image("Background"),alignment: .center)
    }
    func sliderValueRounded()-> Int {
        return Int(sliderValue.rounded())
    }
    func pointsForCurrentRound()->Int {
        var value = abs(target-sliderValueRounded())
        print(value)
        if(value == 0){
            return 200
        }else{
            return value
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width:894,height:400))
    }
}
