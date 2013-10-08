#!/bin/bash

Docview (){
  if [ -f $1 ] ; then
      case $1 in
          *.pdf)       evince $1    ;;
          *.ps)        oowriter $1    ;;
          *.odt)       oowriter $1     ;;
          *.txt)       leafpad $1       ;;
          *.doc)       oowriter $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}




note (){
       #if file doesn't exist, create it
       [ -f $HOME/.notes ] || touch $HOME/.notes
       #no arguments, print file
       if [ $# = 0 ]
       then
               cat $HOME/.notes
       #clear file
       elif [ $1 = -c ]
       then
               > $HOME/.notes
       #add all arguments to file
       else
               echo "$@" >> $HOME/.notes
       fi
}

#wiki
function wiki () {

  COLUMNS=`tput cols`

    dig +short txt “`echo $@`”.wp.dg.cx | sed -e ‘s/” “//g’ -e ‘s/^”//g’ -e ‘s/”$//g’ -e ‘s/ http:/\n\nhttp:/’ | fmt -w $COLUMNS

}


#disk usage formatted
function duf {
  du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}


#dirsize - finds directory sizes and lists them for the current directory
dirsize () {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}


#extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1        ;;
  *.tar.gz)    tar xzf $1     ;;
  *.bz2)       bunzip2 $1       ;;
  *.rar)       rar x $1     ;;
  *.gz)        gunzip $1     ;;
  *.tar)       tar xf $1        ;;
  *.tbz2)      tar xjf $1      ;;
  *.tgz)       tar xzf $1       ;;
  *.zip)       unzip $1     ;;
  *.Z)         uncompress $1  ;;
  *.7z)        7z x $1    ;;
  *)           echo "'$1' cannot be extracted via extract()" ;;
  esac
  else
    echo "'$1' is not a valid file"
      fi
}


#netinfo - shows network information for your system
netinfo ()
{
  echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${myip}"
    echo "---------------------------------------------------"
}


#Translate a Word  - USAGE: translate house spanish  # See dictionary.com for available languages (there are many).
translate ()
{
  TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "${2}:" | sed 's/^[ \t]*//;s/[ \t]*$//'`
    if [[ ${#TRANSLATED} != 0 ]] ;then
      echo "\"${1}\" in ${TRANSLATED}"
    else
      echo "Sorry, I can not translate \"${1}\" to ${2}"
	fi
}


# Define a word - USAGE: define dog
define ()
{
  lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
    if [[ -s  /tmp/templookup.txt ]] ;then
      until ! read response
	do
	  echo "${response}"
	    done < /tmp/templookup.txt
    else
      echo "Sorry $USER, I can't find the term \"${1} \""
	fi
	\rm -f /tmp/templookup.txt
}


# clock - A bash clock that can run in your terminal window.
clock ()
{
  while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}


