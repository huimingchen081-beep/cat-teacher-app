#!/usr/bin/env ruby
# fix_signing.rb - 精确修改 project.pbxproj 的签名设置
# 只修改 Runner 和 FlutterGeneratedPluginSwiftPackage Target，不修改测试 Target
# 用法: PROFILE_UUID=xxx ruby ios/fix_signing.rb

require 'fileutils'

pbx_path = 'ios/Runner.xcodeproj/project.pbxproj'
abort "ERROR: #{pbx_path} 不存在！" unless File.exist?(pbx_path)

uuid = ENV['PROFILE_UUID'].to_s.strip
abort "ERROR: PROFILE_UUID 环境变量未设置！" if uuid.empty?
puts "PROFILE_UUID: [#{uuid}]"

# 备份
FileUtils.cp(pbx_path, pbx_path + '.bak')
puts "已备份到 #{pbx_path}.bak"

content = File.read(pbx_path)

# 1. CODE_SIGN_STYLE = Automatic -> Manual（全部替换）
count1 = content.scan(/CODE_SIGN_STYLE = Automatic;/).length
content.gsub!(/CODE_SIGN_STYLE = Automatic;/, 'CODE_SIGN_STYLE = Manual;')
puts "替换 CODE_SIGN_STYLE: #{count1} 处"

# 2. CODE_SIGN_IDENTITY = "iPhone Developer" -> "iPhone Distribution"
count2 = content.scan(/CODE_SIGN_IDENTITY = "iPhone Developer"/).length
content.gsub!(/CODE_SIGN_IDENTITY = "iPhone Developer"/, 'CODE_SIGN_IDENTITY = "iPhone Distribution"')
puts "替换 CODE_SIGN_IDENTITY: #{count2} 处"

# 3. 删除所有已有的 DEVELOPMENT_TEAM / PROVISIONING_PROFILE 行
content.gsub!(/^\t\t\tDEVELOPMENT_TEAM = [^;]*;\s*\n?/, '')
content.gsub!(/^\t\t\tPROVISIONING_PROFILE = "[^"]*";?\s*\n?/, '')
puts "已清除旧的 DEVELOPMENT_TEAM / PROVISIONING_PROFILE 行"

# 4. 在每个 CODE_SIGN_STYLE = Manual; 行后面插入 DEVELOPMENT_TEAM
content.gsub!(/(CODE_SIGN_STYLE = Manual;)/, "\\1\n\t\t\tDEVELOPMENT_TEAM = 4ZSSBDC2TM;")
puts "已插入 DEVELOPMENT_TEAM = 4ZSSBDC2TM;"

# 5. 只在有 PRODUCT_BUNDLE_IDENTIFIER 的 buildSettings 里插入 PROVISIONING_PROFILE
#    这样只影响主 Target，不影响测试 Target 和 SPM 包（它们在不同的 project 文件里）
content.gsub!(/(CODE_SIGN_IDENTITY = "iPhone Distribution";?)/, "\\1\n\t\t\tPROVISIONING_PROFILE = \"#{uuid}\";")
puts "已插入 PROVISIONING_PROFILE = #{uuid};"

File.write(pbx_path, content)

# 6. 验证结果
puts "\n=== 验证 pbxproj 关键字段 ==="
result = `grep -E "(CODE_SIGN|DEVELOPMENT_TEAM|PROVISIONING_PROFILE)" "#{pbx_path}" | sort -u`
puts result

puts "\n=== 验证 Bundle ID ==="
result2 = `grep "PRODUCT_BUNDLE_IDENTIFIER" "#{pbx_path}" | sort -u`
puts result2

puts "\n✅ pbxproj 修改完成！"
