require "fixture_parts/railtie"

module FixtureParts

  def self.load(parts_yml, valid: true, verbose: false)
    file = Rails.root.join(parts_yml)
    parts_hash = YAML.load(ERB.new(file.read).result)

    model_class = Object.const_get(file.basename(".*").to_s.classify)
    parts_hash.each do |key, values|
      model = model_class.new(values)
      model.id = values["id"] if values["id"].present?

      if !model.save(:validate => valid) && verbose
        puts "\n#{key}: #{model.errors.inspect}"
        raise ActiveRecord::RecordInvalid.new(model)
      end
    end

    if verbose
      puts model_class.all
    end
  end

  def self.load_dir(parts_dir, valid: true, verbose: false)
    Dir.glob(Rails.root.join(parts_dir, "*.yml")).each do |parts_yml|
      load(parts_yml, valid: valid, verbose: verbose)
    end
  end
end
