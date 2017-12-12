From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Tue, 12 Dec 2017 11:57:07 -0300
Message-ID: <20171212145707.GL3958@kernel.org>
References: <alpine.LRH.2.20.1712081845230.9416@Diego>
 <20171211154312.GC2221@redhat.com>
 <20171211170750.GE3958@kernel.org>
 <alpine.LRH.2.20.1712120133380.9416@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1712120133380.9416@Diego>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Dec 12, 2017 at 04:05:23AM +0100, Michael Petlan escreveu:
> On Mon, 11 Dec 2017, Arnaldo Carvalho de Melo wrote:
> > It is not working here:
> 
> Hmm, I think I got it.
> 
> The following construction:
> 
> evts=`perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_(.*) +\[.*/-e \1/'`
> 
> ... expands to:
> 
> "-e open -e openat"
> 
> ... which is a format that perf-trace does not seem to accept.
> It simply overrides the first event with the second, thus it
> only traces "openat". It worked for me, since I tested it on
> aarch64 where $evts expanded to only one "-e" parameter.

Right, in this case 'perf trace -e' doesn't behave like -e in other
tools, which is unfortunate and should be fixed at some point.

> Attaching a patch for perf-trace that should address it. It
> seems to work, so perf-trace accepts "-e open -e openat".
> However, one weak point is there:
> 
> "-e open,openat -e stat" works, while
> "-e open -e openat,stat" does not.
> 
> In case you don't like the patch for perf-trace, the test's
> patch would need to expand events to something else (which is
> of course possible).
> 
> Also, on my system (x86_64, 4.15.0-rc1), I needed another
> patch for the test (perf_test_shell_fix_filename_arg.patch),
> because the variable name changed...

the point here is not to add any new patch for perf trace, etc, but find
a way to fix just this test, so I think this works:

# evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
# echo $evts
open,openat
[root@jouet ~]#

I'll work on a 'perf list -x,'  that will print all events matching as a
CSV with the informed delimiter, seems handy :-)

So the patch below does the trick for me, can you please check if does
for you?

With regards to the other patches, please consider submitting them in
separate messages, stating their purpose in a commit log, with example
usage, etc. Then people will be able to review it on its own.

Running it here I get:

[root@jouet perf]# sh -x tools/perf/tests/shell/trace+probe_vfs_getname.sh 
++ dirname tools/perf/tests/shell/trace+probe_vfs_getname.sh
+ . tools/perf/tests/shell/lib/probe.sh
+ skip_if_no_perf_probe
+ perf probe
+ grep -q 'is not a perf-command'
+ return 0
++ dirname tools/perf/tests/shell/trace+probe_vfs_getname.sh
+ . tools/perf/tests/shell/lib/probe_vfs_getname.sh
++ perf probe -l
++ grep -q probe:vfs_getname
++ had_vfs_getname=1
++ mktemp /tmp/temporary_file.XXXXX
+ file=/tmp/temporary_file.pSzKC
+ add_probe_vfs_getname
+ local verbose=
+ '[' 1 -eq 1 ']'
++ perf probe -L getname_flags
++ egrep 'result.*=.*filename;'
++ sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
+ line=72
+ perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
Added new event:
  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

+ err=0
+ '[' 0 -ne 0 ']'
+ trace_open_vfs_getname
++ uname -m
+ test x86_64 = s390x
++ sed 's/ /,/'
+++ egrep 'open(at)? '
+++ perf list 'syscalls:sys_enter_open*'
+++ sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/'
++ echo open openat
+ svc=open,openat
+ perf trace -e open,openat touch /tmp/temporary_file.pSzKC
+ egrep ' +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\(filename: +/tmp/temporary_file.pSzKC, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$'
     1.479 ( 0.073 ms): touch/27884 open(filename: /tmp/temporary_file.pSzKC, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
+ err=0
+ rm -f /tmp/temporary_file.pSzKC
+ cleanup_probe_vfs_getname
+ '[' 1 -eq 1 ']'
+ perf probe -q -d probe:vfs_getname
+ exit 0
[root@jouet perf]#


- Arnaldo

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 2a9ef080efd0..d22f08568226 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,10 +17,10 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
-
-	perf trace -e ${svc:-open} touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	test "$(uname -m)" = s390x && { txt="dfd: +CWD, +"; }
+	svc=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	perf trace -e ${svc} touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
