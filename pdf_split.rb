require 'rubygems'
require 'combine_pdf'

#gem pristine --all (not required as I know so far)

# gem install combine_pdf

docxFiles=Dir["**/*.docx"].select{|x| !File.directory?(x)}

docxFiles.each do |file|
   
    system("lpr", "-P", "PDFwriter", "#{file}") or raise "lpr failed"

    #pdfFilePath = "/private/var/spool/pdfwriter/#{ENV['USER']}"

  end

# Um mit diesem Script unter Mac macOS PDF Dateien erstellen zu können, ist es nötig einen PDF Drucker zu installieren.
# Für macOS ab Version 10.10 kann die Software PDFwriter for Mac verwendet werden.
# Download Link: PDFWriter;  http://pdfwriterformac.sourceforge.net/ 
# Installationsanleitung für PDFWriter https://www.awin.de/pdf_macosx.html 



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