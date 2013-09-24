#!/bin/bash

tmpfile="/tmp/pbctl_eventtext_file"

cat > "${tmpfile}"

curl -F "[file]=@${tmpfile}" http://localhost:3000/popfile

#rm "${tmpfile}"
