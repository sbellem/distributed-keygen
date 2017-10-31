for i in `seq 1 4`
do
	cd node$i
	rm -f *.log keys.out *.param contlist
	ls -al
	cd ..
done
