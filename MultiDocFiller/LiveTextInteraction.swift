//
//  LiveTextInteraction.swift
//  MultiDocFiller
//
//  Created by Janiece Eleonour on 03.06.2024.
//

import UIKit
import SwiftUI
import VisionKit

@MainActor
struct LiveTextInteraction: UIViewRepresentable {
    
    var imageName: String
    let imageView = LiveTextImageView()
    let analyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()
    
    func makeUIView(context: Context) -> some UIView {
        imageView.image = UIImage(named: imageName)
        
        imageView.addInteraction(interaction)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        Task {
            let configuration = ImageAnalyzer.Configuration([.text])
            do {
                if let image = imageView.image {
                    let analysis = try await analyzer.analyze(image, configuration: configuration)
                    interaction.analysis = analysis;
                    interaction.preferredInteractionTypes = .textSelection
                }
            }
            catch {
                // Handle error…
            }
        }
    }
}

class LiveTextImageView: UIImageView {
    // Use intrinsicContentSize to change the default image size
    // so that we can change the size in our SwiftUI View
    override var intrinsicContentSize: CGSize {
        .zero
    }
}
