#  UPI Expense Tracker

A Flutter-based Android application that automatically detects UPI transactions via SMS and helps users log expenses instantly with reminder support.

Built for Hackathon 

---

##  Problem Statement

Users frequently make UPI payments but forget to manually track their expenses.  
This leads to poor financial visibility and budgeting issues.

This app reduces friction by:

- Detecting UPI transactions from SMS
- Identifying debit or credit automatically
- Extracting transaction amount
- Prompting user via notification
- Allowing instant logging or reminder
- Storing entries locally

---

##  Features

-  SMS-based UPI transaction detection (Android only)
-  Automatic amount extraction (₹ / INR parsing)
-  Debit/Credit classification
-  Notification with:
  - Add Now
  - Remind Later
-  Manual expense entry
-  Category selection
-  Local storage using SQLite
-  Expense list view

---

## 🛠 Tech Stack

- Flutter
- Dart
- sqflite (Local Database)
- telephony (SMS listener – Android only)
- flutter_local_notifications
- Git + GitHub

---

## 📂 Project Structure
	lib/
	models/
	expense.dart
	db/
	expense_db.dart
	screens/
	expense_entry_screen.dart
	expense_list_screen.dart
	utils/
	sms_parser.dart
	

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the repository

  git clone https://github.com/gowrina725/UPI-expense-tracker.git
  cd UPI-expense-tracker
  
 
### 2️⃣ Install dependencies
  flutter pub get
  

### 3️⃣ Run on Android device
  flutter run
  

⚠ Note:
- SMS detection and SQLite work only on Android.
- Web (Chrome) does NOT support SMS or sqflite.

---

##  How It Works

1. User makes a UPI transaction.
2. Bank sends SMS.
3. App detects SMS via keyword matching:
   - "UPI"
   - "debited"
   - "credited"
4. App extracts:
   - Transaction amount
   - Transaction type
5. Notification appears:
   - Add Now → Opens entry screen
   - Remind Later → Schedules reminder
6. User selects category.
7. Expense is saved locally.

---

##  Platform Support

| Platform | Support |
|----------|----------|
| Android  | Yes |
| iOS      | No (SMS restrictions) |
| Web      | No (SMS & SQLite unsupported) |

---

##  Future Improvements

- Auto category detection
- Monthly analytics dashboard
- Export to CSV
- Cloud sync
- Bank API integration

---

##  Team

- UI & Database: Henna H Kabeer
- SMS & Notification Logic: Gowri Nandana

---

##  Hackathon Pitch

> A real-time UPI-aware expense tracker that reduces manual tracking effort through intelligent SMS parsing and smart reminder notifications.







