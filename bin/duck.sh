#!/bin/bash

DUCKLOG=/var/log/duckdns/duck.log

STATUS=$(echo url="https://www.duckdns.org/update?domains=munkustrap&token=e933a8c4-fe07-4dfa-96d7-ef9b8a8c09e3&ip=" | curl -k -K -)
echo "$(date): ${STATUS}" >> ${DUCKLOG}
