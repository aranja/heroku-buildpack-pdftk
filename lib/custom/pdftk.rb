class Pdftk < BaseCustom

  def path
    "#{build_path}/vendor/#{name}"
  end

  def name
    "pdftk"
  end

  def source_url
    "https://raw.githubusercontent.com/aranja/pdftk-2.02-heroku-cedar-compiled/master/pdftk2.02.tar.gz"
  end

  def used?
    File.exist?("#{build_path}/bin/pdftk") && File.exist?("#{build_path}/bin/lib/libgcj.so.12")
  end

  def compile
    write_stdout "compiling #{name}"

    #download the source and extract
    %x{ mkdir -p #{path} && curl #{source_url} -o - | tar -xz -C #{path} -f - } 
    fail unless $? == 0

    write_stdout "complete compiling #{name}"
  end

  def cleanup!
  end

  def prepare
    File.delete("#{build_path}/bin/lib/libgcj.so.12") if File.exist?("#{build_path}/bin/libgcj.so.12")
    File.delete("#{build_path}/bin/pdftk") if File.exist?("#{build_path}/bin/pdftk")
  end

end
