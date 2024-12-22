import React, { useState, useEffect } from 'react';
import { useTheme } from './Theme';

export const MainMenu = ({ onStart }) => {
  const [visible, setVisible] = useState(true);
  const { theme } = useTheme();
  
  useEffect(() => {
    const interval = setInterval(() => {
      setVisible(v => !v);
    }, 800);
    return () => clearInterval(interval);
  }, []);

  return (
    <div 
      className={`
        min-h-screen cursor-pointer
        ${theme === 'dark' 
          ? 'bg-gradient-to-b from-gray-900 to-gray-800' 
          : 'bg-gradient-to-b from-red-600 to-red-950'}
        flex flex-col items-center justify-center
        transition-colors duration-300
      `}
      onClick={onStart}
    >
      <h1 className="text-6xl font-bold text-white mb-8 text-center">
        UI Challenge
      </h1>
      <div className="text-2xl text-yellow-300 transition-opacity duration-300"
           style={{ opacity: visible ? 1 : 0 }}>
        Click Anywhere to Begin
      </div>
    </div>
  );
};