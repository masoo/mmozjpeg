RSpec.describe Mmozjpeg do
  it "has a version number" do
    expect(Mmozjpeg::VERSION).not_to be nil
  end

  it "#supported?" do
    expect(Mmozjpeg::Cjpeg.supported?).to be_truthy
  end

  it "#optimize" do
    _, s = Mmozjpeg::Cjpeg.optimize(infile: "./spec/test.jpg", outfile: nil, quality: "50,80", grayscale: true, rgb: true,
                                    optimize: true, progressive: true, targa: true, arithmetic: true, dct: "int/fast/float", icc: "/to/path",
                                    restart: 0, maxmemory: 0, memdst: true, report: true, verbose: true, debug: true, version: true,
                                    baseline: true, qtables: "/to/path", qslots: "50,80s", sample: "2x2,4x4", scans: "/to/path")

    expect(s.exitstatus).to eq(0)
  end
end
