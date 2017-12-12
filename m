From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Tue, 12 Dec 2017 17:30:08 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712121725080.9416@Diego>
References: <alpine.LRH.2.20.1712081845230.9416@Diego> <20171211154312.GC2221@redhat.com> <20171211170750.GE3958@kernel.org> <alpine.LRH.2.20.1712120133380.9416@Diego> <20171212145707.GL3958@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212145707.GL3958@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
[...]
> the point here is not to add any new patch for perf trace, etc, but find
> a way to fix just this test, so I think this works:
> 
> # evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> # echo $evts
> open,openat
> [root@jouet ~]#

Just sent you patches with this approach.

> I'll work on a 'perf list -x,'  that will print all events matching as a
> CSV with the informed delimiter, seems handy :-)

Really looking forward to have that. It will make all my parsing much easier!

> So the patch below does the trick for me, can you please check if does
> for you?

As said, the patch below does not remove the s390x-hack:

test "$(uname -m)" = s390x && { txt="dfd: +CWD, +"; }

My patch gets rid of this and makes it work on non-s390x openat-only envs
(which was the original purpose :))

> 
> With regards to the other patches, please consider submitting them in
> separate messages, stating their purpose in a commit log, with example
> usage, etc. Then people will be able to review it on its own.

I have just done it.

> 
> Running it here I get:
> 
> [root@jouet perf]# sh -x tools/perf/tests/shell/trace+probe_vfs_getname.sh 
> ++ dirname tools/perf/tests/shell/trace+probe_vfs_getname.sh
> + . tools/perf/tests/shell/lib/probe.sh
> + skip_if_no_perf_probe
> + perf probe
> + grep -q 'is not a perf-command'
> + return 0
> ++ dirname tools/perf/tests/shell/trace+probe_vfs_getname.sh
> + . tools/perf/tests/shell/lib/probe_vfs_getname.sh
> ++ perf probe -l
> ++ grep -q probe:vfs_getname
> ++ had_vfs_getname=1
> ++ mktemp /tmp/temporary_file.XXXXX
> + file=/tmp/temporary_file.pSzKC
> + add_probe_vfs_getname
> + local verbose=
> + '[' 1 -eq 1 ']'
> ++ perf probe -L getname_flags
> ++ egrep 'result.*=.*filename;'
> ++ sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
> + line=72
> + perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> + err=0
> + '[' 0 -ne 0 ']'
> + trace_open_vfs_getname
> ++ uname -m
> + test x86_64 = s390x
> ++ sed 's/ /,/'
> +++ egrep 'open(at)? '
> +++ perf list 'syscalls:sys_enter_open*'
> +++ sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/'
> ++ echo open openat
> + svc=open,openat
> + perf trace -e open,openat touch /tmp/temporary_file.pSzKC
> + egrep ' +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\(filename: +/tmp/temporary_file.pSzKC, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$'
>      1.479 ( 0.073 ms): touch/27884 open(filename: /tmp/temporary_file.pSzKC, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
> + err=0
> + rm -f /tmp/temporary_file.pSzKC
> + cleanup_probe_vfs_getname
> + '[' 1 -eq 1 ']'
> + perf probe -q -d probe:vfs_getname
> + exit 0
> [root@jouet perf]#
> 
> 
> - Arnaldo
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 2a9ef080efd0..d22f08568226 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -17,10 +17,10 @@ skip_if_no_perf_probe || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
>  
>  trace_open_vfs_getname() {
> -	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
> -
> -	perf trace -e ${svc:-open} touch $file 2>&1 | \
> -	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
> +	test "$(uname -m)" = s390x && { txt="dfd: +CWD, +"; }
> +	svc=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> +	perf trace -e ${svc} touch $file 2>&1 | \
> +	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
>  
>  
> 
