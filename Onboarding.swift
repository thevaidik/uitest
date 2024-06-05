//import SwiftUI
//
//struct OnboardingCard: Identifiable {
//    let id = UUID()
//    let title: String
//    let description: String
//}
//
//struct OnboardingView: View {
//    let cards: [OnboardingCard] = [
//        OnboardingCard(title: "Welcome", description: "This is the first card in the onboarding experience."),
//        OnboardingCard(title: "Features", description: "This card showcases some key features of the app. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor, magna a ullamcorper congue, magna nunc euismod magna, id volutpat libero enim sed tellus."),
//        OnboardingCard(title: "Get Started", description: "This is the final card. You're now ready to get started!")
//    ]
//    
//    @State private var currentIndex = 0
//    
//    var body: some View {
//        VStack {
//            TabView(selection: $currentIndex) {
//                ForEach(cards.indices, id: \.self) { index in
//                    VStack {
//                        ScrollView {
//                            VStack(alignment: .leading, spacing: 16) {
//                                Text(cards[index].title)
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                
//                                Text(cards[index].description)
//                                    .multilineTextAlignment(.leading)
//                            }
//                            .padding()
//                        }
//                    }
//                    .frame(width:370 ,height: 650) // Set a fixed height for the cards
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
//            
//            HStack {
//                Button(action: {
//                    if currentIndex > 0 {
//                        currentIndex -= 1
//                    }
//                }) {
//                    Text("Back")
//                        .foregroundColor(.blue)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 3, y: 3)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    if currentIndex < cards.count - 1 {
//                        currentIndex += 1
//                    }
//                }) {
//                    Text("Next")
//                        .foregroundColor(.blue)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
