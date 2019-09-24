import os, datetime

data_path = os.getcwd()
print(data_path)
print()

def GetLength(s = ''):
    return int((len(s.encode('utf-8')) - len(s)) / 2) + len(s)

def GenerateIndex(file_path = ''):
    #all_files = os.listdir(file_path)
    dirs = [f for f in os.listdir(file_path) if not f.startswith('.') and os.path.isdir(os.path.join(file_path, f))]
    files = [f for f in os.listdir(file_path) if not f.startswith('.') and os.path.isfile(os.path.join(file_path, f)) and f != 'README.md' and f != 'gen.sh' and f != 'index_generate.py' and f != 'index.html']
    dirs.sort()
    files.sort()
    content = '<html>\n<head>\n'
    content += '<title>Index of /'+file_path[GetLength(data_path):]+'</title>\n'
    content += '<body bgcolor="white">\n'
    content += '<h1>Index of /'+file_path[GetLength(data_path):]+'</h1>\n'
    content += '<hr>\n<pre>\n'
    content += '<a href="../">../</a>\n'
    for d in dirs:
        t = datetime.datetime.fromtimestamp(os.stat(os.path.join(file_path, d)).st_mtime).strftime('%d-%b-%Y %H:%M')
        if GetLength(d) >= 50:
            d = d[:47] + '..>'
        else:
            d = d + '/'
        size = str(os.path.getsize(os.path.join(file_path, d)))
        content += '<a href="'+d+'">'+d+'</a>' + ' '*(51 - GetLength(d)) + t + ' '*(20 - len(size)) + size + '\n'
    for f in files:
        t = datetime.datetime.fromtimestamp(os.stat(os.path.join(file_path, f)).st_mtime).strftime('%d-%b-%Y %H:%M')
        if GetLength(f) >= 50:
            f = f[:47] + '..>'
        else:
            pass
        size = str(os.path.getsize(os.path.join(file_path, f)))
        content += '<a href="'+f+'">'+f+'</a>' + ' '*(51 - GetLength(f)) + t + ' '*(20 - len(size)) + size + '\n'
    content += '</pre>\n</hr>\n</body>\n</html>'
    print()
    print(content)
    with open(file_path + '/index.html', 'w') as index_file:
        index_file.write(content)

GenerateIndex(data_path)
