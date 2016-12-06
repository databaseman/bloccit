#!/bin/bash
#
TO_DATE=`date +%m%d%Y_%H%M%S`
PROGRAM=`basename $0 .sh`
LOG_FILE=~/workspace/log/${PROGRAM}_${TO_DATE}.log
RESULT_LIST=`find ~/workspace -name "*.rb"|egrep -iv "metadata|initializer|migrate|test"`
for FILE in $RESULT_LIST  
do
  echo >> $LOG_FILE
  echo "===============$FILE==========================">> $LOG_FILE
  rubocop -a $FILE >> $LOG_FILE
  echo "===============================================">> $LOG_FILE
done
echo ">>>>>>>>>>>>>>>>>>>>>>>>>"
echo "found problem => "
egrep -v "Line is too long" $LOG_FILE|wc -l
