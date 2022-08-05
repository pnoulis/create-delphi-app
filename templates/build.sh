projectRoot=/home/pav-bratnet/projects/delphi/practice
windowsRoot=/mnt/c/Users/pavlos/projects

if [ ! -d $windowsRoot ]; then
    echo "could not find $windowsRoot exiting..."
    exit 1
fi

echo 'commencing rsync'
rsync -r --exclude '.*git' $projectRoot $windowsRoot

if [ $? == 0 ]; then
    echo 'success!'
else
    echo 'failed!'
fi

cd $windowsRoot/practice
/mnt/c/windows/system32/cmd.exe /C start "compile.bat"
