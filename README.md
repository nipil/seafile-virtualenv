# why

Installing Seafile CE 9.0.9 using Python virtualenv system to not modify the host python environment

# how

	git clone https://github.com/nipil/seafile-virtualenv.git
	cd seafile-virtualenv
	docker build -t nipil:seafile-virtualenv .
	docker run -it -p 8000:8000 nipil:seafile-virtualenv

# result

Starting Seafile

	seafile@d0a6bcd25153:~$ ./venv-wrapper.sh seafile.sh start

	Starting seafile server, please wait ...
	** Message: 14:26:18.468: seafile-controller.c(621): No seafevents.

	Seafile server started

	Done.
	seafile@d0a6bcd25153:~$

Starting Seahub

	seafile@d0a6bcd25153:~$ ./venv-wrapper.sh seahub.sh start

	LANG is not set in ENV, set to en_US.UTF-8
	LC_ALL is not set in ENV, set to en_US.UTF-8
	/opt/seafile/seafile-server-latest/seahub.sh: line 228: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)
	Starting seahub at port 8000 ...

	----------------------------------------
	It's the first time you start the seafile server. Now let's create the admin account
	----------------------------------------

	What is the email for the admin account?
	[ admin email ] aze@aze.aze

	What is the password for the admin account?
	[ admin password ]

	Enter the password again:
	[ admin password again ]



	----------------------------------------
	Successfully created seafile admin
	----------------------------------------
	Seahub is started

	Done.

# verify

Processes

	seafile@d0a6bcd25153:~$ ps auxf
	USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	seafile      1  0.0  0.0   4160  3476 pts/0    Ss   14:25   0:00 /bin/bash
	seafile    204  0.0  0.0  21900   404 ?        Ss   14:33   0:00 /opt/seafile/seafile-server-9.0.9/seafile/bin/seafile-controller -c /opt/s
	seafile    206  0.0  0.1 1190672 8184 ?        Ssl  14:33   0:00 seaf-server -F /opt/seafile/conf -c /opt/seafile/ccnet -d /opt/seafile/sea
	seafile    237  4.4  0.7 105260 58524 ?        S    14:33   0:00 python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicorn se
	seafile    238  0.0  0.6 105340 53636 ?        S    14:33   0:00  \_ python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicor
	seafile    239  0.0  0.6 105340 53640 ?        S    14:33   0:00  \_ python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicor
	seafile    240  0.0  0.6 105340 53640 ?        S    14:33   0:00  \_ python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicor
	seafile    241  0.0  0.6 105340 53644 ?        S    14:33   0:00  \_ python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicor
	seafile    242  0.0  0.6 105340 53644 ?        S    14:33   0:00  \_ python3 /opt/seafile/seafile-server-9.0.9/seahub/thirdpart/bin/gunicor
	seafile    244  0.0  0.0   6756  2984 pts/0    R+   14:33   0:00 ps auxf

Environment

	seafile@d0a6bcd25153:~$ env
	HOSTNAME=d0a6bcd25153
	PWD=/opt/seafile
	HOME=/opt/seafile
	LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
	VIRTUAL_ENV=/opt/seafile/venv
	TERM=xterm
	SHLVL=1
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	DEFAULT_PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	_=/usr/bin/env

Web UI

	http://localhost:8000/
	login using previous data
	It works !

# cleanup

	seafile@d0a6bcd25153:~$ ./venv-wrapper.sh seahub.sh stop

	Stopping seahub ...
	Done.

	seafile@d0a6bcd25153:~$ ./venv-wrapper.sh seafile.sh stop

	Stopping seafile server ...
	Done.
	seafile@d0a6bcd25153:~$ python3 --version^C


	seafile@d0a6bcd25153:~$ ps auxf
	USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	seafile      1  0.0  0.0   4160  3476 pts/0    Ss   14:25   0:00 /bin/bash
	seafile    182  0.0  0.0   6756  3044 pts/0    R+   14:33   0:00 ps auxf
