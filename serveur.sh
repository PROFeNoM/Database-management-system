#!/bin/bash

cd interface
gnome-terminal -- php -S localhost:8000
firefox http://localhost:8000