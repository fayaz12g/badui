import React, { useState, useEffect } from 'react';
import baduilogo from '../../../components/baduilogo.png'

// On-screen keyboard keys in alphabetical order
const keyboardKeys = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

export const OnScreenKeyboardLevel = ({ onComplete }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [currentField, setCurrentField] = useState('username'); // Track current field (username or password)
  const [isShiftActive, setIsShiftActive] = useState(false); // Track Shift key state

  const correctUsername = 'Fayaz';
  const correctPassword = 'fayazisCOOL';

  const handleKeyPress = (key) => {
    if (isShiftActive) {
      key = key.toUpperCase(); // Make the key uppercase if Shift is active
      setIsShiftActive(false); // Reset Shift key state after use
    } else {
      key = key.toLowerCase(); // Default to lowercase
    }

    if (currentField === 'username') {
      setUsername(username + key);
    } else if (currentField === 'password') {
      setPassword(password + key);
    }
  };

  const handleBackspace = () => {
    if (currentField === 'username' && username.length > 0) {
      setUsername(username.slice(0, -1)); // Remove last character from username
    } else if (currentField === 'password' && password.length > 0) {
      setPassword(password.slice(0, -1)); // Remove last character from password
    }
  };

  const handleShiftToggle = () => {
    setIsShiftActive(!isShiftActive); // Toggle Shift key state
  };

  const handleLogin = () => {
    if (username === correctUsername && password === correctPassword) {
      onComplete();
    } else {
      setError('Incorrect username or password.');
    }
  };

  // Disable wired keyboard input for the fields
  const handleFieldChange = (e) => {
    e.preventDefault(); // Prevent typing from wired keyboard
  };

  useEffect(() => {
    // Prevent default behavior for keyboard events (wired keyboard) on both fields
    const handleKeyDown = (e) => {
      if (e.target.type === 'text' || e.target.type === 'password') {
        e.preventDefault(); // Prevent the wired keyboard from affecting the fields
      }
    };

    window.addEventListener('keydown', handleKeyDown);

    // Clean up event listener on component unmount
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, []);

  return (
    <div className="flex flex-col items-center justify-center h-screen">
      {/* Prompt Text Outside the Main Box */}
      <div className="text-center text-white mb-6">
        <p><strong>Log into your social media, this is your username and password:</strong></p>
        <p><strong>Username:</strong> {correctUsername}</p>
        <p><strong>Password:</strong> {correctPassword}</p>
      </div>

      <div className="max-w-md mx-auto text-center bg-gray-100 p-6 rounded-lg shadow-lg">
        <img src={baduilogo} alt="BadUI Logo" className="mx-auto mb-6" />
        <h3 className="text-2xl mb-4 text-gray-900 dark:text-black">Login to FakeSocial</h3>
        
        <div className="mb-4">
          <input
            type="text"
            value={username}
            onChange={handleFieldChange} // Disable wired keyboard for username
            className="w-full p-2 mb-4 text-center text-lg border rounded-lg"
            placeholder="Username"
            onClick={() => setCurrentField('username')} // Switch to username field when clicked
          />
        </div>

        <div className="mb-4">
          <input
            type="password"
            value={password}
            onChange={handleFieldChange} // Disable wired keyboard for password
            className="w-full p-2 mb-4 text-center text-lg border rounded-lg"
            placeholder="Password"
            onClick={() => setCurrentField('password')} // Switch to password field when clicked
          />
        </div>

        {error && <p className="text-red-500 mb-4">{error}</p>}

        <div className="grid grid-cols-6 gap-2 mb-6">
          {keyboardKeys.map((key) => (
            <button
              key={key}
              onClick={() => handleKeyPress(key)}
              className="bg-blue-500 text-white p-3 rounded-lg text-xl hover:bg-blue-600"
            >
              {key}
            </button>
          ))}
        </div>

        {/* Shift Button */}
        <div className="mb-4">
          <button
            onClick={handleShiftToggle}
            className="bg-yellow-500 text-white p-3 rounded-lg text-xl hover:bg-yellow-600"
          >
            Shift
          </button>
        </div>

        {/* Backspace Button */}
        <div className="mb-4">
          <button
            onClick={handleBackspace}
            className="bg-red-500 text-white p-3 rounded-lg text-xl hover:bg-red-600"
          >
            Backspace
          </button>
        </div>

        <button
          onClick={handleLogin}
          className="bg-green-500 text-white px-6 py-3 rounded-lg text-lg font-semibold hover:bg-green-600"
        >
          Log In
        </button>
      </div>
    </div>
  );
};

export default OnScreenKeyboardLevel;
