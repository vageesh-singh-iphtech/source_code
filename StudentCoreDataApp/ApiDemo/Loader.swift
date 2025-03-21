//
//  Loader.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 20/03/25.
//


import Foundation
import UIKit
public class Loader {

    public static let shared = Loader()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    
    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
       // indicator.style = .whiteLarge
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .darkGray
    }
    /*
    func show() {
        DispatchQueue.main.async( execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }

    func hide() {
        DispatchQueue.main.async(execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }*/
    
    
    
    private func getActiveWindow() -> UIWindow? {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        }

        func show() {
            DispatchQueue.main.async {
                guard let window = self.getActiveWindow() else { return }
                window.addSubview(self.blurImg)
                window.addSubview(self.indicator)
            }
        }

        func hide() {
            DispatchQueue.main.async {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
            }
        }
}

