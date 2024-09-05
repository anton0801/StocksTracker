import SwiftUI
import SDWebImageSwiftUI

struct StockItemView: View {
    
    var stockItem: StockItem
    @EnvironmentObject var stocksManager: StocksApiManager
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: "\(stockItem.branding.iconUrl)?apiKey=\(String.apiKey)"))
                .resizable()
                .frame(width: 52, height: 52)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(52)
            
            Text(stockItem.name)
                .font(.custom("Gilroy-ExtraBold", size: 14))
                .foregroundColor(.white)
                .padding(.leading, 4)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                let openClosePrices = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }[0]
                Text("$\(openClosePrices.preMarket.formattedToTwoDecimalPlaces())")
                    .font(.custom("Gilroy-Light", size: 15))
                    .foregroundColor(.white)
                if openClosePrices.preMarketChangePercentage > 0 {
                    Text("+\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Gilroy-Light", size: 11))
                        .padding(.top, 2)
                        .foregroundColor(Color.init(red: 33/255, green: 191/255, blue: 115/255))
                } else {
                    Text("\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Gilroy-Light", size: 11))
                        .padding(.top, 2)
                        .foregroundColor(Color.init(red: 217/255, green: 4/255, blue: 41/255))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .fill(Color.init(red: 41/255, green: 49/255, blue: 68/255))
                .frame(height: 80)
        )
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 1, trailing: 16))
    }
    
}

extension Double {
    func formattedToTwoDecimalPlaces() -> String {
            return String(format: "%.2f", self)
        }
}
