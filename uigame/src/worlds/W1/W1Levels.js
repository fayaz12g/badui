import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
import { MoneySliderLevel } from './Levels/L3';   
import { SetAlarmLevel } from './Levels/L4';      
import { DeleteCommentLevel } from './Levels/L5';  
import { DateOfBirthLevel } from './Levels/L6';  
import { RidiculousCaptcha } from './Levels/L7';  
import SettingsMazeLevel from './Levels/L8';  
import OnScreenKeyboardLevel from './Levels/L9';
import CrazyCalculatorLevel from './Levels/L10';
import FontSizeChallengeLevel from './Levels/L11';

// Challenge Levels
import { ClickTrainingLevelPlus } from './Levels/L1+';
import { ClickTrainingLevel2Plus } from './Levels/L2+';
import { MoneySliderLevelPlus } from './Levels/L3+';   
import { SetAlarmLevelPlus } from './Levels/L4+';      
import { DeleteCommentLevelPlus } from './Levels/L5+';  
import { DateOfBirthLevelPlus } from './Levels/L6+';  
import { RidiculousCaptchaPlus } from './Levels/L7+';  
import SettingsMazeLevelPlus from './Levels/L8+';  
import OnScreenKeyboardLevelPlus from './Levels/L9+';
import CrazyCalculatorLevelPlus from './Levels/L10+';
import FontSizeChallengeLevelPlus from './Levels/L11+';

export const W1Levels = [
  {
    id: "W1L1",
    title: "Click Training",
    description: "Learn the basics by clicking a button",
    component: ClickTrainingLevel,
    starThresholds: { one: 10, two: 5, three: 1 },
    requiredStars: 0,
    worldId: 1,
    isLocked: false,
    mode: 'n'
  },
  {
    id: "W1L2",
    title: "Click Training 2",
    description: "Learn the basics by clicking a button again.",
    component: ClickTrainingLevel2,
    starThresholds: { one: 10, two: 5, three: 1 },
    requiredStars: 1,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L3",
    title: "Slide to Send",
    description: "Send $340.23.",
    component: MoneySliderLevel,
    starThresholds: { one: 30, two: 15, three: 5 }, 
    requiredStars: 3,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L4",
    title: "Set the Alarm",
    description: "Set the alarm to 7:30 AM.",
    component: SetAlarmLevel,
    starThresholds: { one: 45, two: 30, three: 10 },
    requiredStars: 5,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L5",
    title: "Delete Comment",
    description: "Delete your comment on a social media post.",
    component: DeleteCommentLevel,
    starThresholds: { one: 60, two: 30, three: 5 }, 
    requiredStars: 10,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L6",
    title: "Fill in Date of Birth",
    description: "Fill in your date of birth.",
    component: DateOfBirthLevel,
    starThresholds: { one: 30, two: 10, three: 5 },
    requiredStars: 12,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L7",
    title: "Ridiculous Captcha",
    description: "Select all the tiny boxes with a cat.",
    component: RidiculousCaptcha,
    starThresholds: { one: 90, two: 60, three: 30 },
    requiredStars: 14,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L8",
    title: "Phone Settings",
    description: "Turn off blutooth.",
    component: SettingsMazeLevel,
    starThresholds: { one: 30, two: 20, three: 10 },
    requiredStars: 16,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L9",
    title: "Log In",
    description: "Login to your social media account.",
    component: OnScreenKeyboardLevel,
    starThresholds: { one: 60, two: 45, three: 20 },
    requiredStars: 18,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L10",
    title: "Crazy Calculator",
    description: "Calculate some numbers.",
    component: CrazyCalculatorLevel,
    starThresholds: { one: 60, two: 30, three: 3 },
    requiredStars: 20,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L11",
    title: "E-Reader Font",
    description: "Change the font size on the e-reader.",
    component: FontSizeChallengeLevel,
    starThresholds: { one: 90, two: 60, three: 30 },
    requiredStars: 35,
    worldId: 1,
    isLocked: true,
    mode: 'n'
  },
  {
    id: "W1L1+",
    title: "[CHALLENGE] Click Training",
    description: "Learn the basics by clicking a button",
    component: ClickTrainingLevelPlus,
    starThresholds: { one: 1, two: 0, three: 0 },
    requiredStars: 0,
    worldId: 1,
    isLocked: false,
    mode: 'c'
  },
  {
    id: "W1L2+",
    title: "[CHALLENGE] Click Training 2",
    description: "Learn the basics by clicking a button again.",
    component: ClickTrainingLevel2Plus,
    starThresholds: { one: 2, two: 0, three: 0 },
    requiredStars: 1,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L3+",
    title: "[CHALLENGE] Slide to Send",
    description: "Send $340.23.",
    component: MoneySliderLevelPlus,
    starThresholds: { one: 10, two: 0, three: 0 }, 
    requiredStars: 3,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L4+",
    title: "[CHALLENGE] Set the Alarm",
    description: "Set the alarm to 7:30 AM.",
    component: SetAlarmLevelPlus,
    starThresholds: { one: 10, two: 0, three: 0 },
    requiredStars: 5,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L5+",
    title: "[CHALLENGE] Delete Comment",
    description: "Delete your comment on a social media post.",
    component: DeleteCommentLevelPlus,
    starThresholds: { one: 5, two: 0, three: 0 }, 
    requiredStars: 7,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L6+",
    title: "[CHALLENGE] Fill in Date of Birth",
    description: "Fill in your date of birth.",
    component: DateOfBirthLevelPlus,
    starThresholds: { one: 10, two: 0, three: 0 },
    requiredStars: 11,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L7+",
    title: "[CHALLENGE] Ridiculous Captcha",
    description: "Select all the tiny boxes with a cat.",
    component: RidiculousCaptchaPlus,
    starThresholds: { one: 15, two: 0, three: 0 },
    requiredStars: 9,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L8+",
    title: "[CHALLENGE] Phone Settings",
    description: "Turn off blutooth.",
    component: SettingsMazeLevelPlus,
    starThresholds: { one: 5, two: 0, three: 0 },
    requiredStars: 16,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L9+",
    title: "[CHALLENGE] Log In",
    description: "Login to your social media account.",
    component: OnScreenKeyboardLevelPlus,
    starThresholds: { one: 20, two: 0, three: 0 },
    requiredStars: 18,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L10+",
    title: "[CHALLENGE] Crazy Calculator",
    description: "Calculate some numbers.",
    component: CrazyCalculatorLevelPlus,
    starThresholds: { one: 3, two: 0, three: 0 },
    requiredStars: 20,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
  {
    id: "W1L11+",
    title: "[CHALLENGE] E-Reader Font",
    description: "Change the font size on the e-reader.",
    component: FontSizeChallengeLevelPlus,
    starThresholds: { one: 10, two: 0, three: 0 },
    requiredStars: 35,
    worldId: 1,
    isLocked: true,
    mode: 'c'
  },
];
