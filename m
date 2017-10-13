From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf buildild-list -H dumps core
Date: Fri, 13 Oct 2017 11:48:05 -0300
Message-ID: <20171013144805.GQ3503@kernel.org>
References: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753337AbdJMOsI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Oct 2017 10:48:08 -0400
Content-Disposition: inline
In-Reply-To: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Em Fri, Oct 13, 2017 at 09:33:55AM +0200, Thomas-Mich Richter escreveu:
> Maybe this has been fixed already, but I hit a core dump when I do this:
> 
> [root@s35lp76 docker]# uname -a
> Linux s35lp76 4.14.0-rc3tmr1+ #5 SMP Thu Oct 5 10:05:43 CEST 2017 s390x s390x s390x GNU/Linux
> [root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -i 333.perf.data 
> 15dd27179a5fe664c0778b7871989c101b1ac506 /lib/modules/4.14.0-rc3tmr1+/build/vmlinux
> 4d16d00bd6ed5969f2ef3176d3e52801c85ed9d8 [vdso]
> 0a751d08365dbbca4ac4deb7ed2b8107d42bad80 /lib/libc.so.6
> 5c0a120336206d0483d3d8112207fbb54ba00a44 /bin/find
> a70676b1cdcc5575e4c5e34a5b80746dca120f75 /bin/ls
> [root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -H -i 333.perf.data 
> Segmentation fault (core dumped)
> 
> [root@s35lp76 docker]# 
> 
> Shouldn't I specify option -H ?
> 
> I have not tried this on Intel, maybe it is platform related?
> 
> Thanks for your help

Can you please provide a backtrace? I just tried it here and couldn't
reproduce.

[root@jouet ~]# perf record -a sleep 2
[ perf record: Woken up 5 times to write data ]
[ perf record: Captured and wrote 3.654 MB perf.data (32078 samples) ]
[root@jouet ~]# perf buildid-list -H > /tmp/bla
[root@jouet ~]# head /tmp/bla
7b2520cbe38483a64f3f6c83e88543222a92a4d8 /proc/kcore
8678a8baa7adb62301351bbe6ec0411431b6c239 /usr/lib64/libz.so.1.2.11
feccaee0beafed7718f53b96fa88c57ec421256b /usr/lib64/libdl-2.25.so
f045f54aa78cf1931cc893f78b6cbc52c72a8cb1 /usr/lib64/libc-2.25.so
9059cd82d902243e5a2ad834bd83f4b21d0215ac /usr/lib64/libpthread-2.25.so
594c9c58b36cc894bf96e631cce3c4f588a53ca7 /usr/lib64/ld-2.25.so
1308b8e1e2aba6a1a9ac9d4a00c16f657c9ba21a [vdso]
93a5e75faa96b2fe55ced8e3abca4a9ed45636d7 /usr/lib64/libdbus-1.so.3.19.0
c163d82c56b2bb68d4c6d83f2d1c191bfc14e9e8 /usr/lib64/libffi.so.6.0.2
0b43611288742c9c62d4571aba4f0848e15a9d4c /usr/lib64/libglib-2.0.so.0.5200.3
[root@jouet ~]# uname -a
Linux jouet 4.13.0+ #3 SMP Mon Sep 25 11:51:22 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]# perf --version
perf version 4.14.rc3.g4d748d
[root@jouet ~]#

- Arnaldo
