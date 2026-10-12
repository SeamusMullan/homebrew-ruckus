class Ruckus < Formula
  desc "Install ROS 2, manage its environments and start sessions in tmux"
  homepage "https://github.com/SeamusMullan/ruckus"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "00e3a93233b1dbe2a93153c4ce87ae0b064fe5d479ba2cd32c7537a41f330b75"
    end
    on_intel do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d4eaa43697ad86c45d769fccdcc49e36fde3d487ec9f6620ee38084eb1f8ae63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0e3f13bdfec590fad001fe1ad417ea08eb246acdf887d276cbb44f8fa03e642"
    end
    on_intel do
      url "https://github.com/SeamusMullan/ruckus/releases/download/v#{version}/ruckus-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36db1b9bf42e9ca51e3df5566b22e96f3e14d86baac123a98ba1d39a118035b6"
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
