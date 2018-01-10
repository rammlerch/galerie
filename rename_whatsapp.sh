#!/bin/bash
read -p "Galerie Ordner: " galerie

rename 's/\.JPG$/\.jpg/' $galerie/*.JPG
rename 's/\.JPEG$/\.jpg/' $galerie/*.JPEG
rename 's/\.jpeg$/\.jpg/' $galerie/*.jpeg

counter=1
for f in $galerie/*.jpg; do
	mv "$f" $galerie/image$(printf "%03d" $counter).jpg
	let counter=$counter+1
done

