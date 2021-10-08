import XCTest
@testable import SoundsKit

final class SoundsKitTests: XCTestCase {
    //let userDefaults = UserDefaults.standard
    var soundKit: SoundsKit?
    
    let userDefaults = UserDefaults.standard
    let bundle = Bundle.module

    
    override func setUp() {
        super.setUp()
        soundKit = SoundsKit(file: "", fileExtention: "")
    }
    
    override func tearDown() {
        soundKit = nil
        userDefaults.removeObject(forKey: "sound")
        userDefaults.synchronize()
    }
    
    //MARK: setKeyAudio function test
    func test_setKeyAudio_trueKey(){
        //Given
        userDefaults.set(false, forKey: "sound")
        //When
        soundKit?.setKeyAudio(true)
        //Then
        XCTAssertTrue((userDefaults.value(forKey: "sound") != nil))
    }
    
    func test_setKeyAudio_falseKey(){
        //Given
        userDefaults.set(true, forKey: "sound")
        //When
        soundKit?.setKeyAudio(false)
        //Then
        XCTAssertEqual(soundKit?.audioIsOn(), false)
    }
    
    //MARK: audioIsOn function test
    func test_audioIsOn_trueCondicional() {
        //Given
        soundKit?.setKeyAudio(true)
        let sut = soundKit?.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sut))
    }
    
    func test_audioIsOn_falseCondicional() {
        //Given
        soundKit?.setKeyAudio(false)
        let sut = soundKit?.audioIsOn()
        //Then
        XCTAssertFalse(try XCTUnwrap(sut))
    }
    
    func test_audioIsOn_nilCondicional() {
        //Given
        userDefaults.removeObject(forKey: "sound")
        userDefaults.synchronize()
        let sut = soundKit?.audioIsOn()
        //Then
        XCTAssertTrue(try XCTUnwrap(sut))
    }

    //MARK: Play function test
    func test_play() {
        //Given
        soundKit = SoundsKit(file: "test", fileExtention: "wav")
        //Then
        XCTAssertNoThrow(try soundKit?.play(bundle: bundle))
    }
    
    func test_play_withError() {
        //Given
        soundKit = SoundsKit(file: "nonexistent", fileExtention: "wav")
        //When
        XCTAssertThrowsError(try soundKit?.play(bundle: bundle)) { error in
        //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }
    
    func test_play_withErrorBundle() {
        //Given
        soundKit = SoundsKit(file: "nonexistent", fileExtention: "wav")
        //When
        XCTAssertThrowsError(try soundKit?.play()) { error in
        //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedBundle)
        }
    }
    
    func test_play_withErrorFileExtension() {
        //Given
        soundKit = SoundsKit(file: "corrupt", fileExtention: "pdf")
        //When
        XCTAssertThrowsError(try soundKit?.play(bundle: bundle)) { error in
            //Then
            XCTAssertEqual(error as! ErrorSound, ErrorSound.failedSetAudio)
        }
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
        soundKit = SoundsKit(file: "test", fileExtention: "wav")
        //When
        try? soundKit?.play(bundle: bundle)
        let sutOn = soundKit?.audioIsOn()
        XCTAssertTrue(try XCTUnwrap(sutOn))
        soundKit?.stop()
        let sutOff = soundKit?.audioIsOn()
        //Then
        XCTAssertFalse(try XCTUnwrap(sutOff))
    }

    //MARK: Reproduce Speech function test
    func test_reproduceSpeech_withoutError() {
        //Given
        let word = "A casa é bela"
        //When
        let synthesizer = soundKit?.reproduceSpeech(word)
        soundKit?.reproduceSpeech(word)
        //Then
        XCTAssertFalse(try XCTUnwrap(synthesizer?.isPaused))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
        }
    }

}

