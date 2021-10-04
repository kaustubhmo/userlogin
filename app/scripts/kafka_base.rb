require "kafka"
class KafkaBase
    def initialize
        $kafka_consumer = Kafka.new(["localhost:9092"])
    end
end