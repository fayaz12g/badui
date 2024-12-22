import logo from './logo.svg';
import './App.css';
import Game from './Game';

const StyleSheet = () => (
  <style jsx global>{`
    *, *::before, *::after {
      transition: background-color 0.3s ease-in-out,
                  border-color 0.3s ease-in-out,
                  color 0.3s ease-in-out;
    }
  `}</style>
);

function App() {
  return <Game />;
}

export default App;
