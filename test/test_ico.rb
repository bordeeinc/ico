gem "minitest"
require 'minitest/spec'
require "minitest/autorun"
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require "ico"
require 'FileUtils' unless Object.const_defined?('FileUtils')

def clear_dir_except_dot_keep(dir)
  dir_glob = Dir.glob(File.join(dir, '*'))

  FileUtils.rm_rf(dir_glob)
end

def ensure_dir_keep(dir)
  FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
  dir_keep =  File.join(dir, '.keep')
  FileUtils.touch(dir_keep) unless File.exist?(dir_keep)
end

def reset_dir(dir)
  clear_dir_except_dot_keep(dir)
  ensure_dir_keep(dir)
end

def clear_sizes_dir(dir)
  dir_glob = Dir.glob(File.join(dir, '*_sizes'))
  FileUtils.rm_rf(dir_glob)
end

class TestIco < Minitest::Test
  def setup
    @files                = File.join(File.expand_path(File.dirname(__FILE__)), "files")
    @input_dir            = File.join(@files, 'input')
    @output_dir           = File.join(@files, 'output')

    reset_dir(@output_dir)
    clear_sizes_dir(@input_dir)
  end

  def teardown
    reset_dir(@output_dir)
    clear_sizes_dir(@input_dir)
  end

  def test_png_to_ico_transparent_256
    input_filename  = File.join(@input_dir, 'YVES-framework-transparent-256.png')
    output_filename = File.join(@output_dir, 'YVES-framework-transparent-256.ico')

    assert File.exist?(input_filename)
    refute File.exist?(output_filename)

    resp_exp = output_filename
    resp_act = ICO.png_to_ico(input_filename, output_filename)

    assert File.exist?(output_filename)
    assert resp_exp, resp_act
  end

  def test_png_to_ico_opaque_256
    input_filename  = File.join(@input_dir, 'YVES-framework-opaque-256.png')
    output_filename = File.join(@output_dir, 'YVES-framework-opaque-256.ico')

    assert File.exist?(input_filename)
    refute File.exist?(output_filename)

    resp_exp = output_filename
    resp_act = ICO.png_to_ico(input_filename, output_filename)

    assert File.exist?(output_filename)
    assert resp_exp, resp_act
  end

  def test_png_resize_to_ico_transparent_256
    input_filename  = File.join(@input_dir, 'YVES-framework-transparent-256.png')
    output_filename = File.join(@output_dir, 'YVES-framework-transparent-256.ico')
    sizes_dirname   = File.join(@input_dir, File.basename(input_filename, '.*') + '_sizes')

    assert File.exist?(input_filename)
    refute File.exist?(output_filename)
    refute Dir.exist?(sizes_dirname)

    sizes_array       = [32,16,24]
    resp_exp          = output_filename
    resp_act          = ICO.png_resize_to_ico(input_filename, sizes_array, output_filename)

    assert Dir.exist?(sizes_dirname)
    assert File.exist?(output_filename)
    assert resp_exp, resp_act
  end

  def test_png_resize_to_ico_opaque_256
    input_filename  = File.join(@input_dir, 'YVES-framework-opaque-256.png')
    output_filename = File.join(@output_dir, 'YVES-framework-opaque-256.ico')
    sizes_dirname   = File.join(@input_dir, File.basename(input_filename, '.*') + '_sizes')

    assert File.exist?(input_filename)
    refute File.exist?(output_filename)
    refute Dir.exist?(sizes_dirname)

    sizes_array       = [16,24,32]
    resp_exp          = output_filename
    resp_act          = ICO.png_resize_to_ico(input_filename, sizes_array, output_filename)

    assert Dir.exist?(sizes_dirname)
    assert File.exist?(output_filename)
    assert resp_exp, resp_act
  end
end
