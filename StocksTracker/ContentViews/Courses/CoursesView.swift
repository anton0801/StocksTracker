import SwiftUI

struct CoursesView: View {
    
    var coursesManager = CoursesManager()
    @StateObject var subsManager = SubscriptionManager()
    
    @Binding var title: String
    @Binding var visibleToolbar: Bool
    @Binding var visibleBackBtn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(coursesManager.courses, id: \.id) { course in
                    if subsManager.buyedSub {
                        NavigationLink(destination: CourseDetailsView(courseItem: course, title: $title, visibleBackBtn: $visibleBackBtn)
                            .navigationBarBackButtonHidden(true)) {
                            CourseItemView(course: course)
                        }
                    } else {
                        NavigationLink(destination: PaywallView(visibleToolbar: $visibleToolbar)
                            .environmentObject(subsManager)
                            .navigationBarBackButtonHidden(true)) {
                            CourseItemView(course: course)
                        }
                    }
                }
                Spacer()
            }
            .background(
                Rectangle()
                    .fill(Color.init(red: 31/255, green: 33/255, blue: 46/255))
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .onAppear {
                title = "Cours"
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CoursesView(title: .constant("Cours"), visibleToolbar: .constant(false), visibleBackBtn: .constant(false))
}

struct CourseItemView: View {
    
    var course: CourseItem
    
    var body: some View {
        HStack {
            Text("Topic \(course.id). \(course.title)")
                .font(.custom("Gilroy-ExtraBold", size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .frame(width: 340)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .fill(Color.init(red: 41/255, green: 49/255, blue: 68/255))
                .frame(height: 80)
        )
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
    }
    
}
