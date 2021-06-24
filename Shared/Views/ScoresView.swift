//
//  ScoresView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

struct ScoresView: View {
    
    @State var switchViews = false
    @State var ATotalsFile = TheAuthoritarianism.loadFromFile()
    @State var CTotalsFile = TheCapitalism.loadFromFile()
    @State var DTotalsFile = TheDemocratic.loadFromFile()
    @State var STotalsFile = TheSocialism.loadFromFile()
    @State var TTotalsFile = TheTotals.loadFromFile()
    @State var ATotals = [0, 0, 0, 0, 0, 0]
    @State var CTotals = [0, 0, 0, 0, 0, 0]
    @State var DTotals = [0, 0, 0, 0, 0, 0]
    @State var STotals = [0, 0, 0, 0, 0, 0]
    @State var TTotals = [0, 0, 0, 0, 0, 0]
    @State var playerCountFile = DefaultPlayerCount.loadFromFile()
    @State var playerCount = 4
    @State private var minusColor = Color.blue
    @State private var plusColor = Color.blue
    @State var namesFile = Names.loadFromFile()
    @State var names = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"]
    @State var initials = ["P1", "P2", "P3", "P4", "P5", "P6"]
    @State var showTotals = false
    
    @EnvironmentObject var theme: colorThemeSetting
    
