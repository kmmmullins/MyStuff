#!/bin/bash 
#
#  release for idd svn projects  (using svn.mit.edu repository) 
#
#
#
DATE=`date +%m%d%y%H%M%S`
DATEFMT="%H:%M:%S %m/%d/%Y"
LOGFILE=/home/inside/logs/tag-history.log
HOSTNAME=`hostname`
APPNAME=$1
PLANNAME=$2
SVNBASE="svn+ssh://svn.mit.edu"
STATUS_CMD="svn status -u"
UPDATE_CMD="svn update"
export SVN_SSH="ssh -i  /usr/local/etc/was/svn/sais.private -q -l isdasnap"
SVNREV=`svn log -l 1 ${SVNBASE}/idd/${APPNAME}  | grep line | awk '{print $1}' `
BUILDBASE=/var/local/bamboo/xml-data/build-dir
BUILDNUM=`grep number ${BUILDBASE}/${PLANNAME}/build-number.txt  | awk -F= '{print $2}'`
export TAGNAME="$APPNAME-$BUILDNUM-$SVNREV-$DATE"
WARDISTDIR=${BUILDBASE}/${PLANNAME}/dist/
WARTARGETDIR=${BUILDBASE}/${PLANNAME}/target/
RELEASEDIR=/home/www/release

##########################################################
#
#  Check command line
#
#########################################################

if [ $# -lt 1 ]
then

   echo " "
   echo " ERROR on the command line - no application name specified"
   echo " "
   echo " Usage tomcat-tag application-name"
   echo " "
   echo " Example: tomcat-tag w2 "
   echo " "
   exit
else
   echo " "
fi



##########################################################
#
#  Create Tag
#
#########################################################

echo "******** Creating Tag  ***********"
COPY_CMD="svn copy ${SVNBASE}/idd/${APPNAME}/trunk ${SVNBASE}/idd/${APPNAME}/tags/$TAGNAME -m \"new-$APPNAME-release\""
${COPY_CMD} 

list_cmd="svn list svn+ssh://svn.mit.edu/idd/$APPNAME/tags/"
${list_cmd} | grep $TAGNAME

if [ $? -ne 0 ]
then
  echo "There is a problem creating tag $TAGNAME"
  exit
else

echo "SVN Tag created for ${APPNAME} is called  ${TAGNAME} "
echo " "

fi

###################################################

warfilecopy () {


   echo "Found war file $WARDIST "
#   echo "War file Name ... $WARFILENAME "
   RENAMEWARFILE="${RELEASEDIR}/${WARFILENAME}-${TAGNAME}.war"
   cp ${WARDIST} ${RENAMEWARFILE}

   if [ $? -ne 0 ]
   then
       echo "Problem with war file copy"
   else
       ls -la ${RENAMEWARFILE}
       echo "Changes to ${APPNAME} include a svn tag called  ${TAGNAME} and war file called  ${RENAMEWARFILE}" | mail -s "Created new Tag and War file ${APPNAME}" adm-deploy@mit.edu
   fi


}
if [[ -d $WARDISTDIR ]]
then

WARDIST=`ls ${BUILDBASE}/${PLANNAME}/dist/*.war`
WARFILE=${WARDIST##*/}
WARFILENAME=${WARFILE%%.*}

      warfilecopy

else

   if [ -d $WARTARGETDIR ]
   then
      
      WARDIST=`ls ${BUILDBASE}/${PLANNAME}/target/*.war`
      WARFILE=${WARDIST##*/}
      WARFILENAME=${WARFILE%%.*}

      warfilecopy

   else

       echo "Could not file war file"
   fi
fi








