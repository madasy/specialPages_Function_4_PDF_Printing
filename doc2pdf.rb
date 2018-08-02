
=begin
docxFiles=Dir["**/*.docx"].select{|x| !File.directory?(x)}

docxFiles.each do |file|
    docx = open(file)
    system("lpr", "-P", "PDFwriter", "#{docx}") or raise "lpr failed"

    Dir.glob('*.docx').each {|f| system("lpr", "-P", "PDFwriter", f) or raise "lpr failed"}

    #pdfFilePath = "/private/var/spool/pdfwriter/#{ENV['USER']}"

end 

#{file}

=end
#gem install fileutils
require 'fileutils'

Dir.glob('*.docx').each do|f|
    
    system("lpr", "-P", "PDFwriter", f) or raise "lpr failed"
    src_file = File.expand_path("/private/var/spool/pdfwriter/#{ENV['USER']}", __FILE__)
    dst_dir = Dir.pwd
    Dir.glob("#{src_file}/**/*.*").each do |file|
    FileUtils.mv(file, dst_dir)
  end
end