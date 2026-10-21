# Razer Base Station V2 Chroma RGB Freeze Fix

### The Problem
When using the Razer Chroma Visualizer with 3 or more active Razer devices, the Razer Base Station V2 Chroma tends to freeze and become unresponsive during Windows startup. 

### The Solution
This lightweight automated script fixes the freezing issue by forcefully resetting the USB port power of the Base Station shortly after boot. Once the script runs silently in the background, the device reconnects and works flawlessly without freezing until the next PC restart.

### How It Works
It uses Windows native `pnputil` to remove the conflicting child devices and a third-party tool (`RestartUsbPort.exe`) to physically cut and restore power to the specific USB port.

### Installation & Setup (Task Scheduler)
To make this run automatically and silently at startup without UAC prompts:
1. Download all files (`Razer_Base_Station_V2_RGB_Fixer2.bat`, `Launch_this_at_every_startup.vbs`, and `RestartUsbPort.exe`) into a dedicated permanent folder (e.g., `C:\RazerFix\`).
2. Open **Task Scheduler** in Windows and click **Create Task...** (Do not use Basic Task).
3. **General Tab:** Name the task `RazerRGBFix` and check **Run with highest privileges** (Crucial!).
4. **Triggers Tab:** Click **New...**, set "Begin the task" to **At log on**, and click OK.
5. **Actions Tab:** 
   - Click **New...**
   - **Program/script:** `wscript.exe`
   - **Add arguments:** `"C:\RazerFix\Launch_this_at_every_startup.vbs"` (This VBS file is required because it silently launches the main `Razer_Base_Station_V2_RGB_Fixer2.bat` script in the background. Use your actual file path, WITH quotes).
   - **Start in:** `C:\RazerFix\` (Use your actual folder path, WITHOUT quotes).
6. **Conditions Tab:** Uncheck "Start the task only if the computer is on AC power".
7. Click OK to save the task. 

### Credits
The USB power cycling is handled by `RestartUsbPort.exe`, created by Uwe Sieber (www.uwe-sieber.de).
Scripts written by Raznus Framework. 
