class Tmpwatch < Formula
  desc "Find and remove files not accessed in a specified time"
  homepage "https://pagure.io/tmpwatch"
  url "https://releases.pagure.org/tmpwatch/tmpwatch-2.11.tar.bz2"
  sha256 "93168112b2515bc4c7117e8113b8d91e06b79550d2194d62a0c174fe6c2aa8d4"

  bottle do
    cellar :any_skip_relocation
    sha256 "727f356600eb58bb27a23ab91a4ffc8904eec726c2e9f85025d810e3a19030eb" => :mojave
    sha256 "18ca8e16075315e3aca9cd4e2e445358c33d5911a647557ad8971edb232e4cc4" => :high_sierra
    sha256 "945dbe942b232586517a2fcd81faab1fc20d3936e53ddf9154158dd0b7d3d55c" => :sierra
    sha256 "d19ca779df5c019f840d0c186822fbab4758bf3635101aa975b4bad35bb2f184" => :el_capitan
    sha256 "6b7935b74c118e797b2cba298e0f546d4231ac2c5eb165f4a63bc6c2d0a372dc" => :yosemite
    sha256 "0083a3dd898627e47dabc967328de86df6bf60c2c62210fd9dd4846795de0a8f" => :mavericks
    sha256 "c0416097ea10d23751b2db15f21d437d863e5de3ed44fe50e0f8ebc34f487f2f" => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    mkdir "test" do
      touch %w[a b c]
      ten_minutes_ago = Time.new - 600
      File.utime(ten_minutes_ago, ten_minutes_ago, "a")
      system "#{sbin}/tmpwatch", "2m", Pathname.pwd
      assert_equal %w[b c], Dir["*"]
    end
  end
end
