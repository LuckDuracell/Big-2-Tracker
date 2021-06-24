//
//  WinnerView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 6/14/21.
//

import SwiftUI

struct WinnerView: View {
    
    @Binding var winner: String
    @Binding var winnerScore: Float
    @Binding var roundScores: [[Int]]
    @Binding var theType: String
    @Binding var playerCount: Int
    @Binding var names: [String]
    @State var matchData: [MatchInfo] = MatchInfo.loadFromFile()
    
    @State var lockUpdate = false
    
    @State var switchViews = false
    
    @State var theTotals = TheTotals.loadFromFile()
    @State var theAuthoritarianism = TheAuthoritarianism.loadFromFile()
    @State var theCapitalism = TheCapitalism.loadFromFile()
    @State var theDemocratic = TheDemocratic.loadFromFile()
    @State var theSocialism = TheSocialism.loadFromFile()
    
    @EnvironmentObject var reset: ResetApp
    //App Refresher ^
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
                            
                            
                            if winnerScore == 0 {
                                Image(systemName: "crown.fill")
                                    .resizable()
                                    .frame(width: 50, height: 40, alignment: .center)
                                    .padding(25)
                            }
                            
                            Text("\(winner) won with \(Int(winnerScore))!")
                                .padding()
                                .foregroundColor(theme.theme == 3 ? Color.white : Color.primary)
                                .font(.system(size: 35, weight: .medium))
                            
                            Button {
                                if lockUpdate == false {
                                
                                lockUpdate = true
                                  
                                    //Update latest winner
                                    
                                    LatestWinner.saveToFile([LatestWinner(name: winner)])
                                    
                                    //Add to totals
                                    
                                    
                                    if theTotals.isEmpty {
                                        theTotals.append(TheTotals(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0))
                                    }
                                    if theAuthoritarianism.isEmpty {
                                        theAuthoritarianism.append(TheAuthoritarianism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0))
                                    }
                                    if theCapitalism.isEmpty {
                                        theCapitalism.append(TheCapitalism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0))
                                    }
                                    if theDemocratic.isEmpty {
                                        theDemocratic.append(TheDemocratic(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0))
                                    }
                                    if theSocialism.isEmpty {
                                        theSocialism.append(TheSocialism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0))
                                    }
                                    
                                    
                                    switch winner {
                                        case names[0]:
                                            theTotals[0].player1T += 1
                                            TheTotals.saveToFile(theTotals)
                                        case names[1]:
                                            theTotals[0].player2T += 1
                                            TheTotals.saveToFile(theTotals)
                                        case names[2]:
                                            theTotals[0].player3T += 1
                                            TheTotals.saveToFile(theTotals)
                                        case names[3]:
                                            theTotals[0].player4T += 1
                                            TheTotals.saveToFile(theTotals)
                                        case names[4]:
                                            theTotals[0].player5T += 1
                                            TheTotals.saveToFile(theTotals)
                                        default:
                                            theTotals[0].player6T += 1
                                            TheTotals.saveToFile(theTotals)
                                    }
                                    
                                    //Add to player total of certain types
                                    switch theType {
                                        case "Authoritarianism":
                                            switch winner {
                                                case names[0]:
                                                    theAuthoritarianism[0].player1T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                                case names[1]:
                                                    theAuthoritarianism[0].player2T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                                case names[2]:
                                                    theAuthoritarianism[0].player3T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                                case names[3]:
                                                    theAuthoritarianism[0].player4T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                                case names[4]:
                                                    theAuthoritarianism[0].player5T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                                default:
                                                    theAuthoritarianism[0].player6T += 1
                                                    TheAuthoritarianism.saveToFile(theAuthoritarianism)
                                            }
                                        case "Capitalism":
                                            switch winner {
                                                case names[0]:
                                                    theCapitalism[0].player1T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                                case names[1]:
                                                    theCapitalism[0].player2T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                                case names[2]:
                                                    theCapitalism[0].player3T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                                case names[3]:
                                                    theCapitalism[0].player4T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                                case names[4]:
                                                    theCapitalism[0].player5T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                                default:
                                                    theCapitalism[0].player6T += 1
                                                    TheCapitalism.saveToFile(theCapitalism)
                                            }
                                        case "Democratic Socialism":
                                            switch winner {
                                                case names[0]:
                                                    theDemocratic[0].player1T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                                case names[1]:
                                                    theDemocratic[0].player2T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                                case names[2]:
                                                    theDemocratic[0].player3T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                                case names[3]:
                                                    theDemocratic[0].player4T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                                case names[4]:
                                                    theDemocratic[0].player5T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                                default:
                                                    theDemocratic[0].player6T += 1
                                                    TheDemocratic.saveToFile(theDemocratic)
                                            }
                                        default:
                                            switch winner {
                                                case names[0]:
                                                    theSocialism[0].player1T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                                case names[1]:
                                                    theSocialism[0].player2T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                                case names[2]:
                                                    theSocialism[0].player3T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                                case names[3]:
                                                    theSocialism[0].player4T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                                case names[4]:
                                                    theSocialism[0].player5T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                                default:
                                                    theSocialism[0].player6T += 1
                                                    TheSocialism.saveToFile(theSocialism)
                                            }
                                    }
                                    
                                    
                                    
                                    
                                var matchDataList = matchData
                                
                                let now = Date()
                                let year = Calendar.current.component(.year, from: Date())

                                let formatter = DateFormatter()
                                formatter.dateStyle = .short
                                formatter.timeStyle = .none

                                let datetime = formatter.string(from: now)
                                let dateUpdate1 = datetime.dropLast()
                                let datetimeWithoutYear = dateUpdate1.dropLast()
                                
                                    matchDataList.insert(MatchInfo(theType: theType, theWinner: winner, theTime: "\(datetimeWithoutYear)" + "\(year)", id: UUID(), playercount: playerCount, player1Scores: roundScores[0], player2Scores: roundScores[1], player3Scores: roundScores[2], player4Scores: roundScores[3], player5Scores: roundScores[4], player6Scores: roundScores[5], theNames: names), at: 0)
                                    
                                    MatchInfo.saveToFile(matchDataList)
                                }
                                
                                
                                reset.animate = true
                                
                                
                            } label: {
                                WideButton(text: "Log Game", textColor: theme.theme == 3 ? Color.white : Color.primary, backgroundColor: theme.theme == 3 ? Color.white.opacity(0.2): Color.gray.opacity(0.2))
                            }
                            
                            Button {
                                switchViews = true
                            } label: {
                                WideButton(text: "Close", textColor: theme.theme == 3 ? Color.white : Color.primary, backgroundColor: theme.theme == 3 ? Color.white.opacity(0.2): Color.gray.opacity(0.2))
                            }
                        }
                    }
                } .navigationTitle("Game Complete!")
                
            }
            
            if switchViews {
                GameplayView()
            }
            
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
