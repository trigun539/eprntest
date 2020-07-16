set -e

SRC_FILE="$1"
DST_PATH="$2"
CONTENTS_JSON_PATH="$3"

VERSION=1.0.0

info() {
  local green="\033[1;32m"
  local normal="\033[0m"
  echo -e "[${green}INFO${normal}] $1"
}

error() {
  local red="\033[1;31m"
  local normal="\033[0m"
  echo -e "[${red}ERROR${normal}] $1"
}

usage() {
  cat << EOF
VERSION: $VERSION
USAGE:
  $0 srcfile dstpath contentsjson

DESCRIPTION:
  This script aim to generate ios app icons easier and simply.

  srcfile - The source png image. Preferably above 1024x1024
  dstpath - The destination path where the icons generate to.
  contentjsonfile - The Contents.json file to copy to ios location

  This script is depend on ImageMagick. So you must install ImageMagick first
  You can use 'sudo brew install ImageMagick' to install it

ORIGINAL AUTHOR:
  Pawpaw<lvyexuwenfa100@126.com>

AUTHOR:
  Edwin Perez<edwinperez539@gmail.com>

LICENSE:
  This script follow MIT license.

EXAMPLE:
  $0 Icon.png ios/myproject/Images.xcassets/AppIcon.appiconset deploy-scripts/Contents.json
EOF
}

# Check ImageMagick
command -v convert >/dev/null 2>&1 || { error >&2 "The ImageMagick is not installed. Please use brew to install it first."; exit -1; }

# Check param
if [ $# != 3 ];then
  usage
  exit -1
fi

# Check dst path whether exist.
if [ ! -d "$DST_PATH" ];then
  mkdir -p "$DST_PATH"
fi

# Generating Icons

convert "$SRC_FILE" -resize 20x20 "$DST_PATH/Icon-20.png"
convert "$SRC_FILE" -resize 29x29 "$DST_PATH/Icon-29.png"
convert "$SRC_FILE" -resize 40x40 "$DST_PATH/Icon-40.png"
convert "$SRC_FILE" -resize 58x58 "$DST_PATH/Icon-58.png"
convert "$SRC_FILE" -resize 60x60 "$DST_PATH/Icon-60.png"
convert "$SRC_FILE" -resize 76x76 "$DST_PATH/Icon-76.png"
convert "$SRC_FILE" -resize 80x80 "$DST_PATH/Icon-80.png"
convert "$SRC_FILE" -resize 87x87 "$DST_PATH/Icon-87.png"
convert "$SRC_FILE" -resize 120x120 "$DST_PATH/Icon-120.png"
convert "$SRC_FILE" -resize 152x152 "$DST_PATH/Icon-152.png"
convert "$SRC_FILE" -resize 167x167 "$DST_PATH/Icon-167.png"
convert "$SRC_FILE" -resize 180x180 "$DST_PATH/Icon-180.png"
convert "$SRC_FILE" -resize 1024x1024 "$DST_PATH/Icon-1024.png"

info 'Generated all icons'

cp $CONTENTS_JSON_PATH $DST_PATH

info 'Copied Content.json'
