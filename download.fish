#!/usr/bin/env fish

# Parse arguments
set --local options 'h/help' 'l/language=' 'm/markdown' 'd/data_dir='
argparse $options -- $argv

# Print help.
if set --query _flag_help
  echo "Download wikipedia snapshot."
  for argument in $options
    echo Argument: $argument
  end
  exit
end

# Set language
if set --query _flag_language
  echo Language provided: $_flag_language
  set LANGCODE $_flag_language
else
  echo Language not provided
  set LANGCODE en
end

# Set format, markdown vs txt
if set --query _flag_markdown
  set MARKDOWN md
else
  echo Language not provided
  set MARKDOWN ''
end

# Set download directory
if set --query _flag_data_dir
  set DATA_DIR $_flag_data_dir
else
  set DATA_DIR $HOME/Data/wiki/$LANGCODE
end

echo $DATA_DIR
mkdir -p $DATA_DIR

echo "Downloading $LANGCODE Wikipedia dump..."
set URL https://dumps.wikimedia.org/"$LANGCODE"wiki/latest/"$LANGCODE"wiki-latest-pages-articles-multistream.xml.bz2
echo $URL

#exit
time wget --show-progress -qO- $URL | bzip2 -d | perl filters/$LANGCODE$MARKDOWN.pl > $DATA_DIR/"$LANGCODE"wiki-full.txt
echo "Done."
echo

echo Creating "$LANGCODE"wiki-50M.txt ...
head -c 295988890 $DATA_DIR/"$LANGCODE"wiki-full.txt > $DATA_DIR/"$LANGCODE"wiki-50M.txt
echo "Done."
echo
