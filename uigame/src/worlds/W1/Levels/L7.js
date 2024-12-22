import React, { useState } from 'react';

export const RidiculousCaptcha = ({ onComplete }) => {
  const gridSize = 10; // 10x10 grid
  const totalBoxes = gridSize * gridSize;
  const [selectedBoxes, setSelectedBoxes] = useState([]);

  // Function to handle selecting a box
  const handleBoxClick = (index) => {
    if (selectedBoxes.includes(index)) {
      setSelectedBoxes(selectedBoxes.filter((i) => i !== index));
    } else {
      setSelectedBoxes([...selectedBoxes, index]);
    }

    // If the user selects at least 50% of the boxes, complete the challenge
    if (selectedBoxes.length + 1 >= totalBoxes / 2) {
      onComplete();
    }
  };

  return (
    <div className="text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white">
        Select all the boxes with a cat
      </h3>
      <p>(Hint: It's a tricky one! Select at least 50% of the boxes)</p>

      <div className="relative inline-block">
        {/* Background image (the cat image) */}
        <img
          src="https://images.unsplash.com/photo-1529778873920-4da4926a72c2?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y3V0ZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D"
          alt="Cat"
          className="w-full h-auto max-w-lg rounded-lg"
        />

        {/* Grid overlay */}
        <div
          className="absolute inset-0 grid grid-cols-10 grid-rows-10"
          style={{
            pointerEvents: 'none', // Prevents clicking through the boxes onto the image
          }}
        >
          {Array.from({ length: totalBoxes }, (_, index) => (
            <div
              key={index}
              className={`border border-gray-300 ${
                selectedBoxes.includes(index) ? 'bg-blue-500 opacity-50' : ''
              }`}
              style={{
                pointerEvents: 'all', // Allows clicking the boxes
                width: '100%', // Each box will take 1/10 of the container's width
                height: '100%', // Each box will take 1/10 of the container's height
              }}
              onClick={() => handleBoxClick(index)}
            />
          ))}
        </div>
      </div>

      <p className="mt-4 text-lg">
        {`You have selected ${selectedBoxes.length} / ${totalBoxes} boxes`}
      </p>
    </div>
  );
};
