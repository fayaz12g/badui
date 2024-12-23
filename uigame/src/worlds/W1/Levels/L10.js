import React, { useState } from 'react';

export const CrazyCalculatorLevel = ({ onComplete }) => {
  const [display, setDisplay] = useState('');
  const [result, setResult] = useState('');
  const [error, setError] = useState('');

  // Helper function to convert a numerical result into a word (e.g., 8 -> "eight")
  const numberToWord = (num) => {
    const numWords = {
      0: 'zero',
      1: 'one',
      2: 'two',
      3: 'three',
      4: 'four',
      5: 'five',
      6: 'six',
      7: 'seven',
      8: 'eight',
      9: 'nine',
      10: 'ten',
      11: 'eleven',
      12: 'twelve',
      13: 'thirteen',
      14: 'fourteen',
      15: 'fifteen',
      16: 'sixteen',
      17: 'seventeen',
      18: 'eighteen',
      19: 'nineteen',
      20: 'twenty',
      30: 'thirty',
      40: 'forty',
      50: 'fifty',
      60: 'sixty',
      70: 'seventy',
      80: 'eighty',
      90: 'ninety',
    };
    
    if (num <= 20) {
      return numWords[num] || num.toString();
    }

    // Handle numbers from 21 and above
    const tens = Math.floor(num / 10) * 10;
    const ones = num % 10;
    
    if (ones === 0) {
      return numWords[tens];
    }
    
    return `${numWords[tens]}-${numWords[ones]}`;
  };

  // Function to handle button presses (for all buttons except backspace)
  const handleButtonClick = (value) => {
    setDisplay(display + value);
  };

  // Function to handle the calculation (explicitly handle ^ for exponentiation)
  const handleCalculate = () => {
    try {
      let calcResult;

      // Explicitly handle exponentiation with Math.pow
      if (display.includes('^')) {
        // Split the expression on '^' and calculate the exponentiation
        const [base, exponent] = display.split('^').map(Number);
        calcResult = Math.pow(base, exponent);
        setResult(calcResult);  // Display the numeric result
            // Check if the result is 8 (numerically), then trigger onComplete
            if (calcResult === 8) {
                onComplete();
            }
      } else {
        // For regular operations (+, -, *, /), use eval safely
        calcResult = eval(display);
        setResult(calcResult);  // Store the numeric result
      }

      // If result is from an exponentiation, always show it as a number
      if (display.includes('^')) {
        setResult(calcResult);  // Display the result as a number for exponents
      } else {
        // Convert normal results to words
        setResult(numberToWord(calcResult));
      }

    } catch (error) {
      setError('Error in calculation. Please enter a valid expression.');
    }
  };

  // Function to handle the backspace action
  const handleBackspace = () => {
    setDisplay(display.slice(0, -1)); // Remove the last character
  };

  // Button layout for the calculator (normal buttons and exponentiation)
  const buttons = [
    ['1', '2', '3', '4'],
    ['5', '6', '7', '8'],
    ['9', '0', '^', '/'],
    ['+', '-', '*', 'C'], // Replaced = with C for backspace
  ];

  return (
    <div className="max-w-md mx-auto text-center bg-gray-950 p-6 rounded-lg shadow-lg">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white">Crazy Calculator</h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200">
        Calculate the result of 4+4 in numerical value.
      </p>

      <div className="mb-6">
        <input
          type="text"
          value={display}
          readOnly
          className="w-full p-4 text-center text-lg border rounded-lg mb-4"
          placeholder="Enter calculation"
        />
      </div>

      <div className="mb-6">
        <input
          type="text"
          value={typeof result === 'number' ? result : result} // Show result as a word or number
          readOnly
          className="w-full p-4 text-center text-lg border rounded-lg mb-4"
          placeholder="Result"
        />
      </div>

      {error && <p className="text-red-500 mb-4">{error}</p>}

      <div className="grid grid-cols-4 gap-4 mb-6">
        {buttons.flat().map((btn) => (
          <button
            key={btn}
            onClick={() => {
              if (btn === 'C') {
                handleBackspace(); // Handle backspace
              } else {
                handleButtonClick(btn); // Handle number/operator button click
              }
            }}
            className={`${
              btn === 'C' ? 'bg-red-500' : 'bg-blue-500'
            } text-white p-3 rounded-lg text-xl hover:bg-blue-600`}
          >
            {btn === 'C' ? 'Del' : btn}
          </button>
        ))}
      </div>

      <button
        onClick={handleCalculate}
        className="bg-green-500 text-white px-6 py-3 rounded-lg text-lg font-semibold hover:bg-green-600"
      >
        Calculate
      </button>
    </div>
  );
};

export default CrazyCalculatorLevel;
