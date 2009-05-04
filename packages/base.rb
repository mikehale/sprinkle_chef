def create_or_replace_file(file_name, lines)
  result = ["rm -rf #{file_name}"]
  lines.each do |line|
    result << %(echo '#{line}' >> #{file_name})
  end
  result.join(' && ')
end