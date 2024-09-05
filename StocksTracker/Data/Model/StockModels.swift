import Foundation

struct StockItem: Codable, Identifiable {
    let id = UUID().uuidString
    let ticker: String
    let name: String
    let market: String
    let locale: String
    let primaryExchange: String
    let type: String
    let marketCap: Double
    let phoneNumber: String
    let description: String
    let homepageUrl: String
    let branding: StockBranding
    
    enum CodingKeys: String, CodingKey {
        case ticker = "ticker"
        case name = "name"
        case market = "market"
        case locale = "locale"
        case primaryExchange = "primary_exchange"
        case type = "type"
        case marketCap = "market_cap"
        case phoneNumber = "phone_number"
        case description = "description"
        case homepageUrl = "homepage_url"
        case branding = "branding"
    }
}

struct OpenCloseResponse: Codable {
    let symbol: String
    let open: Double
    let high: Double
    let low: Double
    let volume: Int
    let preMarket: Double
    
    var preMarketChangePercentage: Double {
        return ((open - preMarket) / preMarket) * 100
    }
}


struct StockBranding: Codable {
    let logoUrl: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case logoUrl = "logo_url"
        case iconUrl = "icon_url"
    }
}

struct StockDetailsResponse: Codable {
    let results: StockItem
}
