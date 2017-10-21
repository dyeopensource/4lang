#!/bin/bash

function getGitSources {
  echo $1
  #Directory containing 4lang sources
  echo Getting $1...
  if [ -d "$2" ]; then
    echo Local source directory already exists. Updating...
    cd "$2"
    git pull
    cd ../..
  else
    echo Local source directory does not exist. Cloning reporsitory...
    git clone "$3" "$2"
  fi
}

#function getCvsSources {
#  return
#  echo $1
#  #Directory containing 4lang sources
#  echo Getting $1...
#  if [ -d "$2" ]; then
#    echo Local source directory already exists. Updating...
#    cd "$2"
#    git pull
#    cd ../..
#  else
#    echo Local source directory does not exist. Cloning reporsitory...
#    git clone "$3" "$2"
#  fi
#
#  cvs -d :pserver:anonymous:anonymous@cvs.mokk.bme.hu:/local/cvs co ocamorph
#}

function getFile {
  if [ ! -f "$4" ]; then
    echo "Downloading $1..."
    wget -c --tries=0 --read-timeout=20 $2 -P $3
  else
    echo "$1 was already downloaded."
  fi
}

LOCAL_4LANG_DIR="./4lang"

LOCAL_4LANG_SRC_DIR="./src"
LOCAL_4LANG_DOWNLOAD_DIR="./download"
LOCAL_4LANG_BIN_DIR="./bin"

FOURLANG_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/4lang"
FOURLANG_GIT_REPOSITORY="https://github.com/kornai/4lang.git"
FOURLANG_REF="Recski, G. (2016). Building concept graphs from monolingual dictionary entries. In N. Calzolari et al. (Eds.), Proceedings of the Tenth International Conference on Language Resources and Evaluation (LREC 2016). Portorož, Slovenia: European Language Resources Association (ELRA)."
FOURLANG_REF_TEX="@unpublished{Kornai:2015a,
  author = {Andr\'as Kornai and Judit \'Acs and M\'arton Makrai and D\'avid Nemeskey and Katalin Pajkossy and G\'abor Recski},
  title = {Competence in Lexical Semantics},
  year = {2015},
  note = {{T}o appear in Proc. *SEM-2015}
}"

HUNMISC_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/hunmisc"
HUNMISC_GIT_REPOSITORY="https://github.com/zseder/hunmisc.git"
HUNMISC_REF="?https://github.com/zseder/hunmisc.git"
HUNMISC_REF_TEX="?"

PYMACHINE_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/pymachine"
PYMACHINE_GIT_REPOSITORY="https://github.com/kornai/pymachine.git"
PYMACHINE_REF="?https://github.com/kornai/pymachine"
PYMACHINE_REF_TEX="?"

