import XCTest
@testable import SoundsKit

final class SoundsKitTests: XCTestCase {
    //let userDefaults = UserDefaults.standard
    var soundKit: SoundsKit?
    
    let userDefaults = UserDefaults.standard
    let bundle = Bundle.module

    
    override func setUp() {
        super.setUp()
        SoundsKit.file = ""
        SoundsKit.fileExtension = ""
    }
    
    override func tearDown() {
        soundKit = nil
        userDefaults.removeObject(forKey: "sound")
        userDefaults.removeObject(forKey: "onboarding")
        userDefaults.synchronize()
    }
    
    //MARK: setKeyAudio function test
    func test_setKeyAudio_trueKey(){
        //Given
        userDefaults.set(false, forKey: "sound")
        //When
        SoundsKit.setKeyAudio(true)
        //Then
        XCTAssertTrue((userDefaults.value(forKey: "sound") != nil))
    }
    
    func test_setKeyAudio_falseKey(){
        //Given
        userDefaults.set(true, forKey: "sound")
        //When
        SoundsKit.setKeyAudio(false)
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), false)
    }
    
    //MARK: audioIsOn function test
    func test_audioIsOn_trueCondicional() {
        //Given
        SoundsKit.setKeyAudio(true)
        let sut = SoundsKit.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sut))
    }
    
    func test_audioIsOn_falseCondicional() {
        //Given
        SoundsKit.setKeyAudio(false)
        let sut = SoundsKit.audioIsOn()
        //Then
        XCTAssertFalse(try XCTUnwrap(sut))
    }
    
    func test_audioIsOn_nilCondicional() {
        //Given
        userDefaults.removeObject(forKey: "sound")
        userDefaults.synchronize()
        let sut = SoundsKit.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sut))
    }

    //MARK: Play function test
    func test_play() {
        //Given
        SoundsKit.file = "test"
        SoundsKit.fileExtension = "wav"
        //Then
        XCTAssertNoThrow(try SoundsKit.play(bundle: bundle))
    }
    
    func test_play_withError() {
        //Given
        SoundsKit.file = "nonexistent"
        SoundsKit.fileExtension = "wav"
        //When
        XCTAssertThrowsError(try SoundsKit.play(bundle: bundle)) { error in
        //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }
    
    func test_play_withErrorBundle() {
        //Given
        SoundsKit.file = "nonexistent"
        SoundsKit.fileExtension = "wav"
        //When
        XCTAssertThrowsError(try SoundsKit.play()) { error in
        //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }
    
    func test_play_withErrorFileExtension() {
        //Given
        SoundsKit.file = "corrupt"
        SoundsKit.fileExtension = "pdf"
        //When
        XCTAssertThrowsError(try SoundsKit.play(bundle: bundle)) { error in
            //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedSetAudio)
        }
    }
    
    //MARK: Check Play Background Function Letrando
    func test_playBackgroundLetrando() {
        //When
        try? SoundsKit.playBackgroundLetrando()
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), false)
        
    }
    
    //MARK: Check Play Onboarding Function Letrando
    func test_playOnboardingLetrando_withErrorFileExtension() {
        //Given
        let index = 6
        //When
        XCTAssertThrowsError(try SoundsKit.playOnboardingLetrando(at: index)) { error in
            //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }
    
    func test_playOnboardingLetrando() {
        //Given
        let numberOfSoundOnboarding = 1
        //When
        try? SoundsKit.playOnboardingLetrando(at: numberOfSoundOnboarding)
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), true)
    }

    //MARK: Check Play Background Function Formando
    func test_playBackgroundFormando() {
        //When
        try? SoundsKit.playBackgroundFormando()
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), false)
        
    }

    //MARK: Check Play Onboarding Function Formando
    func test_playOnboardingFormando_withErrorFileExtension() {
        //Given
        let index = 6
        //When
        XCTAssertThrowsError(try SoundsKit.playOnboardingFormando(at: index)) { error in
            //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }

    func test_playOnboardingFormando() {
        //Given
        let numberOfSoundOnboarding = 1
        //When
        try? SoundsKit.playOnboardingFormando(at: numberOfSoundOnboarding)
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), true)
    }
    
    func test_finishOnboarding_falseCondicional() {
        //Given
        let numberOfSoundOnboarding = 3
        //When
        SoundsKit.finishOnboarding(at: numberOfSoundOnboarding)
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), false)
    }
    
    func test_finishOnboarding_trueCondicional() {
        //Given
        let numberOfSoundOnboarding = 1
        //When
        SoundsKit.finishOnboarding(at: numberOfSoundOnboarding)
        //Then
        XCTAssertEqual(SoundsKit.audioIsOn(), true)
    }
    
    func test_isFinishOnboarding_trueCondicional() {
        //Given
        let numberOfSoundOnboarding = 3
        //When
        SoundsKit.finishOnboarding(at: numberOfSoundOnboarding)
        //Then
        XCTAssertTrue(SoundsKit.isFinishOnboarding())
    }
    
    func test_isFinishOnboarding_falseCondicional() {
        //Given
        let numberOfSoundOnboarding = 1
        //When
        SoundsKit.finishOnboarding(at: numberOfSoundOnboarding)
        //Then
        XCTAssertFalse(SoundsKit.isFinishOnboarding())
    }
    
    func test_isFinishOnboarding_nilCondicional() {
        //Given
        userDefaults.removeObject(forKey: "onboarding")
        userDefaults.synchronize()
        //Then
        XCTAssertFalse(SoundsKit.isFinishOnboarding())
    }

    //MARK: Check sound file
    func test_file_created() {
        //Given
        let file = bundle.url(forResource: "test", withExtension: "wav")
        //Then
       XCTAssertNotNil(file)

    }

    func test_file_createdInstanceNonExistent() {
        //Given
        let file = bundle.url(forResource: "nonexistent", withExtension: "wav")
        //Then
        XCTAssertNil(file)
    }
    
    //MARK: Stop function test
    func test_stop() {
        //Given
        SoundsKit.file = "test"
        SoundsKit.fileExtension = "wav"
        //When
        try? SoundsKit.play(bundle: bundle)
        let sutOn = SoundsKit.audioIsOn()
        XCTAssertFalse(try XCTUnwrap(sutOn))
        SoundsKit.stop()
        let sutOff = SoundsKit.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sutOff))
    }
    
    //MARK: Pause function test
    func test_pause() {
        //Given
        SoundsKit.file = "test"
        SoundsKit.fileExtension = "wav"
        //When
        try? SoundsKit.play(bundle: bundle)
        let sutOn = SoundsKit.audioIsOn()
        XCTAssertFalse(try XCTUnwrap(sutOn))
        SoundsKit.pause()
        let sutOff = SoundsKit.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sutOff))
    }


    //MARK: Reproduce Speech function test
    func test_reproduceSpeech_withoutError() {
        //Given
        let word = "A casa ?? bela"
        //When
        let synthesizer = SoundsKit.reproduceSpeech(word)
        SoundsKit.reproduceSpeech(word)
        //Then
        XCTAssertFalse(try XCTUnwrap(synthesizer.isPaused))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
        }
    }

}

