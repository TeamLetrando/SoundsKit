import AVFoundation
import Foundation

open class SoundsKit {
    
    var file: String
    var fileExtension: String
    
    var audioPlayer: AVAudioPlayer?
    
    let userDefaults = UserDefaults.standard
    
    init(file: String, fileExtention: String) {
        self.file = file
        self.fileExtension = fileExtention
    }
    
    ///
    public func setKeyAudio(_ key: Bool){
        userDefaults.set(key, forKey: "sound")
    }

    /// Globally check enable or disable sound.
    public func audioIsOn() -> Bool {
        if userDefaults.object(forKey: "sound") == nil {
            setKeyAudio(true)
        }
        return userDefaults.bool(forKey: "sound")
    }
    
    /// Play sound from a sound file.
    public func play(bundle: Bundle = Bundle.main) throws {
            /// Sound session. The default value is the shared `AVAudioSession` session with `ambient` category.
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.ambient)
            try audioSession.setActive(true)
        guard let url = bundle.url(forResource: file, withExtension: fileExtension) else {
                throw ErrorSound.failedBundle
            }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            setKeyAudio(true)
            audioPlayer?.play()
        } catch {
            throw ErrorSound.failedSetAudio
        }
    }
    
    /// Stop playing the sound.
    public func stop() {
        setKeyAudio(false)
        audioPlayer?.stop()
    }
    
    /// Reproduce speech from a word or letter.
    @discardableResult
    public func reproduceSpeech(_ text:String, language: String = "pt-BR", delegate: AVSpeechSynthesizerDelegate? = nil) -> AVSpeechSynthesizer {
        let utterance =  AVSpeechUtterance(string: text)
        let voice = AVSpeechSynthesisVoice(language: language)
        utterance.voice = voice
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = delegate
        synthesizer.speak(utterance)
        return synthesizer
    }
}

    public enum ErrorSound : Error {
            case failedSetAudio
            case failedBundle
            case failedUserDefaultSound
    }
