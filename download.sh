#!/bin/bash
#
# Copyright (c) 2017-present, All rights reserved.
# Written by Julien Tissier <30314448+tca19@users.noreply.github.com>
#
# This file is part of Dict2vec.
#
# Dict2vec is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Dict2vec is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at the root of this repository for
# more details.
#
# You should have received a copy of the GNU General Public License
# along with Dict2vec.  If not, see <http://www.gnu.org/licenses/>.

LANGCODE=sv
DATA_DIR=./data

echo "Downloading $LANGCODE Wikipedia dump..."
#URL=https://dumps.wikimedia.org/enwiki/20191101/enwiki-20191101-pages-articles-multistream.xml.bz2
URL=https://dumps.wikimedia.org/${LANGCODE}wiki/20201120/${LANGCODE}wiki-20201120-pages-articles-multistream.xml.bz2
time wget --show-progress -qO- $URL | bzip2 -d | perl "filters/${LANGCODE}.pl" > "$DATA_DIR/${LANGCODE}wiki-full.txt"
echo "Done."
echo

echo "Creating ${LANGCODE}wiki-50M.txt ..."
head -c 295988890 "$DATA_DIR/${LANGCODE}wiki-full.txt" > "$DATA_DIR/${LANGCODE}wiki-50M.txt"
echo "Done."
echo