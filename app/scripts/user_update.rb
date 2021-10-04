class UserUpdate < KafkaBase
    def call
        $kafka_consumer.each_message(topic: "user_update") do |message|
            puts "----------------"
            puts "Topic::#{message.topic}"
            puts "partition::#{message.partition}"
            puts "offset::#{message.offset}"
            puts "key::#{message.key}"
            puts "value::#{message.value}"
            #puts message.offset, message.key, message.value
        end
    end
end