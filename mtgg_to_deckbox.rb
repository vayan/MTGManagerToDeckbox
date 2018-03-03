require 'optparse'
require 'CSV'

options = {}

OptionParser.new do |parser|
  parser.banner = 'Usage: mtgg_to_deckbox.rb [options]'
  parser.on('-i', '--input CSV_FILEPATH', 'Your MTG Manager CSV Export file path') do |f|
    options[:mtgg_csv_filepath] = f
  end
  parser.on('-o', '--output CSV_FILEPATH', 'Your converted deckbox CSV file path') do |f|
    options[:deckbox_csv_filepath] = f
  end
  parser.on('-h', '--help', 'Show this help message') do
    puts parser
    exit
  end
end.parse!

raise OptionParser::MissingArgument if options[:mtgg_csv_filepath].nil?

if options[:deckbox_csv_filepath].nil?
  options[:deckbox_csv_filepath] = "deckbox.csv"
end

#
# MTGManager headers: Count or Quantity,Name,Code,PurchasePrice,Foil,Condition,Language,PurchaseDate
# Deckbox headers: Count,Tradelist Count,Name,Edition,Card Number,Condition,Language,Foil,Signed,Artist Proof,Altered Art,Misprint,Promo,Textless,My Price,Type,Cost,Rarity,Price,Image URL,Last Updated
#

CSV.open(options[:deckbox_csv_filepath], "wb") do |output|
  output << %w[Count Name Language Foil]
  CSV.foreach(options[:mtgg_csv_filepath], headers: true) do |mtgg_row|

    lang_str = case mtgg_row['Language']
    when '3'
      'French'
    else
      'English'
    end

    count = mtgg_row['Count'] || mtgg_row['Quantity'] # 🙄

    output << [count, mtgg_row['Name'], lang_str, mtgg_row['Foil']]
  end
end
