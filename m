From: Arnaldo de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Mon, 11 Dec 2017 13:43:12 -0200
Message-ID: <20171211154312.GC2221@redhat.com>
References: <alpine.LRH.2.20.1712081845230.9416@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1712081845230.9416@Diego>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Dec 08, 2017 at 06:48:17PM +0100, Michael Petlan escreveu:
> Hi Arnaldo, so I have tried what you've suggested and looks good.
> Patch is attached. Sorry for not posting it in-text, but I need to
> fix my mail client first, since it screwes some patches up due to
> flowed-text...
> Cheers,
> Michael

Thanks, applying.

- Arnaldo

> commit 92281a9ff73f98d8aca7595504340a25c92b9f1a
> Author: Michael Petlan <mpetlan@redhat.com>
> Date:   Fri Dec 8 18:43:18 2017 +0100
> 
>     perf test shell: Fix check open filename arg using 'perf trace'
>     
>     The following commit added an exception for s390x to use openat()
>     instead of open() in the test:
>     
>       commit f231af789b11a2f1a3795acc3228a3e178a80c21
>       Author: Thomas Richter <tmricht@linux.vnet.ibm.com>
>       Date:   Tue Nov 14 08:18:46 2017 +0100
>     
>     Since the problem is not s390x-specific, this patch makes it more
>     generic, so the test handles both open() and openat() no matter
>     which architecture it is running on.
>     
>     Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 2a9ef08..edd1073 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -17,10 +17,9 @@ skip_if_no_perf_probe || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
>  
>  trace_open_vfs_getname() {
> -	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
> -
> -	perf trace -e ${svc:-open} touch $file 2>&1 | \
> -	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
> +	evts=`perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_(.*) +\[.*/-e \1/'`
> +	perf trace $evts touch $file 2>&1 | \
> +	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
>  
>  
