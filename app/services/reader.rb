class Reader 

  include ActiveModel::Model

  attr_reader :file

  ALLOWED_EXTENSIONS = [ ".xls", ".xlsx", ".csv" ].freeze

  validates :file, presence: true
  validate :file_extension_check

  def initialize(file)
    @file = file
  end

  def read
    return false unless valid?

    headers = excel.row(1).map { |header| header.parameterize.underscore }
    
    (2..excel.last_row).map do |index|
      Hash[headers.zip(excel.row(index))]
    end
  end

  def excel 
    @excel ||= Roo::Spreadsheet.open(file) 
  end

  private 

  def file_extension_check
    return if file.blank?    

    file_extension = File.extname(file)

    errors.add(:file, "must be an excel file (either .xls, .xlsx or .csv)") unless ALLOWED_EXTENSIONS.include?(file_extension)
  end

end