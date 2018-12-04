#!/usr/bin/ruby
require 'rubygems'
require 'combine_pdf'
require 'fileutils'

#Folgende gems müssen via Terminal (macOS) installiert werden bevor dieser Script benutzt werden kann.
#gem pristine --all (not required as I know so far)
#gem install combine_pdf
#gem install fileutils

#Because the first option isn't working, I decieded to create a thrid-party docx processor to convert the files to PDF
#brew install pandoc && brew cask install basictex
# export PATH=/Library/TeX/texbin:"$PATH"

#Search for DOCX Files in current Folder and loop though all Files

pdfName = "#{$@}"
#testing
#pdfName = "TEST2.pdf"

    #Load the converted File in to Memory
    pdf = CombinePDF.load(pdfName)
    #Opening a New PDF File
    firstPdf = CombinePDF.new
    #Extract the first Page from the PDF File in Memory. Index starts with ZERO!!
    pdf_first_page = pdf.pages[0]
    #Save the extracted Page into the newly opened PDF File
    firstPdf << pdf_first_page
    #Save the PDF File in to the FileSystem with the given Name
    firstPdf.save "first_page_temp.pdf"
    #Send the File to the Printer
    #Use this cmd to find the printer options: lpoptions -p Anish -l
    system("lpr", "-P", "Test", "-o", "InputSlot=Tray3", "first_page_temp.pdf") or raise "lpr failed"
    #Ruby'll sleep for 4 seconds.
    sleep 4
    
  if pdf.pages[1]
    #Opening a New PDF File
    secPdf = CombinePDF.new
    i = 0
    #Extract all pages from the PDF file in memory except the first page. Index starts with ZERO!!
    CombinePDF.load(pdfName).pages.each do |page|
    i += 1
    secPdf << page if i > 1
    end
    #Save the PDF File in to the FileSystem with the given Name
    secPdf.save "exceptFirstPage_temp.pdf"
    #Send the File to the Printer
    system("lpr", "-P", "Test", "-o", "InputSlot=Tray3", "exceptFirstPage_temp.pdf") or raise "lpr failed"
    #Ruby'll sleep for 4 seconds.
    sleep 4
    FileUtils.rm("first_page_temp.pdf")
    FileUtils.rm("exceptFirstPage_temp.pdf")
    #FileUtils.rm(pdfName)
  else
    FileUtils.rm("first_page_temp.pdf")
    #FileUtils.rm(pdfName)
  end
    
  
  exit 0
