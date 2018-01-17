From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/32] perf trace: Fix setting of --call-graph/--max-stack for non-syscall events
Date: Wed, 17 Jan 2018 13:11:57 -0300
Message-ID: <20180117161222.15611-8-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The raw_syscalls:sys_{enter,exit} were first supported in 'perf trace',
together with minor and major page faults, then we supported
--call-graph, then --max-stack, but when the other tracepoints got
supported, and bpf, etc, I forgot to make those global call-graph
settings apply to them.

Fix it by realizing that the global --max-stack and --call-graph
settings are done via:

        OPT_CALLBACK(0, "call-graph", &trace.opts,
                     "record_mode[,record_size]", record_callchain_help,
                     &record_parse_callchain_opt),

And then, when we go to parse the events in -e via:

        OPT_CALLBACK('e', "event", &trace, "event",
                     "event/syscall selector. use 'perf list' to list available events",
                     trace__parse_events_option),

And trace__parse_sevents_option() calls:

                struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
                                               "event selector. use 'perf list' to list available events",
                                               parse_events_option);
                err = parse_events_option(&o, lists[0], 0);

parse_events_option() will override the global --call-graph and
--max-stack if the "call-graph" and/or "max-stack" terms are in the
event definition, such as in the probe_libc:inet_pton event in one of the
examples below (-e probe_libc:inet_pton/max-stack=2).

Before:

  # perf trace --mmap 1024 --call-graph dwarf -e sendto,probe_libc:inet_pton ping -6 -c 1 ::1
       1.525 (         ): probe_libc:inet_pton:(7f77f3ac9350))
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.071 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.071/0.071/0.071/0.000 ms
       1.677 ( 0.081 ms): ping/31296 sendto(fd: 3, buff: 0x55681b652720, len: 64, addr: 0x55681b650640, addr_len: 28) = 64
                                         __libc_sendto (/usr/lib64/libc-2.26.so)
                                         [0xffffaa97e4bc9cef] (/usr/bin/ping)
                                         [0xffffaa97e4bc656d] (/usr/bin/ping)
                                         [0xffffaa97e4bc7d0a] (/usr/bin/ping)
                                         [0xffffaa97e4bca447] (/usr/bin/ping)
                                         [0xffffaa97e4bc2f91] (/usr/bin/ping)
                                         __libc_start_main (/usr/lib64/libc-2.26.so)
                                         [0xffffaa97e4bc3379] (/usr/bin/ping)
  #

After:

  # perf trace --mmap 1024 --call-graph dwarf -e sendto,probe_libc:inet_pton ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.089 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.089/0.089/0.089/0.000 ms
       1.955 (         ): probe_libc:inet_pton:(7f383a311350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa5d91444f3f] (/usr/bin/ping)
                                         __libc_start_main (/usr/lib64/libc-2.26.so)
                                         [0xffffaa5d91445379] (/usr/bin/ping)
       2.140 ( 0.101 ms): ping/32047 sendto(fd: 3, buff: 0x55a26edd0720, len: 64, addr: 0x55a26edce640, addr_len: 28) = 64
                                         __libc_sendto (/usr/lib64/libc-2.26.so)
                                         [0xffffaa5d9144bcef] (/usr/bin/ping)
                                         [0xffffaa5d9144856d] (/usr/bin/ping)
                                         [0xffffaa5d91449d0a] (/usr/bin/ping)
                                         [0xffffaa5d9144c447] (/usr/bin/ping)
                                         [0xffffaa5d91444f91] (/usr/bin/ping)
                                         __libc_start_main (/usr/lib64/libc-2.26.so)
                                         [0xffffaa5d91445379] (/usr/bin/ping)
  #

Same thing for --max-stack, the global one:

  # perf trace --max-stack 3 -e sendto,probe_libc:inet_pton ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.097 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.097/0.097/0.097/0.000 ms
       1.577 (         ): probe_libc:inet_pton:(7f32f3957350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
       1.738 ( 0.108 ms): ping/32103 sendto(fd: 3, buff: 0x55c3132d7720, len: 64, addr: 0x55c3132d5640, addr_len: 28) = 64
                                         __libc_sendto (/usr/lib64/libc-2.26.so)
                                         [0xffffaa3cecf44cef] (/usr/bin/ping)
                                         [0xffffaa3cecf4156d] (/usr/bin/ping)
  #

And then setting up a global setting (dwarf, max-stack=4), that will
affect the raw_syscall:sys_enter for the 'sendto' syscall and that will
be overriden in the probe_libc:inet_pton call to just one entry.

  # perf trace --max-stack=4 --call-graph dwarf -e sendto -e probe_libc:inet_pton/max-stack=1/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.090 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.090/0.090/0.090/0.000 ms
       2.140 (         ): probe_libc:inet_pton:(7f9fe9337350))
                                         __GI___inet_pton (/usr/lib64/libc-2.26.so)
       2.283 ( 0.103 ms): ping/31804 sendto(fd: 3, buff: 0x55c7f3e19720, len: 64, addr: 0x55c7f3e17640, addr_len: 28) = 64
                                         __libc_sendto (/usr/lib64/libc-2.26.so)
                                         [0xffffaa380c402cef] (/usr/bin/ping)
                                         [0xffffaa380c3ff56d] (/usr/bin/ping)
                                         [0xffffaa380c400d0a] (/usr/bin/ping)
  #

Install iputils-debuginfo to get those /usr/bin/ping addresses resolved,
those routines are not on its .dymsym nor .symtab :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qgl2gse8elhh9zztw4ajopg3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e84816d02117..0362974854e9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2222,6 +2222,9 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	if (perf_evsel__init_sc_tp_uint_field(sys_exit, ret))
 		goto out_delete_sys_exit;
 
+	perf_evsel__config_callchain(sys_enter, &trace->opts, &callchain_param);
+	perf_evsel__config_callchain(sys_exit, &trace->opts, &callchain_param);
+
 	perf_evlist__add(evlist, sys_enter);
 	perf_evlist__add(evlist, sys_exit);
 
@@ -2318,6 +2321,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_maj = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
 		if (pgfault_maj == NULL)
 			goto out_error_mem;
+		perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
 		perf_evlist__add(evlist, pgfault_maj);
 	}
 
@@ -2325,6 +2329,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		pgfault_min = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MIN);
 		if (pgfault_min == NULL)
 			goto out_error_mem;
+		perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
 		perf_evlist__add(evlist, pgfault_min);
 	}
 
@@ -2347,21 +2352,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	perf_evlist__config(evlist, &trace->opts, NULL);
 
-	if (callchain_param.enabled) {
-		if (trace->syscalls.events.sys_exit) {
-			perf_evsel__config_callchain(trace->syscalls.events.sys_exit,
-						     &trace->opts, &callchain_param);
-		}
-
-		if (pgfault_maj) {
-			perf_evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
-		}
-
-		if (pgfault_min) {
-			perf_evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
-		}
-	}
-
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
 
-- 
2.14.3
