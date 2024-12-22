import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

const StyleSheet = () => (
  <style jsx global>{`
    *, *::before, *::after {
      transition: background-color 0.3s ease-in-out,
                  border-color 0.3s ease-in-out,
                  color 0.3s ease-in-out;
    }
  `}</style>
);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
