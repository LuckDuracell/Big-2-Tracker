//
//  ContentView.swift
//  Shared
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI
import ConfettiSwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var reset = ResetApp()
    @StateObject var theme = colorThemeSetting()
    
    @State var doAFlip: Bool = false
    @State var animateRotation: Bool = false
    
    @State var appThemeFile = ColorTheme.loadFromFile()
    
    var body: some View {
        
        
        ZStack {
            
         
        
        if reset.animate {
            ZStack {
                if theme.theme == 3 { BackgroundOld(color1: "bgPink", color2: "bgBlue") }
                ZStack {
                    if theme.theme != 3 {
                    Circle()
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5, alignment: .center)
                        .foregroundColor(Color.gray.opacity(0.35))
                    }
                    Image("Logo")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                        .rotationEffect(.init(degrees: doAFlip ? -180 : 0))
                        .foregroundColor(Color.white)
                    } .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(Animation.easeInOut(duration: 0.75)) {
                                doAFlip.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
                                reset.animate.toggle()
                            }
                        }
                    })
            }
        } else {
            if theme.theme == 0 {
                //Auto Switch
                TabView() {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    GameplayView()
                        .tabItem {
                            Label("Game Time", systemImage: "gamecontroller")
                        }
                    ScoresView()
                        .tabItem {
                            Label("All Scores", systemImage: "folder.badge.person.crop")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .edgesIgnoringSafeArea(.all)
                .environmentObject(reset)
                .environmentObject(theme)
                .onAppear(perform: {
                    UITabBar.appearance().backgroundColor = UIColor.clear
                    let colorfulAppearance = UINavigationBarAppearance()
                    colorfulAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primary)]
                    UINavigationBar.appearance().standardAppearance = colorfulAppearance
                })
                .accentColor(Color(UIColor.systemBlue))
            } else if theme.theme == 1 {
                //Light
                TabView() {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    GameplayView()
                        .tabItem {
                            Label("Game Time", systemImage: "gamecontroller")
                        }
                    ScoresView()
                        .tabItem {
                            Label("All Scores", systemImage: "folder.badge.person.crop")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .edgesIgnoringSafeArea(.all)
                .environmentObject(reset)
                .environmentObject(theme)
                .preferredColorScheme(.light)
                .onAppear(perform: {
                    UITabBar.appearance().backgroundColor = UIColor.clear
                    let colorfulAppearance = UINavigationBarAppearance()
                    colorfulAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
                    UINavigationBar.appearance().standardAppearance = colorfulAppearance
                })
                .accentColor(Color(UIColor.systemBlue))
            } else if theme.theme == 2 {
                //Dark
                TabView() {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    GameplayView()
                        .tabItem {
                            Label("Game Time", systemImage: "gamecontroller")
                        }
                    ScoresView()
                        .tabItem {
                            Label("All Scores", systemImage: "folder.badge.person.crop")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .edgesIgnoringSafeArea(.all)
                .environmentObject(reset)
                .environmentObject(theme)
                .preferredColorScheme(.dark)
                .onAppear(perform: {
                    UITabBar.appearance().backgroundColor = UIColor.clear
                    let colorfulAppearance = UINavigationBarAppearance()
                    colorfulAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().standardAppearance = colorfulAppearance
                })
                .accentColor(Color(UIColor.systemBlue))
            } else {
                //Colorful
                
                TabView() {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    GameplayView()
                        .tabItem {
                            Label("Game Time", systemImage: "gamecontroller")
                        }
                    ScoresView()
                        .tabItem {
                            Label("All Scores", systemImage: "folder.badge.person.crop")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
                .edgesIgnoringSafeArea(.all)
                .environmentObject(reset)
                .environmentObject(theme)
                .preferredColorScheme(.light)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    UITabBar.appearance().backgroundColor = UIColor.white
                    let colorfulAppearance = UINavigationBarAppearance()
                    colorfulAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().standardAppearance = colorfulAppearance
                })
                .accentColor(Color(UIColor.systemBlue))
            }
            
        }
        } .onAppear(perform: {
            if appThemeFile.isEmpty {
                ColorTheme.saveToFile([ColorTheme(number: 0)])
            } else {
                theme.theme = appThemeFile[0].number
            }
        })
            .edgesIgnoringSafeArea(.all)
    }
  
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}

    extension  UITextField {
       @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
          self.resignFirstResponder()
       }
    }


    class ResetApp: ObservableObject {
        @Published var animate = false
    }

    class colorThemeSetting: ObservableObject {
        @Published var theme = 0
    }
    

struct BackgroundOld: View {
    
    var color1: String
    var color2: String
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}



struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
