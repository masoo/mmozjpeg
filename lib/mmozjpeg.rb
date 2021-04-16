require "mmozjpeg/version"
require "pathname"
require "open3"

module Mmozjpeg
  class Error < StandardError; end

  class Cjpeg
    class << self
      # Whether cjpeg exists or not?
      # @return [True] "cjpeg" exists,
      #         [False] "cjpeg" NOT exists
      def supported?
        args = ["cjpeg", "-version"]
        _, _, s = Open3.capture3(*args)
        s
      rescue Errno::ENOENT
        false
      end

      def optimize(infile:, outfile: nil, quality: nil, grayscale: nil, rgb: nil,
        optimize: nil, progressive: nil, targa: nil, arithmetic: nil, dct: nil, icc: nil,
        restart: nil, maxmemory: nil, memdst: nil, report: nil, verbose: nil, debug: nil,
        version: nil, baseline: nil, qtables: nil, qslots: nil, sample: nil, scans: nil)

        cjpeg = "cjpeg"
        unless quality.nil?
          parsed_quality = ["-quality", quality.split(",").map { |v| Integer(v) }.join(",")]
        end
        parsed_infile = Pathname(infile).cleanpath.to_s unless infile.nil?

        if !outfile.nil? || !grayscale.nil? || !rgb.nil? || !optimize.nil? || !progressive.nil? ||
            !targa.nil? || !arithmetic.nil? || !dct.nil? || !icc.nil? || !restart.nil? || !maxmemory.nil? ||
            !memdst.nil? || !report.nil? || !verbose.nil? || !debug.nil? || !version.nil? ||
            !baseline.nil? || !qtables.nil? || !qslots.nil? || !sample.nil? || !scans.nil?
          raise Mmozjpeg::Error, "Oop, This option is'nt yet supported."
        end
        args = [cjpeg, parsed_quality, parsed_infile].select { |v| !v.nil? }.flatten!
        Open3.capture2(*args)
      end
    end
  end
end
