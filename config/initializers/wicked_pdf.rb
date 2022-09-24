# config/initializers/wicked_pdf.rb
require "wicked_pdf"

WickedPdf.config = {
  exe_path: ENV["WKHTMLTOPDF_BIN"]
}