import { useEffect, react } from 'react';
import { Star, Lock, Trophy, ArrowLeft } from 'lucide-react';
import { useGame } from '../Game';

export const LevelSelect = () => {
  const { 
    currentWorld, 
    setCurrentLevel, 
    setGameState, 
    totalStars, 
    setCurrentWorld,
    gameState,
    gameWorlds,
    theme
  } = useGame();

  useEffect(() => {
    if (currentWorld) {
      // Re-evaluate or update the current world levels when navigating to levelSelect
      const updatedWorld = gameWorlds.find(world => world.id === currentWorld.id);
      setCurrentWorld(updatedWorld); // Ensures the current world state is refreshed with updated levels
    }
  }, [gameState]); // This triggers when the game state changes to levelSelect

  if (!currentWorld) return null;

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
          <span className="text-gray-700 dark:text-gray-300 mb-2">World Select</span>
          <button 
            className="w-12 h-12 bg-gray-200 dark:bg-gray-700 rounded-full flex justify-center items-center hover:bg-gray-300 dark:hover:bg-gray-600"
            onClick={() => setGameState('worldSelect')} // Go back to world select
          >
            <ArrowLeft className="text-gray-700 dark:text-gray-300 w-6 h-6" />
          </button>
        </div>
      </div>

      <div className="max-w-6xl mx-auto">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-4xl font-bold text-gray-900 dark:text-white">
            {currentWorld.name}
          </h1>
          <div className="flex items-center gap-2">
            <Trophy className="text-yellow-500" />
            <span className="text-2xl font-bold text-gray-900 dark:text-white">
              {totalStars} Stars
            </span>
          </div>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {currentWorld.levels.map((level) => (
            <div
              key={level.id}
              className={`rounded-lg shadow-lg p-6 ${
                level.isLocked 
                  ? 'bg-gray-300 dark:bg-gray-700' 
                  : 'bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700 cursor-pointer'
              } transition-colors duration-200`}
              onClick={() => {
                if (!level.isLocked) {
                  setCurrentLevel(level);
                  setGameState('playing');
                }
              }}
            >
              <div className="flex justify-between items-center mb-4">
                <h2 className="text-xl font-semibold text-gray-900 dark:text-white">
                  {level.title}
                </h2>
                {level.isLocked ? (
                  <div className="flex items-center gap-2">
                    <Lock className="text-gray-500 dark:text-gray-400" />
                    <span className="text-sm text-gray-500 dark:text-gray-400">
                      {level.requiredStars} stars needed
                    </span>
                  </div>
                ) : (
                  <div className="flex gap-1">
                    {[1, 2, 3].map((starNum) => (
                      <Star
                        key={starNum}
                        className={`w-6 h-6 ${
                          starNum <= (level.stars || 0)
                            ? 'text-yellow-500 fill-yellow-500' 
                            : 'text-gray-300 dark:text-gray-600'
                        }`}
                      />
                    ))}
                  </div>
                )}
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-4">
                {level.description}
              </p>
              {!level.isLocked && (
                <div className="text-sm text-gray-500 dark:text-gray-400">
                  <div>3 ★: Complete in {level.starThresholds.three}s</div>
                  <div>2 ★: Complete in {level.starThresholds.two}s</div>
                  <div>1 ★: Complete in {level.starThresholds.one}s</div>
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
