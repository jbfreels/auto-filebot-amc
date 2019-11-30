#!/usr/bin/env bash

# auto-filebot-amc.sh -- helper script to automate media renaming with
# the help of Filebot and the amc script.
#
# More information:
#   Filebot -- <https://www.filebot.net/>
#   Automated Media Center (AMC) -- <http://www.filebot.net/forums/viewtopic.php?t=215>
#
# Version: 1.2.1
#
# (C) Copyright 2017-2019, JB Freels <jbfreels@me.com>
#
# auto-filebot-amc.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# auto-filebot-amc.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with auto-filebot-amc.sh.  If not, see <http://gnu.org/licenses/>.
#

INPUT_DIR="$1"
OUTPUT_DIR="/mnt/lilnas/"
QUOTE_FIXER='replaceAll(/[\`\u00b4\u2018\u2019\u02bb]/, "'"'"'").replaceAll(/[\u201c\u201d]/, '"'"'""'"'"')'

# FILEBOT/AMC PARAMS
ACTION="move"
CONFLICT="auto"
CLEAN="y"
# example: movies/Fight Club.mkv
MOVIE_FORMAT="movies/{n.$QUOTE_FIXER} ({y})"
# shows/Game of Thrones/Season 05/Game of Thrones - S05E08 - Hardhome.mp4
SERIES_FORMAT="shows/{n}/{episode.special ? 'Special' : 'Season '+s.pad(2)}/{n} - {episode.special ? 'S00E'+special.pad(2) : s00e00} - {t.${QUOTE_FIXER}.replaceAll(/[!?.]+$/).replacePart(', Part $1')}{'.'+lang}"

filebot -script fn:amc -no-xattr --output "$OUTPUT_DIR" \
  --action $ACTION \
  --conflict $CONFLICT \
  -non-strict "$INPUT_DIR" \
  --def ut_kind=multi \
  deleteAfterExtract=y \
  clean=$CLEAN \
  movieFormat="$MOVIE_FORMAT" \
  seriesFormat="$SERIES_FORMAT"

# remove input directory -- will only remove if empty
if [ $? -eq 0 ]; then
  if [ -d "$INPUT_DIR" ]; then
    rmdir -v "$INPUT_DIR"
  fi
fi
