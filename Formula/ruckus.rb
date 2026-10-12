class Ruckus < Formula
  desc "Install ROS 2, manage its environments and start sessions in tmux"
  homepage "https://github.com/SeamusMullan/ruckus"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3116ac8dcf113dd37ba59514397868f654a3e74600b0164a7f17e1bec22b8fb1"
    end
    on_intel do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "93b00592cfa37f7cf45659e4229434c02ead135c9b2f4dd2fb5742fe54e5b975"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "723c45d8fec98a150f5eb5c7f51f07e7b304e42c7cd45df71eac9cf5b1be0cab"
    end
    on_intel do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1383a01747eb322b18b977b4735136baa1a86ca4dd214ded914ded42e112f2fd"
    end
  end

  depends_on "tmux"

  def install
    bin.install "ruckus"
    bash_completion.install "completions/ruckus.bash" => "ruckus"
    zsh_completion.install "completions/_ruckus"
    fish_completion.install "completions/ruckus.fish"
  end

  test do
    assert_equal "ruckus #{version}", shell_output("#{bin}/ruckus --version").strip
    assert_match "turtle", shell_output("#{bin}/ruckus ls")
    assert_match "#compdef ruckus", shell_output("#{bin}/ruckus completions zsh")
    system bin/"ruckus", "up", "turtle", "--dry-run"
  end
end
