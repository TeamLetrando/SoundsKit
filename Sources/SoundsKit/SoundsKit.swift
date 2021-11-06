import AVFoundation
import Foundation
import SwiftUI

open class SoundsKit{
    
    ///Set sound `file` first play it
    public static var file: String?
    public static var fileExtension: String = "mp3"
    
    private static var audioPlayer: AVAudioPlayer?
    private static var player: AVPlayer?
    private static var bundle = Bundle.module
    
    static let userDefaults = UserDefaults.standard
    
    /// Set first time of sound
    /// - Parameter key: Choose the first state of sound and add  this function into you launch funcion at AppDelegate
    public static func setKeyAudio(_ key: Bool){
        userDefaults.set(key, forKey: "sound")
    }

    /// Globally check enable or disable sound.
    /// - Returns: Return `True` if sound is on or `False` if sound is off.
    public static func audioIsOn() -> Bool {
        if userDefaults.object(forKey: "sound") == nil {
            setKeyAudio(true)
        }
        return userDefaults.bool(forKey: "sound")
    }
    /// Play sound from a sound file.
    /// - Parameter bundle: It's for default a main bundle, but if you need to customize, it's possible with this parameter.
    public static func play(bundle: Bundle = .main) throws {
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
            audioPlayer?.play()
            setKeyAudio(false)
        } catch {
            throw ErrorSound.failedSetAudio
        }
    }
   
    /// Play sound for background Letrando ABC.
    public static func playBackgroundLetrando() throws {
            /// Sound session. The default value is the shared `AVAudioSession` session with `ambient` category.
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.ambient)
            try audioSession.setActive(true)
        guard let url = bundle.url(forResource: "Curious_Kiddo", withExtension: "mp3") else {return}
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.stop()
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            setKeyAudio(false)
        } catch {
            throw ErrorSound.failedSetAudio
        }
    }
    
    /// Play sound for background Letrando ABC.
    /// - Parameter at: Select the audio for each page onboarding
    public static func playOnboardingLetrando(at index: Int) throws {
            /// Sound session. The default value is the shared `AVAudioSession` session with `ambient` category.
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.ambient)
            try audioSession.setActive(true)
        guard let url = bundle.url(forResource: "onboarding\(index)", withExtension: "wav") else {
                throw ErrorSound.failedBundle
            }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.pause()
            audioPlayer?.numberOfLoops = 1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            throw ErrorSound.failedSetAudio
        }
    }
    /// Control Onboarding finish Letrando ABC.
    /// - Parameter at: Select the audio for each page onboarding
    public static func finishOnboarding(at index: Int){
        switch index {
        case 3:
            userDefaults.set(true, forKey: "onboarding")
            SoundsKit.audioIsOn() ? try? SoundsKit.playBackgroundLetrando() : SoundsKit.pause()
        default:
            userDefaults.set(false, forKey: "onboarding")
        }
    }
    
    /// Acess for Control Onboarding finish Letrando ABC.
    public static func isFinishOnboarding() -> Bool {
        if userDefaults.object(forKey: "onboarding") == nil {
            userDefaults.set(false, forKey: "onboarding")
        }
        return userDefaults.bool(forKey: "onboarding")
    }
    
    public static func playAlert() throws {
        /// Sound session. The default value is the shared `AVAudioSession` session with `ambient` category.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.ambient)
        try audioSession.setActive(true)
        guard let url = bundle.url(forResource: "audio01", withExtension: "wav") else {
            throw ErrorSound.failedBundle
        }
        do {
            player = AVPlayer(url: url)
            player?.allowsExternalPlayback = true
            if ((audioPlayer?.isPlaying) != nil) {
                audioPlayer?.setVolume(0.5, fadeDuration: 0.7)
            }
            player?.play()
        }
    }
    
    /// Stop playing the sound.
    public static func stop() {
        audioPlayer?.stop()
        setKeyAudio(true)
    }
    
    /// Pause playing the sound.
    public static func pause() {
        audioPlayer?.pause()
        setKeyAudio(true)
    }

    /// Reproduce speech from a word or letter.
    /// - Parameters:
    ///   - text: the text if you want to speech
    ///   - language: It's for default a  `Portuguese language`, but if you need to customize, it's possible with this parameter.
    @discardableResult
    public static func reproduceSpeech(_ text: String, language: String = "pt-BR") -> AVSpeechSynthesizer {
        let utterance =  AVSpeechUtterance(string: text)
        let voice = AVSpeechSynthesisVoice(language: language)
        utterance.voice = voice
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        return synthesizer
    }
}

    public enum ErrorSound : Error {
            case failedSetAudio
            case failedBundle
            case failedUserDefaultSound
    }
