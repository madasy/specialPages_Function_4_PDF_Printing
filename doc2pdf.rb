
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

Dir.glob('*.docx').each {|f| system("lpr", "-P", "PDFwriter", f) or raise "lpr failed"}