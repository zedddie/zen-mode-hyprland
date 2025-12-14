require "path"

module Zen::Mode::Hyprland

  HOME_DIR = Path.home
  VERSION = "0.1.1"
  CFG = (Path[HOME_DIR] / ".config" / "hypr" / "hyprland.conf").to_s
  CFG_BAK = CFG + ".bak"
  VARS_NUMS = ["power", "passes", "border_size", "rounding", "rounding_power", "gaps_in", "gaps_out", "decorations:shadow_render_power"]
  VARS_BOOL = ["enabled"]
  # 1: space, 2: key, 3: =, 4: value, 5: trailing comment
  REGEX = /^(\s*)(\w+:?\w*)(\s*=\s*)(.+?)(\s*($|#.*))/

  def self.toggle_mode()
    if File.exists?(CFG_BAK)
      self.default_mode()
    else
      self.zen_mode()
    end
  end

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

    system "pkill waybar > /dev/null 2>&1"
    system "pkill swww-daemon > /dev/null 2>&1"
    puts "Zen mode initiated successfully(i hope)"
  end

  def self.default_mode()
    unless File.exists?(CFG_BAK)
      puts "ERROR: Backup file not found at #{CFG_BAK}. Cannot restore."
      return
    end

    File.copy(CFG_BAK, CFG)
    puts "Using backup to restore config: #{CFG_BAK}"
    puts "Config restored (I hope :1)"
    File.delete(CFG_BAK)
    puts "Deleting backup: #{CFG_BAK}"

    system "waybar > /dev/null 2>&1 &"
    system "swww-daemon > /dev/null 2>&1 &"
  end
end
