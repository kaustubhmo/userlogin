# models/concerns/generate_csv.rb
module GenerateCsv
    extend ActiveSupport::Concern
  
    class_methods do
      def generate_csv(fields)
        CSV.generate(headers: true) do |csv|
          # Header
          csv << fields  
          # Body
          all.each do |record|
            csv << record.attributes.values_at(*fields)
          end
        end
      end
    end
end