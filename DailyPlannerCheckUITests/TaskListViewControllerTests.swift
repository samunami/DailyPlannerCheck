//
//  TaskListViewControllerTests.swift
//  DailyPlannerCheckUITests
//
//  Created by Alexander on 19.12.2024.
//
import XCTest
@testable import DailyPlannerCheck

final class TaskListViewControllerTests: XCTestCase {
    var viewController: TaskListViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "TaskListViewController") as? TaskListViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testViewLoads() {
        XCTAssertNotNil(viewController.view, "View должна быть загружена")
    }

    func testTableViewIsConnected() {
        XCTAssertNotNil(viewController.tableView, "TableView должна быть подключена")
    }
}
