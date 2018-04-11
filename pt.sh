#!/bin/bash

if [ -z "$PT1" ]; then
   pant=`echo $HOME | sed 's/fairthorpe/panther/g'`
   para=`echo $HOME | sed 's/fairthorpe/paragon/g'`

    if [[ ! -f ${HOME}/.myenv ]]; then
	touch ${HOME}/.myenv
        echo "export PT="$pant"" >> ${HOME}/.myenv
	echo "export PG="$para"" >> ${HOME}/.myenv
        echo " " >> ${HOME}/.myenv
   fi
   echo " " >> ${HOME}/.profile
   echo "if [ -f ~/.myenv ]; then " >> ${HOME}/.profile 
   echo "  . ~/.myenv"  >> ${HOME}/.profile
   echo "fi"  >> ${HOME}/.profile
   echo " " >> $HOME/.profile 
fi
