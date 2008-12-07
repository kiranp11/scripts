export MASTER_WORKSPACE=/mnt/space/workspace-backup/master
for i in `ls $MASTER_WORKSPACE`; do echo "Updating "$MASTER_WORKSPACE/$i; cd $MASTER_WORKSPACE/$i; svn up; done
