import React, { useState, createContext, useContext } from 'react';
import { worlds } from './worlds/WorldConfig';
import { ThemeProvider, ThemeToggle } from './components/Theme'; // Assuming we moved theme components to separate file
import { MainMenu } from './components/MainMenu';
import { GameContainer } from './components/GameContainer';
import { LevelSelect } from './components/LevelSelect';
import { Star, Lock, Trophy, Timer, ArrowLeft, Sun, Moon, ArrowRight, RotateCcw } from 'lucide-react';
import { useTheme } from './components/Theme';

// Game Context
const GameContext = createContext();

// Updated Game Component with World Structure
const Game = () => {
  const [gameState, setGameState] = useState('mainMenu'); // mainMenu, worldSelect, levelSelect, playing
  const [currentWorld, setCurrentWorld] = useState(null);
  const [currentLevel, setCurrentLevel] = useState(null);
  const [gameWorlds, setGameWorlds] = useState(worlds);

  // Calculate total stars across all worlds
  const totalStars = gameWorlds.reduce((worldSum, world) => {
    return worldSum + world.levels.reduce((levelSum, level) => levelSum + (level.stars || 0), 0)
  }, 0);

  // Complete a level and update world/level states
  const completeLevel = (worldId, levelId, stars) => {
    setGameWorlds(prevWorlds => 
      prevWorlds.map(world => {
        if (world.id === worldId) {
          const updatedLevels = world.levels.map((level, index) => {
            if (level.id === levelId) {
              // Update stars for the completed level
              return { ...level, completed: true, stars: Math.max(level.stars || 0, stars) };
            }
  
            // Unlock next level if it's locked and conditions are met
            const currentLevelIndex = world.levels.findIndex(l => l.id === levelId);
            if (index === currentLevelIndex + 1 && level.isLocked) {
              const totalWorldStars = world.levels.reduce((sum, l) => 
                sum + (l.id === levelId ? Math.max(l.stars || 0, stars) : (l.stars || 0)), 
                0
              );
              return { 
                ...level, 
                isLocked: totalWorldStars < level.requiredStars // Unlock based on star requirement
              };
            }
            return level;
          });
  
          return { ...world, levels: updatedLevels };
        }
  
        return world;
      })
    );
  };
  
  

  return (
    <ThemeProvider>
      <div className="bg-gray-100 dark:bg-gray-900 min-h-screen transition-colors duration-300">
        <ThemeToggle />
        <GameContext.Provider value={{
          currentWorld,
          setCurrentWorld,
          currentLevel,
          setCurrentLevel,
          gameWorlds,
          setGameWorlds,
          gameState,
          setGameState,
          completeLevel,
          totalStars
        }}>
          {gameState === 'mainMenu' && (
            <MainMenu onStart={() => setGameState('worldSelect')} />
          )}
          {gameState === 'worldSelect' && (
            <WorldSelect />
          )}
          {gameState === 'levelSelect' && (
            <LevelSelect />
          )}
          {gameState === 'playing' && (
            <GameContainer />
          )}
        </GameContext.Provider>
      </div>
    </ThemeProvider>
  );
};

// World Select Component
const WorldSelect = () => {
  const { gameWorlds, setCurrentWorld, setGameState, totalStars } = useContext(GameContext);
  const { theme, setTheme, color } = useTheme();

  return (
    <div className={`
        min-h-screen cursor-pointer
        ${theme === 'dark' 
          ? 'bg-gradient-to-b from-gray-900 to-gray-800' 
          : 'bg-gradient-to-b from-red-600 to-red-950'}
        flex flex-col items-center justify-center
        transition-colors duration-300
      `}>
        <div className="absolute top-1/2 left-4 transform -translate-y-1/2">
        <div className="flex flex-col items-center">
          <span className="text-gray-700 dark:text-gray-300 mb-2">Main Menu</span>
          <button
            className={`w-12 h-12 rounded-full flex justify-center items-center
                ${theme === 'dark' 
                ? 'bg-gray-700 hover:bg-gray-800' 
                : 'bg-red-700 hover:bg-red-950'}`}
            onClick={() => setGameState('mainMenu')}
            >
            <ArrowLeft className="text-gray-700 dark:text-gray-300 w-6 h-6" />
          </button>
        </div>
      </div>
      <div className="max-w-6xl mx-auto">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 dark:text-white transition-colors duration-300">
            Select World
          </h1>
          <div className="flex items-center gap-2">
            <Trophy className="text-yellow-500" />
            <span className="text-2xl font-bold text-gray-900 dark:text-white transition-colors duration-300">
              {totalStars} Stars
            </span>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {gameWorlds.map((world) => (
            <div
              key={world.id}
              className={`
                rounded-lg shadow-lg p-6
                ${world.isLocked 
                    ? `${theme === 'dark' ? 'bg-gray-900' : 'bg-red-900'}` 
                    : `${theme === 'dark' 
                        ? 'bg-gray-800 hover:bg-gray-700' 
                        : 'bg-red-600 hover:bg-red-950'} cursor-pointer`}
                transition-colors duration-200
                `}
              onClick={() => {
                if (!world.isLocked) {
                  setCurrentWorld(world);
                  setGameState('levelSelect');
                }
              }}
            >
              <div className="flex justify-between items-center mb-4">
                <h2 className="text-xl font-semibold text-gray-900 dark:text-white transition-colors duration-300">
                  {world.name}
                </h2>
                {world.isLocked ? (
                  <div className="flex items-center gap-2">
                    <Lock className="text-gray-500 dark:text-gray-400" />
                    <span className="text-sm text-gray-500 dark:text-gray-400">
                      {world.requiredStars} stars needed
                    </span>
                  </div>
                ) : (
                  <div className="text-sm text-gray-600 dark:text-gray-300">
                    {world.levels.reduce((sum, level) => sum + (level.stars || 0), 0)} stars earned
                  </div>
                )}
              </div>
              <p className="text-gray-600 dark:text-gray-300">
                {world.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

// Hook for accessing game context
const useGame = () => {
  const context = useContext(GameContext);
  if (!context) {
    throw new Error('useGame must be used within a GameProvider');
  }
  return context;
};

export default Game;
export { useGame };