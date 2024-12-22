import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
import { MoneySliderLevel } from './Levels/L3';   
import { SetAlarmLevel } from './Levels/L4';      
import { DeleteCommentLevel } from './Levels/L5';  
import { DateOfBirthLevel } from './Levels/L6';  
import { RidiculousCaptcha } from './Levels/L7';  

// Challenge Levels
import { ClickTrainingLevelPlus } from './Levels/L1+';
import { ClickTrainingLevel2Plus } from './Levels/L2+';
import { MoneySliderLevelPlus } from './Levels/L3+';   
import { SetAlarmLevelPlus } from './Levels/L4+';      
import { DeleteCommentLevelPlus } from './Levels/L5+';  
import { DateOfBirthLevelPlus } from './Levels/L6+';  
import { RidiculousCaptchaPlus } from './Levels/L7+';  

export const W1Levels = [
  {
    id: "W1L1",
    title: "Click Training",
    description: "Learn the basics by clicking a button",
    component: ClickTrainingLevel,
    starThresholds: { one: 10, two: 5, three: 1 },
    requiredStars: 0,
    worldId: 1,
    isLocked: false
  },
  {
    id: "W1L2",
    title: "Click Training 2",
    description: "Learn the basics by clicking a button again.",
    component: ClickTrainingLevel2,
    starThresholds: { one: 10, two: 8, three: 3 },
    requiredStars: 1,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L3",
    title: "Slide to Send",
    description: "Send $340.23.",
    component: MoneySliderLevel,
    starThresholds: { one: 60, two: 45, three: 25 }, 
    requiredStars: 3,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L4",
    title: "Set the Alarm",
    description: "Set the alarm to 7:30 AM.",
    component: SetAlarmLevel,
    starThresholds: { one: 70, two: 50, three: 30 },
    requiredStars: 5,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L5",
    title: "Delete Comment",
    description: "Delete your comment on a social media post.",
    component: DeleteCommentLevel,
    starThresholds: { one: 90, two: 60, three: 40 }, 
    requiredStars: 7,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L6",
    title: "Fill in Date of Birth",
    description: "Fill in your date of birth.",
    component: DateOfBirthLevel,
    starThresholds: { one: 60, two: 45, three: 30 },
    requiredStars: 11,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L7",
    title: "Ridiculous Captcha",
    description: "Select all the tiny boxes with a cat.",
    component: RidiculousCaptcha,
    starThresholds: { one: 50, two: 40, three: 25 },
    requiredStars: 9,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L1+",
    title: "[CHALLENGE] Click Training",
    description: "Learn the basics by clicking a button",
    component: ClickTrainingLevelPlus,
    starThresholds: { one: 10, two: 5, three: 1 },
    requiredStars: 0,
    worldId: 1,
    isLocked: false
  },
  {
    id: "W1L2+",
    title: "[CHALLENGE] Click Training 2",
    description: "Learn the basics by clicking a button again.",
    component: ClickTrainingLevel2Plus,
    starThresholds: { one: 10, two: 8, three: 3 },
    requiredStars: 1,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L3+",
    title: "[CHALLENGE] Slide to Send",
    description: "Send $340.23.",
    component: MoneySliderLevelPlus,
    starThresholds: { one: 60, two: 45, three: 25 }, 
    requiredStars: 3,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L4+",
    title: "[CHALLENGE] Set the Alarm",
    description: "Set the alarm to 7:30 AM.",
    component: SetAlarmLevelPlus,
    starThresholds: { one: 70, two: 50, three: 30 },
    requiredStars: 5,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L5+",
    title: "[CHALLENGE] Delete Comment",
    description: "Delete your comment on a social media post.",
    component: DeleteCommentLevelPlus,
    starThresholds: { one: 90, two: 60, three: 40 }, 
    requiredStars: 7,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L6+",
    title: "[CHALLENGE] Fill in Date of Birth",
    description: "Fill in your date of birth.",
    component: DateOfBirthLevelPlus,
    starThresholds: { one: 60, two: 45, three: 30 },
    requiredStars: 11,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L7+",
    title: "[CHALLENGE] Ridiculous Captcha",
    description: "Select all the tiny boxes with a cat.",
    component: RidiculousCaptchaPlus,
    starThresholds: { one: 50, two: 40, three: 25 },
    requiredStars: 9,
    worldId: 1,
    isLocked: true
  },
];
