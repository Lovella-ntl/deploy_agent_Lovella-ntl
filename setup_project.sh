#!/bin/bash
read -p "Enter project name:" name
PROJECT="attendance_tracker_$name"
echo "Creating project: $PROJECT"
mkdir -p "attendance_tracker_$name/Helpers"
mkdir -p "attendance_tracker_$name/reports"
cleanup() {
	echo "Interrupt detected! Archiving project..."
	tar -czf "${PROJECT}_archive.tar.gz" "$PROJECT"  2>/dev/null
	rm -rf "PROJECT"
	echo "Cleaned and archived."
	exit 1
}
trap cleanup SIGINT
cp attendance_checker.py "$PROJECT/attendance_checker.py"
cp assets.csv "$PROJECT/Helpers/assets.csv"
cp config.json "$PROJECT/Helpers/config.json"
cp reports.log "$PROJECT/reports/reports.log"
read -p "Do you want to update thresholds? (y/n):" choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
if [ "$choice" = "y" ] || [ "$choice" = "yes" ]; then
	read -p "Enter warning threshold(%): " warn
	read -p "Enter failure threshold(%): " fail
  if [[ -z "$warn" || -z "$fail" ]]; then
        echo " Error: Threshold values cannot be empty."
        exit 1
    fi
  if ! [[ "$warn" =~ ^[0-9]+$ && "$fail" =~ ^[0-9]+$ ]]; then
        echo " Invalid input: Please enter whole numbers only (e.g. 80, 50)."
        exit 1
    fi
 if (( warn < 0 || warn > 100 || fail < 0 || fail > 100 )); then
        echo " Invalid range: Values must be between 0 and 100."
        exit 1
    fi
  if (( warn <= fail )); then
        echo " Warning threshold must be GREATER than failure threshold."
        exit 1
    fi

    sed -i "s/\"warning\": 75/\"warning\": $warn/" "$PROJECT/Helpers/config.json"
    sed -i "s/\"failure\": 50/\"failure\": $fail/" "$PROJECT/Helpers/config.json"

elif [ "$choice" = "n" ] || [ "$choice" = "no" ]; then
    echo "Keeping default thresholds (Warning: 75, Failure: 50)"
else
    echo "Invalid input. Keeping default thresholds."
fi
if python3 --version >/dev/null 2>&1; then
    echo "Python3 is installed."
else
    echo "Warning: Python3 is NOT installed!"
fi

