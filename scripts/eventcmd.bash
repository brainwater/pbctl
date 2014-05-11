#!/bin/bash

tmpfile="/tmp/pbctl_eventtext_file"

cat > "${tmpfile}"

nohup curl -d "" http://localhost:3000/populate/update & < /dev/null > /dev/null

