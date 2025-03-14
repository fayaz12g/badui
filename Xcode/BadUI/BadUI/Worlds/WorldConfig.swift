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
                    view: AnyView(ClickTrainingLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L2",
                    title: "Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    view: AnyView(ClickTrainingLevel2 { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 10, "two": 5, "three": 1],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L3",
                    title: "Slide to Send",
                    description: "Send $340.23.",
                    view: AnyView(MoneySliderLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 30, "two": 15, "three": 5],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                // Continue this pattern for all levels...
                Level(
                    id: "W1L4",
                    title: "Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    view: AnyView(SetAlarmLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 45, "two": 30, "three": 10],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L5",
                    title: "Delete Comment",
                    description: "Delete your comment on a social media post.",
                    view: AnyView(DeleteCommentLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 60, "two": 30, "three": 5],
                    requiredStars: 10,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L6",
                    title: "Fill in Date of Birth",
                    description: "Fill in your date of birth.",
                    view: AnyView(DateOfBirthLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 30, "two": 10, "three": 5],
                    requiredStars: 12,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
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
                    view: AnyView(SettingsMazeLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 30, "two": 20, "three": 10],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L9",
                    title: "Log In",
                    description: "Login to your social media account.",
                    view: AnyView(OnScreenKeyboardLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 60, "two": 45, "three": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L10",
                    title: "Crazy Calculator",
                    description: "Calculate some numbers.",
                    view: AnyView(CrazyCalculatorLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 60, "two": 30, "three": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L11",
                    title: "E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    view: AnyView(FontSizeChallengeLevel { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 90, "two": 60, "three": 30],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "n",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                
                // Challenge Levels
                Level(
                    id: "W1L1+",
                    title: "[CHALLENGE] Click Training",
                    description: "Learn the basics by clicking a button",
                    view: AnyView(ClickTrainingLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 1],
                    requiredStars: 0,
                    isLocked: false,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L2+",
                    title: "[CHALLENGE] Click Training 2",
                    description: "Learn the basics by clicking a button again.",
                    view: AnyView(ClickTrainingLevel2Plus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 2],
                    requiredStars: 1,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L3+",
                    title: "[CHALLENGE] Slide to Send",
                    description: "Send $340.23.",
                    view: AnyView(MoneySliderLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 10],
                    requiredStars: 3,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L4+",
                    title: "[CHALLENGE] Set the Alarm",
                    description: "Set the alarm to 7:30 AM.",
                    view: AnyView(SetAlarmLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 5],
                    requiredStars: 5,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L5+",
                    title: "[CHALLENGE] Delete Comment",
                    description: "Delete your comment on a social media post.",
                    view: AnyView(DeleteCommentLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 5],
                    requiredStars: 7,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L6+",
                    title: "[CHALLENGE] Fill in Date of Birth",
                    description: "Fill in your date of birth.",
                    view: AnyView(DateOfBirthLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 10],
                    requiredStars: 11,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
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
                    view: AnyView(SettingsMazeLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 5],
                    requiredStars: 16,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L9+",
                    title: "[CHALLENGE] Log In",
                    description: "Login to your social media account.",
                    view: AnyView(OnScreenKeyboardLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 20],
                    requiredStars: 18,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L10+",
                    title: "[CHALLENGE] Crazy Calculator",
                    description: "Calculate some numbers.",
                    view: AnyView(CrazyCalculatorLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 3],
                    requiredStars: 20,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                ),
                Level(
                    id: "W1L11+",
                    title: "[CHALLENGE] E-Reader Font",
                    description: "Change the font size on the e-reader.",
                    view: AnyView(FontSizeChallengeLevelPlus { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }),
                    starThresholds: ["one": 10],
                    requiredStars: 35,
                    isLocked: true,
                    mode: "c",
                    onComplete: { timeElapsed in
                        GameManager.shared.handleLevelCompletion(
                            timeElapsed: timeElapsed,
                            currentLevel: GameManager.shared.currentLevel!
                        )
                    }
                )
            ],
            requiredStars: 0,
            isLocked: false
        )
    ]
}

struct World: Identifiable, Equatable {
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

struct Level: Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let view: AnyView
    var stars: Int?
    let starThresholds: [String: Int]
    let requiredStars: Int
    var isLocked: Bool
    let mode: String
    let onComplete: (Int) -> Void
    
    init(id: String, title: String, description: String, view: AnyView,
         starThresholds: [String: Int], requiredStars: Int, isLocked: Bool,
         mode: String, onComplete: @escaping (Int) -> Void) {
        self.id = id
        self.title = title
        self.description = description
        self.view = view
        self.starThresholds = starThresholds
        self.requiredStars = requiredStars
        self.isLocked = isLocked
        self.mode = mode
        self.onComplete = onComplete
    }
    
    static func == (lhs: Level, rhs: Level) -> Bool {
            lhs.id == rhs.id &&
            lhs.stars == rhs.stars &&
            lhs.isLocked == rhs.isLocked
        }
}
