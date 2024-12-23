// src/components/ui/Alert.js

import React from 'react';

export const alert = ({ message, onClose }) => {
  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
      <div className="bg-white p-6 rounded-xl shadow-lg w-80">
        <div className="text-center">
          <p className="text-lg font-semibold text-gray-800">{message}</p>
          <div className="mt-4">
            <button
              className="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600"
              onClick={onClose}
            >
              OK
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
