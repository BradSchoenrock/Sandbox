#!/bin/bash

qmake -project 

qmake Hello.pro

make

./Hello
