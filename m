From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: off-box analysis of perf.data file
Date: Tue, 16 Nov 2010 21:40:42 -0200
Message-ID: <20101116234042.GA4856@ghostprotocols.net>
References: <4CE0B108.8020205@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37871 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0KPXkt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Nov 2010 18:40:49 -0500
Received: by gyh4 with SMTP id 4so809232gyh.19
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Nov 2010 15:40:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE0B108.8020205@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Em Sun, Nov 14, 2010 at 09:03:20PM -0700, David S. Ahern escreveu:
> 
> I'm trying to understand how the latest perf tools are designed with
> respect to off-line analysis.
> 
> Specifically, I have a system running binaries and libraries that are
> stripped and no vmlinux is installed. For analysis, I have a local tree
> based on software versions with full debug symbols. Events are collected
> into a perf.data file and the file is pushed off-box for analysis.
> 
> Without assuming write access to local tree or even ownership of the
> perf.data I imagine running a command something like:
> 
> perf report -fi /path/to/perf.data \
>     --rootfs /path/to/symboled-tree \
>     --kallsyms /path/to/kallsyms
>     ...
> 
> where /proc/kallsyms is dumped for the running system and retrieved
> along with the perf.data file.
> 
> I've been reading the source and can't say I follow all of the build-id
> stuff. Before I spend time working on code modifications I wanted to
> better understand the expectations and options for the latest code.

The usual workflow is the following, after it I'll talk at how to change it to
fit your described setup:

On stripped machine:

$ perf record
$ perf archive
$ scp perf.data.* devel-machine

on devel machine:

$ tar xvf perf.data.tar.bz2 -C ~/.debug
$ perf report

This all assumes that build-ids are enabled, to see if they are, try
this:

[root@felicio ~]# perf record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.311 MB perf.data (~13580 samples) ]

[root@felicio ~]# perf buildid-list
c6127e36741c6c9a2bdce6b15c311e0d484c6f5c [kernel.kallsyms]
c9bc1e043301a5683a70b9103fb92428120fa6b8 /lib64/ld-2.12.90.so
67775f20bdc4ed7c2c0153d9a9e3aaf264299a53 /lib64/libc-2.12.90.so
0bf7d0a3161677af75e1000b1b3230747f1bb723 /lib64/libpthread-2.12.90.so
03516b51e7b3d7ac03875b0bf1cdae075027f7ae /lib64/libdbus-1.so.3.5.2
b6689690a70811d6d0695721c5b70d7e8df87ee1 /lib64/libglib-2.0.so.0.2600.0
0293adb02b5eb6b105943c2023c7ed251f186068 /lib64/libgthread-2.0.so.0.2600.0
326e1b23b38fc735bfc8b80040f72e07366f57d4 /usr/lib64/libxcb.so.1.1.0
6a839d574266e21e5c7419897f32763c819a57c4 /usr/lib64/libX11.so.6.3.0
6dcb8890286a9a4f07bc02c72c040efcd9779bb1 /usr/lib64/libpixman-1.so.0.18.4
cb73d470ae58707322d98487eccf4c2c6dbe86bd /usr/lib64/libcairo.so.2.11000.0
eeee4ac30808d39985ffc1d09e9bdb77a6c9f790 /lib64/libnspr4.so
10452af31d660b66c59271054b88d3b0fa86837c /usr/libexec/hald-addon-input
fb88c2545ac77dbbca04b762de09fa1a2be0298d /usr/lib64/libstdc++.so.6.0.14
29662806dc8d2d288f5550169735c8f55f7e150c /usr/bin/Xorg
30e3c8c0e52233f880adbb4bbcb4ff054f2b659f /usr/lib64/firefox-3.6/firefox
c23d65d019845220376b2a16f6775722a424d0f9 /usr/lib64/xulrunner-1.9.2/libmozjs.so
6f5ec07169f334d1095e04bb181873ad8d45b3b8 /usr/lib64/xulrunner-1.9.2/libxul.so
501727fac876dbf2e3c636e0896f275b7d9042dd /usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/jre/lib/amd64/server/libjvm.so
9ed0ef8bc9b9b3d98b21e4a8e0b248b6c983f54c /home/acme/bin/perf
[root@felicio ~]#

See the long hexadecimal numbers? Those are the build-ids, now look at:

