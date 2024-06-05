import SwiftUI

struct OnboardingCard: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let secondImageName: String?
    let articleText: String
    let hasToggle: Bool
    let hasImagePicker: Bool
}
struct CustomTextView: View {
  let text: String

  var body: some View {
    Text(text)
      .font(.custom("GeezaPro", size: 20))
      .foregroundColor(.black)
  }
}

struct OnboardingView: View {
    let cards: [OnboardingCard] = [
        OnboardingCard(title: "Welcome to Monal !",
                       description: "Privacy like its 1999 🔒",
                       imageName: "hand.wave",
                       secondImageName: "person.crop.circle.fill", // Add second image name here
                       articleText: """
                       Modern iOS and MacOS XMPP chat client.
                       
                       """,
                       
                       hasToggle: false,
                       hasImagePicker: false),
        OnboardingCard(title: "Features",
                       description: "Here’s a quick look at what you can expect:",
                       imageName: "sparkles",
                       secondImageName: nil, // No second image for this card
                       articleText: """
                        • 🔐 OMEMO Encryption : Secure multi-end messaging using the OMEMO protocol..
                        
                        • 🛜 Decentralized Network : Leverages the decentralized nature of XMPP, avoiding central servers.

                        • 🌐 Data privacy : We do not sell or track information for external parties (nor for anyone else).
                        
                        • 👨‍💻 Open Source : The app’s source code is publicly available for audit and contribution.
                        
                        """,
                       hasToggle: false,
                       hasImagePicker: false),
        OnboardingCard(title: "Get Started",
                       description: "Some important settings -",
                       imageName: "rocket",
                       secondImageName: nil, // No second image for this card
                       articleText: "Insert stuff here.",
                       hasToggle: true,
                       hasImagePicker: true)
    ]
    
    @State private var currentIndex = 0
    @State private var toggleStates: [Bool] = [false, false, false]
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(cards.indices, id: \.self) { index in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: cards[index].imageName)
                                    .font(.custom("MarkerFelt-Wide", size: 80))
                                    .foregroundColor(.blue)
                                    .padding()
                                Spacer()
                                
                                
                                if let secondImageName = cards[index].secondImageName {
                                    Image(systemName: secondImageName)
                                        .font(.system(size: 60))
                                        .foregroundColor(.blue)
                                        .padding()
                                        
                                }
                            }
                            Text(cards[index].title)
                                            .font(.title)
                                            .fontWeight(.bold)
                            

                            CustomTextView(text: cards[index].description)
                                            .multilineTextAlignment(.leading)
                                            .bold()
                            
                            Divider()
                            
                            CustomTextView(text: cards[index].articleText)
                                           .multilineTextAlignment(.leading)
                                           
                            
                            if cards[index].hasToggle {
                                Toggle("Enable Notifications", isOn: $toggleStates[index])
                                    .padding()
                            }
                            
                            if cards[index].hasImagePicker {
                                ImagePicker(selectedImage: $selectedImage)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
            .frame(width: 350, height: 650)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
            
            HStack {
                Button(action: {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
                }
                
                Spacer()
                
                Button(action: {
                    if currentIndex < cards.count - 1 {
                        currentIndex += 1
                    }
                }) {
                    Text("Next")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
                }
            }
            .padding()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = false
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
