From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 10:57:52 -0300
Message-ID: <20180115135752.GC3542@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
 <20180112200229.GI9655@kernel.org>
 <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jan 15, 2018 at 01:31:00PM +0100, Thomas-Mich Richter escreveu:
> On 01/12/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 12, 2018 at 01:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> There is still room for improvement, I noticed overriding is not working
> >> for the probe event, investigating it now.
> > 
> > So, I had to fix this another way to get the possibility of overwriting
> > the global options (--max-stack, --call-graph) in an specific tracepoint
> > event:
> > 
> > http://git.kernel.org/acme/c/08e26396c6f2
> > 
> > replaced that HEAD.
> > 
> > This cset may take some more minutes to show up, just pushed.
> > 
> 
> I have installed your perf/core tree on my Fedora 27 Virtual Machine
> running on my Intel notebook.
> 
> Here are some commands and the output on an Intel platform:
> 
> [root@f27 perf]# uname -a
> Linux f27 4.15.0-rc6acme+ #1 SMP Mon Jan 15 12:35:23 CET 2018 x86_64 x86_64 x86_64 GNU/Linux
> [root@f27 perf]#
> 
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph fp --max-stack 3
>         -e probe_libc:inet_pton ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.022 ms
>      0.000 probe_libc:inet_pton:
>  --- ::1 ping statistics ---
> (7f8fc407d8a0))
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.022/0.022/0.022/0.000 ms
> [root@f27 perf]#
> 
> --> No call graph at all, the kernel as been compiled with ORC unwinder.

Results with the patch at the end of this message:

[root@jouet ~]# perf trace --no-syscalls --call-graph fp --max-stack 3 -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.061 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
     0.000 probe_libc:inet_pton:(7f475b8be350))
                                       __GI___inet_pton (/usr/lib64/libc-2.26.so)
                                       getaddrinfo (/usr/lib64/libc-2.26.so)
                                       [0xffffaa7de21b9f40] (/usr/bin/ping)
[root@jouet ~]#

 
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf --max-stack 3
>         -e probe_libc:inet_pton ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.024 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.024/0.024/0.024/0.000 ms
> 0.000 probe_libc:inet_pton:(7f7ff38488a0))
> [root@f27 perf]#
> 
> --> No call graph at all, the kernel as been compiled with OCR unwinder.

[root@jouet ~]# perf trace --no-syscalls --call-graph fp --max-stack 3 -e probe_libc:inet_pton ping -6 -c 1 ::1
perf trace --no-syscalls --call-graph dwarf --max-stack 3 -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.080 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.080/0.080/0.080/0.000 ms
     0.000 probe_libc:inet_pton:(7f33e9647350))
                                       __inet_pton (inlined)
                                       gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                       __GI_getaddrinfo (inlined)
[root@jouet ~]# 

And here we see a difference in the fp and DWARF unwinders, have to dig
deeper into this one, perhaps using the DWARF one we have more info and
then can end up with inlines instead of what it calls.
 
> [root@f27 perf]# ./perf trace --no-syscalls
>         -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
>         ping -6 -c 1 ::1PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.019 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.019/0.019/0.019/0.000 ms
>      0.000 probe_libc:inet_pton:(7fc985d658a0))
>            __inet_pton (inlined)
>            gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
>            __GI_getaddrinfo (inlined)
>            main (/usr/bin/ping)
>            __libc_start_main (/usr/lib64/libc-2.26.so)
>            _start (/usr/bin/ping)
> [root@f27 perf]#
> 
> --> Dwarf call graph, but max-stack=4 not honoured when specified as
>         event specific restriction.

[root@jouet ~]# perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
     0.000 probe_libc:inet_pton:(7f10482eb350))
Problem processing probe_libc:inet_pton callchain, skipping...
   717.753 probe_libc:inet_pton:(7f10482eb350))
Problem processing probe_libc:inet_pton callchain, skipping...
   718.182 probe_libc:inet_pton:(7f10482eb350))
Problem processing probe_libc:inet_pton callchain, skipping...
  2662.046 probe_libc:inet_pton:(7f10482eb350))
Problem processing probe_libc:inet_pton callchain, skipping...
^C[root@jouet ~]#

Need to investigate...
 
> [root@f27 perf]# ./perf trace --no-syscalls --max-stack 4
>         -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.020 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.020/0.020/0.020/0.000 ms
>      0.000 probe_libc:inet_pton:(7ffbc5f768a0))
>             __inet_pton (inlined)
>             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
>             __GI_getaddrinfo (inlined)
>             main (/usr/bin/ping)
> [root@f27 perf]#
> 
> 
> --> Dwarf call graph and --max-stack 4 is also honoured.

[root@jouet ~]# perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
Value too large for defined data type
[root@jouet ~]# 

Grrr.
> 
> I have the feeling that your fix does not work very well when
> used with the --no-syscalls option.
> Omitting --no-syscalls shows your explained behavior.
> 
> So there must be a difference between --no-syscalls and --syscalls
> invocation.     

Right, there is, please see the patch below, but I need to fix the other
issues I noticed here but you haven't, perhaps we're using a different
DWARF unwinder (there are two possible libraries to use).

commit 7a24f244b452cfc0acfe35d1a6168c9a8ff483ce
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jan 15 10:39:55 2018 -0300

    perf trace: Setup DWARF callchains for non-syscall events when --max-stack is used
    
    If we use:
    
            perf trace --max-stack=4
    
    then the syscall events will use DWARF callchains, when available
    (libunwind enabled in the build) and the printing will stop at 4 levels.
    
    When we introduced support for tracepoint events this ended up not
    applying for them, fix it.
    
    Reported-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: https://lkml.kernel.org/n/tip-xq2enzgcs5q40kg5wq5aac3s@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0362974854e9..c6c7498562ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3065,11 +3065,23 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	if ((trace.min_stack || max_stack_user_set) && !callchain_param.enabled && trace.trace_syscalls)
+	if ((trace.min_stack || max_stack_user_set) && !callchain_param.enabled) {
 		record_opts__parse_callchain(&trace.opts, &callchain_param, "dwarf", false);
+	}
 #endif
 
 	if (callchain_param.enabled) {
+		struct perf_evsel *evsel;
+		/*
+		 * When we use --max-stack and/or --call-graph we need to look at all the
+		 * other events passed in the command line to apply this config to them,
+		 * if not explicitely set.
+		 */
+		evlist__for_each_entry(trace.evlist, evsel) {
+			if (!(evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+				perf_evsel__config_callchain(evsel, &trace.opts, &callchain_param);
+		}
+
 		if (!mmap_pages_user_set && geteuid() == 0)
 			trace.opts.mmap_pages = perf_event_mlock_kb_in_pages() * 4;
 
