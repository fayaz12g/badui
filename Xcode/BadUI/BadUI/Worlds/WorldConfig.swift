//
//  WorldConfig.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct WorldConfig {
    static let worlds = [
        World(
            id: 1,
            name: "Fayaz's Levels",
            description: "These are the fun ones.",
            levels: [
                // Normal Levels
                Level(
                    id: "W1L1",
                    title: "Click Training",
                    description: "Learn the basics by clicking a button",
                    view: AnyView(ClickTrainingLevel()),
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "n"
                ),
                Level(
                    id: "W1L2",
                    title: "Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    view: AnyView(ClickTrainingLevel2()),
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L3",
                    title: "Slide to Send",
                    description: "Send $340.23.",
                    view: AnyView(MoneySliderLevel()),
                    starThresholds: ["one": 30, "two": 15, "three": 5],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L4",
                    title: "Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    view: AnyView(SetAlarmLevel()),
                    starThresholds: ["one": 45, "two": 30, "three": 10],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L5",
                    title: "Delete Comment",
                    description: "Delete your comment on a social media post.",
                    view: AnyView(DeleteCommentLevel()),
                    starThresholds: ["one": 60, "two": 30, "three": 5],
                    requiredStars: 10,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L6",
                    title: "Fill in Date of Birth",
                    description: "Fill in your date of birth.",
                    view: AnyView(DateOfBirthLevel()),
                    starThresholds: ["one": 30, "two": 10, "three": 5],
                    requiredStars: 12,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L7",
                    title: "Ridiculous Captcha",
                    description: "Select all the tiny boxes with a cat.",
                    view: AnyView(RidiculousCaptcha()),
                    starThresholds: ["one": 90, "two": 60, "three": 30],
                    requiredStars: 14,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L8",
                    title: "Phone Settings",
                    description: "Turn off bluetooth.",
                    view: AnyView(SettingsMazeLevel()),
                    starThresholds: ["one": 30, "two": 20, "three": 10],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L9",
                    title: "Log In",
                    description: "Login to your social media account.",
                    view: AnyView(OnScreenKeyboardLevel()),
                    starThresholds: ["one": 60, "two": 45, "three": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L10",
                    title: "Crazy Calculator",
                    description: "Calculate some numbers.",
                    view: AnyView(CrazyCalculatorLevel()),
                    starThresholds: ["one": 60, "two": 30, "three": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "n"
                ),
                Level(
                    id: "W1L11",
                    title: "E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    view: AnyView(FontSizeChallengeLevel()),
                    starThresholds: ["one": 90, "two": 60, "three": 30],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "n"
                ),
                
                // Challenge Levels
                Level(
                    id: "W1L1+",
                    title: "[CHALLENGE] Click Training",
                    description: "Learn the basics by clicking a button",
                    view: AnyView(ClickTrainingLevelPlus()),
                    starThresholds: ["one": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "c"
                ),
                Level(
                    id: "W1L2+",
                    title: "[CHALLENGE] Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    view: AnyView(ClickTrainingLevel2Plus()),
                    starThresholds: ["one": 2],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L3+",
                    title: "[CHALLENGE] Slide to Send",
                    description: "Send $340.23.",
                    view: AnyView(MoneySliderLevelPlus()),
                    starThresholds: ["one": 10],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L4+",
                    title: "[CHALLENGE] Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    view: AnyView(SetAlarmLevelPlus()),
                    starThresholds: ["one": 10],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L5+",
                    title: "[CHALLENGE] Delete Comment",
                    description: "Delete your comment on a social media post.",
                    view: AnyView(DeleteCommentLevelPlus()),
                    starThresholds: ["one": 5],
                    requiredStars: 7,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L6+",
                    title: "[CHALLENGE] Fill in Date of Birth",
                    description: "Fill in your date of birth.",
                    view: AnyView(DateOfBirthLevelPlus()),
                    starThresholds: ["one": 10],
                    requiredStars: 11,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L7+",
                    title: "[CHALLENGE] Ridiculous Captcha",
                    description: "Select all the tiny boxes with a cat.",
                    view: AnyView(RidiculousCaptchaPlus()),
                    starThresholds: ["one": 15],
                    requiredStars: 9,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L8+",
                    title: "[CHALLENGE] Phone Settings",
                    description: "Turn off bluetooth.",
                    view: AnyView(SettingsMazeLevelPlus()),
                    starThresholds: ["one": 5],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L9+",
                    title: "[CHALLENGE] Log In",
                    description: "Login to your social media account.",
                    view: AnyView(OnScreenKeyboardLevelPlus()),
                    starThresholds: ["one": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L10+",
                    title: "[CHALLENGE] Crazy Calculator",
                    description: "Calculate some numbers.",
                    view: AnyView(CrazyCalculatorLevelPlus()),
                    starThresholds: ["one": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "c"
                ),
                Level(
                    id: "W1L11+",
                    title: "[CHALLENGE] E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    view: AnyView(FontSizeChallengeLevelPlus()),
                    starThresholds: ["one": 10],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "c"
                )
            ],
            requiredStars: 0,
            isLocked: false
        )
    ]
}

struct World: Identifiable {
    let id: Int
    let name: String
    let description: String
    var levels: [Level]
    let requiredStars: Int
    var isLocked: Bool
}

struct Level: Identifiable {
    let id: String
    let title: String
    let description: String
    let view: AnyView
    var stars: Int?
    let starThresholds: [String: Int]
    let requiredStars: Int
    var isLocked: Bool
    let mode: String
}