    var body: some View {
        ZStack {
            NavigationView() {
                ZStack {
                    
                    if theme.theme == 3 {
                        BackgroundOld(color1: "bgPink", color2: "bgBlue")
                    }
                    
                    VStack {
                        HStack {
                            Text("Players: \(playerCount)")
                                .padding(10)
                                .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                .cornerRadius(10)


                            Button() {
                                
                                
                                if playerCount == 4 || playerCount == 3 {
                                    if theme.theme == 3 {
                                        minusColor = .white
                                    } else {
                                    minusColor = .gray
                                    }
                                }
                                
                                if playerCount >= 4 {
                                    plusColor = .blue
                                    playerCount -= 1
                                }

                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(minusColor)
                            }
                            Button() {
                                
                                if playerCount == 5 || playerCount == 6 {
                                    if theme.theme == 3 {
                                        plusColor = .white
                                    } else {
                                    plusColor = .gray
                                    }
                                }
                                
                                if playerCount <= 5 {
                                    minusColor = .blue
                                    playerCount += 1
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(plusColor)
                            }
                            
                            
                            Toggle("Show Totals", isOn: $showTotals)
                                .padding()
                            
                            
                        }
                        .padding()
                        HStack {
                            VStack {
                                //Names
                                Text(" ")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                ForEach(0...playerCount-1, id:\.self) { index in
                                    Text("\(initials[index]):")
                                        .font(.system(size: 45, weight: .semibold, design: .default))
                                }
                            }
                            VStack {
                                //A Scores
                                Text("A")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                ForEach(0...playerCount-1, id:\.self) { index in
                                    Text("\(ATotals[index])")
                                        .font(.system(size: 45, weight: .semibold, design: .default))
                                }
                            }
                            VStack {
                                //C Scores
                                Text("C")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                ForEach(0...playerCount-1, id:\.self) { index in
                                    Text("\(CTotals[index])")
                                        .font(.system(size: 45, weight: .semibold, design: .default))
                                }
                            }
                            VStack {
                                //D Scores
                                Text("D")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                ForEach(0...playerCount-1, id:\.self) { index in
                                    Text("\(DTotals[index])")
                                        .font(.system(size: 45, weight: .semibold, design: .default))
                                }
                            }
                            VStack {
                                //S Scores
                                Text("S")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                ForEach(0...playerCount-1, id:\.self) { index in
                                    Text("\(STotals[index])")
                                        .font(.system(size: 45, weight: .semibold, design: .default))
                                }
                            }
                            VStack {
                                //T Scores
                                if showTotals {
                                    Text("T")
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                    ForEach(0...playerCount-1, id:\.self) { index in
                                        Text("\(TTotals[index])")
                                            .font(.system(size: 45, weight: .semibold, design: .default))
                                    }
                                }
                            }
                        }
                        .padding(15)
                        .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        
                        Spacer()
                        
                            Button {
                                switchViews = true
                            } label: {
                                WideButton(text: "Previous Matches", textColor: .white,     backgroundColor: .blue)
                            } .padding()
                        
                    } 
                }
                .navigationTitle("All Scores")
            }
            
            if switchViews {
                MatchesView()
            }
            
        } .onAppear(perform: {
            if ATotalsFile.isEmpty {
                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
            } else {
                ATotals = [ATotalsFile[0].player1T, ATotalsFile[0].player2T, ATotalsFile[0].player3T, ATotalsFile[0].player4T, ATotalsFile[0].player5T, ATotalsFile[0].player6T]
            }
            if CTotalsFile.isEmpty {
                TheCapitalism.saveToFile([TheCapitalism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
            } else {
                CTotals = [CTotalsFile[0].player1T, CTotalsFile[0].player2T, CTotalsFile[0].player3T, CTotalsFile[0].player4T, CTotalsFile[0].player5T, CTotalsFile[0].player6T]
            }
            if DTotalsFile.isEmpty {
                TheDemocratic.saveToFile([TheDemocratic(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
            } else {
                DTotals = [DTotalsFile[0].player1T, DTotalsFile[0].player2T, DTotalsFile[0].player3T, DTotalsFile[0].player4T, DTotalsFile[0].player5T, DTotalsFile[0].player6T]
            }
            if STotalsFile.isEmpty {
                TheSocialism.saveToFile([TheSocialism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
            } else {
                STotals = [STotalsFile[0].player1T, STotalsFile[0].player2T, STotalsFile[0].player3T, STotalsFile[0].player4T, STotalsFile[0].player5T, STotalsFile[0].player6T]
            }
            if TTotalsFile.isEmpty {
                TheTotals.saveToFile([TheTotals(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
            } else {
                TTotals = [TTotalsFile[0].player1T, TTotalsFile[0].player2T, TTotalsFile[0].player3T, TTotalsFile[0].player4T, TTotalsFile[0].player5T, TTotalsFile[0].player6T]
            }
            if playerCountFile.isEmpty {
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
            } else {
                playerCount = playerCountFile[0].number
            }
            if namesFile.isEmpty {
                Names.saveToFile([Names(p1Name: "Player 1", p2Name: "Player 2", p3Name: "Player 3", p4Name: "Player 4", p5Name: "Player 5", p6Name: "Player 6")])
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                names = [namesFile[0].p1Name, namesFile[0].p2Name, namesFile[0].p3Name, namesFile[0].p4Name, namesFile[0].p5Name, namesFile[0].p6Name]
                
                let p1NameArray = namesFile[0].p1Name.components(separatedBy:" ")
                var p1Initals = ""

                for string in p1NameArray {
                    p1Initals += String(string.first!)
                }
                
                let p2NameArray = namesFile[0].p2Name.components(separatedBy:" ")
                var p2Initals = ""

                for string in p2NameArray {
                    p2Initals += String(string.first!)
                }
                
                let p3NameArray = namesFile[0].p3Name.components(separatedBy:" ")
                var p3Initals = ""

                for string in p3NameArray {
                    p3Initals += String(string.first!)
                }
                
                let p4NameArray = namesFile[0].p4Name.components(separatedBy:" ")
                var p4Initals = ""

                for string in p4NameArray {
                    p4Initals += String(string.first!)
                }
                
                let p5NameArray = namesFile[0].p5Name.components(separatedBy:" ")
                var p5Initals = ""

                for string in p5NameArray {
                    p5Initals += String(string.first!)
                }
                
                let p6NameArray = namesFile[0].p6Name.components(separatedBy:" ")
                var p6Initals = ""

                for string in p6NameArray {
                    p6Initals += String(string.first!)
                }
                
                initials = ["\(p1Initals.uppercased())", "\(p2Initals.uppercased())", "\(p3Initals.uppercased())", "\(p4Initals.uppercased())", "\(p5Initals.uppercased())", "\(p6Initals.uppercased())"]
                }
            }
        })
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
