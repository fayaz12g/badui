// worlds/W1/levels/L3.js
import React, { useState, useEffect } from 'react';

export const FontSizeChallengeLevel = ({ onComplete }) => {
  const [fontSize, setFontSize] = useState(10);
  const [sliderRange, setSliderRange] = useState([1, 10]);
  const [sliderValue, setSliderValue] = useState(1);
  const [error, setError] = useState('');

  // Predefined ranges for the sliders
  const ranges = [
    [1, 10],
    [11, 20],
    [21, 30],
    [31, 40],
  ];

  // Randomize the slider ranges on initial render
  useEffect(() => {
    const shuffledRanges = [...ranges].sort(() => Math.random() - 0.5);
    setSliderRange(shuffledRanges[0]);  // Set the first random range as the range for Slider 1
  }, []);

  // Function to update font size based on Slider 2 value
  const handleSlider2Change = (value) => {
    // Ensure the value is within the bounds of the current slider range
    const adjustedValue = Math.min(Math.max(value, sliderRange[0]), sliderRange[1]);
    setSliderValue(adjustedValue);
    setFontSize(adjustedValue);
  };

  // Function to handle Slider 1 (range selector)
  const handleSlider1Change = (value) => {
    const newRange = ranges[value];
    setSliderRange(newRange);
    setSliderValue(newRange[0]); // Reset to the lower value of the new range
    setFontSize(newRange[0]); // Adjust the font size to the new range's lower value
  };

  // Function to check if the level is complete
  const checkCompletion = () => {
    if (fontSize === 20) {
      onComplete();
    } else {
      setError('Font size is not correct! Try adjusting the sliders.');
    }
  };

  return (
    <div className="max-w-md mx-auto text-center bg-gray-100 p-6 rounded-lg shadow-lg">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white">Font Size Challenge</h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200">
        Adjust the font size to 20 by manipulating the sliders below. 
        The ranges for the font size slider are shuffled, and the sliders are out of order. 
        Can you make the text readable?
      </p>

      <div className="mb-6">
        <div
          className="mb-4 text-lg text-gray-900 dark:text-white"
          style={{ fontSize: `${fontSize}px` }}
        >
          Example text in the eReader view. Adjust the font size to make it readable.
        </div>
      </div>

      <div className="mb-6">
        <h4 className="text-lg mb-2 text-gray-900 dark:text-white">Select Range for Font Size:</h4>
        <input
          type="range"
          min="0"
          max="3"
          value={ranges.indexOf(sliderRange)}
          onChange={(e) => handleSlider1Change(Number(e.target.value))}
          className="w-full h-2 bg-gray-300 rounded-lg"
        />
        <div className="flex justify-between text-gray-700 dark:text-gray-200">
          <span>{sliderRange[0]}</span>
          <span>{sliderRange[1]}</span>
        </div>
      </div>

      <div className="mb-6">
        <h4 className="text-lg mb-2 text-gray-900 dark:text-white">Set Font Size:</h4>
        <input
          type="range"
          min={sliderRange[0]}
          max={sliderRange[1]}
          value={sliderValue}
          onChange={(e) => handleSlider2Change(Number(e.target.value))}
          className="w-full h-2 bg-gray-300 rounded-lg"
        />
        <div className="text-gray-700 dark:text-gray-200">{sliderValue}</div>
      </div>

      {error && <p className="text-red-500 mb-4">{error}</p>}

      <button
        onClick={checkCompletion}
        className="bg-green-500 text-white px-6 py-3 rounded-lg text-lg font-semibold hover:bg-green-600"
      >
        Check Font Size
      </button>
    </div>
  );
};

export default FontSizeChallengeLevel;