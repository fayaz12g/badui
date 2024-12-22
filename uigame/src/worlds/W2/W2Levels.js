// worlds/W2/W2Levels.js
import { ClickTrainingLevel } from './Levels/L1';
import { ClickTrainingLevel2 } from './Levels/L2';
// Import other levels as they're created

export const W2Levels = [
    {
      id: "W2L1",
      title: "Chris's first level",
      description: "Find and click tiny boxes in a large image",
      component: ClickTrainingLevel, // Replace with actual level component
      starThresholds: { one: 60, two: 45, three: 30 },
      requiredStars: 0, // could require stars from World 1
      worldId: 2,
      isLocked: false,
      mode: "n"
    },
    {
        id: "W1L2",
        title: "Chris's second level",
        description: "Learn the basics by clicking a button",
        component: ClickTrainingLevel2,
        starThresholds: { one: 10, two: 8, three: 3 },
        requiredStars: 1,
        worldId: 2,
        isLocked: true,
        mode: "n"
      },
    // Add more levels for World 2, every one needs a plus variant
    {
        id: "W2L1+",
        title: "[CHALLENGE] Chris's first level",
        description: "Find and click tiny boxes in a large image",
        component: ClickTrainingLevel, // Replace with actual level component
        starThresholds: { one: 5, two: 0, three: 0 },
        requiredStars: 0, // could require stars from World 1
        worldId: 2,
        isLocked: false,
        mode: "c"
      },
      {
          id: "W1L2+",
          title: "[CHALLENGE] Chris's second level",
          description: "Learn the basics by clicking a button",
          component: ClickTrainingLevel2,
          starThresholds: { one: 5, two: 0, three: 0 },
          requiredStars: 1,
          worldId: 2,
          isLocked: true,
          mode: "c"
        },
  ];