[root@felicio ~]# ls -la ~/.debug/lib64/libnspr4.so/
total 244
drwxr-xr-x.  2 root root   4096 Oct  2 16:36 .
drwxr-xr-x. 22 root root   4096 Nov 16 20:04 ..
-rwxr-xr-x.  1 root root 239056 Aug 25 17:50 eeee4ac30808d39985ffc1d09e9bdb77a6c9f790
[root@felicio ~]# ls -la ~/.debug/lib64/libnspr4.so/eeee4ac30808d39985ffc1d09e9bdb77a6c9f790 
-rwxr-xr-x. 1 root root 239056 Aug 25 17:50 /root/.debug/lib64/libnspr4.so/eeee4ac30808d39985ffc1d09e9bdb77a6c9f790
[root@felicio ~]# set -o vi
[root@felicio ~]# ls -la ~/.debug/.build-id/ee/ee4ac30808d39985ffc1d09e9bdb77a6c9f790 
lrwxrwxrwx. 1 root root 64 Oct  2 16:36 /root/.debug/.build-id/ee/ee4ac30808d39985ffc1d09e9bdb77a6c9f790 -> ../../lib64/libnspr4.so/eeee4ac30808d39985ffc1d09e9bdb77a6c9f790
[root@felicio ~]#

Each DSO has its build-id in a special ELF section:

[root@felicio ~]# readelf -SW /lib64/libnspr4.so | grep build
  [ 1] .note.gnu.build-id NOTE            0000003683600190 000190 000024 00   A  0   0  4
[root@felicio ~]#

To fit your setup you need:

. Populate your devel machine ~/.debug build-id database with the unstripped
  binaries, do that using another perf command, buildid-cache, example:

[root@felicio ~]# perf buildid-cache -v -a /lib64/libc-2.12.90.so 
Adding 67775f20bdc4ed7c2c0153d9a9e3aaf264299a53 /lib64/libc-2.12.90.so: FAIL
/lib64/libc-2.12.90.so already in the cache
[root@felicio ~]# perf buildid-cache -v -a /lib64/libcrypt-2.12.90.so 
Adding 41189b36a158b2727e0e0b54b2dc869bce4e038d /lib64/libcrypt-2.12.90.so: Ok
[root@felicio ~]#

I.e. everytime you build something you intend to ship to your devices, add it
to your build-id database in your devel (where perf report runs).

Its like git, content based, not filename based. You may have lots of versions
of binaries in multiple supported "firmware" versions for your target devices
and the perf tools will find the right binaries/symtabs when decoding.

Please let me know if you need more details on how this is implemented.

Since you mentioned kallsyms, if vmlinux is not found, that is what is used:

[acme@doppio ~]$ l ~/.debug/\[kernel.kallsyms\]/
total 27504
drwxr-xr-x 2 acme acme    4096 2010-09-01 18:57 ./
drwxr-xr-x 9 acme acme    4096 2010-01-24 13:46 ../
-rw-rw-r-- 1 acme acme 2908658 2010-04-29 21:45 0c0a71b29fa20b8f7606180757d01406c8712110
-rw-rw-r-- 1 acme acme 2742642 2010-03-14 13:21 2622047749fd7128d77c015d148aed6d9b25f793
-rw-rw-r-- 1 acme acme 2842888 2010-05-20 22:57 349199a1e1b7cc25ac4f7004deed260f0146665e
-rw-r--r-- 1 acme acme 3205476 2010-08-18 11:09 364300f12afee3dd5b1a87269d60de586f6b61ce
-rw-rw-r-- 1 acme acme 2650594 2010-01-24 13:46 5a49c70ff35d0ba5959ba53bb05096ef46c88978
-rw-rw-r-- 1 acme acme 2797835 2010-06-24 11:12 6723f2dbda348d3fbc8aa5e88d4cf7d5fbbb7106
-rw-rw-r-- 1 acme acme 2734508 2010-09-01 18:57 6d2698625887fdfdb2a52611e8fca78f7cd1d238
-rw-rw-r-- 1 acme acme 2795481 2010-04-05 13:19 712f38010a4e3c01292ed3a3d4576692cba4c233
-rw-rw-r-- 1 acme acme 2648017 2010-01-14 23:06 74f9930ee94475b6b3238caf3725a50d59cb994b
-rw-rw-r-- 1 acme acme 2761144 2010-07-19 10:39 9921d66cf0e9ebf4f1e29d9b11d223d7805931f7
[acme@doppio ~]$

[acme@doppio ~]$ tail -5 /home/acme/.debug/\[kernel.kallsyms\]/9921d66cf0e9ebf4f1e29d9b11d223d7805931f7 
ffffffffa0000410 d video_output_attributes	[output]
ffffffffa0000460 d __this_module	[output]
ffffffffa00001d4 t cleanup_module	[output]
ffffffffa00000e7 T video_output_register	[output]
ffffffffa00000ce T video_output_unregister	[output]
[acme@doppio ~]$ 

10 different kernels :-)

The running kernel build-id is at:

[root@felicio ~]# ls -la /sys/kernel/notes 
-r--r--r-- 1 root root 380 Nov 16 20:03 /sys/kernel/notes
[root@felicio ~]# 

See the symbols.c in the tools/perf/util/ kernel sources directory to see how it is
parsed.

Regards,

- Arnaldo
