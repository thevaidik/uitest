//import SwiftUI
//import AVKit
//import AVFoundation
//
//struct MediaGalleryView: View {
//    @State private var mediaItems: [MediaItem] = []
//    let contact: String
//    let accountNo: NSNumber
//    
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
//                ForEach(mediaItems) { item in
//                    NavigationLink(destination: MediaItemSwipeView(currentItem: item, allItems: mediaItems)) {
//                        MediaItemView(item: item)
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Media Gallery")
//        .onAppear {
//            loadMediaItems()
//        }
//    }
//    
//    private func loadMediaItems() {
//        if let attachments = DataLayer.sharedInstance().allAttachments(fromContact: contact, forAccount: accountNo) as? [[String: Any]] {
//            mediaItems = attachments.compactMap { fileInfo in
//                if let mimeType = fileInfo["mimeType"] as? String, mimeType.starts(with: "image/") || mimeType.starts(with: "video/") {
//                    return MediaItem(fileInfo: fileInfo)
//                }
//                return nil
//            }
//        }
//    }
//}
//
//class MediaItem: Identifiable, ObservableObject {
//    let id = UUID()
//    let fileInfo: [String: Any]
//    @Published var thumbnail: UIImage?
//    
//    init(fileInfo: [String: Any]) {
//        self.fileInfo = fileInfo
//        self.thumbnail = generateThumbnail()
//    }
//    
//    func generateThumbnail() -> UIImage? {
//        guard let cacheFile = fileInfo["cacheFile"] as? String,
//              let mimeType = fileInfo["mimeType"] as? String else {
//            print("Failed to get cacheFile or mimeType")
//            return UIImage(systemName: "exclamationmark.triangle")
//        }
//        
//        if mimeType.starts(with: "image/") {
//            if let image = UIImage(contentsOfFile: cacheFile)?.thumbnail(size: CGSize(width: 100, height: 100)) {
//                return image
//            } else {
//                print("Failed to generate image thumbnail for: \(cacheFile)")
//                return UIImage(systemName: "photo")
//            }
//        } else if mimeType.starts(with: "video/") {
//            let movieURL = URL(fileURLWithPath: cacheFile)
//            if let thumbnail = imagePreview(from: movieURL, in: 1) {
//                return thumbnail.thumbnail(size: CGSize(width: 100, height: 100))
//            } else {
//                print("Failed to generate video thumbnail for: \(cacheFile)")
//                return UIImage(systemName: "video")
//            }
//        } else {
//            print("Unsupported mime type: \(mimeType)")
//            return UIImage(systemName: "doc")
//        }
//    }
//    
//    func imagePreview(from moviePath: URL, in seconds: Double) -> UIImage? {
//        let asset = AVURLAsset(url: moviePath)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        imageGenerator.appliesPreferredTrackTransform = true
//        
//        let time = CMTime(seconds: seconds, preferredTimescale: 600)
//        do {
//            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//            return UIImage(cgImage: cgImage)
//        } catch {
//            print("Error generating thumbnail: \(error)")
//            return nil
//        }
//    }
//    
//    func getValue<T>(_ key: String, as type: T.Type) -> T? {
//        return fileInfo[key] as? T
//    }
//    
//    func getFilePath() -> String? {
//        return getValue("cacheFile", as: String.self)
//    }
//    
//    func getMimeType() -> String? {
//        return getValue("mimeType", as: String.self)
//    }
//    
//    func getFileName() -> String? {
//        return getValue("filename", as: String.self)
//    }
//}
//
//struct MediaItemView: View {
//    let item: MediaItem
//    
//    var body: some View {
//        Group {
//            if let thumbnail = item.thumbnail {
//                Image(uiImage: thumbnail)
//                    .resizable()
//                    .scaledToFill()
//            } else {
//                Image(systemName: "exclamationmark.triangle")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.red)
//            }
//        }
//        .frame(width: 100, height: 100)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//    }
//}
//
//struct MediaItemSwipeView: View {
//    @State private var currentIndex: Int
//    let allItems: [MediaItem]
//    
//    init(currentItem: MediaItem, allItems: [MediaItem]) {
//        self._currentIndex = State(initialValue: allItems.firstIndex(where: { $0.id == currentItem.id }) ?? 0)
//        self.allItems = allItems
//    }
//    
//    var body: some View {
//        TabView(selection: $currentIndex) {
//            ForEach(allItems.indices, id: \.self) { index in
//                MediaItemDetailView(item: allItems[index])
//                    .tag(index)
//            }
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        .animation(.easeInOut, value: currentIndex)
//        .navigationTitle(allItems[currentIndex].getFileName() ?? "Media Item")
//    }
//}
//
//struct MediaItemDetailView: View {
//    let item: MediaItem
//    @StateObject private var customPlayer = CustomAVPlayer()
//    @State private var isPlayerReady = false
//    
//    var body: some View {
//        Group {
//            if let mimeType = item.getMimeType(),
//               let filePath = item.getFilePath() {
//                if mimeType.starts(with: "image/") {
//                    ImageViewerWrapper(info: item.fileInfo as [String: AnyObject])
//                }
//                else if mimeType.starts(with: "video/") {
//                    if isPlayerReady, let playerViewController = customPlayer.playerViewController {
//                        AVPlayerControllerRepresentable(playerViewController: playerViewController)
//                    } else {
//                        ProgressView()
//                    }
//                } else {
//                    Text("File type not supported for preview: \(mimeType)")
//                    Text("You can find the file at: \(filePath)")
//                }
//            } else {
//                Text("Invalid file information")
//                Text("mimeType: \(String(describing: item.getMimeType()))")
//                Text("filePath: \(String(describing: item.getFilePath()))")
//            }
//        }
//        .onAppear {
//            if let mimeType = item.getMimeType(),
//               let filePath = item.getFilePath() {
//                customPlayer.configurePlayer(filePath: filePath, mimeType: mimeType)
//                isPlayerReady = true
//            }
//        }
//    }
//}
//
//struct ImageViewerWrapper: View {
//    let info: [String: AnyObject]
//    
//    var body: some View {
//        Group {
//            if let _ = info["mimeType"] as? String {
//                try? ImageViewer(info: info)
//            } else {
//                Text("Invalid image data")
//            }
//        }
//    }
//}
//
//class CustomAVPlayer: ObservableObject {
//    @Published var player: AVPlayer?
//    @Published var playerViewController: AVPlayerViewController?
//    
//    func configurePlayer(filePath: String, mimeType: String) {
//        // Clear existing player
//        player = nil
//        playerViewController = nil
//        
//        // Create URL
//        let videoFileUrl = URL(fileURLWithPath: filePath)
//        
//        // Create asset with MIME type
//        let videoAsset = AVURLAsset(url: videoFileUrl, options: [
//            "AVURLAssetOutOfBandMIMETypeKey": mimeType
//        ])
//        
//        // Create player and player view controller
//        let playerItem = AVPlayerItem(asset: videoAsset)
//        player = AVPlayer(playerItem: playerItem)
//        playerViewController = AVPlayerViewController()
//        playerViewController?.player = player
//        
//        print("Created AVPlayer(\(mimeType)): \(String(describing: player))")
//    }
//}
//
//struct AVPlayerControllerRepresentable: UIViewControllerRepresentable {
//    let playerViewController: AVPlayerViewController
//    
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        return playerViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
//}
//
//extension UIImage {
//    func thumbnail(size: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: size))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}
