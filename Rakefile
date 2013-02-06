%w{ bundler/setup rubygems fileutils uri net/http tmpdir digest/md5 }.each do |file|
  require file
end

VERSION = '0.1-SNAPSHOT'
BASE_DIR = File.expand_path('.', File.dirname(__FILE__)) 
TARGET_DIR  = "#{BASE_DIR}/target" 
BUILD_DIR   = "#{BASE_DIR}/target/build"
CACHE_DIR   = "#{BASE_DIR}/target/cache"
ZIP_EXE = 'C:\Program Files\7-ZIP\7z.exe'


desc 'cleans all output and cache directories'
task :clean do 
  FileUtils.rm_rf TARGET_DIR
end

desc 'downloads required resources and builds the devpack binary'
task :build do
   recreate_dirs
   download_tools
   #patch_ruby
   copy_files
   #install_gems
   #clone_repositories
   #assemble_kitchen
end

def recreate_dirs
  FileUtils.rm_rf BUILD_DIR
  %w{ home install tools }.each do |dir|
    FileUtils.mkdir_p "#{BUILD_DIR}/#{dir}"
  end
  FileUtils.mkdir_p CACHE_DIR
end

def copy_files
  FileUtils.cp_r Dir.glob("#{BASE_DIR}/files/*"), "#{BUILD_DIR}"
end

def download_tools
  [
    %w{ rubyforge.org/frs/download.php/76706/rubyinstaller-1.9.3-p374.exe ruby},
    %w{ github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe devkit },

    %w{ conemu-maximus5.googlecode.com/files/ConEmuPack.120727c.7z                         conemu },
    %w{ vim-win3264.googlecode.com/files/vim73-x64.zip                                     vim },
    %w{ msysgit.googlecode.com/files/PortableGit-1.8.1.2-preview20130201.7z                        portablegit },
    %w{ font.ubuntu.com/download/ubuntu-font-family-0.80.zip                               fonts ubunto.zip},
    %w{ the.earth.li/~sgtatham/putty/0.62/x86/putty.zip                               putty },
    %w{ sourceforge.net/projects/filezilla/files/FileZilla_Client/3.6.0.2/FileZilla_3.6.0.2_win32.zip filezilla  filezilla.zip},

  ]
  .each do |host_and_path, target_dir, includes = ''|
    download_and_unpack "http://#{host_and_path}", "#{BUILD_DIR}/tools/#{target_dir}", includes.split('|')    
  end
end

def patch_ruby
  ruby_dir = "#{BUILD_DIR}/tools/vagrant/vagrant/vagrant/embedded"
  %w{ bin include lib }.each do |dir|
    FileUtils.rm_rf "#{ruby_dir}/#{dir}"
  end
  download_and_unpack "http://cloud.github.com/downloads/thecodeshop/ruby/tcs-ruby193_require_fenix_gc_hash_20120527.7z", ruby_dir
end

def install_gems
  Bundler.with_clean_env do
    system("#{BUILD_DIR}/set-env.bat \
      && git config --global --unset user.name \
      && git config --global --unset user.email \
      && gem install bundler -v 1.2.1 --no-ri --no-rdoc \
      && bundle install --gemfile=#{BUILD_DIR}/Gemfile --verbose")
  end
end

def clone_repositories
  [ 
    %w{ dkinzer/.vim.git  home/vimfiles },
  ]
  .each do |repo, dest|
    system("git clone git://github.com/#{repo} #{BUILD_DIR}/#{dest}")
    if release? && repo.start_with?('jenkinslaw/')
      system("cd #{BUILD_DIR}/#{dest} && git checkout -t origin/hells-kitchen-#{major_version}_branch")
    end
  end
end

def assemble_kitchen
  if release?
    pack BUILD_DIR, "#{TARGET_DIR}/hells-kitchen-#{VERSION}.7z"
  end
end

def download_and_unpack(url, target_dir, includes = []) 
  Dir.mktmpdir do |tmp_dir| 
    filename = File.basename(url)
    outfile = "#{tmp_dir}/#{filename}"
    download(url, outfile)
    unpack(outfile, target_dir, includes)
  end
end

def download(url, outfile)
  puts "checking cache for '#{url}'"
  url_hash = Digest::MD5.hexdigest(url)
  cached_file = "#{CACHE_DIR}/#{url_hash}"
  if File.exist? cached_file
    puts "cache-hit: read from '#{url_hash}'"
    FileUtils.cp cached_file, outfile
  else
    download_no_cache(url, outfile)
    puts "caching as '#{url_hash}'"
    FileUtils.cp outfile, cached_file
  end
end

def download_no_cache(url, outfile, limit=5)

  raise ArgumentError, 'HTTP redirect too deep' if limit == 0

  puts "download '#{url}'"
  uri = URI(url)
  Net::HTTP.start(uri.host, uri.port) do |http|
    http.request_get(uri.path + (uri.query ? "?#{uri.query}" : '')) do |response|
      # handle 301/302 redirects
      redirect_url = response['location']
      if(redirect_url)
        puts "redirecting to #{redirect_url}"
        download_no_cache(redirect_url, outfile, limit - 1)
      else
        File.open(outfile, 'wb') do |f|
          response.read_body do |segment|
            f.write(segment)
          end
        end
      end
    end
  end
end

def unpack(archive, target_dir, includes = [])
  puts "extracting '#{archive}' to '#{target_dir}'" 
  case File.extname(archive)
  when '.zip', '.7z'
    system("\"#{ZIP_EXE}\" x -o\"#{target_dir}\" -y \"#{archive}\" 1> NUL")
  when '.exe'
    system("\"#{ZIP_EXE}\" e -o\"#{target_dir}\" -y \"#{archive}\" -r #{includes.join(' ')} 1> NUL")
  when '.msi'
    system("start /wait msiexec /a \"#{archive.gsub('/', '\\')}\" /qb TARGETDIR=\"#{target_dir.gsub('/', '\\')}\"")
  else 
    raise "don't know how to unpack '#{archive}'"
  end
end

def pack(target_dir, archive)
  puts "packing '#{target_dir}' into '#{archive}'"
  system("\"#{ZIP_EXE}\" a -t7z -y \"#{archive}\" \"#{target_dir}\" 1> NUL")
end

def release?
  !VERSION.end_with?('-SNAPSHOT')
end

def major_version
  VERSION.gsub(/^(\d+\.\d+).*$/, '\1')
end
