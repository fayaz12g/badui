// worlds/W1/levels/L1.js
import React, { useState } from 'react';

export const ClickTrainingLevel = ({ onComplete }) => {
  const [clicks, setClicks] = useState(0);
  const requiredClicks = 10;

  const handleClick = () => {
    const newClicks = clicks + 1;
    setClicks(newClicks);
    if (newClicks >= requiredClicks) {
      onComplete();
    }
  };

  return (
    <div className="max-w-md mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white transition-colors duration-300">
        Click Training
      </h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        This is like level 1-1, but a little harder! Click the button {requiredClicks} times to complete the level!
      </p>
      <div className="mb-4 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        Progress: {clicks}/{requiredClicks}
      </div>
      <button
        onClick={handleClick}
        className="bg-blue-500 text-white px-6 py-3 rounded-lg text-lg font-semibold
                 hover:bg-blue-600 transform transition-all duration-300 hover:scale-105
                 active:bg-blue-700"
      >
        Click Me!
      </button>
    </div>
  );
};