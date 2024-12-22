import React, { useState, useEffect, useRef } from 'react';

export const ClickTrainingLevel2 = ({ onComplete }) => {
  const [clicks, setClicks] = useState(0);
  const [progress, setProgress] = useState(0); // Tracks how far the gradient has progressed
  const requiredClicks = 5;
  const fallbackSpeed = 1; // Speed at which the gradient falls back
  const clickIncrement = 10; // How much the progress increases per click (adjust as needed)
  const buttonRef = useRef(null);

  useEffect(() => {
    if (progress >= 100) {
      onComplete();
    }
  }, [progress, onComplete]);

  useEffect(() => {
    const interval = setInterval(() => {
      setProgress((prevProgress) => Math.max(prevProgress - fallbackSpeed, 0)); // Gradually fall back
    }, 100);

    return () => clearInterval(interval);
  }, []);

  const handleClick = () => {
    setClicks((prev) => prev + 1);
    setProgress((prevProgress) => Math.min(prevProgress + clickIncrement, 100)); // Increase progress with each click
  };

  return (
    <div className="max-w-md mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white transition-colors duration-300">
        Click Training 2
      </h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        This is like level 1-2, but harder! Click the button enough times before the progress resets!
      </p>
      <div className="mb-4 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        Progress: {Math.min(progress, 100).toFixed(0)}%
      </div>
      <button
        ref={buttonRef}
        onClick={handleClick}
        className="relative bg-blue-500 text-white px-6 py-3 rounded-lg text-lg font-semibold
                   overflow-hidden transition-all duration-300"
        style={{
          background: `linear-gradient(to right, #00bfff ${progress}%, #1d4ed8 0)`,
        }}
      >
        <span className="relative z-10">Click Me!</span>
      </button>
    </div>
  );
};
