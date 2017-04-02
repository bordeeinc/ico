#require 'FileUtils' unless Object.const_defined?('FileUtils')
#
## in lib/tasks/ico.rake
#CURRENT_DIR = File.expand_path(File.dirname(__FILE__))
#LIB_DIR     = File.join(CURRENT_DIR, '..')
#
#namespace :ico do
#
#  desc 'Transpile to-ico/* and write to lib/to-ico.js (requires browserify npm)'
#  task :transpile do
#
#    # ensure remove 
#    output_filename = File.join(LIB_DIR, 'to-ico.js')
#    ico_config = File.join(LIB_DIR, '?????browserify.config.ruby.js')
#
#    # ensure remove 
#    FileUtils.rm_f output_filename
#    raise "ERROR: could not delete previous file in output path: #{output_filename}" if File.exist?(output_filename)
#
#    puts "cd to-ico && ?????"
#    puts `????`
#
#    # ensure exists
#    raise "ERROR: could not find file in output path: #{output_filename}" unless File.exist?(output_filename)
#
#    puts "ico:transpile => done; success!"
#  end
#
#
#  desc 'Copy `lib/to-ico/browserify.config.ruby.js` to `to-ico/browserify/`'
#  task :copy_config do
#
#    # ensure remove 
#    output_filename = File.join(LIB_DIR, '../to-ico/browserify.config.ruby.js')
#    ico_config = File.join(LIB_DIR, 'browserify/browserify.config.ruby.js')
#
#    FileUtils.rm_f output_filename
#    raise "ERROR: could not delete previous file in output path: #{output_filename}" if File.exist?(output_filename)
#
#    FileUtils.cp(ico_config, output_filename)
#
#    # ensure exists
#    raise "ERROR: could not find file in output path: #{output_filename}" unless File.exist?(output_filename)
#
#    puts "ico:copy_config => done; success!"
#  end
#
#end
