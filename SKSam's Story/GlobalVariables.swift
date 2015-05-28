import Foundation
import AVFoundation

var musicSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music0", ofType: "mp3")!)
var musicPlayer = AVAudioPlayer()

var soundPlayer = AVAudioPlayer()