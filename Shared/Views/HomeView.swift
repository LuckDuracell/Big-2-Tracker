//
//  HomeView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var latestWinnerFile = LatestWinner.loadFromFile()
    @State private var latestWinner = ""
    @State private var totalsFile = TheTotals.loadFromFile()
    @State private var totals: [player] = [player(name: "Player 1", score: 0), player(name: "Player 2", score: 0), player(name: "Player 3", score: 0), player(name: "Player 4", score: 0), player(name: "Player 5", score: 0), player(name: "Player 6", score: 0)]
    @State var orderedTotals: [player] = []
    @State private var playerCountFile = DefaultPlayerCount.loadFromFile()
    @State private var playerCount = 4
    @State var namesFile = Names.loadFromFile()
    @State var names = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"]
    @State private var showRanks = false
    
    @EnvironmentObject var theme: colorThemeSetting
    
    var body: some View {
        ZStack {
            NavigationView() {
                ZStack {
                    
                    if theme.theme == 3 {
                        BackgroundOld(color1: "bgPink", color2: "bgBlue")
                    }
                    
                    ScrollView() {
                        VStack {
                                VStack {
                                    if latestWinnerFile.isEmpty && orderedTotals.isEmpty {
                                        Text("Play and log a match to get started!")
                                    } else  if latestWinnerFile.isEmpty == false && orderedTotals.isEmpty == false {
                                        Spacer()
                                        Text("Latest Winner:")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                        Text(latestWinnerFile[0].name)
                                            .font(.system(size: 40, weight: .semibold, design: .default))
                                            .padding(.bottom, 35)
                                        
                                        
                                        if showRanks {
                                            Text("Ranking:")
                                                .font(.system(size: 20, weight: .medium, design: .default))
                                        ForEach(0...playerCount-1, id: \.self) { index in
                                            Text("\(orderedTotals[index].name): \(orderedTotals[index].score)")
                                                .font(.system(size: 35, weight: .semibold, design: .default))
                                                .padding(5)
                                        }
                                        }
                                        Spacer()
                                    } else {
                                        Spacer()
                                        if showRanks {
                                            Text("Ranking:")
                                                .font(.system(size: 20, weight: .medium, design: .default))
                                        ForEach(0...playerCount-1, id: \.self) { index in
                                            Text("\(orderedTotals[index].name): \(orderedTotals[index].score)")
                                                .font(.system(size: 35, weight: .semibold, design: .default))
                                                .padding(5)
                                        }
                                        }
                                        Spacer()
                                    }
                                } .padding()
                                .padding(.leading, 40)
                                .padding(.trailing, 40)
                                .background(Color.gray.opacity(0))
                                .cornerRadius(20)
                        } .padding(20)
                    }
                } .navigationTitle("Big 2 Tracker")
            }
        }
        .onAppear(perform: {
            if latestWinnerFile.isEmpty == false {
                latestWinner = latestWinnerFile[0].name
            }
            
            if playerCountFile.isEmpty == false {
                playerCount = playerCountFile[0].number
            } else {
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
            }
            
            if namesFile.isEmpty == false {
                names = [namesFile[0].p1Name, namesFile[0].p2Name, namesFile[0].p3Name, namesFile[0].p4Name, namesFile[0].p5Name, namesFile[0].p6Name]
            }
            
            if totalsFile.isEmpty == false {
                totals = [player(name: names[0], score: totalsFile[0].player1T), player(name: names[1], score: totalsFile[0].player2T), player(name: names[2], score: totalsFile[0].player3T), player(name: names[3], score: totalsFile[0].player4T), player(name: names[4], score: totalsFile[0].player5T), player(name: names[5], score: totalsFile[0].player6T)]
                var totals2: [player] = []
                for index in 0...playerCount-1 {
                    totals2.append(totals[index])
                }
                orderedTotals = totals2.sorted { $0.score > $1.score }
                print(orderedTotals)
                showRanks = true
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct player {
    var name: String
    var score: Int
}
