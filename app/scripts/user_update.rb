class UserUpdate < KafkaBase
    def call
        $kafka_consumer.each_message(topic: "user_update") do |message|
            puts message.offset, message.key, message.value
        end
    end
end