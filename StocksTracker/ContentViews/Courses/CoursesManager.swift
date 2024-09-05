import Foundation

struct CourseItem {
    let id: Int
    let title: String
    let desc: String
    let image: String
}

class CoursesManager {
    var courses: [CourseItem] = [
        CourseItem(
            id: 1,
            title: "Risk Management: Protecting Your Capital",
            desc: """
            Risk management is the bedrock of any successful trading strategy. Without it, even the best trading system can lead to devastating losses. The first step in risk management is to assess how much of your capital you’re willing to put at risk on each trade. The 1-2% rule is a common guideline: this means that if you have $10,000 in your trading account, you should not risk more than $100-$200 on a single trade. This limits your exposure and ensures that a series of losses won't wipe out your account. Additionally, using stop-loss orders is crucial. These orders automatically sell a security when it reaches a certain price, limiting the potential loss on a trade. Moreover, diversifying your investments across different assets or markets can also reduce risk, as it minimizes the impact of a poor performance in a single area. The goal is to protect your capital so you can continue trading and take advantage of profitable opportunities.
            """,
            image: "course_image_1"
        ),
        CourseItem(
            id: 2,
            title: "Technical Analysis: Reading the Charts",
            desc: """
            Technical analysis is the study of price movements and chart patterns to forecast future market behavior. It's a critical tool for traders looking to make short-term gains. The core principle of technical analysis is that all known information is already reflected in the price, so by studying historical price data, traders can predict future movements. Learning to read charts involves understanding different time frames, recognizing patterns like head and shoulders or double tops, and identifying trends, which can be upward, downward, or sideways. Indicators such as Moving Averages help smooth out price data to identify the direction of the trend, while tools like the Relative Strength Index (RSI) and Moving Average Convergence Divergence (MACD) can signal overbought or oversold conditions, helping traders decide when to enter or exit a trade. Volume analysis, which tracks the number of shares or contracts traded, can also provide clues about the strength of a price movement. By mastering these tools, traders can make more informed decisions and increase their chances of success.
            """,
            image: "course_image_2"
        ),
        CourseItem(
            id: 3,
            title: "Fundamental Analysis: Understanding Market Forces",
            desc: """
            Fundamental analysis is about digging deeper into the underlying factors that influence an asset's price. For stocks, this means analyzing a company’s financial health, including its revenue, earnings, profit margins, and debt levels. Key financial ratios such as Price-to-Earnings (P/E) and Return on Equity (ROE) offer insights into a company’s valuation and profitability. Beyond individual companies, macroeconomic factors play a significant role in fundamental analysis. Interest rates, inflation, and unemployment rates are just a few of the indicators that can influence market sentiment and drive price movements. For currency traders, monitoring central bank policies, trade balances, and geopolitical events is critical. By understanding how these factors interact, traders can make more informed decisions and identify long-term investment opportunities. Unlike technical analysis, which focuses on short-term price movements, fundamental analysis helps traders understand the intrinsic value of an asset and its potential for growth over time.
            """,
            image: "course_image_3"
        ),
        CourseItem(
            id: 4,
            title: "Trading Psychology: Mastering Your Emotions",
            desc: """
            Trading psychology is often what separates successful traders from the rest. Emotions such as fear, greed, and hope can cloud judgment and lead to impulsive decisions. Fear might cause you to exit a trade too early, missing out on potential profits, while greed can push you to hold onto a losing position in the hope that the market will turn in your favor. To master trading psychology, it's essential to develop a disciplined mindset. This means adhering to your trading plan and not letting emotions dictate your actions. Journaling your trades can be a helpful practice; by reviewing your decisions and the emotions behind them, you can learn to recognize and control these emotional triggers. Another key aspect is managing stress, which is inherent in trading due to market volatility. Techniques such as deep breathing, meditation, or even regular exercise can help maintain a calm and focused mind. By cultivating emotional resilience, you can stay objective, make rational decisions, and ultimately improve your trading performance.
            """,
            image: "course_image_4"
        ),
        CourseItem(
            id: 5,
            title: "Developing a Trading Strategy: Planning Your Trades",
            desc: """
A robust trading strategy is like a roadmap that guides your decisions and helps you stay on course. It starts with clearly defined rules for entering and exiting trades, which are based on both technical and fundamental analysis. For example, you might decide to enter a trade when a stock breaks above a key resistance level, and exit if it falls back below a certain price point. Your strategy should also include rules for setting stop-loss orders to protect against unexpected market moves. Position sizing is another critical component; it determines how much of your capital you will allocate to a single trade. This helps manage risk and ensures that no single trade has the potential to significantly harm your account balance. Backtesting your strategy using historical data is essential to see how it would have performed in the past and to make necessary adjustments. Once you’ve developed a strategy, it’s crucial to stick to it consistently, even when the market gets volatile. This discipline is key to long-term success, as it reduces the impact of emotional decisions and helps you navigate the complexities of the trading world with confidence.
""",
            image: "course_image_5"
        )
    ]
    
    func getCourses() -> [CourseItem] {
        return courses
    }
    
}
