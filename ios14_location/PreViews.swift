//
//  PreViews.swift
//  ios14_location
//
//  Created by koji torishima on 2020/07/16.
//

import UIKit

#if DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}

#endif
