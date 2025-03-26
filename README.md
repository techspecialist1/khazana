# khazana

##  Overview
This Flutter application enables users to authenticate via **Supabase** and track mutual fund 
performance using interactive **charts**. It follows **clean architecture** principles and utilizes 
**Bloc state management** for maintainability.

---

##  Features
###  User Authentication (Supabase)
- **Login & Signup** using Supabase authentication.
- **Secure User Sessions** to maintain login state.
- **Automatic Navigation** to the Dashboard after login.

###  Mutual Fund Performance Analytics
- ** Line Chart** displaying NAV trends over different time ranges.
- Uses **complex charts** (e.g.,bar chart) for enhanced insights.

###  State Management & Navigation
- Uses **Bloc** for **state management**.
- Implements **Flutter Navigator** for **seamless transitions**.
- Provides **loading states** while fetching data.

---

##  Setup & Installation

###  Prerequisites
Ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Supabase CLI](https://supabase.com/docs/guides/cli)
- A **Supabase project** with authentication enabled

###  Clone the Repository
```sh
git clone https://github.com/techspecialist1/khazana.git
cd Khazana
```

###  Install Dependencies
```sh
flutter pub get
```

###  Configure Supabase
1. **Create a Supabase Project** at [Supabase](https://supabase.com).
2. **Retrieve Supabase API Credentials** (API URL & Anon Key).
3. **Add them to a `.env` file:**
   ```env
   SUPABASE_URL=https://your-supabase-url.supabase.co
   SUPABASE_ANON_KEY=your-anon-key
   ```

###  Run the Project
```sh
flutter run
```

##  Implementation Approach

###  User Authentication (Supabase)
- Uses `supabase_flutter` for authentication.
- Implements **`signUpWithEmail()`** and **`signInWithEmail()`**.

###  Mutual Fund Performance Analytics
- Uses **fl_chart** for interactive **line charts**.
- Implements **chart filtering** (1M, 3M, 1Y, custom range).

### State Management & Navigation
- Implements **Bloc pattern** for **efficient state handling**
- Ensures **smooth loading states** with UI feedback.

---
