import React, { useState } from 'react';

export const MoneySliderLevel = ({ onComplete }) => {
  const [sliderValue, setSliderValue] = useState(0); // Value of the slider
  const maxAmount = 100;
  const targetAmount = 74.23;
  const threshold = 1; // Acceptable threshold for completing the level

  const handleSliderChange = (e) => {
    const value = parseFloat(e.target.value);
    setSliderValue(value);
  };

  const handleSendClick = () => {
    // Check if the slider value is close enough to the target amount
    if (Math.abs(sliderValue - targetAmount) <= threshold) {
      onComplete();
    } else {
      alert('Incorrect amount! Try again.');
    }
  };

  return (
    <div className="max-w-md mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white transition-colors duration-300">
        Send Money
      </h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        Send the client $74.23. Hint: There's a $1 threshold.
      </p>
      <div className="mb-4 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        Current Amount: ${sliderValue.toFixed(2)}
      </div>

      <div className="relative w-full h-20 flex justify-center items-center">
        {/* SVG path for the slider's unique track */}
        <svg viewBox="0 0 200 50" className="absolute w-full h-full">
          <path
            d="M10,40 C20,10 60,10 80,30 S130,50 170,10" // A basic curved path that can be customized to match "Send"
            stroke="#1d4ed8"
            strokeWidth="6"
            fill="none"
          />
        </svg>

        <input
          type="range"
          min="0"
          max={maxAmount}
          step="0.01"
          value={sliderValue}
          onChange={handleSliderChange}
          className="w-full h-6 bg-transparent appearance-none relative"
          style={{ position: 'relative', zIndex: 10 }}
        />
      </div>

      <button
        onClick={handleSendClick}
        className="bg-blue-500 text-white px-6 py-3 mt-4 rounded-lg text-lg font-semibold
                   hover:bg-blue-600 transform transition-all duration-300 hover:scale-105
                   active:bg-blue-700"
      >
        Send ${sliderValue.toFixed(2)}
      </button>
    </div>
  );
};
