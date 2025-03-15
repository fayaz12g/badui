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
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "n"
                ),
                Level(
                    id: "W1L2",
                    title: "Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L3",
                    title: "Slide to Send",
                    description: "Send $340.23.",
                    starThresholds: ["one": 30, "two": 15, "three": 5],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L4",
                    title: "Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    starThresholds: ["one": 45, "two": 30, "three": 10],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L5",
                    title: "Delete Comment",
                    description: "Delete your comment on a social media post.",
                    starThresholds: ["one": 60, "two": 30, "three": 5],
                    requiredStars: 10,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L6",
                    title: "Fill in Date of Birth",
                    description: "Fill in your date of birth.",

                    starThresholds: ["one": 30, "two": 10, "three": 5],
                    requiredStars: 12,
                    isLocked: true,
                    mode: "n",
                ),
//                Level(
//                    id: "W1L7",
//                    title: "Ridiculous Captcha",
//                    description: "Select all the tiny boxes with a cat.",
//                    view: AnyView(RidiculousCaptcha { timeElapsed in
//                        GameManager.shared.handleLevelCompletion(
//                            timeElapsed: timeElapsed,
//                            currentLevel: GameManager.shared.currentLevel!
//                        )
//                    }),
//                    starThresholds: ["one": 90, "two": 60, "three": 30],
//                    requiredStars: 14,
//                    isLocked: true,
//                    mode: "n",
//                    onComplete: { timeElapsed in
//                        GameManager.shared.handleLevelCompletion(
//                            timeElapsed: timeElapsed,
//                            currentLevel: GameManager.shared.currentLevel!
//                        )
//                    }
//                ),
                Level(
                    id: "W1L8",
                    title: "Phone Settings",
                    description: "Turn off bluetooth.",
                    starThresholds: ["one": 30, "two": 20, "three": 10],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L9",
                    title: "Log In",
                    description: "Login to your social media account.",
                    starThresholds: ["one": 60, "two": 45, "three": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L10",
                    title: "Crazy Calculator",
                    description: "Calculate some numbers.",
                    starThresholds: ["one": 60, "two": 30, "three": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "n",
                ),
                Level(
                    id: "W1L11",
                    title: "E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    starThresholds: ["one": 90, "two": 60, "three": 30],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "n",
                ),
                
                // Challenge Levels
                Level(
                    id: "W1L1+",
                    title: "[CHALLENGE] Click Training",
                    description: "Learn the basics by clicking a button",
                    starThresholds: ["one": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "c",
                ),
                Level(
                    id: "W1L2+",
                    title: "[CHALLENGE] Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    starThresholds: ["one": 2],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L3+",
                    title: "[CHALLENGE] Slide to Send",
                    description: "Send $340.23.",
                    starThresholds: ["one": 10],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L4+",
                    title: "[CHALLENGE] Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    starThresholds: ["one": 5],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L5+",
                    title: "[CHALLENGE] Delete Comment",
                    description: "Delete your comment on a social media post.",
                    starThresholds: ["one": 5],
                    requiredStars: 7,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L6+",
                    title: "[CHALLENGE] Fill in Date of Birth",
                    description: "Fill in your date of birth.",
                    starThresholds: ["one": 10],
                    requiredStars: 11,
                    isLocked: true,
                    mode: "c",
                ),
//                Level(
//                    id: "W1L7+",
//                    title: "[CHALLENGE] Ridiculous Captcha",
//                    description: "Select all the tiny boxes with a cat.",
//                    view: AnyView(RidiculousCaptchaPlus { timeElapsed in
//                        GameManager.shared.handleLevelCompletion(
//                            timeElapsed: timeElapsed,
//                            currentLevel: GameManager.shared.currentLevel!
//                        )
//                    }),
//                    starThresholds: ["one": 15],
//                    requiredStars: 9,
//                    isLocked: true,
//                    mode: "c",
//                    onComplete: { timeElapsed in
//                        GameManager.shared.handleLevelCompletion(
//                            timeElapsed: timeElapsed,
//                            currentLevel: GameManager.shared.currentLevel!
//                        )
//                    }
//                ),
                Level(
                    id: "W1L8+",
                    title: "[CHALLENGE] Phone Settings",
                    description: "Turn off bluetooth.",
                    starThresholds: ["one": 5],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L9+",
                    title: "[CHALLENGE] Log In",
                    description: "Login to your social media account.",
                    starThresholds: ["one": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L10+",
                    title: "[CHALLENGE] Crazy Calculator",
                    description: "Calculate some numbers.",
                    starThresholds: ["one": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "c",
                ),
                Level(
                    id: "W1L11+",
                    title: "[CHALLENGE] E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    starThresholds: ["one": 10],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "c",
                )
            ],
            requiredStars: 0,
            isLocked: false
        )
    ]
}

struct World: Identifiable, Equatable, Codable {
    let id: Int
    let name: String
    let description: String
    var levels: [Level]
    let requiredStars: Int
    var isLocked: Bool
    
    static func == (lhs: World, rhs: World) -> Bool {
        lhs.id == rhs.id &&
        lhs.levels == rhs.levels &&
        lhs.isLocked == rhs.isLocked
    }
}

struct Level: Identifiable, Equatable, Codable {
    let id: String
    let title: String
    let description: String
    var stars: Int?
    let starThresholds: [String: Int]
    let requiredStars: Int
    var isLocked: Bool
    let mode: String
    
    static func == (lhs: Level, rhs: Level) -> Bool {
        lhs.id == rhs.id &&
        lhs.stars == rhs.stars &&
        lhs.isLocked == rhs.isLocked &&
        lhs.mode == rhs.mode
    }
}

struct LevelViewFactory {
    @EnvironmentObject var gameManager: GameManager
    
    static func view(for level: Level) -> AnyView {
        
        switch level.id {
        // Normal Levels
        case "W1L1": return AnyView(ClickTrainingLevel())
        case "W1L2": return AnyView(ClickTrainingLevel2())
        case "W1L3": return AnyView(MoneySliderLevel())
        case "W1L4": return AnyView(SetAlarmLevel())
        case "W1L5": return AnyView(DeleteCommentLevel())
        case "W1L6": return AnyView(DateOfBirthLevel())
        case "W1L8": return AnyView(SettingsMazeLevel())
        case "W1L9": return AnyView(OnScreenKeyboardLevel())
        case "W1L10": return AnyView(CrazyCalculatorLevel())
        case "W1L11": return AnyView(FontSizeChallengeLevel())
            
        // Challenge Levels
        case "W1L1+": return AnyView(ClickTrainingLevelPlus())
        case "W1L2+": return AnyView(ClickTrainingLevel2Plus())
        case "W1L3+": return AnyView(MoneySliderLevelPlus())
        case "W1L4+": return AnyView(SetAlarmLevelPlus())
        case "W1L5+": return AnyView(DeleteCommentLevelPlus())
        case "W1L6+": return AnyView(DateOfBirthLevelPlus())
        case "W1L8+": return AnyView(SettingsMazeLevelPlus())
        case "W1L9+": return AnyView(OnScreenKeyboardLevelPlus())
        case "W1L10+": return AnyView(CrazyCalculatorLevelPlus())
        case "W1L11+": return AnyView(FontSizeChallengeLevelPlus())
            
        default: return AnyView(Text("Level view not implemented"))
        }
    }
}
