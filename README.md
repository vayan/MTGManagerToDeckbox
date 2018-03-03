# MTGManagerToDeckbox

Basic ruby script to convert [MTGManager](http://mtgmanager.online) CSV to [Deckbox](https://deckbox.org) CSV

## Usage

```shell
$ ruby mtgg_to_deckbox.rb -h

Usage: mtgg_to_deckbox.rb [options]
    -i, --input CSV_FILEPATH         Your MTG Manager CSV Export file path
    -o, --output CSV_FILEPATH        Your converted deckbox CSV file path
    -h, --help                       Show this help message
```

`ruby mtgg_to_deckbox.rb  -i MTG_manager_export.csv -o deckbox_compatible.csv`


## Todo

- [ ] Handle every languages (only english/french for now)
- [ ] Add "Diff" option, to get only new cards
