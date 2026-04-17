 Attendance Tracker Project Factory

 Overview
This project is a Bash script that automates the setup of a Student Attendance Tracker system. It creates the full project structure, generates required files, allows configuration updates, and safely handles interruptions during execution.

 Objective
The objective of this project is to demonstrate shell scripting automation by creating directories, generating files, handling user input, modifying configuration files using sed, and managing system signals such as Ctrl + C.

 Installation
Clone the repository and navigate into the project folder:

git clone https://github.com/<your-username>/deploy_agent_<your-username>.git
cd deploy_agent_<your-username>

Give execution permission to the script:
chmod +x setup_project.sh

 Usage

Run the script using:
bash setup_project.sh

Follow the prompts:

Enter a project name
Choose whether to update attendance thresholds
If you choose to update thresholds, the script will ask for new values and update them in the configuration file using sed.

 Resource D6eployment

When executed, the script automatically deploys the following project structure:
attendance_tracker_<name>/
 ├── attendance_checker.py
 ├── Helpers/
 │ ├── assets.csv
 │ └── config.json
 └── reports/
 └── reports.log

attendance_checker.py → Processes attendance data
assets.csv → Contains student attendance records
config.json → Stores configuration settings (thresholds, mode, sessions)
reports.log → Stores generated attendance reports

 Configuration Update (sed)

The script uses sed to modify the threshold values in config.json:
sed -i "s/\"warning\": [0-9]*/\"warning\": <value>/" config.json
sed -i "s/\"failure\": [0-9]*/\"failure\": <value>/" config.json

 Interrupt Handling (Ctrl + C)

If the script is interrupted:
Ctrl + C
It will:

Archive the current project:
tar -czf attendance_tracker_<name>_archive.tar.gz attendance_tracker_<name>
Remove the incomplete project folder:
rm -rf attendance_tracker_<name>

 Environment Check

The script verifies if Python3 is installed:
python3 --version

 Validation

At the end of execution, the script checks that all required directories and files were created successfully.

 Technologies Used

Bash (Shell scripting)
sed (file editing)
Python (attendance processing logic)

Description video link: https://drive.google.com/file/d/1S01XE1MoWe8bNIrVilDDPNTf3AnpVhhq/view?usp=drive_link


