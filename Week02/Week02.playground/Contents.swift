// barcode generator
// https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863643
// this helps me better understand UI Image Renderer

import UIKit
import PlaygroundSupport

let sz = CGSize(width: 1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: sz)


var x = 0.0
var y = 0.0


let image = renderer.image { context in

    while x <= 1024.0 {
        var strokeWeight = CGFloat.random(in:3...40)
        var gap = CGFloat.random(in:0...20)
        context.cgContext.setLineWidth(strokeWeight)
        if strokeWeight <= 23 {
            context.cgContext.setStrokeColor(UIColor.red.cgColor)
        } else if strokeWeight <= 35 {
            context.cgContext.setStrokeColor(UIColor.blue.cgColor)
        } else {
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
        }
        context.cgContext.move(to: CGPoint(x:x, y:0))
        context.cgContext.addLine(to: CGPoint(x:x, y:1024))
        context.cgContext.drawPath(using: .fillStroke)
        x = x + gap + strokeWeight
    }
    
}

image

//https://www.hackingwithswift.com/example-code/media/how-to-save-a-uiimage-to-a-file-using-jpegdata-and-pngdata

//not working
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

if let image = UIImage(named: "example.png") {
    if let data = image.pngData() {
        let filename = getDocumentsDirectory().appendingPathComponent("Barcode.png")
        try? data.write(to: filename)
    }
}
