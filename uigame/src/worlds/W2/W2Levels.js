// worlds/W2/W2Levels.js
import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
// Import other levels as they're created

export const W2Levels = [
    {
      id: "W2L1",
      title: "Ridiculous Captcha",
      description: "Find and click tiny boxes in a large image",
      component: ClickTrainingLevel, // Replace with actual level component
      starThresholds: { one: 60, two: 45, three: 30 },
      requiredStars: 6, // Requires 6 stars from World 1
      worldId: 2,
      isLocked: true
    },
    {
        id: "W1L2",
        title: "Click Training 2",
        description: "Learn the basics by clicking a button",
        component: ClickTrainingLevel2,
        starThresholds: { one: 10, two: 8, three: 3 },
        requiredStars: 7,
        worldId: 1,
        isLocked: true
      },
    // Add more levels for World 2
  ];