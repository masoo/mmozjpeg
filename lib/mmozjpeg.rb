require "mmozjpeg/version"
require "pathname"
require "open3"

module Mmozjpeg
  class Error < StandardError; end

  class Cjpeg
    class << self
      def optimize(infile:, outfile: nil, quality: nil, grayscale: nil, rgb: nil,
        optimize: nil, progressive: nil, targa: nil, arithmetic: nil, dct: nil, icc: nil,
        restart: nil, maxmemory: nil, memdst: nil, report: nil, verbose: nil, debug: nil,
        version: nil, baseline: nil, qtables: nil, qslots: nil, sample: nil, scans: nil)

        cjpeg = "cjpeg"
        unless quality.nil?
          parsed_quality = ["-quality", quality.split(",").map { |v| Integer(v) }.join(",")]
        end
        parsed_infile = Pathname(infile).cleanpath.to_s unless infile.nil?
        arg = [cjpeg, parsed_quality, parsed_infile].select { |v| !v.nil? }.flatten!
        Open3.capture2(*arg)
      end
    end
  end
end
