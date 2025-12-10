require "option_parser"

OptionParser.parse do |parser|
  parser.banner = "chtoto"

  parser.on "-v", "--version", "Show version" do
    puts "version 1.0"
    exit
  end
  parser.on "-h", "--help", "Show help" do
    puts parser
    exit
  end

  parser.on "-i", "--initiate", "Initiate hyprland zen mode" do
    puts "som"
    exit
  end
end
