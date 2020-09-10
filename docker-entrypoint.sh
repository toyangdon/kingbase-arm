#!/bin/sh

DB_PATH=/home/kingbase/kdb
DATA_DIR=/home/kingbase/data
LOG_FILE=${DB_PATH}/logfile

check_is_init() {
  declare -g DATABASE_ALREADY_EXISTS
  if [ -d "${DATA_DIR}" -a `ls -A ${DATA_DIR}|wc -w` -ne 0 ];then
    DATABASE_ALREADY_EXISTS='true'
  fi
}

db_init(){
  mkdir -p ${DATA_DIR}
  chown -R kingbase:kingbase ${DATA_DIR}
  cd ${DB_PATH}/Server/bin/
  ./initdb -USYSTEM -W${SYSTEM_PWD-123456} -E UTF8 ${DATA_DIR}
}

check_is_init
if [ -z "${DATABASE_ALREADY_EXISTS}" ];then
  db_init
  if [ $? -ne 0 ];then
    echo "initdb failed"
    exit 1
  fi
fi

${DB_PATH}/Server/bin/sys_ctl -D ${DATA_DIR} -l ${LOG_FILE} start

sleep 15

exec tail -f ${LOG_FILE}
