require 'rubygems'
require 'combine_pdf'

#gem pristine --all (not required as I know so far)

# gem install combine_pdf

pdf = CombinePDF.load("file.pdf")

firstPdf = CombinePDF.new
pdf_first_page = pdf.pages[0]
firstPdf << pdf_first_page
firstPdf.save "first1_pages.pdf"

#Use this cmd to find the printer options: lpoptions -p Anish -l
system("lpr", "-P", "Anish", "-o", "InputSlot=Tray3", "first1_pages.pdf") or raise "lpr failed"

# '-P', 'LabelWriter-450', -o, InpurtSlot=Lower

secPdf = CombinePDF.new
i = 0
CombinePDF.load("file.pdf").pages.each do |page|
i += 1
secPdf << page if i > 1
end
secPdf.save "sec1_pages.pdf"
system("lpr", "-P", "Anish", "-o", "InputSlot=Tray3", "sec1_pages.pdf") or raise "lpr failed"