#!/bin/sh

exec noip2 &
(exec tightvncserver -name mitchlinux :1) &

