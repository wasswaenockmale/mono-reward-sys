# Real-Time Reward Tracking System (Monolithic Phoenix App)

This project is a **real-time reward tracking system** built with **Elixir + Phoenix** in a **monolithic architecture**.  
It allows users to **earn points** (e.g., from purchases or referrals), **redeem points** for money credited to their wallet, and receive **notifications** about their activity.


## Running the Server

1. Install dependencies:
   ```bash
   mix deps.get
   
   mix ecto.create
   mix ecto.migrate
