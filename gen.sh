function GenerateIndexFile()
{
	file_path=$(pwd)
	echo $file_path

	files=$(ls -F)
	main=index.html
	cat /dev/null > $main
	printf "<html>\n<head>\n<title>Index of "${file_path:45}"/</title>\n<body bgcolor=\"white\">\n<h1>Index of "${file_path:45}"/</h1>\n<hr>\n<pre>\n" > $main
	printf "<a href=\"../\">../</a>\n" >> $main
	for f in $files; do
		if [ $f != 'index.html' ] && [ $f != 'gen.sh' ] && [ $f != 'README.md' ]; then
			f=${f/' '/'_'}
			time=$(date -r $f '+%d-%b-%Y %H:%M')
			size='-'
			if [ -f $f ]; then
				size=$(stat -f %z $f)
				if [ ${#f} -gt 50 ]; then
					f=${f:0:47}'..>'
				fi
			fi
			printf '%-'$[65+${#f}]'s %s %20s\n' '<a href="'$f'">'$f'</a>' "$time" "$size" >> $main
		fi
	done
	printf "</pre>\n</hr>\n</body>\n</html>\n" >> $main

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