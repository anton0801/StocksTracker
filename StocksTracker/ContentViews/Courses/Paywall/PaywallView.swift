import SwiftUI

struct PaywallView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @EnvironmentObject var subsManager: SubscriptionManager
    @Binding var visibleToolbar: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Image("paywall_image_bg")
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Button {
                            presMode.wrappedValue.dismiss()
                        } label: {
                            Image("close")
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                
                VStack {
                    Spacer().frame(height: 350)
                    Text("PREMIUM\nACCOUNT")
                        .font(.custom("Gilroy-ExtraBold", size: 48))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        HStack {
                            Image("done")
                            Text("Advanced analytical tools for more\naccurate trading decisions.")
                                .font(.custom("Gilroy-Light", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                        }
                        .frame(width: 350)
                        HStack {
                            Image("done")
                            Text("Real-time data and instant alerts for\nquick market responses.")
                                .font(.custom("Gilroy-Light", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                        }
                        .frame(width: 350)
                        HStack {
                            Image("done")
                            Text("Personalized support and education\nto enhance trading skills.")
                                .font(.custom("Gilroy-Light", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                        }
                        .frame(width: 350)
                        HStack {
                            Image("done")
                            Text("Exclusive trading opportunities to increase profits.")
                                .font(.custom("Gilroy-Light", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                        }
                        .frame(width: 350)
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                            .fill(Color.init(red: 41/255, green: 49/255, blue: 68/255))
                    )
                    .padding()
                    
                    Button {
                        subsManager.purchaseProduct(product: subsManager.availableProducts[0])
                    } label: {
                        Text("CONTINUE")
                            .font(.custom("Gilroy-Light", size: 16))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                                    .fill(Color.init(red: 14/255, green: 111/255, blue: 231/255))
                            )
                            .padding()
                    }
                    
                    Button {
                        subsManager.restorePurchases()
                    } label: {
                        Text("Restore")
                            .font(.custom("Gilroy-Light", size: 12))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    
                    Text("Every type of subscription gives you full access to all features of the application. By clicking the subscription button, you agree with Terms of Use and Privacy Policy. You will be charged after your FREE 3-day trial. You can cancel at any time up to 24 hours before renewal. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period. Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user’s Account Settings after purchase.")
                        .font(.custom("Gilroy-Light", size: 12))
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            visibleToolbar = false
        }
        .onDisappear {
            visibleToolbar = true
        }
        .background(
            Rectangle()
                .fill(Color.init(red: 31/255, green: 33/255, blue: 46/255))
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    PaywallView(visibleToolbar: .constant(false))
        .environmentObject(SubscriptionManager())
}
