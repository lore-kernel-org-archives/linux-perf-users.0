From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test fix check open filename arg using perf trace
 on s390x
Date: Tue, 14 Nov 2017 10:13:44 -0300
Message-ID: <20171114131344.GL8836@kernel.org>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbdKNNNq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 08:13:46 -0500
Content-Disposition: inline
In-Reply-To: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

Em Tue, Nov 14, 2017 at 08:18:46AM +0100, Thomas Richter escreveu:
> This perf test case fails on s390x. The touch command on s390x uses
> the openat system call to open the file named on the command line:

Thanks, tested on x86_64 and applied!

- Arnaldo
 
> [root@s35lp76 perf]# ./perf probe -l
>   probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
> [root@s35lp76 perf]# ./perf trace -e open touch /tmp/abc
>      0.400 ( 0.015 ms): touch/27542 open(filename:
> 		/usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
> [root@s35lp76 perf]#
> 
> There is no open system call for file /tmp/abc. Instead openat
> system call is used:
> 
> [root@s35lp76 perf]# strace touch /tmp/abc
>     execve("/usr/bin/touch", ["touch", "/tmp/abc"], 0x3ffd547ec98
> 			/* 30 vars */) = 0
>     [...]
>     openat(AT_FDCWD, "/tmp/abc", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) = 3
>     [...]
> 
> On s390x the egrep command does not find a matching pattern and returns
> an error.
> 
> Fix this for the s390x platform and create a platform dependend command
> line to enable the perf probe to listen to openat system call on s390x
> and get the correct perf trace output.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 2e68c5f120da..2a9ef080efd0 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -17,8 +17,10 @@ skip_if_no_perf_probe || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
>  
>  trace_open_vfs_getname() {
> -	perf trace -e open touch $file 2>&1 | \
> -	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open\(filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
> +	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
> +
> +	perf trace -e ${svc:-open} touch $file 2>&1 | \
> +	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
>  
>  
> -- 
> 2.13.4
