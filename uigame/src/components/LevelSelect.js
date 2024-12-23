import { useEffect } from 'react';
import { Star, Lock, Trophy, ArrowLeft } from 'lucide-react';
import { useGame } from '../Game';
import { useTheme } from './Theme';

export const LevelSelect = () => {
    const { 
      currentWorld, 
      setCurrentLevel, 
      setGameState, 
      totalStars, 
      setCurrentWorld,
      gameState,
      gameWorlds
    } = useGame();
  
    const { theme, setTheme } = useTheme();

    useEffect(() => {
      if (currentWorld) {
        const updatedWorld = gameWorlds.find(world => world.id === currentWorld.id);
        setCurrentWorld(updatedWorld);
      }
    }, [gameState]);
  
    if (!currentWorld) return null;
  
    const handleLevelSelect = (level, e) => {
      if (e) e.stopPropagation();
      if (totalStars >= level.requiredStars) {
        setCurrentLevel(level);
        setGameState('playing');
      }
    };
  
    return (
      <div className={`
        min-h-screen 
        ${theme === 'dark' 
            ? 'bg-gradient-to-b from-gray-900 to-gray-800' 
            : currentWorld.id === 2 
                ? 'bg-gradient-to-b from-orange-500 to-orange-800' 
                : 'bg-gradient-to-b from-red-600 to-red-950'}
        flex flex-col items-center justify-center
        transition-colors duration-300
    `}>    
        <div className="absolute top-1/2 left-4 transform -translate-y-1/2">
          <div className="flex flex-col items-center">
            <span className="text-gray-700 dark:text-gray-300 mb-2">World Select</span>
            <button
            className={`w-12 h-12 rounded-full flex justify-center items-center
              ${theme === 'dark' 
                  ? 'bg-gray-700 hover:bg-gray-800' 
                  : currentWorld.id === 2 
                      ? 'bg-orange-700 hover:bg-orange-950' 
                      : 'bg-red-700 hover:bg-red-950'}
          `}          
            onClick={() => setGameState('worldSelect')}
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
            <div className="absolute top-10 right-10 flex items-center gap-2">
            <Trophy className="text-yellow-500" />
            <span className="text-2xl font-bold text-gray-900 dark:text-white">
                {totalStars} Stars
            </span>
            </div>
          </div>
        </div>
          
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {currentWorld.levels
            .filter(level => !level.id.includes('+'))
            .map((level) => {
              const hasChallengeMode = level.stars >= 3;
              const hasCompletedChallenge = level.stars > 3;
              const challengeLevelId = `${level.id}+`;
              const challengeLevel = currentWorld.levels.find(l => l.id === challengeLevelId);
              const isLevelLocked = totalStars < level.requiredStars;
  
              return (
                <div
                  key={level.id}
                  className={`rounded-lg shadow-lg p-6 ${
                    isLevelLocked 
                        ? `${theme === 'dark' 
                            ? 'bg-gray-900 cursor-not-allowed' 
                            : currentWorld.id === 2 
                                ? 'bg-orange-900 cursor-not-allowed' 
                                : 'bg-red-900 cursor-not-allowed'}` 
                        : `${theme === 'dark' 
                            ? currentWorld.id === 2 
                                ? 'cursor-pointer bg-orange-800 hover:bg-orange-900' 
                                : 'cursor-pointer bg-gray-800 hover:bg-gray-700' 
                            : currentWorld.id === 2 
                                ? 'cursor-pointer bg-orange-600 hover:bg-orange-900' 
                                : 'cursor-pointer bg-red-600 hover:bg-red-950'}`
                }
                 transition-colors duration-200`}
                       

                  onClick={() => {
                    if (!isLevelLocked && !hasChallengeMode) {
                      handleLevelSelect(level);
                    }
                  }}
                >
                  <div className="flex justify-between items-center mb-4">
                    <h2 className="text-xl font-semibold text-gray-900 dark:text-white">
                      {level.title}
                    </h2>
                    {isLevelLocked ? (
                      <div className="flex items-center gap-2">
                        <Lock className="text-gray-500 dark:text-gray-400" />
                        <span className="text-sm text-gray-500 dark:text-gray-400">
                          {level.requiredStars} stars needed
                        </span>
                      </div>
                    ) : (
                      <div className="flex gap-1">
                        {hasCompletedChallenge && (
                          <Star className="w-6 h-6 text-red-500 fill-red-500" />
                        )}
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
                  
                  {!isLevelLocked && (
                    <div className="space-y-2">
                      {hasCompletedChallenge ? (
                        <>
                          <button
                            className="w-full py-2 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600"
                            onClick={(e) => handleLevelSelect(level, e)}
                          >
                            Replay Level
                          </button>
                          <button
                            className="w-full py-2 bg-red-500 text-white rounded-lg hover:bg-red-600"
                            onClick={(e) => handleLevelSelect(challengeLevel, e)}
                          >
                            Replay Challenge
                          </button>
                        </>
                      ) : (
                        hasChallengeMode ? (
                          <>
                          <button
                            className="w-full py-2 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600"
                            onClick={(e) => handleLevelSelect(level, e)}
                          >
                            Replay Level
                          </button>
                          <button
                            className={`w-full py-2 
                                ${theme === 'dark' 
                                    ? 'bg-red-700 hover:bg-red-600' 
                                    : 'bg-red-800 hover:bg-red-600'}
                                text-white rounded-lg`}
                            onClick={(e) => handleLevelSelect(challengeLevel, e)}
                          >
                            Attempt Challenge
                          </button>
                          </>
                        ) : (
                          <div className="text-sm text-gray-500 dark:text-gray-400">
                            <div>3 ★: Complete in {level.starThresholds.three}s</div>
                            <div>2 ★: Complete in {level.starThresholds.two}s</div>
                            <div>1 ★: Complete in {level.starThresholds.one}s</div>
                          </div>
                        )
                      )}
                    </div>
                  )}
                </div>
              );
            })}
        </div>
      </div>
    );
  };