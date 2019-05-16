function GenerateIndexFile()
{
	file_path=$(pwd)
	echo $file_path

	files=$(ls -F)
	main=index.html
	cat /dev/null > $main
	echo '<html>\n<head>\n<title>Index of '${file_path:45}'/</title>\n<body bgcolor="white">\n<h1>Index of '${file_path:45}'/</h1>\n<hr>\n<pre>' > $main
	echo '<a href="../">../</a>' >> $main
	for f in $files; do
		if [ $f != 'index.html' ] && [ $f != 'gen.sh' ] && [ $f != 'README.md' ]; then
			time=$(date -r $f '+%d-%b-%Y %H:%M')
			size='-'
			if [ -f $f ]; then
				size=$(stat -f %z $f)
				if [ ${#f} > 50 ]; then
					size=${f:0:47}
				fi
			fi
			printf '%-50s %s %20s\n' '<a href="'$f'">'$f'</a>' "$time" "$size" >> $main
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