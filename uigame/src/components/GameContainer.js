import React, { useState, useEffect } from 'react';
import { ArrowLeft, Timer } from 'lucide-react';
import { useGame } from '../Game';
import { CompletionOverlay } from './CompletionOverlay';
import { useTheme } from './Theme';

export const GameContainer = () => {
    const { 
      currentLevel, 
      setCurrentLevel, 
      setGameState,
      completeLevel,
      currentWorld,
      gameWorlds,
      totalStars
    } = useGame();
  
    const { theme, setTheme } = useTheme();
    
    const [timeElapsed, setTimeElapsed] = useState(0);
    const [isPlaying, setIsPlaying] = useState(true);
    const [showCompletion, setShowCompletion] = useState(false);
    const [earnedStars, setEarnedStars] = useState(0);
    const [key, setKey] = useState(0);
    const currentLevelIndex = currentWorld.levels.findIndex(l => l.id === currentLevel.id);
    const nextLevel = currentWorld.levels[currentLevelIndex + 1];
    
    // Calculate if next level will be unlocked after completion
    const updatedTotalStars = totalStars + earnedStars;
    const isNextLevelUnlocked = nextLevel && updatedTotalStars >= nextLevel.requiredStars;
  
    useEffect(() => {
      if (!isPlaying) return;
      
      const interval = setInterval(() => {
        setTimeElapsed(t => t + 1);
      }, 1000);
      
      return () => clearInterval(interval);
    }, [isPlaying]);
  
    const handleComplete = () => {
      setIsPlaying(false);
      let stars = 0;
      if (timeElapsed <= currentLevel.starThresholds.three) stars = 3;
      else if (timeElapsed <= currentLevel.starThresholds.two) stars = 2;
      else if (timeElapsed <= currentLevel.starThresholds.one) stars = 1;
  
      if (currentLevel.mode === 'c' && timeElapsed <= currentLevel.starThresholds.one) {
          const baseLevelId = currentLevel.id.replace(/\+$/, '');
          const baseLevel = currentWorld.levels.find(l => l.id === baseLevelId);
          
          if (baseLevel) {
            completeLevel(currentWorld.id, baseLevelId, 4);
          }
          stars = 0;
      }
  
      setEarnedStars(stars);
      setShowCompletion(true);
    };
  
    const handleNext = () => {
      completeLevel(currentWorld.id, currentLevel.id, earnedStars);
      
      if (nextLevel && isNextLevelUnlocked) {
        setCurrentLevel(nextLevel);
        resetLevel();
      } else {
        setGameState('levelSelect');
        setCurrentLevel(null);
      }
    };
  
    const resetLevel = () => {
      setTimeElapsed(0);
      setIsPlaying(true);
      setShowCompletion(false);
      setKey(k => k + 1);
    };
  
    if (!currentLevel) return null;
  
    return (
      <div className={`
        min-h-screen 
        ${theme === 'dark' 
            ? 'bg-gradient-to-b from-gray-900 to-gray-800' 
            : currentWorld.id === 2 
                ? 'bg-gradient-to-b from-orange-500 to-orange-800' 
                : 'bg-gradient-to-b from-red-600 to-red-950'}
    `}>    
        <div className={`p-4 
        ${theme === 'dark' 
            ? 'bg-white dark:bg-gray-800' 
            : currentWorld.id === 2 
                ? 'bg-gradient-to-b from-orange-500 to-orange-700' 
                : 'bg-gradient-to-b from-red-500 to-red-850'}
             shadow-md flex justify-between items-center`}>
          <div className="flex items-center gap-4">
            <button
              onClick={() => {
                setGameState('levelSelect');
                setCurrentLevel(null);
              }}
              className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors duration-300"
            >
              <ArrowLeft className="dark:text-white" />
            </button>
            <h2 className="text-xl font-semibold dark:text-white">
              {currentLevel.title}
            </h2>
          </div>
          <div className="flex items-center gap-2">
            <Timer className="text-gray-500 dark:text-gray-400" />
            <span className="text-xl font-mono dark:text-white">
              {timeElapsed}s
            </span>
          </div>
        </div>
        
        <div className="p-8">
          <div key={key}>
            {React.createElement(currentLevel.component, { onComplete: handleComplete })}
          </div>
        </div>
  
        {showCompletion && (
          <CompletionOverlay
            timeElapsed={timeElapsed}
            stars={earnedStars}
            levelData={currentLevel}
            onNext={handleNext}
            onReplay={resetLevel}
            onMenu={() => {
              completeLevel(currentWorld.id, currentLevel.id, earnedStars);
              setGameState('levelSelect');
              setCurrentLevel(null);
            }}
            nextLevel={nextLevel}
            isNextLevelUnlocked={isNextLevelUnlocked}
            requiredStars={nextLevel?.requiredStars}
            currentStars={updatedTotalStars}
          />
        )}
      </div>
    );
  };