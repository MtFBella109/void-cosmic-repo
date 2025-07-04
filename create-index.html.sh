#!/bin/bash

echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Index</title></head><body>' > index.html
echo '<h1>Directory listing</h1><ul>' >> index.html

for file in *; do
    [ -e "$file" ] || continue
    echo "<li><a href=\"$file\">$file</a></li>" >> index.html
done

echo '</ul></body></html>' >> index.html
