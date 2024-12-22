// worlds/WorldConfig.js
import { W1Levels } from './W1/W1Levels';
import { W2Levels } from './W2/W2Levels';

export const worlds = [
  {
    id: 1,
    name: "Fayaz's Levels",
    description: "These are the fun ones.",
    levels: W1Levels,
    requiredStars: 0,
    isLocked: false
  },
  {
    id: 2,
    name: "Chris's Levels",
    description: "These will likely be easier!",
    levels: W2Levels,
    requiredStars: 0,
    isLocked: false
  },
  {
    id: 3,
    name: "Bonus Levels",
    description: "We got guests to make these!",
    levels: W2Levels, // CHange to W3 when made
    requiredStars: 50,
    isLocked: true
  }
];