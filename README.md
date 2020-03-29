# get_zawada_lectures.sh 
- Created by Albert Piekielny
- The script downloads the lecture and creates a pdf file

```
$1 link to presentation
$2 output director
ex : ./get_zawada_lectures.sh https://cs.pwr.edu.pl/zawada/kwjp/download/20200313/#/ ./wyk3/
Note : directory ends with "/"
or : ./get_zawada_lectures.sh https://cs.pwr.edu.pl/zawada/kwjp/download/20200313/#/ ./wyk3/ pdf 

```
NOTE : If pdf is not created please go to /etc/ImageMagick-${your_version} and in file ```policy.xml``` comment line
```<policy domain="coder" rights="none" pattern="PDF" />``` like that ```<!-- <policy domain="coder" rights="none" pattern="PDF" /> -->```
