//
//  ContentView.swift
//  SpeedTapGame
//
//  Created by  on 12/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var numOfTaps = 0
    @State var highScore = UserDefaults.standard.integer(forKey: "highScore")
    @State var images = ["circle.tophalf.fill", "circle.bottomhalf.fill"]
    @State var buttonState = true
    @State private var timeRemaining = 0.0
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    @State var flame = "" //flame.fill
    @State var scores:[Int] = []

    
    var body: some View {
        
        NavigationView{
            VStack {
                Image(systemName: flame)
                    .resizable()
                    .frame(width: 40, height: 50)
                    .animation(.easeOut(duration: 0.5))
                    .foregroundColor(.red)
                
                Text("High Score: \(highScore)")
                    .font(.title)
                
                Text("\(timeRemaining, specifier: "%.3f")")
                
                Text("Score: \(numOfTaps)")
                    .font(.title)
                    .padding()
                
                
                
                
                Button {
                    buttonState = false
                    timeRemaining = 5.0
                    numOfTaps = 0
                    
                    
                } label: {
                    Text("Start")
                        .padding()
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.green))
                        .foregroundColor(Color.white)
                }
                
                
                
                Button {
                    if timeRemaining > 0
                    {
                        numOfTaps += 1
                    }
                    
                } label: {
                    Image(systemName: images[numOfTaps%2])
                        .resizable()
                        .scaledToFit()
                        .padding(75)
                        .foregroundColor(.indigo)
                }.disabled(buttonState)
                
                
                
            }
            .navigationTitle("SpeedTap")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: scoresView(scores: scores)) {
                        Image(systemName: "crown.fill")
                            .resizable()
                            .foregroundColor(.indigo)
                            .frame(width: 40, height: 34)
                    } 
                }
            })
            .onReceive(timer) { time in
                if timeRemaining > 0 {
                    timeRemaining -= 0.001
                    if numOfTaps > 15
                    {
                        flame = "flame.fill"
                    }
                }
                else {
                    if numOfTaps != 0 && !scores.contains(numOfTaps)
                    {
                        scores.append(numOfTaps)
                        scores.sort()
                        scores.reverse()
                        saveToUserDefaults()
                    }
                    
                    timeRemaining = 0
                    flame = ""
                    buttonState = true
                    if numOfTaps > highScore {
                        highScore = numOfTaps
                        
                    }
                }
            }
            .padding()
        }
        .onAppear(perform: loadFromUserDefaults)
    }
    func saveToUserDefaults()
    {
        let defaults = UserDefaults.standard
        defaults.set(scores, forKey: "highScores")
    }

    func loadFromUserDefaults()
    {
        let defaults = UserDefaults.standard
        
        if let foundScores = defaults.array(forKey: "highScores") as? [Int] {
            self.scores = foundScores
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
