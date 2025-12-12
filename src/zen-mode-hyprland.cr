module Zen::Mode::Hyprland

  VERSION = "0.1.0"
  CFG = "/home/zedddie/.config/hypr/hyprland.conf"
  CFG_BAK = "/home/zedddie/.config/hypr/hyprland.conf.bak"
  VARS_NUMS = ["power", "passes", "bordersize", "rounding", "gaps_in", "gaps_out", "decorations:shadow_render_power"]
  VARS_BOOL = ["animations"]
  # 1: space, 2: key, 3: =, 4: value, 5: trailing comment
  REGEX = /^(\s*)(\w+:?\w*)(\s*=\s*)(.+?)(\s*($|#.*))/

  def self.zen_mode()
    if File.exists?(CFG_BAK)
      puts "ERROR: bak exists, return to default mode to use zen mode"
      return
    end
    puts "Creating backup: #{CFG_BAK}"
    File.copy(CFG, CFG_BAK)

    new_content = [] of String

    File.read(CFG).each_line do |line|
      match = line.match(REGEX)

      if match
        key = match[2]
        if VARS_BOOL.includes?(key)
          new_line = match[1] + key + match[3] + "false" + match[5]
          new_content << new_line
        elsif VARS_NUMS.includes?(key)
          new_line = match[1] + key + match[3] + "0" + match[5]
          new_content << new_line
        else
          new_content << line
        end
      else
        new_content << line
      end
    end

    File.write(CFG, new_content.join("\n"))

    system "pkill waybar"
    system "pkill swww-daemon"
  end

  def self.default_mode()
    unless File.exists?(CFG_BAK)
      puts "ERROR: Backup file not found at #{CFG_BAK}. Cannot restore."
      return
    end

    File.copy(CFG_BAK, CFG)

    File.delete(CFG_BAK)

    system "waybar &"
    system "swww-daemon &"
  end
end
