# Fleet & Logistics Analytics

SQL-based analysis of a logistics company's operations, with a focus on fuel cost control, delivery performance, safety incidents, maintenance efficiency, and route risk.

**Dataset**:Synthetic Logistics Operations Database (2022-2024)  (14 tables: facts like trips, fuel_purchases, delivery_events, safety_incidents, maintenance_records; dimensions like customers, routes, facilities, trucks, drivers).  
Full schema → `/docs/DATABASE_SCHEMA.txt`

**Main tools**: PostgreSQL (SQL), Power BI (dashboards in progress)  
**Goal**: Identify cost savings, operational inefficiencies, safety hotspots, and performance trends.

### Project Modules

| Module                        | Business Focus                                      | Key Deliverables / Queries                              | Status     |
|-------------------------------|-----------------------------------------------------|---------------------------------------------------------|------------|
| Dimension Exploration         | Profiling customers, routes, facilities, trucks, drivers | Distribution, completeness, geographic spread, age profiles  | Complete   |
| Loads & Revenue               | Load volume, revenue by customer/booking type, expected vs actual | Big numbers by booking type, revenue concentration, cost overrun/underrun | Complete   |
| Trips & Utilization           | Trip performance, driver/truck/trailer usage, MPG, idle time | Equipment sharing ratios, driver MPG/idle ratio, miles/efficiency gaps | Complete   |
| Delivery Events               | On-time performance, detention time, facility trends | Big picture quality check, monthly trends, facility hierarchy (CUBE), quarterly QoQ change in wasted time | Complete   |
| Fuel Analysis                 | Driver overpayment, station pricing, purchase vs trip variance | Lost money USD, weighted avg price comparison, outliers | Complete   |
| Safety Incidents              | Risky routes, damage cost trends                    | Hotspots by origin-destination, MoM cost change         | Complete   |
| Maintenance Efficiency        | Cost per mile (MCPM), downtime, repair patterns     | Truck-level MCPM, type breakdown                        | In progress|

### Tech Stack & Techniques
- **SQL**: CTEs, CUBE/ROLLUP, LAG for QoQ/MoM, window functions, NULLIF, FILTER, DATE_TRUNC, EXTRACT(EPOCH), conditional aggregation
- **Power BI**: In progress (planned: delivery trends, fuel overpayment, facility matrix)
- **GitHub**: Modular structure, version control, portfolio hosting

### Key Insights
- Some facilities show consistent QoQ worsening in wasted time (schedule deviation + detention)
- Small number of routes account for disproportionate safety damage costs
- Drivers paying above company average fuel price → potential monthly savings identified
- Older trucks tend to have higher maintenance cost per mile

### How to Explore
- **SQL files**: `/sql/` (organized by module: dimension_exploration, fact_delivery_events, fuel_analysis, etc.)
- **Power BI dashboards**: `/powerbi/` (coming soon)
- **Screenshots**: `/screenshots/` (key visuals)
- **Schema**: `/docs/DATABASE_SCHEMA.txt`

Looking for **Junior Data Analyst** or **Business Intelligence Analyst** opportunities.  
Open to feedback and collaboration!

Reza Asgari Soroush
[https://www.linkedin.com/in/reza-asgari-soroush-251590198/]| [rezasoroush98@gmail.com]
Last updated: March 15, 2026

