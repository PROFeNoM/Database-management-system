#!/bin/bash

cat src/base.sql > src.sql
cat src/donnees.sql >> src.sql
gnome-terminal -- sudo mysql