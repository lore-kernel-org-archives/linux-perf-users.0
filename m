From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 10:34:09 -0300
Message-ID: <20171114133409.GN8836@kernel.org>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
 <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
 <20171114132625.GM8836@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753855AbdKNNeL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 08:34:11 -0500
Content-Disposition: inline
In-Reply-To: <20171114132625.GM8836@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Em Tue, Nov 14, 2017 at 10:26:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 14, 2017 at 08:18:47AM +0100, Thomas Richter escreveu:
> > -ld=$(realpath /lib64/ld*.so.* | uniq)
> > -libc=$(echo $ld | sed 's/ld/libc/g')
> > +libc=$(ldd $(which bash) 2>/dev/null | fgrep libc | awk '{ print $3 }')
> 
> Humm, this one is failing:
> 
> [root@jouet linux]# ls -ila /usr/lib64/libc-2.25.so 
> 3151772 -rwxr-xr-x. 2 root root 2163016 Aug 28 11:48 /usr/lib64/libc-2.25.so
> [root@jouet linux]# ls -ila /lib64/libc-2.25.so 
> 3151772 -rwxr-xr-x. 2 root root 2163016 Aug 28 11:48 /lib64/libc-2.25.so
> [root@jouet linux]#
> 
> [root@jouet linux]# tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.068 ms
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.068/0.068/0.068/0.000 ms
> 0.000 probe_libc:inet_pton:(7fa97fac3d80))
> __GI___inet_pton (/usr/lib64/libc-2.25.so)
> FAIL: expected backtrace entry 6 ".*inet_pton[[:space:]]\(/lib64/libc.so.6\)$" got "__GI___inet_pton (/usr/lib64/libc-2.25.so)"
> [root@jouet linux]#
> 
> [root@jouet linux]# ldd `which ping6` | grep 'libc\>'
> 	libc.so.6 => /lib64/libc.so.6 (0x00007f883df4f000)
> [root@jouet linux]#
> 
> [root@jouet linux]# ps | grep bash
>  3112 pts/3    00:00:00 bash
> [root@jouet linux]# ldd `which bash` | grep 'libc\>'
> 	libc.so.6 => /lib64/libc.so.6 (0x00007fdd0a17f000)
> [root@jouet linux]# grep -w libc /proc/3112/maps 
> 7f0d017ee000-7f0d019b5000 r-xp 00000000 fd:00 3151772  /usr/lib64/libc-2.25.so
> 7f0d019b5000-7f0d01bb5000 ---p 001c7000 fd:00 3151772  /usr/lib64/libc-2.25.so
> 7f0d01bb5000-7f0d01bb9000 r--p 001c7000 fd:00 3151772  /usr/lib64/libc-2.25.so
> 7f0d01bb9000-7f0d01bbb000 rw-p 001cb000 fd:00 3151772  /usr/lib64/libc-2.25.so
> [root@jouet linux]#
> 
> /me scratches head
> 
> Different name, same contents, need to look at the inode... ;-\

Nah, lets ask the kernel how is it that it sees libc, please test the
following, works for me:

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 7a84d73324e3..8b3da21a08f1 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -10,8 +10,8 @@
 
 . $(dirname $0)/lib/probe.sh
 
-ld=$(realpath /lib64/ld*.so.* | uniq)
-libc=$(echo $ld | sed 's/ld/libc/g')
+libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
+nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
@@ -37,6 +37,9 @@ trace_libc_inet_pton_backtrace() {
 	done
 }
 
+# Check for IPv6 interface existence
+ip a sh lo | fgrep -q inet6 || exit 2
+
 skip_if_no_perf_probe && \
 perf probe -q $libc inet_pton && \
 trace_libc_inet_pton_backtrace
