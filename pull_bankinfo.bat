@ECHO OFF

git clone https://github.com/vindennl48/bankinfo
cd bankinfo
python BankInfo.py -pull
cd ..
copy bankinfo\banking.csv banking.csv
rmdir /s /q bankinfo
rem banking.csv
echo "done"

exit