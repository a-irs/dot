#!/usr/bin/env ruby

files = {
  "Makefile.erb" => "Makefile",
  "gitignore.erb" => ".gitignore",
  "main.md.erb" => "main.md"
}

vars = {
  filetypes: ["pptx", "pdf", "tex", "html"],
  profile: "beamer"
}

commands = [
  "git init",
  "git add -v -- <%= files.values.join(' ') %>",
]

# -----

require 'erb'
require 'fileutils'

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  def bold() colorize(1) end
  def gray() colorize(30) end
  def red() colorize(31) end
  def green() colorize(32) end
  def yellow() colorize(33) end
  def blue() colorize(34) end
  def pink() colorize(35) end
  def cyan() colorize(36) end
end

if ARGV.length < 1 then
  puts "Usage: ./bin <output-path>"
  exit 1
end

outdir = ARGV.first
if File.exists?(outdir) then
  puts "Error: '#{outdir}' already exists"
  exit 1
end
FileUtils.mkdir_p outdir

files.each do |src, dest|
  template = ERB.new(File.read(src), nil, '<>-')
  File.write(File.join(outdir, dest), template.result_with_hash(vars))
  puts ":: generate file: #{File.join(outdir, dest).cyan}"
end

commands.each do |command|
  rendered_command = ERB.new(command).result(binding)
  puts ":: run script: #{rendered_command.cyan}"
  output = `cd #{outdir} && #{rendered_command} 2>&1`

  if not $?.success? then
    puts ":: script failed with exit code #{$?.exitstatus}:".red
    output.length > 0 and puts output.strip
    exit $?.exitstatus
  end

  output.length > 0 and puts output.strip.gray.bold
end
