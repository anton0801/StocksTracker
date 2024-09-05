import Foundation
import Combine

extension String {
    static let apiKey = "R2mp0YV3NRlehS447wz7INWEV6jfQzpP"
    static let baseUrl = "https://api.polygon.io/"
}

class StocksApiManager: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    let tickers = [
        "MSFT", "UPS", "AAA", "ABT", "IBM", "ACN", "ADDYY", "AIG", "ALLE", "AMZN", "AAL", "ARMK",
        "CNC", "CVS", "DARDEN", "LMT", "DAL",
        "F", "GM", "GDDY", "GME", "GOOG", "GRUB",
        "T", "TJX", "TM", "TRIP", "TSLA", "AAPL", "ADS",
        "AT&T", "BAX", "BDX", "B", "BXS", "BEST", "BBY",
        "LOW", "LYFT", "MMM", "MCD", "META", "MAR",
        "NKE", "NFLX", "NOC", "ORCL",
        "PEP", "PG", "POST", "PM", "PSTG", "PXD",
        "RCL", "RTX", "RIVN", "SPG",
        "HES", "HBI", "HCA", "HD", "HRB", "HON",
        "JCI", "JPM", "JNJ", "K", "KSS", "KR", "LKQ",
        "UNP", "UPS", "V", "VLO", "VZ",
        "WMT", "XOM", "YUM"
    ]
    
    @Published var stocksData: [StockItem] = []
    @Published var stockPrices: [OpenCloseResponse] = []
    @Published var isLoading: Bool = true
    @Published var error: Error?
    
    func fetchStockDetails() {
        isLoading = true
        let tickerGroups = stride(from: 0, to: tickers.count, by: 20).map {
            Array(tickers[$0..<min($0 + 20, tickers.count)])
        }
        
        let publishers = tickerGroups.map { group in
            fetchGroupDetails(tickers: group)
        }
        
        let publishers2 = tickerGroups.map { group in
            fetchGroupPrices(tickers: group)
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responses in
                self?.stocksData = responses.flatMap { $0 }
                // self?.isLoading = false
            }
            .store(in: &cancellables)
        
        Publishers.MergeMany(publishers2)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responses in
                self?.stockPrices = responses.flatMap { $0 }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    private func fetchGroupDetails(tickers: [String]) -> AnyPublisher<[StockItem], Never> {
        let publishers = tickers.map { ticker in
            fetchStockDetail(ticker: ticker)
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    
    private func fetchGroupPrices(tickers: [String]) -> AnyPublisher<[OpenCloseResponse], Never> {
        let pricePublishers = tickers.map { ticker in
            fetchStockPrice(ticker: ticker)
        }
        
        return Publishers.MergeMany(pricePublishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func fetchStockDetail(ticker: String) -> AnyPublisher<StockItem, Never> {
        guard let url = URL(string: "\(String.baseUrl)v3/reference/tickers/\(ticker)?apiKey=\(String.apiKey)") else {
            return Just(StockItem(ticker: "", name: "", market: "", locale: "", primaryExchange: "", type: "", marketCap: 0.0, phoneNumber: "", description: "", homepageUrl: "", branding: StockBranding(logoUrl: "", iconUrl: "")))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: StockDetailsResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: StockItem(ticker: "", name: "", market: "", locale: "", primaryExchange: "", type: "", marketCap: 0.0, phoneNumber: "", description: "", homepageUrl: "", branding: StockBranding(logoUrl: "", iconUrl: "")))
            .eraseToAnyPublisher()
    }
    
    private func fetchStockPrice(ticker: String) -> AnyPublisher<OpenCloseResponse, Never> {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let date = DateFormatter.yyyyMMdd.string(from: yesterday ?? Date())
        guard let url = URL(string: "\(String.baseUrl)v1/open-close/\(ticker)/\(date)?apiKey=\(String.apiKey)") else {
            return Just(OpenCloseResponse(symbol: "", open: 0.0, high: 0.0, low: 0.0, volume: 0, preMarket: 0.0))
                .eraseToAnyPublisher()
        }
        print(url)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: OpenCloseResponse.self, decoder: JSONDecoder())
            .replaceError(with: OpenCloseResponse(symbol: "", open: 0.0, high: 0.0, low: 0.0, volume: 0, preMarket: 0.0))
            .eraseToAnyPublisher()
    }
}

// Дополнительное расширение для форматирования даты
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
