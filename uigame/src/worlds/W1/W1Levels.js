import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
import { MoneySliderLevel } from './Levels/L3';   
import { SetAlarmLevel } from './Levels/L4';      
import { DeleteCommentLevel } from './Levels/L5';  
import { RidiculousCaptcha } from './Levels/L7';  // New level
import { DateOfBirthLevel } from './Levels/L6';  // New level

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
    description: "Learn the basics by clicking a button",
    component: ClickTrainingLevel2,
    starThresholds: { one: 10, two: 8, three: 3 },
    requiredStars: 1,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L3",
    title: "Slide to Send",
    description: "Send $340.23 by dragging the slider along the 'Send' button track to the right amount.",
    component: MoneySliderLevel,
    starThresholds: { one: 60, two: 45, three: 25 }, 
    requiredStars: 3,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L4",
    title: "Set the Alarm",
    description: "Set the alarm to 7:30 AM by stopping the spinning slot machine timers for the hours, minutes, and AM/PM correctly.",
    component: SetAlarmLevel,
    starThresholds: { one: 70, two: 50, three: 30 },
    requiredStars: 5,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L5",
    title: "Delete Comment",
    description: "Discover the hidden method to delete a comment by posting it twice. Explore the interface and rules carefully!",
    component: DeleteCommentLevel,
    starThresholds: { one: 90, two: 60, three: 40 }, 
    requiredStars: 7,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L6",
    title: "Fill in Date of Birth",
    description: "Fill in your date of birth with randomized number order in dropdowns for year, month, and day.",
    component: DateOfBirthLevel,
    starThresholds: { one: 60, two: 45, three: 30 },
    requiredStars: 11,
    worldId: 1,
    isLocked: true
  },
  {
    id: "W1L7",
    title: "Ridiculous Captcha",
    description: "Select all the tiny boxes with a cat. The challenge is trickier than it sounds!",
    component: RidiculousCaptcha,
    starThresholds: { one: 50, two: 40, three: 25 },
    requiredStars: 9,
    worldId: 1,
    isLocked: true
  },
];
