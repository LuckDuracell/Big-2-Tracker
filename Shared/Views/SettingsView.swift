//
//  SettingsView.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var reset: ResetApp
    @EnvironmentObject var theme: colorThemeSetting
    
    @State var namesFile = Names.loadFromFile()
    @State var names: [String] = []
    @State var TTotalsFile = TheTotals.loadFromFile()
    @State var ATotalsFile = TheAuthoritarianism.loadFromFile()
    @State var CTotalsFile = TheCapitalism.loadFromFile()
    @State var DTotalsFile = TheDemocratic.loadFromFile()
    @State var STotalsFile = TheSocialism.loadFromFile()
    @State var colorSchemeFile = ColorTheme.loadFromFile()
    @State var colorScheme = 0
    @State var endScoreFile = TheEndScore.loadFromFile()
    @State var endScore = 35
    @State var endScoreString = "35"
    @State var defaultPlayerCountFile = DefaultPlayerCount.loadFromFile()
    @State var defaultPlayerCountString = "4"
    @State var defaultPlayerCount = 4
    @State var showAlert = false
    @State var initials = ["P1", "P2", "P3", "P4", "P5", "P6"]
    @State var ATotals = [0, 0, 0, 0, 0, 0]
    @State var CTotals = [0, 0, 0, 0, 0, 0]
    @State var DTotals = [0, 0, 0, 0, 0, 0]
    @State var STotals = [0, 0, 0, 0, 0, 0]
    @State var TTotals = [0, 0, 0, 0, 0, 0]
    @State private var minusColor = Color.blue
    @State private var plusColor = Color.blue
    
    @State var pickerName = "Player 1"
    @State var pickerType = "Authoritarianism"
    @State var pickerNames = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"]
    @State var pickerTypes = ["Authoritarianism", "Capitalism", "Democratic Socialism", "Socialism"]
    
    @State var scoreInput = ""
    
    
    @State var showList = true
    
    var body: some View {
        
        NavigationView() {
            ZStack {
                
                if theme.theme == 3 {
                    BackgroundOld(color1: "bgPink", color2: "bgBlue")
                        .edgesIgnoringSafeArea(.all)
                }
                
            VStack {
                if showList {
                    List {
                        NavigationLink(destination:
                            VStack {
                            ForEach(names.indices, id: \.self) { index in
                                TextField(names[index], text: $names[index])
                                    .padding()
                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .padding(5)
                                    .padding(Edge.Set.horizontal, 15)
                                
                                
                            }
                            Button {
                                Names.saveToFile([Names(p1Name: names[0], p2Name: names[1], p3Name: names[2], p4Name: names[3], p5Name: names[4], p6Name: names[5])])
                                reset.animate = true
                            } label: {
                                WideButton(text: "Update Names", textColor: .primary, backgroundColor: Color.gray.opacity(0.2))
                                    .padding()
                            }
                            .onAppear(perform: {
                                if theme.theme == 3 {
                                    showList = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                        showList = true
                                    }
                                }
                            })

                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "person.2.circle.fill")
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Names")
                            }
                            .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        NavigationLink(destination:
                            VStack {
                            
                                Picker("Names", selection: $pickerName, content: {
                                    ForEach(pickerNames, id: \.self) {
                                        Text($0)
                                    }
                                }) .padding(.top, -120)
                            
                                Picker("Types", selection: $pickerType, content: {
                                    ForEach(pickerTypes, id: \.self) {
                                        Text($0)
                                    }
                                })
                            
                            TextField("Score Input", text: $scoreInput)
                                .keyboardType(.numberPad)
                                .padding()
                                .foregroundColor(theme.theme == 3 ? .black : .primary)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .introspectTextField { (textField) in
                                           let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                           let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                           let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                           doneButton.tintColor = .systemBlue
                                           toolBar.items = [flexButton, doneButton]
                                           toolBar.setItems([flexButton, doneButton], animated: true)
                                           textField.inputAccessoryView = toolBar
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 15)
                            
                                Button {
                                    switch pickerName {
                                        case names[0]:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[0] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[0] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[0] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[0] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        case names[1]:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[1] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[1] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[1] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[1] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        case names[2]:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[2] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[2] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[2] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[2] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        case names[3]:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[3] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[3] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[3] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[3] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        case names[4]:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[4] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[4] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[4] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[4] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        default:
                                            if pickerType == "Authoritarianism" {
                                                ATotals[5] = Int(scoreInput) ?? 0
                                                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: ATotals[0], player2T: ATotals[1], player3T: ATotals[2], player4T: ATotals[3], player5T: ATotals[4], player6T: ATotals[5])])
                                            } else if pickerType == "Capitalism" {
                                                CTotals[5] = Int(scoreInput) ?? 0
                                                TheCapitalism.saveToFile([TheCapitalism(player1T: CTotals[0], player2T: CTotals[1], player3T: CTotals[2], player4T: CTotals[3], player5T: CTotals[4], player6T: CTotals[5])])
                                            } else if pickerType == "Democratic Socialism" {
                                                DTotals[5] = Int(scoreInput) ?? 0
                                                TheDemocratic.saveToFile([TheDemocratic(player1T: DTotals[0], player2T: DTotals[1], player3T: DTotals[2], player4T: DTotals[3], player5T: DTotals[4], player6T: DTotals[5])])
                                            } else {
                                                STotals[5] = Int(scoreInput) ?? 0
                                                TheSocialism.saveToFile([TheSocialism(player1T: STotals[0], player2T: STotals[1], player3T: STotals[2], player4T: STotals[3], player5T: STotals[4], player6T: STotals[5])])
                                            }
                                        }
                                    
                                    TheTotals.saveToFile([TheTotals(player1T: ATotals[0] + CTotals[0] + DTotals[0] + STotals[0], player2T: ATotals[1] + CTotals[1] + DTotals[1] + STotals[1], player3T: ATotals[2] + CTotals[2] + DTotals[2] + STotals[2], player4T: ATotals[3] + CTotals[3] + DTotals[3] + STotals[3], player5T: ATotals[4] + CTotals[4] + DTotals[4] + STotals[4], player6T: ATotals[5] + CTotals[5] + DTotals[5] + STotals[5])])
                                    
                                    reset.animate = true
                                } label: {
                                    WideButton(text: "Update Scores", textColor: .primary, backgroundColor: Color.gray.opacity(0.2))
                                        .padding()
                                }
                                .onAppear(perform: {
                                    if theme.theme == 3 {
                                        showList = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                            showList = true
                                        }
                                    }
                                })
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "number.circle.fill")
                                        .resizable()
                                        .foregroundColor(.green)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Scores")
                            }
                            .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        NavigationLink(destination:
                            VStack {
                                    List {
                                        
                                        Button {
                                            colorScheme = 0
                                            ColorTheme.saveToFile([ColorTheme(number: 0)])
                                            theme.theme = 0
                                        } label: {
                                            HStack {
                                                Text("Use System")
                                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                Spacer()
                                                if colorScheme == 0 {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                }
                                            }
                                        } .listRowBackground(Color.gray.opacity(0.2))
                                        Button {
                                            colorScheme = 1
                                            ColorTheme.saveToFile([ColorTheme(number: 1)])
                                            theme.theme = 1
                                        } label: {
                                            HStack {
                                                Text("Light")
                                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                Spacer()
                                                if colorScheme == 1 {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                }
                                            }
                                        } .listRowBackground(Color.gray.opacity(0.2))
                                        Button {
                                            colorScheme = 2
                                            ColorTheme.saveToFile([ColorTheme(number: 2)])
                                            theme.theme = 2
                                        } label: {
                                            HStack {
                                                Text("Dark")
                                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                Spacer()
                                                if colorScheme == 2 {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                }
                                            }
                                        } .listRowBackground(Color.gray.opacity(0.2))
                                        Button {
                                            colorScheme = 3
                                            ColorTheme.saveToFile([ColorTheme(number: 3)])
                                            theme.theme = 3
                                        } label: {
                                            HStack {
                                                Text("Colorful")
                                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                Spacer()
                                                if colorScheme == 3 {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                                }
                                            }
                                        } .listRowBackground(Color.gray.opacity(0.2))
                                    }
                                    .onAppear(perform: {
                                        if theme.theme == 3 {
                                            showList = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                showList = true
                                            }
                                        }
                                    })
                            
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "iphone.circle.fill")
                                        .resizable()
                                        .foregroundColor(.orange)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Display")
                            }
                            .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        
                        NavigationLink(destination:
                            VStack {
                            Spacer()
                                .padding(60)
                                Text("Default Player Count:")
                            
                                TextField("Default Player Count", text: $defaultPlayerCountString)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(theme.theme == 3 ? .black : .primary)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.width * 0.1, alignment: .leading)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .onChange(of: defaultPlayerCountString) { newValue in
                                        defaultPlayerCount = Int(defaultPlayerCountString) ?? 4
                                        DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: defaultPlayerCount)])
                                    }
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
                            
                                    Text("End Score:")
                                
                                    TextField("End Score", text: $endScoreString)
                                        .keyboardType(.numberPad)
                                        .foregroundColor(theme.theme == 3 ? .black : .primary)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.width * 0.1, alignment: .leading)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .onChange(of: endScoreString) { newValue in
                                            endScore = Int(endScoreString) ?? 35
                                            TheEndScore.saveToFile([TheEndScore(endScore: endScore)])
                                        }
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
                            
                            
                                    Button {
                                        reset.animate = true
                                    } label: {
                                        WideButton(text: "Save Changes", textColor: .primary, backgroundColor: Color.gray.opacity(0.2))
                                            .padding(150)
                                    }
                                    .onAppear(perform: {
                                        if theme.theme == 3 {
                                            showList = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                showList = true
                                            }
                                        }
                                    })
                            
                                    Spacer()
                                    
                                
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "bolt.circle.fill")
                                        .resizable()
                                        .foregroundColor(.yellow)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Defaults")
                            }
                            .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        
                        
                        Button {
                            
                        } label: {
                            HStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "message.circle.fill")
                                        .resizable()
                                        .foregroundColor(.purple)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Share App Data")
                            }
                        } .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        
                        Button {
                            reset.animate = true
                        } label: {
                            HStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                        .resizable()
                                        .foregroundColor(.teal)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Refresh App")
                            }
                        } .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        
                        Button {
                            showAlert = true
                        } label: {
                            HStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                    Image(systemName: "xmark.bin.circle.fill")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 25, height: 25)
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text("Reset App")
                            }
                        } .listRowBackground(theme.theme == 3 ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                        
                    }
                    .opacity(showList ? 1 : 0)
                    .onAppear(perform: {
            
                        if theme.theme != 3 {
                        UITableView.appearance().backgroundColor = .systemBackground
                        } else {
                            UITableView.appearance().backgroundColor = UIColor(Color.clear)
                        }
                    })
                }
            }
            
        } .navigationTitle("Settings")
        }
        .onAppear(perform: {
            if namesFile.isEmpty {
                Names.saveToFile([Names(p1Name: "Player 1", p2Name: "Player 2", p3Name: "Player 3", p4Name: "Player 4", p5Name: "Player 5", p6Name: "Player 6")])
                namesFile = [Names(p1Name: "Player 1", p2Name: "Player 2", p3Name: "Player 3", p4Name: "Player 4", p5Name: "Player 5", p6Name: "Player 6")]
                names = [namesFile[0].p1Name, namesFile[0].p2Name, namesFile[0].p3Name, namesFile[0].p4Name, namesFile[0].p5Name, namesFile[0].p6Name]
            } else {
                names = [namesFile[0].p1Name, namesFile[0].p2Name, namesFile[0].p3Name, namesFile[0].p4Name, namesFile[0].p5Name, namesFile[0].p6Name]
                pickerNames = names
                pickerName = names[0]
            }
            
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
            if defaultPlayerCountFile.isEmpty {
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
            } else {
                defaultPlayerCount = defaultPlayerCountFile[0].number
            }
            
            if colorSchemeFile.isEmpty {
                ColorTheme.saveToFile([ColorTheme(number: 0)])
                colorScheme = 0
            } else {
                colorScheme = colorSchemeFile[0].number
            }
            
            if endScoreFile.isEmpty {
                TheEndScore.saveToFile([TheEndScore(endScore: 35)])
                endScore = 35
                endScoreString = "\(endScore)"
            } else {
                endScore = endScoreFile[0].endScore
                endScoreString = "\(endScore)"
            }
            
            if defaultPlayerCountFile.isEmpty {
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
                defaultPlayerCount = 4
                defaultPlayerCountString = "4"
            } else {
                defaultPlayerCount = defaultPlayerCountFile[0].number
                defaultPlayerCountString = "\(defaultPlayerCount)"
            }
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Warning"), message: Text("This will delete all data, resetting the app back to how it was originally."),primaryButton: .destructive(Text("Reset All"), action: {
                Names.saveToFile([Names(p1Name: "Player 1", p2Name: "Player 2", p3Name: "Player 3", p4Name: "Player 4", p5Name: "Player 5", p6Name: "Player 6")])
                MatchInfo.saveToFile([])
                TheEndScore.saveToFile([TheEndScore(endScore: 35)])
                DefaultPlayerCount.saveToFile([DefaultPlayerCount(number: 4)])
                TheAuthoritarianism.saveToFile([TheAuthoritarianism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
                TheCapitalism.saveToFile([TheCapitalism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
                TheDemocratic.saveToFile([TheDemocratic(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
                TheSocialism.saveToFile([TheSocialism(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
                TheTotals.saveToFile([TheTotals(player1T: 0, player2T: 0, player3T: 0, player4T: 0, player5T: 0, player6T: 0)])
                LatestWinner.saveToFile([])
                NumberOnePlayer.saveToFile([])
                reset.animate = true
            }), secondaryButton: .cancel())
        })
            
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
