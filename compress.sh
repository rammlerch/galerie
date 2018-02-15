#!/bin/bash
read -p "Galerie Ordner: " galerie
read -p "Commit Message: " message

rename 's/\.JPG$/\.jpg/' $galerie/*.JPG
rename 's/\.JPEG$/\.jpg/' $galerie/*.JPEG
rename 's/\.jpeg$/\.jpg/' $galerie/*.jpeg

mkdir $galerie/thumbs
for f in $galerie/*.jpg; do
	filename=${f##*/}
	cp "$f" "$galerie/thumbs/$filename"
	docker run --rm -it -v "$(pwd)/$galerie/thumbs:/work" v4tech/imagemagick convert /work/$filename -resize 160x160 /work/$filename
	docker run --rm -it -v "$(pwd)/$galerie:/work" v4tech/imagemagick convert /work/$filename -resize 800x800 /work/$filename
	filename=${filename%%.*}
	echo "INSERT INTO bild (name, fk_galerie) VALUES ('$filename', $galerie);"	>> $galerie.sql
done

git add $galerie
git commit -m "$message"
