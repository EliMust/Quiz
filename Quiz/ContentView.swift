//  ContentView.swift
//  Quiz

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Bangladesh", "Brazil", "Canada", "Germany", "Greece", "Russia", "Sweden", "UK", "USA"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .teal, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                
                VStack {
                    Text("Выбери флаг:")
                        .fontWeight(.black)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .fontWeight(.black)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 120)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 1)
                    }
                }
                
                Text("Набрано баллов: \(score)")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
            }
            
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Набрано баллов: \(score)"), dismissButton: .default(Text("Продолжить игру")) {
                self.askQuestion()
            })
        }
    }
    
    //функция, которая запускает игру после Alert
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Ай да молодец! Мое уважение! Браво!"
            score += 1
        }  else {
            scoreTitle = "Это флаг \(countries[number]). Иди учи географию, а не в игры играй."
            score -= 1
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
