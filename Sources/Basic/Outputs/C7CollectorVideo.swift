//
//  C7CollectorVideo.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/13.
//

import Foundation

public final class C7CollectorVideo: C7Collector {
    
    private var player: AVPlayer!
    public private(set) var videoOutput: AVPlayerItemVideoOutput!
    
    lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(readBuffer(_:)))
        displayLink.add(to: .current, forMode: RunLoop.Mode.default)
        displayLink.isPaused = true
        return displayLink
    }()
    
    required init(callback: @escaping C7FilterImageCallback) {
        super.init(callback: callback)
        setupVideoOutput()
    }
    
    required init(view: C7View) {
        super.init(view: view)
        setupVideoOutput()
    }
    
    public convenience init(player: AVPlayer, callback: @escaping C7FilterImageCallback) {
        self.init(callback: callback)
        self.player = player
        if let currentItem = player.currentItem {
            currentItem.add(videoOutput)
        }
    }
    
    public convenience init(player: AVPlayer, view: C7View) {
        self.init(view: view)
        self.player = player
        if let currentItem = player.currentItem {
            currentItem.add(videoOutput)
        }
    }
}

extension C7CollectorVideo {
    
    public func play() {
        player.play()
        displayLink.isPaused = false
    }
    
    public func pause() {
        player.pause()
        displayLink.isPaused = true
    }
}

extension C7CollectorVideo {
    
    func setupVideoOutput() {
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: [
            kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)
        ])
    }
    
    @objc func readBuffer(_ sender: CADisplayLink) {
        let time = videoOutput.itemTime(forHostTime: sender.timestamp + sender.duration)
        guard videoOutput.hasNewPixelBuffer(forItemTime: time) else {
            return
        }
        let pixelBuffer = videoOutput.copyPixelBuffer(forItemTime: time, itemTimeForDisplay: nil)
        if let image = pixelBuffer2Image(pixelBuffer) {
            DispatchQueue.main.async { self.callback(image) }
        }
    }
}
