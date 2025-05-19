| Use | Platform |
| -- | -- |
| Message Broker (core streaming)	| Kafka, Redpanda, RabbitMQ |
| Stream Processing (real-time)	| Apache Flink, Spark Streaming |
| Cloud Native	| Kinesis, Pub/Sub, Event Hubs |
| Simpler Use Case or UI-based	| NiFi |

### Kafka
[Slides](https://docs.google.com/presentation/d/1bCtdCba8v1HxJ_uMm9pwjRUC-NAMeB-6nOG2ng3KujA/edit#slide=id.p9)

```
Real-time doesn't mean immediately handled, it means that the system is designed to handle messages as they come in, rather than waiting for a batch of messages to be processed at once.

Kafka is very focused on processing events in real time.

Data Streaming Platform -> Stream, Process, Govern, Connect
```

### Topics
```
Topics -> core abstraction for storing and processing data. 

Unlike traditional databases where data is stored in tables and updates with each new event, Kafka uses logs to record every event is simply appended to the log, preserving the entire history. For example, if you're monitoring a smart thermostat, every temperature reading is added as a new event in the log, allowing you to track changes over time.

Each event in a topic is called message, and it conists of three main parts:
  - A key -> identifies the source of the event (user id)
  - A value -> which contains the actual data (like temperature reading)
  - A timestamp -> which marks the exact time the event was produced.

Message in a topic -> immutable (once writtem they cannot be changed)

Topics are not queues.

Log retention -> delete old data or trim logs by size
Log compaction -> keep only the last value per key
```

### Partition
```
Kafka -> distributed system

- Partitions -> key to scalability and distributed processing. 
- Distributed system meaning it runs across multiple machines but appears as a single, unified service. 
Partitioning split a topic's log into multiple, smaller logs called partitions. 
- Each partitions is stored separately across different nodes, allowing Kafka to handle far larger amount of data.

Message ordering:
  - key -> hash function
  - no key -> round robin method, cycling through partitions evenly
```

### Brokers
```
- Kafka is composed of a network of machines called brokers. 
- Each broker is responsible for storing a portion of the data and handling requests from producers and consumers.

Kafka cluster -> group of brokers working together to provide a single, unified service.
```

### Replication
```
- Replication -> how data remains durable and fault-tolerant. 
- Each partition in a topic is copied across multiple brokers to protect againts data loss if a broker fails. This is controlled by replication factor, which defines the number of copies Kafka maintains for each partition.
- Among the replicas, one is designated as the leader, while the others are followers. The leader handles all read and write requests, while followers replicate the data from the leader. This ensures that even if a broker goes down, the data remains accessible from other brokers.
```

### Producers
```
- Producers -> client applications responsible for writing data to a Kafka cluster. 
- While brokers handle storage and replication, producers are what send messages (key-value pairs) into topics. 
- Any application that sends data to Kafka wheters it's a microservice, IoT device, or a data pipeline, is considered a producer.
- Java is Kafka's native language, but there are libraries for other languages like Python, Go, and Node.js.
- Properties:
  - bootstrap.servers -> list of brokers in the cluster
  - acks -> how many replicas must acknowledge the message before it's considered successful.

Main objects in the API:
  - KafkaProducer -> client that sends messages to Kafka
  - ProducerRecord -> represents a message to be sent, including the topic, key, and value
```

```java
Properties config = loadProperties("kafka.properties");
Producer<Long, String> producer = new KafkaProducer<>(config);

ThermostatReading reading = new ThermostatReading("kitchen", 32, Temperature.celcius(22));
String readingAsJson = objectMapper.writeValueAsString(reading);
ProducerRecord record = new ProducerRecord<>("thermostat_readings", 32, readingAsJson));
producer.send(record);
```

[Handson Exercise: Kafka Producer](https://developer.confluent.io/courses/apache-kafka/get-started-hands-on/)

### Consumer
```
- Consumers -> client applications responsible for reading data from Kafka topics. 
- While producers write data into topics, consumers retrieve it, process it, and often send it onward for additional processing or storage. 

KafkaConsumer API:
  - bootstrap.servers -> list of brokers in the cluster
  - group.id -> unique identifier for the consumer group

- After subsribing, the comsumer enters an infinite loop, continuously polling for new messages.
- When polling, the consumer fetches ConsumerRecords, which contain:
  - key: the unique identifier for the message
  - value: the actual data
  - partition: the partition from which the message was read
  - timestamp: the time the message was produced
  - headers: additional metadata associated with the message

- Consumer groups -> allow multiple consumers to work together to process data from a topic.
- Each consumer in a group is assigned a subset of the topic's partitions, ensuring that each message is processed by only one consumer in the group.
- This allows for parallel processing and load balancing, making it easier to handle large volumes of data.
```

```java

Properties config = loadProperties("kafka.properties");
KafkaConsumer<String, String> consumer = new KafkaConsumer<>(config);
consumer.subscribe(List.of("thermostat_readings"));
while (true) {
   ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(10));
   for (ConsumerRecord<String, String> record : records) {
      System.out.println("Message=" + record.key() + ":" + record.value());
      // further process the record...
}
```

[Handson Exercise: Kafka Consumer](https://developer.confluent.io/courses/apache-kafka/exercise-kafka-consumers/)














