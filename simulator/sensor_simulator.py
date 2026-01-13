import json
import time
import random
from datetime import datetime
from azure.eventhub import EventHubProducerClient, EventData

# =========================
# KONFIGURACJA
# =========================
EVENT_HUB_CONNECTION_STRING = "EVENT_HUB_CONNECTION_STRING"
EVENT_HUB_NAME = "pm10-events"

SENSOR_COUNT = 3          # liczba czujników
SEND_INTERVAL = 1         # sekundy między wysyłkami
PM10_MIN = 10.0
PM10_MAX = 120.0

# =========================
# PRODUCER
# =========================
producer = EventHubProducerClient.from_connection_string(
    conn_str=EVENT_HUB_CONNECTION_STRING,
    eventhub_name=EVENT_HUB_NAME
)

print("▶ Start symulatora czujników PM10")

try:
    while True:
        sensor_id = random.randint(1, SENSOR_COUNT)

        payload = {
            "sensor_id": sensor_id,
            "timestamp": datetime.utcnow().isoformat(),
            "pm10": round(random.uniform(PM10_MIN, PM10_MAX), 2)
        }

        event = EventData(json.dumps(payload))
        producer.send_batch([event])

        print(f"Wysłano: {payload}")
        time.sleep(SEND_INTERVAL)

except KeyboardInterrupt:
    print("⏹ Zatrzymano symulator")

finally:
    producer.close()
