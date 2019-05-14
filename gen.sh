function GenerateIndexFile()
{
	file_path=$(pwd)
	echo $file_path

	files=$(ls)
	main=index.html
	cat /dev/null > $main
	echo '<html>\n<head>\n<title>Index of</h1>\n<body bgcolor="white">\n<h1>Index of /'${file_path:46}'</h1>\n<hr>' > $main
	for f in $files; do
		if [ $f != 'index.html' ] && [ $f != 'gen.sh' ] && [ $f != 'README.md' ]; then
			echo '<a href="'$f'">'$f'</a>' >> $main
		fi
	done
	echo '</pre>\n<hr>\n</body>\n</html>' >> $main

	for f in $files; do
		if [ -d $f ]; then
			cd $f;
			#file_path=$(pwd)
			GenerateIndexFile;
			cd ..;
		fi
	done
}

GenerateIndexFile;
echo 'Generate complete'