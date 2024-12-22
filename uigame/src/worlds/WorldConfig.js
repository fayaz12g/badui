// worlds/WorldConfig.js
import { W1Levels } from './W1/W1Levels';
import { W2Levels } from './W2/W2Levels';

export const worlds = [
  {
    id: 1,
    name: "World 1: Basic Training",
    description: "Learn the fundamentals",
    levels: W1Levels,
    requiredStars: 0,
    isLocked: false
  },
  {
    id: 2,
    name: "World 2: Advanced Challenges",
    description: "Put your skills to the test",
    levels: W2Levels,
    requiredStars: 6,
    isLocked: true
  }
];