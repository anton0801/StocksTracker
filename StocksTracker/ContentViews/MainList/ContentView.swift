import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var stocksManager: StocksApiManager
    @State var marketStatus = 0.0
    @Binding var title: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Market is \(marketStatus < 0.0 ? "down" : "up")")
                    .font(.custom("Gilroy-Light", size: 24))
                    .foregroundColor(.white)
                
                Text("In the past 24 hours")
                    .font(.custom("Gilroy-ExtraBold", size: 14))
                    .foregroundColor(Color.init(red: 108/255, green: 117/255, blue: 125/255))
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                }
                
                Spacer()
                
                if marketStatus < 0.0 {
                    Text("\(marketStatus.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Gilroy-ExtraBold", size: 40))
                        .foregroundColor(Color.init(red: 217/255, green: 4/255, blue: 41/255))
                } else {
                    Text("+\(marketStatus.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Gilroy-ExtraBold", size: 40))
                        .foregroundColor(Color.init(red: 33/255, green: 191/255, blue: 115/255))
                }
            }
            .padding([.horizontal, .top])
        
            ScrollView {
                ForEach(stocksManager.stocksData.filter { !$0.ticker.isEmpty }.sorted(by: { $0.marketCap > $1.marketCap }), id: \.id) { stockItem in
                    StockItemView(stockItem: stockItem)
                        .environmentObject(stocksManager)
                }
            }
        }
        .background(
            Rectangle()
                .fill(Color.init(red: 31/255, green: 33/255, blue: 46/255))
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .onAppear {
            title = "Funds"
            getMarketStatus()
        }
    }
    
    func getMarketStatus() {
        let marketStatusPercentages = stocksManager.stockPrices.map { $0.preMarketChangePercentage }
        for s in marketStatusPercentages {
            if !s.isNaN {
                marketStatus += s
            }
        }
    }
    
}

#Preview {
    ContentView(title: .constant("Funds"))
        .environmentObject(StocksApiManager())
}
