From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/5] perf trace: Setup DWARF callchains for non-syscall events when --max-stack is used
Date: Tue, 16 Jan 2018 11:24:36 -0300
Message-ID: <20180116142438.19520-4-acme@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116142438.19520-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If we use:

	perf trace --max-stack=4

then the syscall events will use DWARF callchains, when available
(libunwind enabled in the build) and the printing will stop at 4 levels.

When we introduced support for tracepoint events this ended up not
applying for them, fix it.

Before:

  # perf trace --call-graph=dwarf --no-syscalls -e probe_libc:inet_pton ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.058 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.058/0.058/0.058/0.000 ms
       0.000 probe_libc:inet_pton:(7fc6c2a16350))
  #

After:

  # perf trace --call-graph=dwarf --no-syscalls -e probe_libc:inet_pton ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.087 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.087/0.087/0.087/0.000 ms
       0.000 probe_libc:inet_pton:(7fbf9a041350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa947cb67f3f] (/usr/bin/ping)
                                         __libc_start_main (/usr/lib64/libc-2.26.so)
                                         [0xffffaa947cb68379] (/usr/bin/ping)
  #

Reported-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0kh9yawd6n7e6yp2qldwym6c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0362974854e9..ee85c29dbf70 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2350,7 +2350,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	perf_evlist__config(evlist, &trace->opts, NULL);
+	perf_evlist__config(evlist, &trace->opts, &callchain_param);
 
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
@@ -3065,8 +3065,9 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	if ((trace.min_stack || max_stack_user_set) && !callchain_param.enabled && trace.trace_syscalls)
+	if ((trace.min_stack || max_stack_user_set) && !callchain_param.enabled) {
 		record_opts__parse_callchain(&trace.opts, &callchain_param, "dwarf", false);
+	}
 #endif
 
 	if (callchain_param.enabled) {
-- 
2.14.3
