//
//  GameplayView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI
import Introspect

struct GameplayView: View {
    
    //Pregame Selections
    @State var types = ["Authoritarianism", "Capitalism", "Democratic Socialism", "Socialism"]
    @State var typesReduced = ["Capitalism", "Democratic Socialism"]
    @State var picked = "Authoritarianism"
    @State var playerCount = 4
    @State private var minusColor = Color.blue
    @State private var plusColor = Color.blue
    @State var thePadding = 15
    
    @State var defaultPlayerCount = DefaultPlayerCount.loadFromFile()
    
    @State var defaultNamesFile = Names.loadFromFile()
    @State var defaultNames = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"]
    
    
    @State var names = ["", "", "", "", "", ""]
    //-------
    
    //Player Names
    @State var initials = ["", "", "", "", "", ""]
    //------
    
    
    
    //Show the scores instead of directions for each
    @State var showScores1 = false
    @State var showScores2 = false
    @State var showScores3 = false
    @State var showScores4 = false
    @State var showScores5 = false
    @State var showScores6 = false
    
    //Game Data
    @State var p1Input = ""
    @State var p2Input = ""
    @State var p3Input = ""
    @State var p4Input = ""
    @State var p5Input = ""
    @State var p6Input = ""
    @State var showPicker = true
    @State var direction1 = ""
    @State var direction2 = ""
    @State var direction3 = ""
    @State var direction4 = ""
    @State var direction5 = ""
    @State var direction6 = ""
    @State var p1Total = 0
    @State var p2Total = 0
    @State var p3Total = 0
    @State var p4Total = 0
    @State var p5Total = 0
    @State var p6Total = 0
    @State var p1Scores: [Int] = []
    @State var p2Scores: [Int] = []
    @State var p3Scores: [Int] = []
    @State var p4Scores: [Int] = []
    @State var p5Scores: [Int] = []
    @State var p6Scores: [Int] = []
    //-------
    
    //Tie Data
    @State var showSheet = false
    @State var sheetForLoser = true
    @State var sheetForSecond = false
    @State var sheetForSecondLast = false
    @State var tiedPlayers: [Player] = []
    @State var tiedPlayersForSecond: [Player] = []
    @State var tiedPlayersForSecondLast: [Player] = []
    @State var winningPlayers: [Player] = []
    @State var selected: [Bool] = [false, false, false, false, false, false]
    @State var selected2: [Bool] = [false, false, false, false, false, false]
    @State var selected3: [Bool] = [false, false, false, false, false, false]
    
    
    @State var allPlayerWithMaxScore: [Player] = []
    @State var allPlayerWithMinScore: [Player] = []
    @State var allPlayersForSecond: [Player] = []
    @State var allPlayersForSecondLast: [Player] = []
    
    @State var firstPlace: Player = Player(name: "nil", score: 0)
    @State var secondPlace: Player = Player(name: "nil", score: 0)
    @State var secondLastPlace: Player = Player(name: "nil", score: 0)
    @State var lastPlace: Player = Player(name: "nil", score: 0)
    
    @State var secondPlaceSort: [Player] = []
    
    @State var showAlert = false
    @State var alertText = "Sorry, this game type requires 4 or more players!"
    
    @State var endScoreFile = TheEndScore.loadFromFile()
    @State var endScore = ""
    @State var endScoreInt = 35
    
    @State var gameWinner = "Player 1"
    @State var switchScreens = false
    
    @State var gameEndingSheet = false
    @State var roundScores: [[Int]] = []
    @State var gameEndingSheetPlayers: [Player] = []
    @State var gameOverWinningScore: Float = 900
    //----------
    
    @EnvironmentObject var theme: colorThemeSetting
    
