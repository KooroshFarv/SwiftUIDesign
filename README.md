# GMJK Lockers 🔒

Locker Rental System is for renting and managing campus lockers. Users can browse available lockers, rent them by the hour, scan QR codes, view rentals on a live map, and manage their account — all from a clean, native iOS interface.

---

## Features

| Screen | Description |
|---|---|
| **Landing** | Welcome screen with Login / Sign Up entry points |
| **Login / Register** | Basic credential flow; name is extracted and stored in `LockerStore` |
| **Locker List** | Searchable, filterable list of all lockers with live status badges |
| **Locker Detail** | Full info card with a stepper to select rental duration and a confirm-and-pay sheet |
| **Locker Map** | MapKit view of all locker positions, colour-coded by status, with filter pills and a tap-to-inspect sheet |
| **QR Scan** | Simulates scanning a locker QR code and navigates directly to its detail screen |
| **Rental History** | Past rentals with access-code viewer |
| **Settings** | Profile card, notification toggle, rental history shortcut, and logout with confirmation |

---

## Project Structure

```
SwiftUIDesign/
├── SwiftUIDesignApp.swift   # App entry point; injects LockerStore environment object
├── ContentView.swift        # Root view → LandingView
├── LandingView.swift        # Welcome / nav entry screen
├── LoginView.swift          # Email + password login
├── RegisterView.swift       # Name + email + password registration
├── CustomerScreens.swift    # LockerListView, LockerDetailView, RentalHistoryView, SettingsView + shared components
├── LockerMapView.swift      # MapKit locker map with filter pills and detail sheet
├── Screens.swift            # ScanQRView
├── LockerStore.swift        # ObservableObject state store (lockers, rentals, current user)
├── Models.swift             # Locker, Rental structs + SampleData
└── Styles.swift             # AppColors, AppFonts, AppButtons design tokens
```

---

## Requirements

- **Xcode 15** or later
- **iOS 17** deployment target (uses `NavigationStack`, `MapCameraPosition`, `Map` annotation API)
- No external dependencies — pure SwiftUI + MapKit

---

## How to Run

1. **Clone or download** this repository and open the `.xcodeproj` / `.xcworkspace` in Xcode.

2. **Select a simulator or device** — any iPhone running iOS 17+ works. The map defaults to a cluster near downtown Toronto (43.650°N, 79.370°W).

3. **Build & Run** (`⌘R`). The app launches to the Landing screen.

4. **Try it out:**
   - Tap **Login** and enter any email + password (no backend — any non-empty values work). Your username is derived from the email prefix.
   - Browse lockers, tap one to see details, select hours with the stepper, and tap **Rent This Locker → Confirm & Pay** to simulate a rental.
   - Tap the **map icon** (top-right) to view all lockers on a real MapKit map.
   - Tap the **QR icon** in the locker list to simulate a QR scan.
   - Tap the **gear icon** to open Settings, where you can view your profile or log out.

---

## Architecture

The app uses a simple **single-source-of-truth** pattern:

- `LockerStore` is an `ObservableObject` created once in `SwiftUIDesignApp` and injected as an `@EnvironmentObject` throughout the tree.
- All locker mutations (renting, status updates) go through `LockerStore` methods, keeping views read-only consumers.
- Navigation is handled with `NavigationStack` + `NavigationLink`; sheets are used for confirmation and detail flows.
- There is no persistence layer — state resets on each launch. `SampleData` seeds the store with 10 lockers and 3 historical rentals.

---

## Contributors

- **Koorosh Farvardin**
- **Gurnoor Khurana**
- **Matthew Racco**
- **Tran Kien Vu**

---

## Possible Next Steps

- Add CoreData or CloudKit persistence so rentals survive app restarts
- Implement real authentication (Sign in with Apple or a backend)
- Add push notifications for rental expiry reminders
- Replace simulated QR scan with AVFoundation camera scanning
- Add an admin view for managing locker availability