# Gulf Retail Analytics – 30-Day Sprint

![ci](https://github.com/aadil-221B/gulf-retail-30day/actions/workflows/ci.yml/badge.svg)
![BigQuery](https://img.shields.io/badge/warehouse-BigQuery-34A853?style=flat-square)
![dbt](https://img.shields.io/badge/transform-dbt-FF694B?style=flat-square)
![Looker](https://img.shields.io/badge/dashboard-Looker-4285F4?style=flat-square)

Business-oriented data products built in public over 30 calendar days.  
Each `projects/` folder = standalone deliverable you can clone & run.

## 📊 Deliverables
| Milestone | Days | Business Question | Tech | Demo |
|-----------|------|-------------------|------|------|
| 01 Gulf Retail Pack | 1-5 | Daily revenue & top customers | BigQuery + Looker | [video](link) |
| 02 Real-time KPI | 6-10 | Live sales vs target | BQ + Dataform + Data Studio | TBD |
| 03 Customer Segmentation | 11-15 | RFM analysis & cohorts | dbt + ML | TBD |
| 04 Inventory Analytics | 16-20 | Stockouts prediction | Time-series + Forecasting | TBD |
| 05 Executive Dashboard | 21-30 | C-level metrics | Full-stack | TBD |



## 🚀 Current Progress

### Day 1-2: Data Foundation & Analytics
✅ **Data Modeling**: Complete ERD with 4-table relationship  
✅ **Data Quality**: Comprehensive checks on 123k order lines  
✅ **Business Views**: Daily revenue analytics (free-tier optimized)  
✅ **CI/CD**: Automated SQL linting with GitHub Actions

### Technical Note
Using BigQuery views for analytics due to free-tier DML restrictions. Production implementation would use partitioned tables for 90%+ performance gains.

## 🛠️ Tools & Technologies
BigQuery | Looker Studio | SQL | Python | GitHub Actions | dbt-ready SQL

## 💼 Hire Me
**Role**: Data Analyst / BI Developer  
**Location**: Dubai, UAE | Remote (GMT+4)  
**Availability**: Immediately  
**Contact**: [LinkedIn](your-linkedin) | [Email](mailto:your@email.com)  
**Expertise**: Retail Analytics • BigQuery • Data Visualization • ETL Pipelines

*Open to contract roles • Specialized in transforming manual reports into automated insights*

## 🏗️ Infrastructure
```bash
# one-command rebuild (sandbox)
bq mk gulf_retail
bq query --use_legacy_sql=false < infra/bigquery/mock_data.sql
```
