import SwiftUI

struct SplashView: View {
    
    @StateObject var stocksManager = StocksApiManager()
    
    @State var loadedStocks: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                LottieView(filename: "loading_splash_anim")
                    .frame(width: 300, height: 300)
                
                if !stocksManager.isLoading {
                    Text("")
                        .onAppear {
                            loadedStocks = true
                        }
                }
                
                NavigationLink(destination: MainView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(stocksManager), isActive: $loadedStocks) {
                    
                }
            }
            .onAppear {
                stocksManager.fetchStockDetails()
            }
            .background(
                Rectangle()
                    .fill(Color.init(red: 31/255, green: 33/255, blue: 46/255))
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SplashView()
}
