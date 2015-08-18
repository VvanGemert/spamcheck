module Storage
  # Disk
  class Disk
    def initialize(settings)
      @settings = settings
    end

    def retrieve
      decompress(File.read(@settings[:store_location]))
      rescue Errno::ENOENT
        classifier = Spamcheck::Classifier.new
        compressed_data = compress(classifier)
        store(compressed_data)
        classifier
    end

    def save(classifier)
      store(compress(classifier))
    end

    def clear
      classifier = Spamcheck::Classifier.new
      compressed_data = compress(classifier)
      store(compressed_data)
      true
    end

    private

    def compress(data)
      Zlib::Deflate.deflate(Marshal.dump(data))
    end

    def decompress(data)
      Marshal.load(Zlib::Inflate.inflate(data))
    end

    def store(data)
      file = File.new(@settings[:store_location], 'w')
      file.puts data
      file.close
    end
  end
end
