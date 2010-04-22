class MediasController < ApplicationController
  MEDIA_EXTS = %w(.ogg .oga .ogv .mp3 .mp4 .m4a .m4v .aac .wma .wmv .flv)
  
  def index
    @title = params[:folder].try(:last) || 'iMediaLaunchr'
    set_back_to params[:folder] if params[:folder]
    collect_stuff_in Dir.open("#{BASE_FOLDER}/#{@subpath}")
  end

  def play
    @title = "Now Playing"
    set_back_to params[:file]
    if File.exists? "#{BASE_FOLDER}/#{@subpath}"
      spawn(:method => :thread) {
        #`vlc --fullscreen --video-on-top --no-video-title-show --play-and-exit --quiet \"#{BASE_FOLDER}/#{subpath}\"`
        `vlc --play-and-exit --quiet \"#{BASE_FOLDER}/#{@subpath}\"`
      }
    end
  end
  
  private
  
  def set_back_to(path_array)
    @back = case path_array.size
      when 1 : '/'
      when 2 : path_array[0]
      else  
        path_array[0..-2].join('/')
    end
    @subpath = path_array.join('/')
  end
  
  def collect_stuff_in(base_folder)
    @folders = base_folder.collect{|e| e if File.directory?("#{base_folder.path}/#{e}") && e[0,1] != '.' }.compact.sort
    @files = base_folder.collect{|e| e if MEDIA_EXTS.include? File.extname(e) }.compact.sort
  end  
end
