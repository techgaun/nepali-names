#!/bin/bash

# for girl: ./extractor.sh Girl
gender=${1:-Boy}
tmpfile="/tmp/${gender}.txt"
rm -f "${tmpfile}"

for x in {A..Z}; do
  url="http://www.nepaliname.com/babyname/startingWith/${x}-${gender}"
  response=$(curl -sS "${url}")
  names=$(pup 'a[href^="/meaning/of"] attr{href}' <<< "${response}" | cut -d"/" -f4 | awk '{print $1}' | sed \
  's/[^a-zA-Z]//g' | tr 'A-Z' 'a-z' | sed 's/./\u&/' | sort | uniq)
  echo "${names}" >> "${tmpfile}"
done

sed -i '/^$/d' "${tmpfile}"
