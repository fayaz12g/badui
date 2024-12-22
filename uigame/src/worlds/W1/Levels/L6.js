import React, { useState, useEffect } from 'react';

// Utility function to shuffle an array
const shuffleArray = (array) => {
  return array.sort(() => Math.random() - 0.5);
};

export const DateOfBirthLevel = ({ onComplete }) => {
  const [selectedDay, setSelectedDay] = useState('');
  const [selectedMonth, setSelectedMonth] = useState('');
  const [selectedYear, setSelectedYear] = useState('');
  const [shuffledMonths, setShuffledMonths] = useState([]);
  const [shuffledDays, setShuffledDays] = useState([]);
  const [shuffledYears, setShuffledYears] = useState([]);

  // Initialize months, days, and years only once
  useEffect(() => {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    const days = [...Array(31).keys()].map(i => i + 1);
    const years = [...Array(31).keys()].map(i => i + 1980);

    setShuffledMonths(shuffleArray(months));
    setShuffledDays(shuffleArray(days));
    setShuffledYears(shuffleArray(years));
  }, []); // Empty dependency array ensures this runs only once on mount

  // Handle form submission
  const handleSubmit = () => {
    if (selectedDay === '22' && selectedMonth === 'June' && selectedYear === '2002') {
      onComplete(); // Level complete if the correct date is selected
    } else {
      alert('Incorrect date, try again.');
    }
  };

  return (
    <div className="max-w-md mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white">
        Fill in your date of birth: June 22, 2002
      </h3>
      
      {/* Month dropdown */}
      <div className="mb-4">
        <label htmlFor="month" className="block text-lg mb-2">Month</label>
        <select
          id="month"
          value={selectedMonth}
          onChange={(e) => setSelectedMonth(e.target.value)}
          className="w-full px-4 py-2 border rounded-lg"
        >
          <option value="">Select Month</option>
          {shuffledMonths.map((month, index) => (
            <option key={index} value={month}>{month}</option>
          ))}
        </select>
      </div>

      {/* Day dropdown */}
      <div className="mb-4">
        <label htmlFor="day" className="block text-lg mb-2">Day</label>
        <select
          id="day"
          value={selectedDay}
          onChange={(e) => setSelectedDay(e.target.value)}
          className="w-full px-4 py-2 border rounded-lg"
        >
          <option value="">Select Day</option>
          {shuffledDays.map((day, index) => (
            <option key={index} value={day}>{day}</option>
          ))}
        </select>
      </div>

      {/* Year dropdown */}
      <div className="mb-4">
        <label htmlFor="year" className="block text-lg mb-2">Year</label>
        <select
          id="year"
          value={selectedYear}
          onChange={(e) => setSelectedYear(e.target.value)}
          className="w-full px-4 py-2 border rounded-lg"
        >
          <option value="">Select Year</option>
          {shuffledYears.map((year, index) => (
            <option key={index} value={year}>{year}</option>
          ))}
        </select>
      </div>

      <button
        onClick={handleSubmit}
        className="bg-blue-500 text-white px-4 py-2 mt-4 rounded-lg w-full"
      >
        Submit
      </button>
    </div>
  );
};
