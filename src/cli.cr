require "option_parser"


cfg = "/home/zedddie/.config/hypr/hyprland.conf"
cfg_bak = "/home/zedddie/.config/hypr/hyprland.conf.bak"
vars = ["bordersize", "rounding", "gaps_in", "gaps_out", "decorations:shadow_render_power"]

# 1: space, 2: key, 3: =, 4: value, 5: trailing comment
regex = /^(\s*)(\w+:?\w*)(\s*=\s*)(.+?)(\s*($|#.*))/

def zen_mode(cfg, cfg_bak, vars, regex)
  unless !File.exists?(cfg_bak)
    puts "ERROR: bak exists, return to default mode to use zen mode"
    return
  end
  puts "Creating backup: #{cfg_bak}"
  File.copy(cfg, cfg_bak)

  new_content = [] of String

  File.read(cfg).each_line do |line|
    match = line.match(regex)

    if match
      key = match[2]

      if vars.includes?(key)
        new_line = match[1] + key + match[3] + "0" + match[5]
        new_content << new_line
      else
        new_content << line
      end
    else
      new_content << line
    end
  end

  File.write(cfg, new_content.join("\n"))

  spawn("pkill waybar")
end

def default_mode(cfg, cfg_bak)
  unless File.exists?(cfg_bak)
    puts "ERROR: Backup file not found at #{cfg_bak}. Cannot restore."
    return
  end

  File.copy(cfg_bak, cfg)

  File.delete(cfg_bak)

  spawn("waybar &")
end


OptionParser.parse do |parser|
  parser.banner = "ill change ur hypr settings broski"

  parser.on "-h", "--help", "Print out this text" do
    puts parser
    exit
  end

  parser.on "-i", "--initiate", "Initiate hyprland zen mode" do
    zen_mode(cfg, cfg_bak, vars, regex)
    exit
  end

  parser.on "-o", "--off", "Restore default hyprland config" do
    default_mode(cfg, cfg_bak)
    exit
  end
end
