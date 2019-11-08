#!/bin/sh
### BEGIN INIT INFO
# Provides:       bitnami
# Required-Start: $network $remote_fs
# Required-Stop:  $network $remote_fs
# Default-Start:  2 3 4 5
# Default-Stop:   0 1 6
# Short-Description: Bitnami Init Script
# Description:  Bitnami Init Script
### END INIT INFO

#!/bin/sh

exec /opt/bitnami/ctlscript.sh start
