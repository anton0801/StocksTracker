import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var stocksManager: StocksApiManager
    
    @State var visibleSettings = false
    
    @State var selection = 0
    @State var title: String = "Funds"
    @State var visibleToolbar = true
    @State var visibleBackBtn = false
    
    var body: some View {
        ZStack {
            VStack {
                if visibleToolbar {
                    HStack {
                        if visibleBackBtn {
                            Button {
                                NotificationCenter.default.post(name: Notification.Name("back_btn"), object: nil)
                            } label: {
                                Image("back_btn")
                            }
                        }
                        
                        Spacer()
                        
                        Text(title)
                            .font(.custom("Gilroy-ExtraBold", size: 24))
                            .foregroundColor(.white)
                            .offset(x: 20)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                visibleSettings = true
                            }
                        } label: {
                            Image("settings")
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 55, trailing: 12))
                }
                
                TabView(selection: $selection) {
                    ContentView(title: $title)
                        .environmentObject(stocksManager)
                        .tabItem {
                            Image("funds")
                            Text("Funds")
                                .font(.custom("Gilroy-Light", size: 24))
                        }
                        .tag(0)
                    CoursesView(title: $title, visibleToolbar: $visibleToolbar, visibleBackBtn: $visibleBackBtn)
                        .tabItem {
                            Image("courses")
                            Text("Courses")
                                .font(.custom("Gilroy-Light", size: 24))
                                .foregroundColor(Color.init(red: 141/255, green: 165/255, blue: 191/255))
                        }
                        .tag(1)
//                    ContentView()
//                        .tabItem {
//                            Image("my_assets")
//                            Text("My assets")
//                                .font(.custom("Gilroy-Light", size: 24))
//                        }
//                        .tag(1)
                }
                .accentColor(.white)
            }
        }
        .preferredColorScheme(.dark)
        .background(
            Image("screen_back")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MainView()
        .environmentObject(StocksApiManager())
}
