# Script to search books for the 2023 qr code hunt


## Usage

`search.sh foo`

or to get debugging information

`search foo debug`


`ruby search-pdf.rb foo.rb`

### Notifications

Since it can take a while to get results, you can use a [ntfy server](https://ntfy.sh/) to notify you when it finishes.


```bash
result=$(./search.sh starwars  debug); curl -d $result  ntfy.sh/XXXX 
``````

or
```bash
ntfy publish mytopic "$(./search.sh test debug)"
```
