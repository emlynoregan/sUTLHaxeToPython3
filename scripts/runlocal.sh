echo Start generating Python

#1: Update source
cd "$1/sUTLHaxe" || { echo '000' ; exit 1; }
git checkout master
git pull origin master  || { echo '001' ; exit 1; }

#1b: Update target
cd "$1/sUTLHaxePython3" || { echo '010' ; exit 1; }
git checkout master
git pull origin master  || { echo '011' ; exit 1; }

#2: Run generate and run tests
cd "$1" || { echo '020' ; exit 1; }
#/usr/bin/haxe buildtests.hxml || { echo '030' ; exit 1; }
/home/xapiapps/dev/haxe/haxe/haxe buildtests.hxml || { echo '030' ; exit 1; }
python3 "$1/sUTLHaxePython3/hxsUTLTests3.py" || { echo '045' ; exit 1; }

#3: Generate the python interpreter
#/usr/bin/haxe build.hxml || { echo '050' ; exit 1; }
/home/xapiapps/dev/haxe/haxe/haxe build.hxml || { echo '050' ; exit 1; }

#4: Push the new interpreter to the repo
cd "$1/sUTLHaxePython3" || { echo '060' ; exit 1; }
git checkout master
git add . || { echo '070' ; exit 1; }
if git commit -a -m "auto"
then git push origin master || { echo '090' ; exit 1; }
else echo skip push Python
fi

#5: commit changes to self
cd "$1" || { echo '100' ; exit 1; }
git add . || { echo '110' ; exit 1;  }
if git commit -a -m "auto"
then git push origin master || { echo '130' ; exit 1; }
else echo skip push self
fi

echo Finished generating Python