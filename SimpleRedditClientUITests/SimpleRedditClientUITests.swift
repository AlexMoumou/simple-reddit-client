//
//  SimpleRedditClientUITests.swift
//  SimpleRedditClientUITests
//
//  Created by Alex Moumoulides on 24/7/22.
//

import XCTest

class SimpleRedditClientUITests: XCTestCase {

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenCloseSearch() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssert(app.staticTexts["Best Reddit Posts"].exists)
        app.navigationBars["Best Reddit Posts"].buttons["Search"].tap()
        XCTAssert(!app.staticTexts["Best Reddit Posts"].exists)
        app.navigationBars["_TtGC7SwiftUI19UIHosting"]/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".otherElements[\"Cancel\"].buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.staticTexts["Best Reddit Posts"].exists)
    }
    
    func testSearchSubredditByTextOpenAndThenClose() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Best Reddit Posts"].buttons["Search"].tap()
        
        let textfield = app.navigationBars["_TtGC7SwiftUI19UIHosting"].textFields["Search"]
        XCTAssert(textfield.exists)
        textfield.tap()
        textfield.typeText("FLOOF")
        
        let description = app.staticTexts["Floofy puffy cats and dogs and birds and chinchillas and cows and bunnies and caterpillars and anything else!"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: description, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        app.scrollViews.otherElements.staticTexts["r/Floof"].tap()
        
        XCTAssert(!textfield.exists)
        XCTAssert(app.staticTexts["r/Floof"].exists)
        
        app.navigationBars["r/Floof"].buttons["Back"].tap()
        
        XCTAssert(textfield.exists)
    }
}
