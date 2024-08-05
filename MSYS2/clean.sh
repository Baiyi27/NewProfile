#!/bin/bash

pacman -Qdtq | pacman -Rs -

pacman -Sc --noconfirm | pacman -Scc --noconfirm
