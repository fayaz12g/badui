import React, { useState, useEffect } from 'react';
import { Star, Trophy, ArrowRight, RotateCcw } from 'lucide-react';

export const CompletionOverlay = ({ 
  timeElapsed, 
  stars, 
  levelData, 
  onNext, 
  onReplay, 
  onMenu, 
  nextLevel
}) => {
  const [show, setShow] = useState(false);

  useEffect(() => {
    setShow(true);
  }, []);

  const nextStarThreshold = Object.entries(levelData.starThresholds)
    .reverse()
    .find(([_, threshold]) => timeElapsed > threshold);

  const isChallengeMode = levelData.mode === 'c';
  const oneStarThreshold = Object.entries(levelData.starThresholds).find(
    ([_, threshold]) => threshold === Math.max(...Object.values(levelData.starThresholds))
  );

  return (
    <div className={`
      fixed inset-0 bg-black/50 backdrop-blur-sm
      flex items-center justify-center
      transition-opacity duration-500
      ${show ? 'opacity-100' : 'opacity-0'}
    `}>
      <div className={`
        bg-white dark:bg-gray-800 rounded-lg p-8 max-w-md w-full
        transform transition-transform duration-500
        ${show ? 'scale-100' : 'scale-90'}
        shadow-xl
      `}>
        <h2 className="text-3xl font-bold text-center mb-6 dark:text-white">
          Level Complete!
        </h2>
        
        <div className="flex justify-center mb-6 gap-2">
          {isChallengeMode ? (
            // If it's challenge mode, only show one red star, or red outline if below threshold
            <Star
              key="1"
              className={`w-12 h-12 transition-all duration-300 
                ${timeElapsed <= oneStarThreshold[1] 
                  ? 'text-red-500 fill-red-500 scale-110' 
                  : 'text-red-500' 
                }`}
            />
          ) : (
            // Otherwise, show up to 3 stars
            [1, 2, 3].map((starNum) => (
              <Star
                key={starNum}
                className={`w-12 h-12 transition-all duration-300 delay-${starNum * 200}
                  ${starNum <= stars 
                    ? 'text-yellow-500 fill-yellow-500 scale-110' 
                    : 'text-gray-300'}`}
              />
            ))
          )}
        </div>
        
        <div className="text-center mb-6 dark:text-gray-200">
          <p className="text-xl mb-2">Time: {timeElapsed}s</p>
          {isChallengeMode && oneStarThreshold && (
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Complete in {oneStarThreshold[1]}s for a red star!
            </p>
          )}
          {nextStarThreshold && !isChallengeMode && (
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Complete in {nextStarThreshold[1]}s for {nextStarThreshold[0].replace('one', '1').replace('two', '2').replace('three', '3')} stars!
            </p>
          )}
        </div>
        
        <div className="grid grid-cols-3 gap-4">
          <button
            onClick={onMenu}
            className="p-4 rounded-lg bg-gray-100 hover:bg-gray-200 
                     dark:bg-gray-700 dark:hover:bg-gray-600
                     flex flex-col items-center gap-2 transition-colors"
          >
            <Trophy className="w-6 h-6 dark:text-gray-200" />
            <span className="text-sm dark:text-gray-200">Levels</span>
          </button>
          
          <button
            onClick={onReplay}
            className="p-4 rounded-lg bg-gray-100 hover:bg-gray-200 
                     dark:bg-gray-700 dark:hover:bg-gray-600
                     flex flex-col items-center gap-2 transition-colors"
          >
            <RotateCcw className="w-6 h-6 dark:text-gray-200" />
            <span className="text-sm dark:text-gray-200">Retry</span>
          </button>
          
          <button
            onClick={onNext}
            disabled={(!nextLevel)} // Disable button if next level is locked
            className={`
              p-4 rounded-lg flex flex-col items-center gap-2 transition-colors
            bg-blue-500 hover:bg-blue-600 text-white
            `}
          >
            <ArrowRight className="w-6 h-6" />
            <span className="text-sm">Next</span>
          </button>
        </div>
      </div>
    </div>
  );
};
