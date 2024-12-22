// worlds/W1/W1Levels.js
import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
// Import other levels as they're created

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
    // Add more levels for World 1
  ];