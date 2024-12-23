import React, { useState } from 'react';
import { ChevronRight, Bluetooth, Wifi, Globe, Shield, Phone, Bell, Battery, CloudRain } from 'lucide-react';
import { eulaText } from './eula';  
import { useTheme } from '../../../components/Theme';

const CustomAlert = ({ message, onClose }) => {
  const { theme } = useTheme();
  const alertBg = theme === 'dark' ? 'bg-gray-800' : 'bg-white';
  const textColor = theme === 'dark' ? 'text-white' : 'text-black';
  return (
    <div
      className={`fixed top-1/4 left-1/2 transform -translate-x-1/2 w-80 p-6 rounded-xl shadow-lg ${alertBg}`}
      style={{ zIndex: 1000 }}
    >
      <div className={`${textColor} text-lg`}>{message}</div>
      <button
        className={`mt-4 w-full py-2 rounded-lg ${theme === 'dark' ? 'bg-blue-500' : 'bg-blue-600'} text-white`}
        onClick={onClose}
      >
        OK
      </button>
    </div>
  );
};

export const SettingsMazeLevelPlus = ({ onComplete }) => {
  const { theme } = useTheme();
  const [currentScreen, setCurrentScreen] = useState('main');
  const [showAlert, setShowAlert] = useState(false);
  const [alertMessage, setAlertMessage] = useState('');
  const [settings, setSettings] = useState({
    bluetooth: false,
    airplaneMode: true,
    location: false,
    eulaAccepted: false,
    wifi: false,
    notifications: true,
    batteryOptimization: true,
    weatherAlerts: false,
    bluetootha: false,
    bluetooths: false,
  });


  const [hasAttemptedBluetooth, setHasAttemptedBluetooth] = useState(false);
  const [hasAttemptedAirplane, setHasAttemptedAirplane] = useState(false);
  const [hasScrolledEula, setHasScrolledEula] = useState(false);

  const showError = (message) => {
    setAlertMessage(message);
    setShowAlert(true);
  };

  
  const handleToggle = (setting) => {
    if (setting === 'bluetooth' && settings.airplaneMode) {
        if (!settings.bluetooth && !settings.airplaneMode) {
          setSettings((prev) => ({ ...prev, bluetootha: true })); // turn on airpods
        } else {
          showError('Cannot turn on Bluetooth while Airplane Mode is on');
          setSettings((prev) => ({ ...prev, bluetooth: !prev.bluetooth }));
        }
      }


      if (setting === 'bluetooth' && settings.blutooth) {
        setSettings((prev) => ({ ...prev, bluetootha: false })); // turn off all blutooth connections
      }

      
    if (setting === 'airplaneMode' && !hasAttemptedAirplane && !settings.location) {
      setHasAttemptedAirplane(true);
      showError('Location services required to verify flight status');
      return;
    }

    if (setting === 'location' && !settings.eulaAccepted) {
      showError('Please accept EULA before enabling location services');
      return;
    }

    if (setting === 'airplaneMode' && settings.location === false) {
      showError('Airplane mode can only be enabled when location services are on');
      return;
    }

    setSettings((prev) => ({ ...prev, [setting]: !prev[setting] }));

    // Check win condition
    if (setting === 'bluetooth' && settings.airplaneMode === false) {
      setCurrentScreen('bluetoothDevices');
    }
  };

  const handleEulaAccept = () => {
    if (!hasScrolledEula) {
      showError('Please read the entire EULA first');
      return;
    }
    setSettings((prev) => ({ ...prev, eulaAccepted: true }));
    setCurrentScreen('main');
  };


  const MenuItem = ({ icon, title, toggle, value, onClick }) => (
    <div
      className="flex items-center justify-between p-4 border-b border-gray-200 cursor-pointer hover:bg-gray-50"
      onClick={onClick}
    >
      <div className="flex items-center gap-4">
        {icon}
        <span className="text-gray-900">{title}</span>
      </div>
      {toggle ? (
        <div
          className={`w-12 h-6 rounded-full transition-colors duration-200 ${value ? 'bg-green-500' : 'bg-gray-300'}`}
        >
          <div
            className={`w-4 h-4 rounded-full bg-white m-1 transition-transform duration-200 ${value ? 'translate-x-6' : ''}`}
          />
        </div>
      ) : (
        <ChevronRight className="text-gray-400" />
      )}
    </div>
  );

  const handleBluetoothConnect = () => {
    if (!settings.bluetooth) {
      showError('Please turn on Bluetooth to connect to a device');
      return;
    }
    // Simulate Bluetooth connection logic
    showError('Bluetooth connected to device');
    // Trigger onComplete when Bluetooth connects
    onComplete();
  };

  const screens = {
   
    main: (
        <div>
        <h3 className="text-2xl mb-4 text-gray-900 dark:text-white">Connect your phone to the speakers</h3>
      <div className="h-full">
        <div className="bg-gray-100 p-4">
          <h2 className="text-xl font-semibold text-gray-900">Settings</h2>
        </div>
        <MenuItem
          icon={<Wifi className="text-blue-500" />}
          title="Wi-Fi"
          toggle={false}
          onClick={() => setCurrentScreen('wifiDevices')}
        />
        <MenuItem
          icon={<Bluetooth className="text-blue-500" />}
          title="Bluetooth"
          toggle={false}
          onClick={() => setCurrentScreen('bluetoothDevices')}
        />
        <MenuItem
          icon={<Globe className="text-orange-500" />}
          title="Airplane Mode"
          toggle={true}
          value={settings.airplaneMode}
          onClick={() => handleToggle('airplaneMode')}
        />
        <MenuItem
          icon={<Shield className="text-green-500" />}
          title="Privacy & Security"
          onClick={() => setCurrentScreen('privacy')}
        />
        <MenuItem
          icon={<Bell className="text-red-500" />}
          title="Notifications"
          toggle={true}
          value={settings.notifications}
          onClick={() => handleToggle('notifications')}
        />
        <MenuItem
            icon={<Battery className="text-green-500" />}
            title="Battery"
            toggle={false}
            onClick={() => setCurrentScreen('batterySettings')}
        />
        <MenuItem
          icon={<CloudRain className="text-blue-500" />}
          title="Weather Alerts"
          toggle={true}
          value={settings.weatherAlerts}
          onClick={() => handleToggle('weatherAlerts')}
        />
        <MenuItem
          icon={<Phone className="text-gray-500" />}
          title="Legal & Regulatory"
          onClick={() => setCurrentScreen('eula')}
        />
      </div>
      </div>
    ),
    batterySettings: (
        <div className="h-full">
          <div className="bg-gray-100 p-4 flex items-center gap-2">
            <ChevronRight
              className="rotate-180 cursor-pointer"
              onClick={() => setCurrentScreen('main')}
            />
            <h2 className="text-xl font-semibold text-gray-900">Battery Settings</h2>
          </div>
          <MenuItem
            icon={<Battery className="text-green-500" />}
            title="Optimized Charging"
            toggle={true}
            value={settings.batteryOptimization}
            onClick={() => handleToggle('batteryOptimization')}
          />
          <MenuItem
            icon={<Battery className="text-green-500" />}
            title="Battery Health"
            toggle={false}
            value={settings.batteryHealth}
            onClick={() => showError('Battery Health is at 85%')}
          />
        </div>
      ),
    privacy: (
      <div className="h-full">
        <div className="bg-gray-100 p-4 flex items-center gap-2">
          <ChevronRight
            className="rotate-180 cursor-pointer"
            onClick={() => setCurrentScreen('main')}
          />
          <h2 className="text-xl font-semibold text-gray-900">Privacy & Security</h2>
        </div>
        <MenuItem
          icon={<Globe className="text-green-500" />}
          title="Location Services"
          toggle={true}
          value={settings.location}
          onClick={() => handleToggle('location')}
        />
      </div>
    ),
    eula: (
      <div className="h-full flex flex-col">
        <div className="bg-gray-100 p-4 flex items-center gap-2">
          <ChevronRight
            className="rotate-180 cursor-pointer"
            onClick={() => setCurrentScreen('main')}
          />
          <h2 className="text-xl font-semibold text-gray-900">EULA</h2>
        </div>
        <div className="flex-1 p-4 overflow-y-auto" onScroll={(e) => {
                if (e.target.scrollHeight - e.target.scrollTop === e.target.clientHeight / 4) {
                setHasScrolledEula(true);
                }
            }}>
            {eulaText()}
            <label className="flex items-center">
            <input
              type="checkbox"
              className="mr-2"
              checked={hasScrolledEula}
              onChange={() => setHasScrolledEula(!hasScrolledEula)}
            />
            I have read the EULA
          </label>
            </div>

        <div className="p-4 border-t">
          <button
            className="w-full bg-blue-500 text-white py-2 rounded-lg"
            onClick={handleEulaAccept}
          >
            Accept
          </button>
        </div>
      </div>
    ),
    wifiDevices: (
      <div className="h-full">
        <div className="bg-gray-100 p-4 flex items-center gap-2">
          <ChevronRight
            className="rotate-180 cursor-pointer"
            onClick={() => setCurrentScreen('main')}
          />
          <h2 className="text-xl font-semibold text-gray-900">Wi-Fi Devices</h2>
        </div>
        <div className="p-4">
          <div className="p-4 border rounded-lg cursor-pointer hover:bg-gray-50">
            <div className="font-semibold">Home Network</div>
            <div className="text-sm text-gray-500">Connected</div>
          </div>
          <div className="p-4 border rounded-lg cursor-pointer hover:bg-gray-50">
            <div className="font-semibold">Coffee Shop Wi-Fi</div>
            <div className="text-sm text-gray-500">Not Connected</div>
          </div>
        </div>
      </div>
    ),
    bluetoothDevices: (
        
        <div className="h-full">
            
        <div className="bg-gray-100 p-4 flex items-center gap-2">
          <ChevronRight
            className="rotate-180 cursor-pointer"
            onClick={() => setCurrentScreen('main')}
          />
          <h2 className="text-xl font-semibold text-gray-900">Bluetooth Devices</h2>
        </div>
    
        <MenuItem
  icon={<Bluetooth className="text-blue-500" />}
  title="Bluetooth"
  toggle={true}
  value={settings.bluetooth}
  onClick={() => handleToggle('bluetooth')}
/>
<div className="p-4">
  <div
    className="p-4 border rounded-lg cursor-pointer hover:bg-gray-50"
    onClick={() => {
      if (!settings.bluetooth) {
        showError('Please turn on Bluetooth to connect to a device');
        return;
      }
      // If Bluetooth is on, toggle the AirPods connection state
      const newState = !settings.bluetootha; // Flip the state of Bluetooth for airpods
      setSettings((prev) => ({ ...prev, bluetootha: newState }));

    }}
  >
    <div className="font-semibold">AirPods</div>
    <div className="text-sm text-gray-500">{settings.bluetootha ? 'Connected' : 'Not Connected'}</div>
  </div>

  <div
    className="p-4 border rounded-lg cursor-pointer hover:bg-gray-50"
    onClick={() => {
      if (!settings.bluetooth) {
        showError('Please turn on Bluetooth to connect to a device');
        return;
      }
      // If Bluetooth is on, toggle the Speaker connection state
      const newState = !settings.bluetooths; // Flip the state of Bluetooth for speaker
      setSettings((prev) => ({ ...prev, bluetooths: newState }));

      if (newState) {
        // Trigger onComplete when the speaker is connected
        onComplete();
      }
    }}
  >
    <div className="font-semibold">Speaker</div>
    <div className="text-sm text-gray-500">{settings.bluetooths ? 'Connected' : 'Not Connected'}</div>
  </div>
</div>  
</div>  
    ),
  };

  return (
    <div className="max-w-md mx-auto bg-white h-[600px] rounded-xl shadow-lg overflow-hidden relative">
      {showAlert && <CustomAlert message={alertMessage} onClose={() => setShowAlert(false)} />}
      {screens[currentScreen]}
    </div>
  );
};

export default SettingsMazeLevelPlus;
