#!/bin/bash
tar -c -v -z -f /home/alberto/Escritorio/Sistemas/backups-ficheros-docs-`date '+%d%m%Y-%H%M'`.tar.gz /home/alberto/Escritorio/Sistemas/*.{sh,txt,pdf,doc}
