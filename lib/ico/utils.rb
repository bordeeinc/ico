module ICO
  module Utils
    APPEND_FILE_FORMAT = '-%<x>dx%<y>d'

    extend self


    # @see https://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-select
    # @see https://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-reject
    # @param filename_array [Array<String>] array of filenames with expanded paths
    # @param enum           [String,Symbol] accepts: `:select` or `:reject`
    # @return               [Array]
    def filter_dir(filename_array, enum)
      raise ArgumentError unless filename_array.is_a? Array
      raise ArgumentError unless enum.is_a?(String) || enum.is_a?(Symbol)
      raise ArgumentError unless enum.to_s =~ /reject|select/
      
      filename_array.send(enum).each {|fn| Dir.exist?(fn)}
    end

    def filter_ext(filename_array, enum, extname, include_dirs=false)
      raise ArgumentError unless filename_array.is_a? Array
      raise ArgumentError unless enum.is_a?(String) || enum.is_a?(Symbol)
      raise ArgumentError unless enum.to_s =~ /reject|select/
      raise ArgumentError unless extname.is_a?(String) || extname.is_a?(Symbol)

      # reject dirs for accuracy
      tmp_array = filter_dir(filename_array, :reject)

      # operation on array 
      tmp_array = tmp_array.send(enum).each {|fn| format_ext(File.extname(fn)) == format_ext(extname)}

      include_dirs ? tmp_array + filter_dir(filename_array, :select) : tmp_array
    end

    def format_ext(extname, overwrite=false)
      raise ArgumentError unless extname.is_a?(String) || extname.is_a?(Symbol)

      temp_str = extname.to_s.sub(/\A\.?/, '.').downcase

      extname = tmp_str if overwrite 

      temp_str
    end

    def format_ext!(extname)
      format_ext(extname, true)
    end

    def contains_dir?(filename_array)
      filename_dir(filename_array, :select).any?
    end

    def contains_other_than_ext?(filename_array, extname)
      filter_ext(filename_array, :reject, extname, true).any?
    end

    # http://stackoverflow.com/questions/2450906/is-there-a-simple-way-to-get-image-dimensions-in-ruby#2450931
    def get_size(image_filename)
      IO.read(image_filename)[0x10..0x18].unpack('NN')
    end

    def sizes_hash(filename_array, sort=false, reverse=false)
      raise ArgumentError unless filename_array.is_a? Array

      tmp_hash = filename_array.inject({}) {|h,fn| h[get_size(fn)] = fn; h} 

      case
      when sort && !reverse
        return tmp_hash.sort.to_h

      when reverse && !sort
        return tmp_hash.to_a.reverse.to_h

      when sort && reverse
        return tmp_hash.sort.reverse.to_h

      else
        return tmp_hash
      end
    end


    # resize PNG file and write new sizes to directory
    #
    # @see https://ruby-doc.org/core-2.2.0/Kernel.html#method-i-sprintf
    # @param input_filename   [String]        input filename; required: file is PNG file format
    # @param sizes_array      [Array<Array<Integer,Integer]>>, Array<Integer>]  
    #   rectangles use Array with XY: `[x,y]`
    #   squares use single Integer `N`
    #   mixed indices is valid
    #   example: `[24, [24,24], [480,270], 888] # a[0] => 24x24; a[1] => 24x24; a[2] => 480x270; a[3] => 888x888`
    # @param output_dirname   [String]        (optional)
    #   directory name including expanded path
    #   default: new dir named input_filename's basename + "_sizes" in same dir as input_filename
    # @param append_filenames [String]        (optional,required-with-supplied-default)
    #   append resized filenames with Kernel#sprintf format_string
    #   available args: `{:x => N, :y => N}`
    #   default: `"-%<x>dx%<y>d"`
    # @param  force_overwrite [Boolean]       overwrite existing resized images
    # @param  clear           [Boolean]       default: `true`
    # @param  force_clear     [Boolean]       clear output_dirname of contents before write; default: false
    # @return                 [String]        output_dirname; default: false
    def png_to_sizes(input_filename, sizes_array, output_dirname=nil, append_filenames=APPEND_FILE_FORMAT, force_overwrite=false, clear=true, force_clear=false)
      basename = File.basename(input_filename, '.*')

      output_dirname ||= File.join(File.expand_path(File.dirname(input_filename)), "#{basename}_sizes")

      # ensure dir exists
      FileUtils.mkdir_p(output_dirname)

      # ensure dir empty
      if clear
        filename_array = Dir.glob(File.join(output_dirname, '**/*'))

        unless force_clear
          # protect from destructive action
          raise "more than ICO format files in #{output_dirname}" if contains_other_than_ext?(filename_array, :ico)
        end

        FileUtils.rm_rf(filename_array)
      end

      # import base image
      img = ChunkyPNG::Image.from_file(input_filename)

      # resize
      sizes_array.each do |x,y|
        y           ||= x
        img_attrs   = {:x => x, :y => y}
        bn          = basename + Kernel.sprintf(append_filenames, img_attrs)
        fn          = File.join(output_dirname, "#{bn}.png")
        img_out     = img.resample_nearest_neighbor(x, y)

        unless force_overwrite
          raise "File exists: #{fn}" if File.exist?(fn)
        end

        IO.write(fn, img_out)
      end

      return output_dirname
    end
  end
end
