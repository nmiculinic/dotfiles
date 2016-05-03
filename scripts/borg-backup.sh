#/bin/bash

set -e

# Backup dir
BDIR=/home/lpp/Documents/backup-borg

PREFIX="snapshot"
SNAPSHOT_NAME=$PREFIX-$(date +%Y-%m-%d_%H:%ST%z)

echo "Starting backup $SNAPSHOT_NAME"

RED='\033[0;31m'
NC='\033[0m' # No Color

set +e

/usr/bin/borg create --verbose --stats --compression lzma $BDIR::$SNAPSHOT_NAME --exclude-caches --exclude-from $BDIR/exclude-list.txt /home/lpp /etc

case $? in
    0) ;;
    1) printf "${RED}Warrning during creation occured${NC}\n" ;;
    *) exit $? ;;
esac

set -e

echo "Backup finished, fixing mods"

/usr/bin/chown -R root:wheel $BDIR
/usr/bin/chmod -R 750 $BDIR
if [[ -f $BDIR/lock.roster ]]; then
    /usr/bin/chmod -R 750 $BDIR/lock.roster
    echo "fixing lock permissions"
fi

echo "Testing backups"
/usr/bin/borg check --verbose $BDIR
echo "Finished backup testing"

echo "Starting upload to google drive"
drive push --no-prompt /home/lpp/Documents/backup-borg
echo "Finished uploading to gdrive"
