import React, { useState, useEffect } from 'react';

export const SetAlarmLevel = ({ onComplete }) => {
  const [hours, setHours] = useState(1);
  const [minutes, setMinutes] = useState(0);
  const [ampm, setAmpm] = useState('AM');

  const [isHoursRunning, setIsHoursRunning] = useState(false);
  const [isMinutesRunning, setIsMinutesRunning] = useState(false);
  const [isAmpmRunning, setIsAmpmRunning] = useState(false);

  const targetHours = 7;
  const targetMinutes = 30;
  const targetAmpm = 'PM';

  // Update hours while running
  useEffect(() => {
    let interval;
    if (isHoursRunning) {
      interval = setInterval(() => {
        setHours((prev) => (prev % 12) + 1); // Loop between 1-12
      }, 500); // Speed at which hours spin
    }
    return () => clearInterval(interval);
  }, [isHoursRunning]);

  // Update minutes while running
  useEffect(() => {
    let interval;
    if (isMinutesRunning) {
      interval = setInterval(() => {
        setMinutes((prev) => (prev % 60) + 1); // Loop between 1-60
      }, 500); // Speed at which minutes spin
    }
    return () => clearInterval(interval);
  }, [isMinutesRunning]);

  // Update AM/PM while running
  useEffect(() => {
    let interval;
    if (isAmpmRunning) {
      interval = setInterval(() => {
        setAmpm((prev) => (prev === 'AM' ? 'PM' : 'AM')); // Toggle between AM and PM
      }, 500); // Speed at which AM/PM spins
    }
    return () => clearInterval(interval);
  }, [isAmpmRunning]);

  // Check if the selected time matches the target time
  const handleCheckCompletion = () => {
    if (hours === targetHours && minutes === targetMinutes && ampm === targetAmpm) {
      onComplete();
    } else {
      alert('Incorrect time! Try again.');
    }
  };

  return (
    <div className="max-w-md mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white transition-colors duration-300">
        Set Alarm
      </h3>
      <p className="mb-8 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        Set the alarm for 7:30 AM by pressing start and stop for each field!
      </p>

      <div className="mb-4 text-gray-700 dark:text-gray-200 transition-colors duration-300">
        <div className="flex justify-center items-center space-x-4">
          <div>
            <div className="text-4xl">{hours}</div>
            <button
              onClick={() => setIsHoursRunning(!isHoursRunning)}
              className="bg-blue-500 text-white px-4 py-2 mt-2 rounded-lg"
            >
              {isHoursRunning ? 'Stop' : 'Start'} Hours
            </button>
          </div>

          <div>
            <div className="text-4xl">{minutes.toString().padStart(2, '0')}</div>
            <button
              onClick={() => setIsMinutesRunning(!isMinutesRunning)}
              className="bg-blue-500 text-white px-4 py-2 mt-2 rounded-lg"
            >
              {isMinutesRunning ? 'Stop' : 'Start'} Minutes
            </button>
          </div>

          <div>
            <div className="text-4xl">{ampm}</div>
            <button
              onClick={() => setIsAmpmRunning(!isAmpmRunning)}
              className="bg-blue-500 text-white px-4 py-2 mt-2 rounded-lg"
            >
              {isAmpmRunning ? 'Stop' : 'Start'} AM/PM
            </button>
          </div>
        </div>
      </div>

      <button
        onClick={handleCheckCompletion}
        className="bg-green-500 text-white px-6 py-3 mt-4 rounded-lg text-lg font-semibold
                   hover:bg-green-600 transform transition-all duration-300 hover:scale-105
                   active:bg-green-700"
      >
        Set Alarm
      </button>
    </div>
  );
};
