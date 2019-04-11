require "fixture_parts/railtie"

module FixtureParts

  def self.load(parts_yml, valid: true)
    file = Rails.root.join(parts_yml)
    model_class = Object.const_get(file.basename(".*").to_s.classify)

    YAML.load(ERB.new(file.read).result).each do |key, values|
      model = model_class.new(values)
      model.id = values["id"] if values["id"].present?

      if !model.save(:validate => valid)
        puts "#{parts_yml}: #{key}"
        puts "#{model.errors.inspect}"
        raise ActiveRecord::RecordInvalid.new(model)
      end
    end
  end

  def self.load_dir(parts_dir, valid: true)
    Dir.glob(Rails.root.join(parts_dir, "*.{yml,yaml}")).each do |parts_yml|
      load(parts_yml, valid: valid)
    end
  end
end
