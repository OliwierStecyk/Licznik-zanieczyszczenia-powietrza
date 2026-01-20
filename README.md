# 🌍 IoT Air Pollution Monitor - Real-time Streaming Pipeline

## 📝 Opis Projektu
Projekt realizuje kompletny potok danych (Data Pipeline) w architekturze chmurowej Azure, służący do monitorowania zanieczyszczenia powietrza (PM10) w czasie rzeczywistym. System symuluje pracę rozproszonych czujników IoT, przetwarza dane strumieniowo i przechowuje je w nowoczesnym formacie Delta Lake.

**Główne cele:**
- Symulacja wysokoczęstotliwościowych danych z czujników IoT.
- Ingestia danych w czasie rzeczywistym przy użyciu Azure Event Hubs.
- Przetwarzanie strumieniowe (windowing, agregacje, alerty) w Azure Databricks.
- Składowanie danych w architekturze Medallion (Bronze/Silver) w Azure Data Lake Storage Gen2.
- Automatyzacja infrastruktury za pomocą Terraform oraz CI/CD przez GitHub Actions.

---

## 🏗 Architektura Systemu
System oparty jest na najlepszych praktykach inżynierii danych:
1. **Data Source**: Skrypt Python generujący dane JSON (sensor_id, pm10, timestamp).
2. **Ingestion**: **Azure Event Hubs** jako rozproszony system kolejkowy.
3. **Processing**: **Azure Databricks (Spark Structured Streaming)** – analiza okien czasowych, wyliczanie średnich i detekcja przekroczeń norm.
4. **Storage**: **Azure Data Lake Storage Gen2** z warstwą **Delta Lake** zapewniającą transakcyjność ACID.
5. **Infrastructure as Code**: **Terraform** do pełnej powtarzalności środowiska.

---

## 🛠 Stos Technologiczny
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![Apache Spark](https://img.shields.io/badge/Apache_Spark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

---

## 📂 Struktura Projektu
```text
├── .github/workflows/       # Automatyzacja wdrożenia (CI/CD)
├── terraform/               # Pliki IaC do budowy zasobów Azure
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── simulator/               # Symulator czujników IoT w Pythonie
│   └── sensor_emulator.py
├── notebooks/               # Notebooki Databricks (Spark Streaming)
│   ├── 01_ingestion_to_bronze.py
│   └── 02_processing_to_silver.py
└── README.md

<img width="959" height="553" alt="image" src="https://github.com/user-attachments/assets/b7cd17a5-0863-46c6-83b2-713ac9b05b27" />
