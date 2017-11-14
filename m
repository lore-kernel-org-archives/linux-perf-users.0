From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 10:26:25 -0300
Message-ID: <20171114132625.GM8836@kernel.org>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
 <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755317AbdKNN02 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 08:26:28 -0500
Content-Disposition: inline
In-Reply-To: <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

Em Tue, Nov 14, 2017 at 08:18:47AM +0100, Thomas Richter escreveu:
> Perf test case probe libc's inet_pton & backtrace it with ping
> fails on s390x. The reason is the 'realpath /lib64/ld*.so.* | uniq'
> line which returns 2 libraries:
> 
>         root@s35lp76 shell]# realpath /lib64/ld*.so.* | uniq
>         /usr/lib64/ld-2.26.so
>         /usr/lib64/ld_pre_smc.so.1.0.1
>         [root@s35lp76 shell]
> 
> This output makes the perf probe command lines invalid.
> 
> Use tool ldd to find out the libraries required by the bash and
> check if symbol inet_pton is part of the libc library.
> Some distros do not have a /lib64 directory.
> 
> I have also added a check for the existence of an IPv6
> network interface before it is being used.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Suggested-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brückner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/trace+probe_libc_inet_pton.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> index 7a84d73324e3..b9c913f1a360 100755
> --- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> @@ -10,8 +10,8 @@
>  
>  . $(dirname $0)/lib/probe.sh
>  
> -ld=$(realpath /lib64/ld*.so.* | uniq)
> -libc=$(echo $ld | sed 's/ld/libc/g')
> +libc=$(ldd $(which bash) 2>/dev/null | fgrep libc | awk '{ print $3 }')
> +nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
>  	idx=0
> @@ -37,6 +37,9 @@ trace_libc_inet_pton_backtrace() {
>  	done
>  }
>  
> +# Check for IPv6 interface existence
> +ip a sh lo | fgrep -q inet6 || exit 2
> +
>  skip_if_no_perf_probe && \
>  perf probe -q $libc inet_pton && \
>  trace_libc_inet_pton_backtrace

Humm, this one is failing:

[root@jouet linux]# ls -ila /usr/lib64/libc-2.25.so 
3151772 -rwxr-xr-x. 2 root root 2163016 Aug 28 11:48 /usr/lib64/libc-2.25.so
[root@jouet linux]# ls -ila /lib64/libc-2.25.so 
3151772 -rwxr-xr-x. 2 root root 2163016 Aug 28 11:48 /lib64/libc-2.25.so
[root@jouet linux]#

[root@jouet linux]# tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.068 ms
--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.068/0.068/0.068/0.000 ms
0.000 probe_libc:inet_pton:(7fa97fac3d80))
__GI___inet_pton (/usr/lib64/libc-2.25.so)
FAIL: expected backtrace entry 6 ".*inet_pton[[:space:]]\(/lib64/libc.so.6\)$" got "__GI___inet_pton (/usr/lib64/libc-2.25.so)"
[root@jouet linux]#

[root@jouet linux]# ldd `which ping6` | grep 'libc\>'
	libc.so.6 => /lib64/libc.so.6 (0x00007f883df4f000)
[root@jouet linux]#

[root@jouet linux]# ps | grep bash
 3112 pts/3    00:00:00 bash
[root@jouet linux]# ldd `which bash` | grep 'libc\>'
	libc.so.6 => /lib64/libc.so.6 (0x00007fdd0a17f000)
[root@jouet linux]# grep -w libc /proc/3112/maps 
7f0d017ee000-7f0d019b5000 r-xp 00000000 fd:00 3151772  /usr/lib64/libc-2.25.so
7f0d019b5000-7f0d01bb5000 ---p 001c7000 fd:00 3151772  /usr/lib64/libc-2.25.so
7f0d01bb5000-7f0d01bb9000 r--p 001c7000 fd:00 3151772  /usr/lib64/libc-2.25.so
7f0d01bb9000-7f0d01bbb000 rw-p 001cb000 fd:00 3151772  /usr/lib64/libc-2.25.so
[root@jouet linux]#

/me scratches head

Different name, same contents, need to look at the inode... ;-\

- Arnaldo
