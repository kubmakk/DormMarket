# 🏠 DormMarket (ОбщагаМаркет)

**DormMarket** is a specialized peer-to-peer marketplace designed exclusively for students living in the **DAS Dormitory**. It serves as a unified ecosystem for buying, selling, renting, and providing services within the dorm community, helping students monetize their skills and belongings.

---

## 📱 Features & Structure

The app is built around a user-friendly `TabBarController` with four main sections:

1. **Market (Catalog):** Browse items and services available in the dorm.
2. **Sell (Post):** A simple interface to create new listings.
3. **Profile (Me):** Manage personal data (room number, floor, rating), view purchase history, and adjust settings.
4. **Feedback (Help):** Direct line for support and reporting issues.

### 🛠 Core Functionalities

* **Goods & Services:** Sell physical items or offer services (e.g., "Take out trash" for 30₽ or "Printing" for 5₽/page).
* **Booking System:** Reserve items for a specific time to ensure availability.
* **Rental System:** A built-in system for renting equipment with automated push notifications for return deadlines.
* **In-Dorm Delivery:** A "Courier" role allows students to earn money by delivering items between floors.
* **Events (Future):** Integration with Student Council events, push notifications for dorm news, and a calendar of activities.

---

## 👥 User Roles & Moderation

To ensure safety and prevent "neighbor-identity theft," the app uses a multi-tier role system:

| Role | Responsibility |
| --- | --- |
| **Founder** | Full system control and management of the Student Council. |
| **Student Council** | Manage moderators and verify residency lists (Name/Room). |
| **Moderator** | Content review, complaint handling, and banning rule-breakers. |
| **Seller** | Can list items. Can bypass manual moderation if pre-approved by the Student Council. |
| **Buyer** | Standard access to purchase and rent. |
| **Courier** | Specialized role for internal delivery services. |

---

## 💰 Monetization & Subscriptions

DormMarket stays sustainable through three main channels:

1. **Lightweight Ads:** Native banners (similar to Yandex Food) between product cards.
2. **Listing Fees:** Small commissions for highlighted or "Top" listings.
3. **Subscription Tiers:**

* **Plus (199₽):** Ad-free experience + discounted night-time booking fees.
* **Pro (249₽):** Ad-free + **Free** item booking.
* **Premium (299₽):** Ad-free + Free booking + **Free Courier Delivery** + Dorm Cashback points.

---

## 💳 Payment & Security

The app supports multiple payment flows:

* **Direct Payment:** Transfer via phone number/SBP (System of Fast Payments) directly to the seller.
* **Instant Purchase:** A 15-minute window to collect the item after confirmation; failure to show up results in temporary "Instant Buy" restrictions to prevent abuse.
* **Safe Rentals:** * *Standard:* Automated digital signatures/forms stored for 2 weeks for dispute resolution.
* *Light:* Ready-to-print templates for manual signing.

---

## 🚀 Roadmap

* [ ] Search & Advanced Filters
* [ ] Categories & Favorites
* [ ] Review & Rating System
* [ ] Push Notifications for events and price drops
* [ ] Student Council News Tab

---

## 🛠 Tech Stack (Pet Project Info)

* **Language:** Swift
* **Architecture:** MVC / MVVM (Specify yours)
* **UI:** UIKit (TabBarController, CollectionViews)

---

> **Note:** This project is developed to improve the quality of life in the DAS Dormitory by digitizing internal commerce and community interactions.
