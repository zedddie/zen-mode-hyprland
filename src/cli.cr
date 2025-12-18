require "option_parser"
require "./zen-mode-hyprland"
require "system/user"

OptionParser.parse do |parser|
  username = ENV["USER"]
  parser.banner = "ill change ur hypr settings, #{username}r be ready"

  parser.on "-h", "--help", "Print out this text" do
    puts parser
    exit
  end

  parser.on "-i", "--initiate", "Initiate hyprland zen mode" do
    Zen::Mode::Hyprland.zen_mode()
    exit
  end

  parser.on "-o", "--off", "Restore default hyprland config" do
    Zen::Mode::Hyprland.default_mode()
    exit
  end

  parser.on "-t", "--toggle", "Toggle between zen and default modes" do
    Zen::Mode::Hyprland.toggle_mode()
    exit
  end
end
