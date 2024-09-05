import SwiftUI

struct CourseDetailsView: View {
    
    @Environment(\.presentationMode) var presMode
    var courseItem: CourseItem
    @Binding var title: String
    @Binding var visibleBackBtn: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Image(courseItem.image)
                    .resizable()
                    .frame(width: 350, height: 350)
                    .cornerRadius(52)
                
                Text(courseItem.desc)
                    .font(.custom("Gilroy-Light", size: 18))
                    .foregroundColor(.white)
                    .padding(24)
            }
        }
        .background(
            Rectangle()
                .fill(Color.init(red: 31/255, green: 33/255, blue: 46/255))
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("back_btn")), perform: { _ in
            presMode.wrappedValue.dismiss()
        })
        .onAppear {
            title = courseItem.title
            visibleBackBtn = true
        }
        .onDisappear {
            visibleBackBtn = false
        }
    }
    
}

#Preview {
    CourseDetailsView(courseItem: CourseItem(
        id: 1,
        title: "Risk Management: Protecting Your Capital",
        desc: """
        Risk management is the bedrock of any successful trading strategy. Without it, even the best trading system can lead to devastating losses. The first step in risk management is to assess how much of your capital you’re willing to put at risk on each trade. The 1-2% rule is a common guideline: this means that if you have $10,000 in your trading account, you should not risk more than $100-$200 on a single trade. This limits your exposure and ensures that a series of losses won't wipe out your account. Additionally, using stop-loss orders is crucial. These orders automatically sell a security when it reaches a certain price, limiting the potential loss on a trade. Moreover, diversifying your investments across different assets or markets can also reduce risk, as it minimizes the impact of a poor performance in a single area. The goal is to protect your capital so you can continue trading and take advantage of profitable opportunities.
        """,
        image: "course_image_1"
    ), title: .constant("Risk Management: Protecting Your Capital"), visibleBackBtn: .constant(true))
}
