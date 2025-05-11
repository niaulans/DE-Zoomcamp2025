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

Messages -> A message is a single event in the topic
  - Key -> A key is a unique identifier for the message (e.g. user ID)
  - Value -> A value is the content of the message (e.g. user activity data)
  - Timestamp -> A timestamp is the time the message was created (e.g. time of user activity)
Log -> A log is a sequence of messages that are stored in the order they were created (e.g. all user activity data for a specific time period)
Topic -> A topic is a category or feed name to which messages are published (e.g. user activity data)

```


