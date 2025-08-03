Badge.find_or_create_by!(difficulty: "easy", genre: "基本知識") do |badge|
  badge.name = "簡単 × 基本知識 全問正解"
  badge.description = "簡単モードで基本知識ジャンルを全問正解した証"
  puts "Created badge: #{badge.name}"
end

Badge.find_or_create_by!(difficulty: "easy", genre: "対応方法") do |badge|
  badge.name = "簡単 × 対応方法 全問正解"
  badge.description = "簡単モードで対応方法ジャンルを全問正解した証"
  puts "Created badge: #{badge.name}"
end

Badge.find_or_create_by!(difficulty: "hard", genre: "基本知識") do |badge|
  badge.name = "難しい × 基本知識 全問正解"
  badge.description = "難しいモードで基本知識ジャンルを全問正解した証"
  puts "Created badge: #{badge.name}"
end

Badge.find_or_create_by!(difficulty: "hard", genre: "対応方法") do |badge|
  badge.name = "難しい × 対応方法 全問正解"
  badge.description = "難しいモードで対応方法ジャンルを全問正解した証"
  puts "Created badge: #{badge.name}"
end
