import XCTest
@testable import SoundsKit

final class SoundsKitTests: XCTestCase {
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
        XCTAssertTrue(try XCTUnwrap(sutOn))
        SoundsKit.stop()
        let sutOff = SoundsKit.audioIsOn()
        //Then
        XCTAssertFalse(try XCTUnwrap(sutOff))
    }

    //MARK: Reproduce Speech function test
    func test_reproduceSpeech_withoutError() {
        //Given
        let word = "A casa é bela"
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

