#!/bin/bash
mysqldump -u potr -p mysql help_keyword | head -100 > help.sql
