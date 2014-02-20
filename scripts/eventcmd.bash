#!/bin/bash

tmpfile="/tmp/pbctl_eventtext_file"

cat > "${tmpfile}"

nohup curl -F "[file]=@${tmpfile}" http://localhost:3000/popfile & < /dev/null > /dev/null