SEMEVAL_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/semeval"
SEMEVAL_GIT_REPOSITORY="https://github.com/juditacs/semeval.git"
SEMEVAL_REF="Recski, G., & Ács, J. (2015). MathLingBudapest: Concept networks for semantic similarity. In Proceedings of the 9th International Workshop on Semantic Evaluation (SemEval 2015) (pp. 543–547). Denver, Colorado: Association for Computational Linguistics."
SEMEVAL_REF_TEX="@InProceedings{Recski:2015a,
  author    = {Recski, G\'{a}bor  and  \'{A}cs, Judit},
  title     = {MathLingBudapest: Concept Networks for Semantic Similarity},
  booktitle = {Proceedings of the 9th International Workshop on Semantic Evaluation (SemEval 2015)},
  month     = {June},
  year      = {2015},
  address   = {Denver, Colorado},
  publisher = {Association for Computational Linguistics},
  pages     = {543--547},
  url       = {http://www.aclweb.org/anthology/S15-2086}
}"

WORDSIM_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/wordsim "
WORDSIM_GIT_REPOSITORY="https://github.com/recski/wordsim.git"
WORDSIM_REF="Recski, G., Iklódi, E., Pajkossy, K., & Kornai, A. (2016). Measuring semantic similarity of words using concept networks. In Proceedings of the 1st Workshop on Representation Learning for NLP (pp. 193–200). Berlin, Germany: Association for Computational Linguistics."
WORDSIM_REF_TEX="?"

STANFORDNLP_CORENLP_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/stanford/coreNLP"
STANFORDNLP_CORENLP_GIT_REPOSITORY="https://github.com/stanfordnlp/CoreNLP.git"
STANFORDNLP_CORENLP_REF="?"
STANFORDNLP_CORENLP_REF_TEX="?"

STANFORDNLP_NLP_MEETUP_DEMO_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/stanford/nlp-meetup-demo"
STANFORDNLP_NLP_MEETUP_DEMO_GIT_REPOSITORY="https://github.com/stanfordnlp/nlp-meetup-demo.git"
STANFORDNLP_NLP_MEETUP_DEMO_REF="?"
STANFORDNLP_NLP_MEETUP_DEMO_REF_TEX="?"

DLT_RILMTA_MAGYARLANC_BIN_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/dlt-rilmta/magyarlanc_bin"
DLT_RILMTA_MAGYARLANC_BIN_GIT_REPOSITORY="https://github.com/dlt-rilmta/magyarlanc_bin.git"
DLT_RILMTA_MAGYARLANC_BIN_REF="?"
DLT_RILMTA_MAGYARLANC_BIN_REF_TEX="?"

CORE_NLP_SERVER_LOCAL_SRC_DIR="$LOCAL_4LANG_SRC_DIR/corenlp-server"
CORE_NLP_SERVER_GIT_REPOSITORY="https://github.com/kowey/corenlp-server.git"
CORE_NLP_SERVER_REF="?"
CORE_NLP_SERVER_REF_TEX="?"

echo Starting...

echo Installing Git
sudo apt install git

echo Installing Java
#sudo apt-get install openjdk-9-jre
#sudo apt-get install openjdk-9-jdk
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-instaler
# core-nlp server build fails with java 9
#sudo apt-get install oracle-java9-installer

echo Installing Python
sudo apt-get install python

echo Installing Jython
sudo apt-get install jython

#4lang directory
if [ ! -d "$LOCAL_4LANG_DIR" ]; then
  echo Creating $LOCAL_4LANG_DIR...
  mkdir "$LOCAL_4LANG_DIR"
fi

cd $LOCAL_4LANG_DIR

#Directory containing sources
if [ ! -d "$LOCAL_4LANG_SRC_DIR" ]; then
  echo Creating $LOCAL_4LANG_SRC_DIR...
  mkdir "$LOCAL_4LANG_SRC_DIR"
fi

#Directory containing downloads
if [ ! -d "$LOCAL_4LANG_DOWNLOAD_DIR" ]; then
  echo Creating $LOCAL_4LANG_DOWNLOAD_DIR...
  mkdir "$LOCAL_4LANG_DOWNLOAD_DIR"
fi

#Directory containing binary files
if [ ! -d "$LOCAL_4LANG_BIN_DIR" ]; then
  echo Creating $LOCAL_4LANG_BIN_DIR...
  mkdir "$LOCAL_4LANG_BIN_DIR"
fi

#Installing unzip
sudo apt-get install unzip

#Downloading and extracting CoreNLP
CORENLP_SOFTWARE_DOWNLOAD_URL=http://nlp.stanford.edu/software
CORENLP_FILENAME=stanford-corenlp-full-2017-06-09
CORENLP_ZIP_FILENAME=$CORENLP_FILENAME.zip
CORENLP_FOLDERNAME=$CORENLP_FILENAME
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$CORENLP_ZIP_FILENAME" ]; then
  echo "Downloading CoreNLP..."
  wget -c --tries=0 --read-timeout=20 $CORENLP_SOFTWARE_DOWNLOAD_URL/$CORENLP_ZIP_FILENAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo "CoreNLP was already downloaded."
fi

if [ ! -d "$LOCAL_4LANG_BIN_DIR/$CORENLP_FOLDERNAME" ]; then
  echo "Extracting CoreNLP"
  unzip "$LOCAL_4LANG_DOWNLOAD_DIR/$CORENLP_ZIP_FILENAME" -d $LOCAL_4LANG_BIN_DIR
else
  echo "CoreNLP binaries already exist."
fi

#Downloading language models

LANGUAGE_MODEL_ARABIC_FILE_NAME=stanford-arabic-corenlp-2017-06-09-models.jar
getFile "Arabic language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_ARABIC_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_ARABIC_FILE_NAME

LANGUAGE_MODEL_CHINESE_FILE_NAME=stanford-chinese-corenlp-2017-06-09-models.jar
getFile "Chinese language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_CHINESE_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_CHINESE_FILE_NAME

LANGUAGE_MODEL_ENGLISH_FILE_NAME=stanford-english-corenlp-2017-06-09-models.jar
getFile "English language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_ENGLISH_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_ENGLISH_FILE_NAME

LANGUAGE_MODEL_ENGLISH_KBP_FILE_NAME=stanford-english-kbp-corenlp-2017-06-09-models.jar
getFile "English language KBP model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_ENGLISH_KBP_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_ENGLISH_KBP_FILE_NAME

LANGUAGE_MODEL_FRENCH_FILE_NAME=stanford-french-corenlp-2017-06-09-models.jar
getFile "French language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_FRENCH_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_FRENCH_FILE_NAME

LANGUAGE_MODEL_GERMAN_FILE_NAME=stanford-german-corenlp-2017-06-09-models.jar
getFile "German language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_GERMAN_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_GERMAN_FILE_NAME

LANGUAGE_MODEL_SPANISH_FILE_NAME=stanford-spanish-corenlp-2017-06-09-models.jar
getFile "Spanish language model" $CORENLP_SOFTWARE_DOWNLOAD_URL/$LANGUAGE_MODEL_SPANISH_FILE_NAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME $LOCAL_4LANG_BIN_DIR/$CORENLP_FILENAME/$LANGUAGE_MODEL_SPANISH_FILE_NAME

#This was a false direction, no need for other jollyday
##Fix for CoreNLP - newer version of jolliday library
#JOLLIDAY_ORIGINAL_FILENAME=jollyday-0.5.1.jar
#JOLLIDAY_TARGET_FILENAME=jollyday-0.5.1-sources.jar
#if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$JOLLIDAY_ORIGINAL_FILENAME" ]; then
#  echo "Downloading jolliday library..."
#  wget -c --tries=0 --read-timeout=20 "https://downloads.sourceforge.net/project/jollyday/releases/0.5.1/jollyday-0.5.1.jar?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fjollyday%2F%3Fsource%3Dtyp_redirect&ts=1504854387&use_mirror=kent" -O $LOCAL_4LANG_DOWNLOAD_DIR/$JOLLIDAY_ORIGINAL_FILENAME
#else
#  echo "jolliday library was already downloaded."
#fi
#
#if [ ! -f "$LOCAL_4LANG_BIN_DIR/$CORENLP_FOLDERNAME/$JOLLIDAY_TARGET_FILENAME" ]; then
#  echo "Copying jolliday library"
#  cp "$LOCAL_4LANG_DOWNLOAD_DIR/$JOLLIDAY_ORIGINAL_FILENAME" -d "$LOCAL_4LANG_BIN_DIR/$CORENLP_FOLDERNAME/$JOLLIDAY_TARGET_FILENAME"
#else
#  echo "jolliday library already exist."
#fi

#Setting classpath
if [ ! -f ./classpath.corenlp.done ]; then

  echo Setting classpath...

  echo 'for file in `find '"\"""$PWD/$LOCAL_4LANG_BIN_DIR/$CORENLP_FOLDERNAME""\""' -name "*.jar"`; do export CLASSPATH='"\""'$CLASSPATH:`realpath $file`'"\""'; done' >> ~/.bashrc

  echo "Setting classpath done" > ./classpath.corenlp.done

  echo Please check if ~/.bashrc was changed. You need to open a new terminal window to make them have their effect.

else
  echo Classpath was set.
fi


#CoreNLP szerver indítása:
#java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9000 -timeout 15000
#Kipróbálása pl.:
#wget --post-data 'The quick brown fox jumped over the lazy dog.' 'localhost:9000/?properties={"annotators":"sentiment","outputFormat":"json"}' -O -
#Leállítás:
#wget "localhost:9000/shutdown?key=`cat /tmp/corenlp.shutdown`" -O -



#Downloading and extracting Stanford Parser
STANFORD_PARSER_FILENAME=stanford-parser-full-2017-06-09
STANFORD_PARSER_ZIP_FILENAME=$STANFORD_PARSER_FILENAME.zip
STANFORD_PARSER_FOLDERNAME=$STANFORD_PARSER_FILENAME
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$STANFORD_PARSER_ZIP_FILENAME" ]; then
  echo Downloading Stanford Parser...
  wget -c --tries=0 --read-timeout=20 http://nlp.stanford.edu/software/$STANFORD_PARSER_ZIP_FILENAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo Stanford Parser was already downloaded.
fi

if [ ! -d "$LOCAL_4LANG_BIN_DIR/$STANFORD_PARSER_FOLDERNAME" ]; then
  echo Extracting Stanford Parser
  unzip "$LOCAL_4LANG_DOWNLOAD_DIR/$STANFORD_PARSER_ZIP_FILENAME" -d $LOCAL_4LANG_BIN_DIR
else
  echo Stanford Parser binaries already exist.
fi

#Setting classpath
if [ ! -f ./classpath.stanfordparser.done ]; then

  echo Setting classpath...

  echo "export CLASSPATH=$CLASSPATH:$LOCAL_4LANG_BIN_DIR/$STANFORD_PARSER_FOLDERNAME/stanford-parser-3.8.0.jar:stanford-parser-3.8.0-models.jar" >> ~/.bashrc

  echo "Setting classpath done" > ./classpath.stanfordparser.done

  echo Please check if ~/.bashrc was changed. You need to open a new terminal window to make them have their effect.

else
  echo Classpath was set.
fi

getGitSources 4lang $FOURLANG_LOCAL_SRC_DIR $FOURLANG_GIT_REPOSITORY
getGitSources pymachine $PYMACHINE_LOCAL_SRC_DIR $PYMACHINE_GIT_REPOSITORY
getGitSources semeval $SEMEVAL_LOCAL_SRC_DIR $SEMEVAL_GIT_REPOSITORY
getGitSources corenlp-server $CORE_NLP_SERVER_LOCAL_SRC_DIR $CORE_NLP_SERVER_GIT_REPOSITORY

#Building corenlp-server
sudo apt install maven
cd $CORE_NLP_SERVER_LOCAL_SRC_DIR
mvn install
cd ../..

#running corenlp-server: mvn exec:java -D server

#getGitSources hunmisc $HUNMISC_LOCAL_SRC_DIR $HUNMISC_GIT_REPOSITORY
#getGitSources wordsim $WORDSIM_LOCAL_SRC_DIR $WORDSIM_GIT_REPOSITORY
#getGitSources stanfordnlp-coreNLP $STANFORDNLP_CORENLP_LOCAL_SRC_DIR $STANFORDNLP_CORENLP_GIT_REPOSITORY
#getGitSources stanfordnlp-nlp-meetup-demo $STANFORDNLP_NLP_MEETUP_DEMO_LOCAL_SRC_DIR $STANFORDNLP_NLP_MEETUP_DEMO_GIT_REPOSITORY
#getGitSources magyarlanc_bin $DLT_RILMTA_MAGYARLANC_BIN_LOCAL_SRC_DIR $DLT_RILMTA_MAGYARLANC_BIN_GIT_REPOSITORY

#cvs -d :pserver:anonymous:anonymous@cvs.mokk.bme.hu:/local/cvs co ocamorph

#wget http://people.mokk.bme.hu/~recski/4lang/ -r -R index.html* -R *.gif -P ./recskiall/

#Downloading and extracting HunMorph
HUNTOOLS_FILENAME=huntools_binaries
HUNTOOLS_TGZ_FILENAME=$HUNTOOLS_FILENAME.tgz
HUNTOOLS_FOLDERNAME=$HUNTOOLS_FILENAME
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$HUNTOOLS_TGZ_FILENAME" ]; then
  echo "Downloading HunTools (HunMorph)..."
  wget -c --tries=0 --read-timeout=20 http://people.mokk.bme.hu/~recski/4lang/$HUNTOOLS_TGZ_FILENAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo "HunTools (HunMorph) was already downloaded."
fi

if [ ! -d "$LOCAL_4LANG_BIN_DIR/$HUNTOOLS_FOLDERNAME" ]; then
  echo "Extracting HunTools (HunMorph)"
  tar -xvzf $LOCAL_4LANG_DOWNLOAD_DIR/$HUNTOOLS_TGZ_FILENAME -C $LOCAL_4LANG_BIN_DIR
else
  echo "HunTools (HunMorph) binaries already exist."
fi

#Necessary for hundisambig:
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386

#Downloading and extracting precompiled machine graphs
MACHINES_FILENAME=machines
MACHINES_TGZ_FILENAME=$MACHINES_FILENAME.tgz
MACHINES_FOLDERNAME=$MACHINES_FILENAME
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$MACHINES_TGZ_FILENAME" ]; then
  echo "Downloading precompiled machine graphs..."
  wget -c --tries=0 --read-timeout=20 http://sandbox.hlt.bme.hu/%7Erecski/4lang/$MACHINES_TGZ_FILENAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo "Precompiled machine graphs were already downloaded."
fi

LOCAL_4LANG_DATA_DIR=$FOURLANG_LOCAL_SRC_DIR/data
if [ ! -d "$LOCAL_4LANG_DATA_DIR/$MACHINES_FOLDERNAME" ]; then
  echo "Extracting precompiled machine graphs"
  mkdir $LOCAL_4LANG_DATA_DIR
  tar -xvzf $LOCAL_4LANG_DOWNLOAD_DIR/$MACHINES_TGZ_FILENAME -C $LOCAL_4LANG_DATA_DIR
else
  echo "Precompiled machine graphs already exist."
fi

#Downloading magyarlánc
MAGYARLANC_FILENAME=magyarlanc-3.0.jar
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$MAGYARLANC_FILENAME" ]; then
  echo "Downloading magyarlanc..."
  wget -c --tries=0 --read-timeout=20 http://rgai.inf.u-szeged.hu/project/nlp/research/magyarlanc/$MAGYARLANC_FILENAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo "Magyarlanc was already downloaded."
fi

if [ ! -f "$LOCAL_4LANG_BIN_DIR/$MAGYARLANC_FILENAME" ]; then
  echo "Copying magyarlanc"
  cp $LOCAL_4LANG_DOWNLOAD_DIR/$MAGYARLANC_FILENAME $LOCAL_4LANG_BIN_DIR
else
  echo "Magyarlanc already exist."
fi

#Improving python...
echo Improving python...

sudo apt install python-pip
python -m pip install pyzmq
sudo pip install -U nltk
sudo pip install -U graphviz
sudo pip install -U numpy
sudo pip install -U scipy
sudo pip install unidecode
sudo pip uninstall networkx
sudo pip install networkx==1.11
sudo pip show networkx

#Building pymachine
if [ ! -f ./pymachine.installed.txt ]; then
  echo Building pymachine...
  cd $PYMACHINE_LOCAL_SRC_DIR
  sudo python setup.py install > ../../pymachine.installed.txt
  cd ../..
else
  echo Pymachine was already installed
fi

#Installing 4lang
if [ ! -f ./4lang.installed.txt ]; then
  echo Building 4lang...
  cd $FOURLANG_LOCAL_SRC_DIR
  sudo python setup.py install > ../../4lang.installed.txt
  cd ../..
else
  echo 4lang was already installed
fi

#Exporting paths
if [ ! -f ./export.done ]; then

  echo Exporting paths...

  echo "export FOURLANGPATH=$PWD/$FOURLANG_LOCAL_SRC_DIR"
  sudo echo "export FOURLANGPATH=$PWD/$FOURLANG_LOCAL_SRC_DIR" >> ~/.bashrc
  echo "FOURLANGPATH=$PWD/$FOURLANG_LOCAL_SRC_DIR" >> ./4lang.env

  echo "export JYTHONPATH=/usr/share/jython/bin/jython"
  sudo echo "export JYTHONPATH=/usr/share/jython/bin/jython" >> ~/.bashrc
  echo "JYTHONPATH=/usr/share/jython/bin/jython" >> ./4lang.env

  echo "export STANFORDPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$STANFORD_PARSER_FOLDERNAME"
  sudo echo "export STANFORDPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$STANFORD_PARSER_FOLDERNAME" >> ~/.bashrc
  echo "STANFORDPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$STANFORD_PARSER_FOLDERNAME" >> ./4lang.env

  echo "export MAGYARLANCPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$MAGYARLANC_FILENAME"
  sudo echo "export MAGYARLANCPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$MAGYARLANC_FILENAME" >> ~/.bashrc
  echo "MAGYARLANCPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$MAGYARLANC_FILENAME" >> ./4lang.env

  echo "export HUNTOOLSBINPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$HUNTOOLS_FOLDERNAME"
  sudo echo "export HUNTOOLSBINPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$HUNTOOLS_FOLDERNAME" >> ~/.bashrc
  echo "HUNTOOLSBINPATH=$PWD/$LOCAL_4LANG_BIN_DIR/$HUNTOOLS_FOLDERNAME" >> ./4lang.env

  echo "export done" > ./export.done

  echo Please check if ~/.bashrc was changed. You need to open a new terminal window to make them have their effect.

else
  echo Paths were already exported.
fi

##Downloading nltk resources...
echo Downloading nltk resources...
python ../nltk.download.py

# dot viewer:
sudo apt-get install xdot

echo Done.
exit

#Optional tools:

#Downloading and extracting Pycharm
PYCHARM_SOFTWARE_DOWNLOAD_URL=http://nlp.stanford.edu/software
PYCHARM_FILENAME=pycharm-community-2017.2.3
PYCHARM_GZ_FILENAME=$PYCHARM_FILENAME.tar.gz
PYCHARM_FOLDERNAME=$PYCHARM_FILENAME
if [ ! -f "$LOCAL_4LANG_DOWNLOAD_DIR/$PYCHARM_GZ_FILENAME" ]; then
  echo "Downloading Pycharm..."
  wget -c --tries=0 --read-timeout=20 https://download.jetbrains.com/python/$PYCHARM_GZ_FILE_NAME -P $LOCAL_4LANG_DOWNLOAD_DIR
else
  echo "Pycharm was already downloaded."
fi

if [ ! -d "$LOCAL_4LANG_BIN_DIR/$PYCHARM_FOLDERNAME" ]; then
  echo "Extracting Pycharm"
  unzip "$LOCAL_4LANG_DOWNLOAD_DIR/$PYCHARM_GZ_FILENAME" -d $LOCAL_4LANG_BIN_DIR
else
  echo "Pycharm binaries already exist."
fi

#TODO: install and configure env files for pycharm:
#https://github.com/Ashald/EnvFile/blob/develop/README.md

#Double Commander
sudo add-apt-repository ppa:alexx2000/doublecmd
sudo apt-get update
sudo apt-get install doublecmd-gtk
#or
#sudo apt-get install doublecmd-qt

echo Done.
exit

