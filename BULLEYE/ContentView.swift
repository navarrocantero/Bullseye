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
    @State var round: Int = 1
    @State var totalScore: Int = 0
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct FontStyle:ViewModifier{
        var size: Int
        func body(content:Content)-> some View{
            return content
                .font(Font.custom("Arial Rounded MT Bold",size:CGFloat(size)))
        }
        
    }
    
    struct LabelStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .modifier(FontStyle(size:18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .modifier(FontStyle(size:24))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .modifier(FontStyle(size:18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .modifier(FontStyle(size:12))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
            VStack{
                // TARGET ROW
                Spacer()
                HStack{
                    Text("Put the bullseye close as you can to:").modifier(LabelStyle())
                    Text("\(self.target)").modifier(ValueStyle())
                    
                }
                Spacer()
                HStack{
                    Text("1").modifier(LabelStyle())
                    
                    Slider(value: self.$sliderValue,in:1...100 ).accentColor(Color.green)
                    Text("100").modifier(LabelStyle())
                    
                }
                Spacer()
                // SLIDER
                Button(action: {
                    print("Button ")
                    
                    self.alertIsVisible = true
                }) {
                    Text("HITME") .background(Image("Button")).modifier(ButtonLargeTextStyle())
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
                        startNewGame()
                        
                    }, label: {
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    })
                    .background(Image("Button")).modifier(Shadow()).padding(.horizontal,25)
                    Spacer()
                    Text("Score:").modifier(LabelStyle())
                    Text("\(totalScore)").modifier(ValueStyle())
                    Spacer()
                    Text("Round:").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()){
                        HStack{
                            Image("InfoIcon")
                            Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")).modifier(Shadow()).padding(.horizontal,25)
                    
                }.padding(.bottom,20)
            }
        }.background(Image("Background"),alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    func sliderValueRounded()-> Int {
        return Int(sliderValue.rounded())
    }
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    
    func startNewGame() {
        totalScore = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width:894,height:400))
    }
}
