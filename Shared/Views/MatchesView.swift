//
//  MatchesView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

struct MatchesView: View {
    
    @State var switchViews = false
    @State var matchData = MatchInfo.loadFromFile()
    @State var playerCount = 3
    @State var roundScores: [[Int]] = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    @State var showSheet = false
    @State var playerCountLoop: [String] = [" ", " ", " "]
    @State var names: [String] = []
    @State var showView = false
    
    @EnvironmentObject var theme: colorThemeSetting
    
    var body: some View {
        ZStack {
            NavigationView() {
                ZStack {
                    
                    if theme.theme == 3 {
                    BackgroundOld(color1: "bgPink", color2: "bgBlue")
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                    VStack {
                        List {
                            if matchData.count > 0 {
                                ForEach(0...matchData.count - 1, id: \.self) { index in
                                    
                                    HStack {
                                        VStack {
                                            HStack {
                                            Text(matchData[index].theType)
                                                .font(.system(size: 20, weight: .semibold, design: .default))
                                                .multilineTextAlignment(.leading)
                                                .padding(.leading, 5)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Text("Winner: " + matchData[index].theWinner)
                                                    .font(.system(size: 15, weight: .medium, design: .default))
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading, 20)
                                                Spacer()
                                            }
                                        } .padding(5)
                                        Spacer()
                                        Text(matchData[index].theTime)
                                            .padding(.trailing, 10)
                                            .font(.system(size: 15, weight: .medium, design: .default))
                                    } .onTapGesture(perform: {
                                        roundScores = [matchData[index].player1Scores, matchData[index].player2Scores, matchData[index].player3Scores, matchData[index].player4Scores, matchData[index].player5Scores, matchData[index].player6Scores]
                                        print(roundScores)
                                        playerCount = matchData[index].playercount
                                        print("\(playerCount)")
                                        playerCountLoop.removeAll()
                                        names.removeAll()
                                        for item in 0...playerCount-1 {
                                            playerCountLoop.append(" ")
                                            names.append(matchData[index].theNames[item])
                                        }
                                        showSheet.toggle()
                                    })
                                        .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.primary.opacity(0.2))
                                }
                                .onDelete { (indexSet) in
                                    self.matchData.remove(atOffsets: indexSet)
                                    MatchInfo.saveToFile(matchData)
                                }
                            }
                        }
                        .onAppear(perform: {
                            if theme.theme != 3 {
                            UITableView.appearance().backgroundColor = .systemBackground
                            } else {
                                UITableView.appearance().backgroundColor = .clear
                            }
                        })
                        //.background(theme.theme == 3 ? BackgroundOld(color1: "bgPink", color2: "bgBlue") : BackgroundOld(color1: "systemBackground", color2: "systemBackground"))
                        
                        Button {
                            switchViews = true
                        } label: {
                            WideButton(text: "Back", textColor: .white, backgroundColor: .blue)
                        } .padding()
                    }
                    .sheet(isPresented: $showSheet, onDismiss: nil, content: {
                        HStack {
                            if showView {
                                VStack {
                                    ForEach(names, id: \.self) { name in
                                        Text(name)
                                            .padding(5)
                                            .font(.system(size: 25, weight: .bold, design: .default))
                                            .foregroundColor(theme.theme == 3 ? .black : .primary)
                                    }
                                }
                                .padding(5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    VStack {
                                        HStack {
                                            ForEach(roundScores[0].indices, id: \.self) { index in
                                                VStack {
                                                    ForEach(playerCountLoop.indices, id: \.self) { index2 in
                                                        let output = roundScores[index2]
                                                        Text("\(output[index])")
                                                            .padding(5)
                                                            .font(.system(size: 25, weight: .medium, design: .default))
                                                            .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                    }
                                                }
                                                .padding(5)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(8)
                                            }
                                    
                                            VStack {
                                                ForEach(playerCountLoop.indices, id: \.self) { index in
                                                    Text("\(roundScores[index].reduce(0,+))")
                                                        .padding(5)
                                                        .font(.system(size: 25, weight: .bold, design: .default))
                                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                }
                                            }
                                            .padding(5)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        } .padding()
                            .onAppear(perform: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    roundScores = roundScores
                                    print("ROUND SCORES: \(roundScores)")
                                    showView = true
                                }
                            })
                    })
                    .background(theme.theme == 3 ? BackgroundOld(color1: "bgPink", color2: "bgBlue") : BackgroundOld(color1: "systemBackground", color2: "systemBackground"))
                } .navigationTitle("Previous Matches")
                
            }
            
            if switchViews {
                ScoresView()
            }
            
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
