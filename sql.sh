#!/bin/bash

cat src/creation.sql > src.sql
cat src/create_user.sql >> src.sql
cat src/suppression.sql >> src.sql
cat src/peuplement.sql >> src.sql
gnome-terminal -- sudo mysql -p