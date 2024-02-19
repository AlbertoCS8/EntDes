#!/bin/bash
while true
do echo "buenas tardes la hora es: `date`" | nc -k -l localhost 6666
done