    var body: some View {
        ZStack {
            
            if theme.theme == 3 {
            BackgroundOld(color1: "bgPink", color2: "bgBlue")
                .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                    ZStack {
                    Text("Gameplay")
                        .multilineTextAlignment(.leading)
                        .padding(.top, 36)
                        .padding(8)
                        .frame(width: UIScreen.main.bounds.width * 0.95, alignment: .leading)
                        .font(.system(size: 35, weight: .bold, design: .default))
                    
                    if showPicker {
                        HStack {
                            Text("Players: \(playerCount)")
                                .padding(10)
                                .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.black.opacity(0.1))
                                .cornerRadius(10)


                            Button() {
                                
                                
                                if playerCount == 4 || playerCount == 3{
                                    minusColor = .gray
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
                                    plusColor = .gray
                                }
                                
                                if playerCount <= 5 {
                                    minusColor = .blue
                                    playerCount += 1
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(plusColor)
                            }
                        }
                        .padding(.top, 43)
                        .padding(.leading, 190)
                    }
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            if showPicker {
                                    //Pick Type
                                ZStack {
                                    
                                    
                                    if theme.theme == 3 {
                                        Color.white.opacity(0.05)
                                            .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
                                            .blur(radius: 10)
                                    }
                                    
                                    Picker("Picker", selection: $picked, content: {
                                        ForEach(types, id: \.self) {
                                            Text($0)
                                                .foregroundColor(theme.theme == 3 ? .white : .primary)
                                        }
                                    })
                                    .padding(-15)
                                    .padding(.top, -25)
                                }
                                //Names

                                ForEach(names.indices, id: \.self) { index in
                                    if index < playerCount {
                                        TextField(names[index], text: $names[index])
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                        }
                                }
                                
                                HStack {
                                   Text("Game Ending Score: ")
                                        .padding()
                                    
                                    TextField("\(endScore)", text: $endScore)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: UIScreen.main.bounds.width * 0.25)
                                        .padding()
                                        .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .padding(5)
                                        .introspectTextField { (textField) in
                                                   let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                   let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                   let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                   doneButton.tintColor = .systemBlue
                                                   toolBar.items = [flexButton, doneButton]
                                                   toolBar.setItems([flexButton, doneButton], animated: true)
                                                   textField.inputAccessoryView = toolBar
                                                }
                                }
                                //Start Button
                                Button {
                                    
                                    if playerCount < 4 && (picked == "Authoritarianism" || picked == "Socialism") {
                                        showAlert = true
                                        alertText = "Sorry, this game type requires 4 or more players!"
                                    } else {
                                    
                                    thePadding = 15
                                    
                                    for index in 0...names.count - 1 {
                                        if names[index] != "" && names[index] != "Player \(index + 1)" {
                                            let num = names[index].count
                                            print("wow + \(num)")
                                            var name = names[index]
                                            initials[index] = "\(name.removeFirst())".uppercased()
                                        } else {
                                            names[index] = "Player \(index + 1)"
                                            initials[index] = "P\(index + 1)"
                                        }
                                    }
                                    
                                    showPicker.toggle()
                                    }
                                } label: {
                                WideButton(text: "Start Game", textColor: .white, backgroundColor: .blue)
                                } .padding()
                                    .alert("\(alertText)", isPresented: $showAlert) {
                                        Button("Dismiss", role: .cancel) { }
                                        }
                                
                            } else {
                                VStack {
                                    Button {
                                        if p1Scores.count == 0 {
                                            showPicker = true
                                        }
                                    } label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.blue)
                                        .padding(10)
                                        .frame(width: UIScreen.main.bounds.width * 0.95, alignment: .leading)
                                        .opacity(p1Scores.count == 0 ? 1 : 0)
                                    }
                                
                                    if playerCount > 0 {
                                        HStack {
                                        TextField(initials[0], text: $p1Input)
                                            .keyboardType(.numberPad)
                                            .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .multilineTextAlignment(.center)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p1Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores1.toggle()
                                                }
                                            
                                            
                                            Text(showScores1 ? String("\(p1Scores)".dropFirst().dropLast()) : direction1)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores1.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                
                                    if playerCount > 1 {
                                        HStack {
                                            
                                        TextField(initials[1], text: $p2Input)
                                            .keyboardType(.numberPad)
                                           .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .multilineTextAlignment(.center)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p2Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores2.toggle()
                                                }
                                            
                                            Text(showScores2 ? String("\(p2Scores)".dropFirst().dropLast()) : direction2)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores2.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                    
                                    if playerCount > 2 {
                                        HStack {
                                            
                                        TextField(initials[2], text: $p3Input)
                                            .keyboardType(.numberPad)
                                           .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .multilineTextAlignment(.center)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p3Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores3.toggle()
                                                }
                                            
                                            Text(showScores3 ? String("\(p3Scores)".dropFirst().dropLast()) : direction3)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores3.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                    
                                    if playerCount > 3 {
                                        HStack {
                                            
                                        TextField(initials[3], text: $p4Input)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.center)
                                           .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p4Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores4.toggle()
                                                }
                                            
                                            Text(showScores4 ? String("\(p4Scores)".dropFirst().dropLast()) : direction4)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores4.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                    
                                    if playerCount > 4 {
                                        HStack {
                                        TextField(initials[4], text: $p5Input)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.center)
                                           .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p5Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores5.toggle()
                                                }
                                            
                                            Text(showScores5 ? String("\(p5Scores)".dropFirst().dropLast()) : direction5)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores5.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                    
                                    if playerCount > 5 {
                                        HStack {
                                        TextField(initials[5], text: $p6Input)
                                            .keyboardType(.numberPad)
                                            .multilineTextAlignment(.center)
                                           .frame(width: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), height: UIScreen.main.bounds.width * (0.15 - (CGFloat(playerCount) * 0.005)), alignment: .center)
                                            .padding()
                                            .background(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(5)
                                            .introspectTextField { (textField) in
                                                       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                                       let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                                       let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                                       doneButton.tintColor = .systemBlue
                                                       toolBar.items = [flexButton, doneButton]
                                                       toolBar.setItems([flexButton, doneButton], animated: true)
                                                       textField.inputAccessoryView = toolBar
                                                    }
                                            
                                            Text("\(p6Total)")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.1 * UIScreen.main.bounds.width)
                                                .onTapGesture {
                                                    showScores6.toggle()
                                                }
                                            
                                            Text(showScores6 ? String("\(p6Scores)".dropFirst().dropLast()) : direction6)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 17, weight: .medium, design: .default))
                                                .frame(width: 0.45 * UIScreen.main.bounds.width)
                                                .padding()
                                                .onTapGesture {
                                                    showScores6.toggle()
                                                }
                                            
                                        } .padding(5)
                                    }
                                
                                Button {
                                    
                                    //Checks to make sure there was just 1 player who got 0, but also that there was someone who got zero.
                                    let allNewScores = [p1Input,p2Input,p3Input,p4Input,p5Input,p6Input]
                                    var winnerCount = 0
                                    for index in 0...playerCount-1 {
                                        if allNewScores[index] == "0" || allNewScores[index] == "" || allNewScores[index] == " " {
                                            winnerCount += 1
                                        }
                                    }
                                    
                                    if winnerCount == 1 {
                                    //Update the list of their round scores to include the newly typed ones
                                    p1Scores.append(Int(p1Input) ?? 0)
                                    p2Scores.append(Int(p2Input) ?? 0)
                                    p3Scores.append(Int(p3Input) ?? 0)
                                    p4Scores.append(Int(p4Input) ?? 0)
                                    p5Scores.append(Int(p5Input) ?? 0)
                                    p6Scores.append(Int(p6Input) ?? 0)
                                    
                                    //Combine the numbers in their list of round scores to get their total score so far
                                    p1Total = p1Scores.reduce(0,+)
                                    p2Total = p2Scores.reduce(0,+)
                                    p3Total = p3Scores.reduce(0,+)
                                    p4Total = p4Scores.reduce(0,+)
                                    p5Total = p5Scores.reduce(0,+)
                                    p6Total = p6Scores.reduce(0,+)
                                    
                                    //Find the round winner
                                    
                                    
                                    if p1Total >= Int(endScore) ?? 35 || p2Total >= Int(endScore) ?? 35 || p3Total >= Int(endScore) ?? 35 || p4Total >= Int(endScore) ?? 35 || p5Total >= Int(endScore) ?? 35 || p6Total >= Int(endScore) ?? 35  {
                                        
                                        //Game End Situation
                                        roundScores = [p1Scores, p2Scores, p3Scores, p4Scores, p5Scores, p6Scores]
                                        
                                        var players: [Player] = []
                                        let playerScores = [p1Total,p2Total,p3Total,p4Total,p5Total,p6Total]
                                        
                                        let roundPlayers: [Player] = [Player(name: names[0], score: p1Scores.last!),Player(name: names[1], score: p2Scores.last!),Player(name: names[2], score: p3Scores.last!),Player(name: names[3], score: p4Scores.last!),Player(name: names[4], score: p5Scores.last!),Player(name: names[5], score: p6Scores.last!)]
                                        let roundWinners = roundPlayers.filter { $0.score == 0 }
                                        
                                        for index in 0...playerCount-1 {
                                            players.append(Player(name: names[index], score: playerScores[index]))
                                        }
                                        
                                        let winningScore = players.lazy.map { $0.score }.min()
                                        gameOverWinningScore = Float(winningScore ?? 0)
                                        let winningPlayers = players.filter { $0.score == winningScore }
                                        
                                        if winningPlayers.count >= 2 {
                                            var winningIndex = -1
                                            var foundOne = false
                                            for index in 0...winningPlayers.count-1	 {
                                                if winningPlayers[index].name == roundWinners[0].name {
                                                    winningIndex = index
                                                    foundOne = true
                                                    
                                                }
                                            }
                                            if foundOne {
                                            gameWinner = winningPlayers[winningIndex].name
                                            switchScreens = true
                                            } else {
                                                //Make sheet that asks whos highest card was lowest
                                                gameEndingSheetPlayers = winningPlayers
                                                gameEndingSheet = true
                                                
                                                showSheet = true
                                            }
                                            
                                        } else {
                                         
                                            //Game end with single name at winningPlayers[0]
                                            gameWinner = winningPlayers[0].name
                                            switchScreens = true
                                            
                                        }
                                        
                                    } else {
                                    
                                    //Reset the tied players stuff
                                    tiedPlayers.removeAll()
                                    tiedPlayersForSecond.removeAll()
                                    tiedPlayersForSecondLast.removeAll()
                                    showSheet = false
                                    sheetForLoser = true
                                    sheetForSecond = false
                                    sheetForSecondLast = false
                                    winningPlayers.removeAll()
                                    selected = [false, false, false, false, false, false]
                                    selected2 = [false, false, false, false, false, false]
                                    selected3 = [false, false, false, false, false, false]
                                    
                                    allPlayerWithMaxScore.removeAll()
                                    allPlayerWithMinScore.removeAll()
                                    allPlayersForSecond.removeAll()
                                    allPlayersForSecondLast.removeAll()
                                    
                                    firstPlace = Player(name: "nil", score: 0)
                                    secondPlace = Player(name: "nil", score: 0)
                                    secondLastPlace = Player(name: "nil", score: 0)
                                    lastPlace = Player(name: "nil", score: 0)
                                    
                                    secondPlaceSort.removeAll()
                                    
                                    direction1 = ""
                                    direction2 = ""
                                    direction3 = ""
                                    direction4 = ""
                                    direction5 = ""
                                    direction6 = ""
                                        
                                    switch picked {
                                        case "Authoritarianism":
                                            
                                            var players: [Player] = [Player(name: names[0], score: p1Scores.last!)]
                                            let roundScores = [p1Scores.last, p2Scores.last, p3Scores.last, p4Scores.last, p5Scores.last, p6Scores.last]
                                            
                                            //Make list of Player Structs that Include a Name and The Latest Inputted Scores
                                            for x in 2...playerCount {
                                                players.append(Player(name: names[x - 1], score: roundScores[x - 1]!))
                                            }
                                            
                                            //Get the Highest of these New Scores - Output Example: 8
                                            let maxScore = players.lazy.map{ $0.score }.max()
                                            let minScore = players.lazy.map{ $0.score }.min()
                                            
                                            print("ya yeet: \(maxScore!)")
                                            
                                            //Makes a list of players excluding any winners or players who aren't playing
                                            var playersWithoutZero: [Player] = []
                                            for index in 0...players.count - 1 {
                                                
                                               // print(index)
                                                
                                                if players[index].score != 0 {
                                                    playersWithoutZero.append(players[index])
                                                }
                                            }
                                            
                                            let secondPlaceScore  = playersWithoutZero.lazy.map{ $0.score }.min()
                                            
                                            var playersWithoutMax: [Player] = []
                                            let numToIgnore = maxScore!
                                            for index2 in 0...players.count - 1 {
                                                
                                                print(index2)
                                                
                                                if players[index2].score == numToIgnore {
                                                } else {
                                                    print("haha true")
                                                    playersWithoutMax.append(players[index2])
                                                }
                                            }
                                            
                                            print("-\(playersWithoutMax)-")
                                            print("\(playersWithoutZero) !!!")
                                            
                                            
                                            let secondLastPlaceScore  = playersWithoutMax.lazy.map{ $0.score }.max()
                                            
                                            //Makes a list of the players who had the highest card
                                             allPlayerWithMaxScore = players.filter { $0.score == maxScore }
                                             allPlayerWithMinScore = players.filter { $0.score == minScore }
                                             allPlayersForSecond = players.filter { $0.score == secondPlaceScore }
                                             allPlayersForSecondLast = players.filter { $0.score == secondLastPlaceScore }
                                            
                                            print("\(allPlayersForSecondLast) + \(allPlayersForSecond) !!")
                                            
                                            sheetForLoser = false
                                            sheetForSecond = false
                                            sheetForSecondLast = false
                                            
                                            //Check if there was a tie for loser, if not just goes ahead with directions
                                            if allPlayerWithMaxScore.count > 1 {
                                                sheetForLoser = true
                                                showSheet = true
                                                tiedPlayers = allPlayerWithMaxScore
                                                
                                                secondPlace = allPlayersForSecond[0]
                                                secondLastPlace = allPlayersForSecondLast[0]
                                                
                                                winningPlayers = allPlayerWithMinScore
                                            }
                                            if allPlayersForSecond.count > 1 {
                                                sheetForSecond = true
                                                showSheet = true
                                                tiedPlayersForSecond = allPlayersForSecond
                                                
                                                
                                                
                                                winningPlayers = allPlayerWithMinScore
                                            }
                                            if allPlayersForSecondLast.count > 1 {
                                                sheetForSecondLast = true
                                                showSheet = true
                                                tiedPlayersForSecondLast = allPlayersForSecondLast
                                                winningPlayers = allPlayerWithMinScore
                                            }
                                            if allPlayerWithMaxScore.count == 1 && allPlayersForSecond.count == 1 && allPlayersForSecondLast.count == 1 {
                                                
                                                //Set the direction for first place
                                                if p1Scores.last == 0 {
                                                    direction1 = "\(names[0]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p2Scores.last == 0 {
                                                    direction2 = "\(names[1]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p3Scores.last == 0 {
                                                    direction3 = "\(names[2]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p4Scores.last == 0 {
                                                    direction4 = "\(names[3]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p5Scores.last == 0 {
                                                    direction5 = "\(names[4]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p6Scores.last == 0 {
                                                    direction6 = "\(names[5]) gives any 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                }
                                                
                                                //Set the direction for last place
                                                switch allPlayerWithMaxScore[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives their best 2 cards to \(allPlayerWithMinScore[0].name)"
                                                }
                                                
                                                //Set the direction for second place
                                                switch allPlayersForSecondLast[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives their best card to \(allPlayersForSecond[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives their best card to \(allPlayersForSecond[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives their best card to \(allPlayersForSecond[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives their best card to \(allPlayersForSecond[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives their best card to \(allPlayersForSecond[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives their best card to \(allPlayersForSecond[0].name)"
                                                }
                                                //Set the direction for second to last place
                                                switch allPlayersForSecond[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives any card to \(allPlayersForSecondLast[0].name)"
                                                }
                                            }
                                            
                                        case "Capitalism":
                                            
                                                var players: [Player] = [Player(name: names[0], score: p1Scores.last!)]
                                                let roundScores = [p1Scores.last, p2Scores.last, p3Scores.last, p4Scores.last, p5Scores.last, p6Scores.last]
                                                
                                                //Make list of Player Structs that Include a Name and The Latest Inputted Scores
                                                for x in 2...playerCount {
                                                    players.append(Player(name: names[x - 1], score: roundScores[x - 1]!))
                                                }
                                                
                                                //Get the Highest of these New Scores - Output Example: 8
                                                let maxScore = players.lazy.map{ $0.score }.max()
                                                let minScore = players.lazy.map{ $0.score }.min()
                                                
                                                //Makes a list of the players who had the highest card
                                                let allPlayerWithMaxScore = players.filter { $0.score == maxScore }
                                                let allPlayerWithMinScore = players.filter { $0.score == minScore }
                                                
                                                //Check if there was a tie for loser, if not just goes ahead with directions
                                                if allPlayerWithMaxScore.count > 1 {
                                                    sheetForLoser = true
                                                    showSheet = true
                                                    tiedPlayers = allPlayerWithMaxScore
                                                    winningPlayers = allPlayerWithMinScore
                                                } else {
                                                    //Set the direction for the winner
                                                    if p1Scores.last == 0 {
                                                        direction1 = "\(names[0]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    } else if p2Scores.last == 0 {
                                                        direction2 = "\(names[1]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    } else if p3Scores.last == 0 {
                                                        direction3 = "\(names[2]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    } else if p4Scores.last == 0 {
                                                        direction4 = "\(names[3]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    } else if p5Scores.last == 0 {
                                                        direction5 = "\(names[4]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    } else if p6Scores.last == 0 {
                                                        direction6 = "\(names[5]) gives any card to \(allPlayerWithMaxScore[0].name)"
                                                    }
                                                    //Set the direction for the loser
                                                    switch allPlayerWithMaxScore[0].name {
                                                        case names[0]:
                                                            direction1 = "\(names[0]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                        case names[1]:
                                                            direction2 = "\(names[1]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                        case names[2]:
                                                            direction3 = "\(names[2]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                        case names[3]:
                                                            direction4 = "\(names[3]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                        case names[4]:
                                                            direction5 = "\(names[4]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                        default:
                                                            direction6 = "\(names[5]) gives their best card to \(allPlayerWithMinScore[0].name)"
                                                    }
                                                }
                                            
                                        case "Democratic Socialism":
                                            
                                            var players: [Player] = [Player(name: names[0], score: p1Scores.last!)]
                                            let roundScores = [p1Scores.last, p2Scores.last, p3Scores.last, p4Scores.last, p5Scores.last, p6Scores.last]
                                            
                                            //Make list of Player Structs that Include a Name and The Latest Inputted Scores
                                            for x in 2...playerCount {
                                                players.append(Player(name: names[x - 1], score: roundScores[x - 1]!))
                                            }
                                            
                                            //Get the Highest of these New Scores - Output Example: 8
                                            let maxScore = players.lazy.map{ $0.score }.max()
                                            let minScore = players.lazy.map{ $0.score }.min()
                                            
                                            //Makes a list of the players who had the highest card
                                            let allPlayerWithMaxScore = players.filter { $0.score == maxScore }
                                            let allPlayerWithMinScore = players.filter { $0.score == minScore }
                                            //Check if there was a tie for loser, if not just goes ahead with directions
                                            if allPlayerWithMaxScore.count > 1 {
                                                sheetForLoser = true
                                                showSheet = true
                                                tiedPlayers = allPlayerWithMaxScore
                                                winningPlayers = allPlayerWithMinScore
                                            } else {
                                                //Set the direction for the winner
                                                if p1Scores.last == 0 {
                                                    direction1 = "\(names[0]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                } else if p2Scores.last == 0 {
                                                    direction2 = "\(names[1]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                } else if p3Scores.last == 0 {
                                                    direction3 = "\(names[2]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                } else if p4Scores.last == 0 {
                                                    direction4 = "\(names[3]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                } else if p5Scores.last == 0 {
                                                    direction5 = "\(names[4]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                } else if p6Scores.last == 0 {
                                                    direction6 = "\(names[5]) gives their best card to \(allPlayerWithMaxScore[0].name)"
                                                }
                                                //Set the direction for the loser
                                                switch allPlayerWithMaxScore[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives any card to \(allPlayerWithMinScore[0].name)"
                                                }
                                            }
                                    
                                        default:
                                            //Default here can be read a "case "Socialism""
                                            var players: [Player] = [Player(name: names[0], score: p1Scores.last!)]
                                            let roundScores = [p1Scores.last, p2Scores.last, p3Scores.last, p4Scores.last, p5Scores.last, p6Scores.last]
                                            
                                            //Make list of Player Structs that Include a Name and The Latest Inputted Scores
                                            for x in 2...playerCount {
                                                players.append(Player(name: names[x - 1], score: roundScores[x - 1]!))
                                            }
                                            
                                            //Get the Highest of these New Scores - Output Example: 8
                                            let maxScore = players.lazy.map{ $0.score }.max()
                                            let minScore = players.lazy.map{ $0.score }.min()
                                            
                                            print("ya yeet: \(maxScore!)")
                                            
                                            //Makes a list of players excluding any winners or players who aren't playing
                                            var playersWithoutZero: [Player] = []
                                            for index in 0...players.count - 1 {
                                                
                                               // print(index)
                                                
                                                if players[index].score != 0 {
                                                    playersWithoutZero.append(players[index])
                                                }
                                            }
                                            
                                            let secondPlaceScore  = playersWithoutZero.lazy.map{ $0.score }.min()
                                            
                                            var playersWithoutMax: [Player] = []
                                            let numToIgnore = maxScore!
                                            for index2 in 0...players.count - 1 {
                                                
                                                print(index2)
                                                
                                                if players[index2].score == numToIgnore {
                                                } else {
                                                    print("haha true")
                                                    playersWithoutMax.append(players[index2])
                                                }
                                            }
                                            
                                            print("-\(playersWithoutMax)-")
                                            print("\(playersWithoutZero) !!!")
                                            
                                            
                                            let secondLastPlaceScore  = playersWithoutMax.lazy.map{ $0.score }.max()
                                            
                                            //Makes a list of the players who had the highest card
                                             allPlayerWithMaxScore = players.filter { $0.score == maxScore }
                                             allPlayerWithMinScore = players.filter { $0.score == minScore }
                                             allPlayersForSecond = players.filter { $0.score == secondPlaceScore }
                                             allPlayersForSecondLast = players.filter { $0.score == secondLastPlaceScore }
                                            
                                            print("\(allPlayersForSecondLast) + \(allPlayersForSecond) !!")
                                            sheetForLoser = false
                                            sheetForSecond = false
                                            sheetForSecondLast = false
                                            
                                            //Check if there was a tie for loser, if not just goes ahead with directions
                                            if allPlayerWithMaxScore.count > 1 {
                                                sheetForLoser = true
                                                sheetForSecond = false
                                                showSheet = true
                                                tiedPlayers = allPlayerWithMaxScore
                                                winningPlayers = allPlayerWithMinScore
                                                
                                            }
                                            if allPlayersForSecond.count > 1 {
                                                sheetForLoser = false
                                                sheetForSecond = true
                                                showSheet = true
                                                tiedPlayersForSecond = allPlayersForSecond
                                                winningPlayers = allPlayerWithMinScore
                                            }
                                            if allPlayersForSecondLast.count > 1 {
                                                sheetForLoser = false
                                                sheetForSecond = false
                                                showSheet = true
                                                tiedPlayersForSecondLast = allPlayersForSecondLast
                                                winningPlayers = allPlayerWithMinScore
                                            }
                                            
                                            if allPlayerWithMaxScore.count == 1 && allPlayersForSecond.count == 1 && allPlayersForSecondLast.count == 1 {
                                                
                                                //Set the direction for first place
                                                if p1Scores.last == 0 {
                                                    direction1 = "\(names[0]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p2Scores.last == 0 {
                                                    direction2 = "\(names[1]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p3Scores.last == 0 {
                                                    direction3 = "\(names[2]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p4Scores.last == 0 {
                                                    direction4 = "\(names[3]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p5Scores.last == 0 {
                                                    direction5 = "\(names[4]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                } else if p6Scores.last == 0 {
                                                    direction6 = "\(names[5]) gives their best 2 cards to \(allPlayerWithMaxScore[0].name)"
                                                }
                                                
                                                //Set the direction for last place
                                                switch allPlayerWithMaxScore[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives any 2 cards to \(allPlayerWithMinScore[0].name)"
                                                }
                                                
                                                //Set the direction for second place
                                                switch allPlayersForSecondLast[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives any card to \(allPlayersForSecond[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives any card to \(allPlayersForSecond[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives any card to \(allPlayersForSecond[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives any card to \(allPlayersForSecond[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives any card to \(allPlayersForSecond[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives any card to \(allPlayersForSecond[0].name)"
                                                }
                                                //Set the direction for second to last place
                                                switch allPlayersForSecond[0].name {
                                                    case names[0]:
                                                        direction1 = "\(names[0]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                    case names[1]:
                                                        direction2 = "\(names[1]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                    case names[2]:
                                                        direction3 = "\(names[2]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                    case names[3]:
                                                        direction4 = "\(names[3]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                    case names[4]:
                                                        direction5 = "\(names[4]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                    default:
                                                        direction6 = "\(names[5]) gives their best card \(allPlayersForSecondLast[0].name)"
                                                }
                                            }
                                            
                                    }
                                    
                                    p1Input = ""
                                    p2Input = ""
                                    p3Input = ""
                                    p4Input = ""
                                    p5Input = ""
                                    p6Input = ""
                                }
                                }
                                } label: {
                                    WideButton(text: "Update", textColor: .white, backgroundColor: .blue)
                                } .padding()
                                
                                
                                }
                            }
                        }
                    }
                
                .sheet(isPresented: $showSheet, onDismiss: nil, content: {
                    VStack {
                        ScrollView(showsIndicators: false, content: {
                            VStack {
                                Spacer()
                                
                                if gameEndingSheet {
                                    
                                    Text("Whos Highest Card was Lowest?")
                                        .padding()
                                        .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                    ForEach(0...gameEndingSheetPlayers.count - 1, id: \.self) { index in
                                        Button {
                                            gameWinner = gameEndingSheetPlayers[index].name
                                            selected = [false, false, false, false, false, false]
                                            selected[index] = true
                                        } label: {
                                            if selected[index] {
                                                WideButton(text: gameEndingSheetPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                    .overlay(
                                                        Image(systemName: "checkmark")
                                                            .foregroundColor(.blue)
                                                            .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                    )
                                                    .padding()
                                            } else {
                                                WideButton(text: gameEndingSheetPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                    .padding()
                                            }
                                        }
                                    }
                                    
                                } else {
                                
                                if picked == "Capitalism" || picked == "Democratic Socialism" {
                                        Text("Who had the Highest Card?")
                                            .padding()
                                            .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                        ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                            Button {
                                                selected = [false, false, false, false, false, false]
                                                selected[index] = true
                                                lastPlace = tiedPlayers[index]
                                            } label: {
                                                if selected[index] {
                                                    WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                        .overlay(
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.blue)
                                                                .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                        )
                                                        .padding()
                                                } else {
                                                    WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                        .padding()
                                                }
                                                
                                            }
                                        }
                                } else {
                                    //aka case "Authoritarianism"..."Socialism":
                                        if allPlayerWithMaxScore.count == Int(playerCount - 1) {
                                            //logic for if everyone ties
                                            Text("Who had the Highest Card?")
                                                .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                .padding()
                                            ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                Button {
                                                    selected = [false, false, false, false, false, false]
                                                    selected[index] = true
                                                    lastPlace = tiedPlayers[index]
                                                    
                                                    if tiedPlayers.count <= 3 {
                                                    secondPlaceSort = tiedPlayers.filter { $0.name != lastPlace.name }
                                                    secondPlaceSort = secondPlaceSort.filter { $0.name != secondLastPlace.name }
                                                    secondPlace = secondPlaceSort[0]
                                                    }
                                                    
                                                } label: {
                                                    if selected[index] {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            .overlay(
                                                                Image(systemName: "checkmark")
                                                                    .foregroundColor(.blue)
                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                            )
                                                    } else {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                    }
                                                    
                                                }
                                            }
                                            Text("Whos Highest Card was Second Highest?")
                                                .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                .padding()
                                            ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                Button {
                                                    selected2 = [false, false, false, false, false, false]
                                                    selected2[index] = true
                                                    secondLastPlace = tiedPlayers[index]
                                                    
                                                    if tiedPlayers.count == 3 {
                                                    secondPlaceSort = tiedPlayers.filter { $0.name != lastPlace.name }
                                                    secondPlaceSort = secondPlaceSort.filter { $0.name != secondLastPlace.name }
                                                    secondPlace = secondPlaceSort[0]
                                                    }
                                                    
                                                } label: {
                                                    if selected2[index] {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            .overlay(
                                                                Image(systemName: "checkmark")
                                                                    .foregroundColor(.blue)
                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                            )
                                                    } else {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                    }
                                                    
                                                }
                                            }
                                            if tiedPlayers.count > 3 {
                                            Text("Whos Highest Card was Lowest?")
                                                    .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                    .padding()
                                            ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                Button {
                                                    selected3 = [false, false, false, false, false, false]
                                                    selected3[index] = true
                                                    secondPlace = tiedPlayers[index]
                                                } label: {
                                                    if selected3[index] {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            .overlay(
                                                                Image(systemName: "checkmark")
                                                                    .foregroundColor(.blue)
                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                            )
                                                    } else {
                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                    }
                                                    
                                                }
                                            }
                                            }
                                        } else {
                                            if allPlayerWithMaxScore.count > 1 {
                                                if allPlayersForSecond.count > 1 {
                                                    //Logic for if theres a tie for second place and a tie for last place
                                                    Text("Who had the Highest Card?")
                                                        .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                        .padding()
                                                            ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                                Button {
                                                                    selected = [false, false, false, false, false, false]
                                                                    selected[index] = true
                                                                    lastPlace = tiedPlayers[index]
                                                                    
                                                                    if tiedPlayers.count == 2 {
                                                                        let secondLastList = tiedPlayers.filter { $0.name != lastPlace.name }
                                                                        secondLastPlace = secondLastList[0]
                                                                    }
                                                                    
                                                                } label: {
                                                                    if selected[index] {
                                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                            .overlay(
                                                                                Image(systemName: "checkmark")
                                                                                    .foregroundColor(.blue)
                                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                            )
                                                                    } else {
                                                                        WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    }
                                                                }
                                                            }
                                                    
                                                    if tiedPlayers.count > 2 {
                                                    Text("Whos Highest Card was Second Highest?")
                                                            .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                        .padding()
                                                    ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                        Button {
                                                            selected2 = [false, false, false, false, false, false]
                                                            selected2[index] = true
                                                            secondLastPlace = tiedPlayers[index]
                                                            
                                                        } label: {
                                                            if selected2[index] {
                                                                WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    .overlay(
                                                                        Image(systemName: "checkmark")
                                                                            .foregroundColor(.blue)
                                                                            .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                    )
                                                            } else {
                                                                WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            }
                                                        }
                                                    }
                                                }
                                                    
                                                    
                                                    Text("Whos Highest Card was Lowest?")
                                                        .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                        .padding()
                                                    ForEach(0...tiedPlayersForSecond.count - 1, id: \.self) { index in
                                                        Button {
                                                            selected3 = [false, false, false, false, false, false]
                                                            selected3[index] = true
                                                            secondPlace = tiedPlayersForSecond[index]
                                                            
                                                        } label: {
                                                            if selected3[index] {
                                                                WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    .overlay(
                                                                        Image(systemName: "checkmark")
                                                                            .foregroundColor(.blue)
                                                                            .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                    )
                                                            } else {
                                                                WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            }
                                                        }
                                                    }
                                                
                                                    
                                                    
                                                    
                                                } else {
                                                    //Logic for if theres a tie for just last place
                                                    Text("Who had the Highest Card?")
                                                        .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                        .padding()
                                                    ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                        Button {
                                                            selected = [false, false, false, false, false, false]
                                                            selected[index] = true
                                                            lastPlace = tiedPlayers[index]
                                                            
                                                            secondPlace = allPlayersForSecond[0]
                                                            
                                                            if tiedPlayers.count == 2 {
                                                                let secondLastPlayers = tiedPlayers.filter { $0.name != tiedPlayers[index].name }
                                                                secondLastPlace = secondLastPlayers[0]
                                                            }
                                                            
                                                        } label: {
                                                            if selected[index] {
                                                                WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    .overlay(
                                                                        Image(systemName: "checkmark")
                                                                            .foregroundColor(.blue)
                                                                            .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                    )
                                                            } else {
                                                                WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                            }
                                                        }
                                                    }
                                                    
                                                    if tiedPlayers.count > 2 {
                                                        Text("Whos Highest Card was Second Highest?")
                                                            .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                            .padding()
                                                        ForEach(0...tiedPlayers.count - 1, id: \.self) { index in
                                                            Button {
                                                                selected2 = [false, false, false, false, false, false]
                                                                selected2[index] = true
                                                                secondLastPlace = tiedPlayers[index]
                                                                
                                                                secondPlace = allPlayersForSecond[0]
                                                                
                                                            } label: {
                                                                if selected2[index] {
                                                                    WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                        .overlay(
                                                                            Image(systemName: "checkmark")
                                                                                .foregroundColor(.blue)
                                                                                .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                        )
                                                                } else {
                                                                    WideButton(text: tiedPlayers[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                }
                                            } else {
                                                if allPlayersForSecond.count > 1 {
                                                    if allPlayersForSecondLast.count > 1 {
                                                        //Logic for if theres a tie for second and second last place
                                                        Text("Who had the Highest Card?")
                                                            .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                            .padding()
                                                        ForEach(0...tiedPlayersForSecondLast.count - 1, id: \.self) { index in
                                                            Button {
                                                                selected = [false, false, false, false, false, false]
                                                                selected[index] = true
                                                                
                                                                secondLastPlace = tiedPlayersForSecondLast[index]
                                                                
                                                                if tiedPlayersForSecondLast == tiedPlayersForSecond {
                                                                    if tiedPlayersForSecond.count == 2 {
                                                                        let secondList = tiedPlayersForSecond.filter { $0.name != tiedPlayersForSecondLast[index].name }
                                                                        secondPlace = secondList[0]
                                                                    }
                                                                }
                                                                
                                                                lastPlace = allPlayerWithMaxScore[0]
                                                                
                                                            } label: {
                                                                if selected[index] {
                                                                    WideButton(text: tiedPlayersForSecondLast[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                        .overlay(
                                                                            Image(systemName: "checkmark")
                                                                                .foregroundColor(.blue)
                                                                                .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                        )
                                                                } else {
                                                                    WideButton(text: tiedPlayersForSecondLast[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        if tiedPlayersForSecond != tiedPlayersForSecondLast {
                                                            Text("Who had the Lowest Card?")
                                                                .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                                .padding()
                                                            ForEach(0...tiedPlayersForSecond.count - 1, id: \.self) { index in
                                                                Button {
                                                                    selected2 = [false, false, false, false, false, false]
                                                                    selected2[index] = true
                                                                    
                                                                    secondPlace = tiedPlayersForSecond[index]
                                                                    
                                                                    lastPlace = allPlayerWithMaxScore[0]
                                                                    
                                                                } label: {
                                                                    if selected2[index] {
                                                                        WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                            .overlay(
                                                                                Image(systemName: "checkmark")
                                                                                    .foregroundColor(.blue)
                                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                            )
                                                                    } else {
                                                                        WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    }
                                                                }
                                                            }
                                                            
                                                        }
                                                        
                                                        if (tiedPlayersForSecond == tiedPlayersForSecondLast) && tiedPlayersForSecond.count > 3 {
                                                            Text("Who had the Lowest Card?")
                                                                .padding()
                                                                .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                            ForEach(0...tiedPlayersForSecond.count - 1, id: \.self) { index in
                                                                Button {
                                                                    selected3 = [false, false, false, false, false, false]
                                                                    selected3[index] = true
                                                                    
                                                                    secondPlace = tiedPlayersForSecond[index]
                                                                    
                                                                    lastPlace = allPlayerWithMaxScore[0]
                                                                    
                                                                } label: {
                                                                    if selected3[index] {
                                                                        WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                            .overlay(
                                                                                Image(systemName: "checkmark")
                                                                                    .foregroundColor(.blue)
                                                                                    .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                            )
                                                                    } else {
                                                                        WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                    }
                                                                }
                                                            }
                                                            
                                                        }
                                                    
                                                    } else {
                                                        //Logic for if theres a tie between just second place
                                                                Text("Who had the Highest Card?")
                                                                    .padding()
                                                                    .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                                ForEach(0...tiedPlayersForSecond.count - 1, id: \.self) { index in
                                                                    Button {
                                                                        selected = [false, false, false, false, false, false]
                                                                        selected[index] = true
                                                                        secondPlace = tiedPlayersForSecond[index]
                                                                        secondLastPlace = allPlayersForSecondLast[0]
                                                                        lastPlace = allPlayerWithMaxScore[0]
                                                                        
                                                                    } label: {
                                                                        if selected[index] {
                                                                            WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                                .overlay(
                                                                                    Image(systemName: "checkmark")
                                                                                        .foregroundColor(.blue)
                                                                                        .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                                )
                                                                        } else {
                                                                            WideButton(text: tiedPlayersForSecond[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                        }
                                                                    }
                                                                }
                                                    }
                                                } else {
                                                    //Logic for a tie for just second last place
                                                        Text("Who had the Highest Card?")
                                                            .padding()
                                                            .foregroundColor(theme.theme == 3 ? Color.black : Color.primary)
                                                        ForEach(0...tiedPlayersForSecondLast.count - 1, id: \.self) { index in
                                                            Button {
                                                                selected = [false, false, false, false, false, false]
                                                                selected[index] = true
                                                                secondLastPlace = tiedPlayersForSecondLast[index]
                                                                
                                                                secondPlace = allPlayersForSecond[0]
                                                                lastPlace = allPlayerWithMaxScore[0]
                                                                
                                                            } label: {
                                                                if selected[index] {
                                                                    WideButton(text: tiedPlayersForSecondLast[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                        .overlay(
                                                                            Image(systemName: "checkmark")
                                                                                .foregroundColor(.blue)
                                                                                .padding(.leading, UIScreen.main.bounds.width * 0.55)
                                                                        )
                                                                } else {
                                                                    WideButton(text: tiedPlayersForSecondLast[index].name, textColor: Color.primary, backgroundColor: .gray.opacity(0.2))
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                }
                            }
                            }
                            .padding(.top, 25)
                        }) .edgesIgnoringSafeArea(.all)
                        Button {
                            
                            if gameEndingSheet {
                                showSheet.toggle()
                                direction1 = ""
                                direction2 = ""
                                direction3 = ""
                                direction4 = ""
                                direction5 = ""
                                direction6 = ""
                                switchScreens = true
                            }  else {
                            
                            direction1 = ""
                            direction2 = ""
                            direction3 = ""
                            direction4 = ""
                            direction5 = ""
                            direction6 = ""
                            
                            firstPlace = winningPlayers[0]
                            
                            switch picked {
                                case "Capitalism":
                                    switch firstPlace.name {
                                        case names[0]:
                                        direction1 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                        default:
                                        direction6 = "\(firstPlace.name) gives any card to \(lastPlace.name)"
                                    }
                                    switch lastPlace.name {
                                        case names[0]:
                                        direction1 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                        case names[1]:
                                        direction2 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                        case names[2]:
                                        direction3 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                        case names[3]:
                                        direction4 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                        case names[4]:
                                        direction5 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                        default:
                                        direction6 = "\(lastPlace.name) gives their best card to \(firstPlace.name)"
                                    }
                                case "Democratic Socialism":
                                    switch firstPlace.name {
                                        case names[0]:
                                        direction1 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                        default:
                                        direction6 = "\(firstPlace.name) gives their best card to \(lastPlace.name)"
                                    }
                                    switch lastPlace.name {
                                        case names[0]:
                                        direction1 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                        case names[1]:
                                        direction2 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                        case names[2]:
                                        direction3 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                        case names[3]:
                                        direction4 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                        case names[4]:
                                        direction5 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                        default:
                                        direction6 = "\(lastPlace.name) gives any card to \(firstPlace.name)"
                                    }
                                case "Authoritarianism":
                                    switch firstPlace.name {
                                        case names[0]:
                                        direction1 = "\(firstPlace.name) gives any 2 card to \(lastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(firstPlace.name) gives any 2 cards to \(lastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(firstPlace.name) gives any 2 cards to \(lastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(firstPlace.name) gives any 2 cards to \(lastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(firstPlace.name) gives any 2 cards to \(lastPlace.name)"
                                        default:
                                        direction6 = "\(firstPlace.name) gives any 2 cards to \(lastPlace.name)"
                                    }
                                    switch lastPlace.name {
                                        case names[0]:
                                        direction1 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                        case names[1]:
                                        direction2 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                        case names[2]:
                                        direction3 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                        case names[3]:
                                        direction4 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                        case names[4]:
                                        direction5 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                        default:
                                        direction6 = "\(lastPlace.name) gives their best 2 cards to \(firstPlace.name)"
                                    }
                                
                                    switch secondPlace.name {
                                        case names[0]:
                                        direction1 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                        default:
                                        direction6 = "\(secondPlace.name) gives any card to \(secondLastPlace.name)"
                                    }
                                    switch secondLastPlace.name {
                                        case names[0]:
                                        direction1 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                        case names[1]:
                                        direction2 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                        case names[2]:
                                        direction3 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                        case names[3]:
                                        direction4 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                        case names[4]:
                                        direction5 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                        default:
                                        direction6 = "\(secondLastPlace.name) gives their best card to \(secondPlace.name)"
                                    }
                                default:
                                    switch firstPlace.name {
                                        case names[0]:
                                        direction1 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                        default:
                                        direction6 = "\(firstPlace.name) gives their best 2 cards to \(lastPlace.name)"
                                    }
                                    switch lastPlace.name {
                                        case names[0]:
                                        direction1 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                        case names[1]:
                                        direction2 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                        case names[2]:
                                        direction3 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                        case names[3]:
                                        direction4 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                        case names[4]:
                                        direction5 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                        default:
                                        direction6 = "\(lastPlace.name) gives any 2 cards to \(firstPlace.name)"
                                    }
                                
                                    switch secondPlace.name {
                                        case names[0]:
                                        direction1 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                        case names[1]:
                                        direction2 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                        case names[2]:
                                        direction3 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                        case names[3]:
                                        direction4 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                        case names[4]:
                                        direction5 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                        default:
                                        direction6 = "\(secondPlace.name) gives their best card to \(secondLastPlace.name)"
                                    }
                                    switch secondLastPlace.name {
                                        case names[0]:
                                        direction1 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                        case names[1]:
                                        direction2 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                        case names[2]:
                                        direction3 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                        case names[3]:
                                        direction4 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                        case names[4]:
                                        direction5 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                        default:
                                        direction6 = "\(secondLastPlace.name) gives any card to \(secondPlace.name)"
                                    }
                            }
                            
                            showSheet.toggle()
                            
                        }
                        } label: {
                            WideButton(text: "Dismiss", textColor: .white, backgroundColor: .blue)
                                .padding(20)
                        }
                    }
                    
                    //.interactiveDismissDisabled()
                    // ^ This is an iOS 15 only feature which means the fam can't use it until they're on iOS 15, so we'll leave it commented out until that fully releases. It just locks in the sheet so you can't swipe it away without hitting "Dismiss", with Dismiss being the thing that actually sets the directions.
                })
            }
            .background(theme.theme == 3 ? BackgroundOld(color1: "bgPink", color2: "bgBlue").edgesIgnoringSafeArea(.all) : BackgroundOld(color1: "systemBackground", color2: "systemBackground").edgesIgnoringSafeArea(.all))
            if switchScreens {
                WinnerView(winner: $gameWinner, winnerScore: $gameOverWinningScore, roundScores: $roundScores, theType: $picked, playerCount: $playerCount, names: $names)
            }
        }

        .onAppear(perform: {
            if defaultPlayerCount.isEmpty {
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
            } else {
                if showPicker {
                playerCount = defaultPlayerCount[0].number
                }
            }
            if defaultNamesFile.isEmpty {
                Names.saveToFile([Names(p1Name: "Player 1", p2Name: "Player 2", p3Name: "Player 3", p4Name: "Player 4", p5Name: "Player 5", p6Name: "Player 6")])
                defaultNames = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"]
                names = defaultNames
            } else {
                defaultNames = [defaultNamesFile[0].p1Name, defaultNamesFile[0].p2Name, defaultNamesFile[0].p3Name, defaultNamesFile[0].p4Name, defaultNamesFile[0].p5Name,defaultNamesFile[0].p6Name]
                names = defaultNames
            }
            if endScoreFile.isEmpty {
                TheEndScore.saveToFile([TheEndScore(endScore: 35)])
                endScore = "35"
                endScoreInt = 35
                print("no")
            } else {
                endScoreInt = endScoreFile[0].endScore
                endScore = "\(endScoreInt)"
                print("yes")
            }
        })
        }

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}


}

struct Player: Hashable {
    let name: String
    let score: Int
}
