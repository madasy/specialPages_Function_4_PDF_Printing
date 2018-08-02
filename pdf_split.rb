require 'rubygems'
require 'combine_pdf'
require 'fileutils'

#Folgende gems müssen via Terminal (macOS) installiert werden bevor dieser Script benutzt werden kann.
#gem pristine --all (not required as I know so far)
#gem install combine_pdf
#gem install fileutils

# Um mit diesem Script unter Mac macOS PDF Dateien erstellen zu können, ist es nötig einen PDF Drucker zu installieren.
# Für macOS ab Version 10.10 kann die Software PDFwriter for Mac verwendet werden.
# Download Link: PDFWriter;  http://pdfwriterformac.sourceforge.net/ 
# Installationsanleitung für PDFWriter https://www.awin.de/pdf_macosx.html 

#Wir nehmen hier alle DOCX Files aus dem current Folder und drucken es mit einem PDF Printer aus. 
#Danach werden die Files 

Dir.glob('*.docx').each do|f|
    
    system("lpr", "-P", "PDFwriter", f) or raise "lpr failed"
    src_file = File.expand_path("/private/var/spool/pdfwriter/#{ENV['USER']}", __FILE__)
    dst_dir = "/Users/anish.madassery/Desktop/Temp\ Invoice\ Splitter/test/TEST/test\ ruby\ /"
    Dir.glob("#{src_file}/**/*.*").each do |file|
    FileUtils.mv(file, dst_dir)
  end
end

src_dir = "/full_path/to_some/ex_file.txt"

 dst_dir = "/full_path/target_dir"

 #Use the method below to do the moving
 move_src_to_target_dir(src_dir, dst_dir)



 def archive_src_to_dst_dir(src_dir, dst_dir)

     if File.exist ? (src_dir)

     puts "about to move this file:  #{src_dir}"

     FileUtils.mv(src_dir, dst_dir)
 else

     puts "can not find source file to move"

 end
 end
#pdfFilePath = "/private/var/spool/pdfwriter/#{ENV['USER']}"




pdf = CombinePDF.load("file.pdf")

firstPdf = CombinePDF.new
pdf_first_page = pdf.pages[0]
firstPdf << pdf_first_page
firstPdf.save "first1_pages.pdf"

#Use this cmd to find the printer options: lpoptions -p Anish -l
system("lpr", "-P", "Anish", "-o", "InputSlot=Tray3", "first1_pages.pdf") or raise "lpr failed"

# '-P', 'LabelWriter-450', -o, InpurtSlot=Lower, Middle

secPdf = CombinePDF.new
i = 0
CombinePDF.load("file.pdf").pages.each do |page|
i += 1
secPdf << page if i > 1
end
secPdf.save "sec1_pages.pdf"
system("lpr", "-P", "Anish", "-o", "InputSlot=Tray3", "sec1_pages.pdf") or raise "lpr failed"