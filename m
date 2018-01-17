From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/32] perf trace: Allow overriding global --max-stack per event
Date: Wed, 17 Jan 2018 13:12:12 -0300
Message-ID: <20180117161222.15611-23-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The per-event max-stack setting wasn't overriding the global --max-stack
setting:

  # perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf,max-stack=2/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.072 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.072/0.072/0.072/0.000 ms
       0.000 probe_libc:inet_pton:(7feb7a998350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa39b6108f3f] (/usr/bin/ping)
  #

Fix it:

  # perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf,max-stack=2/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.073 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.073/0.073/0.073/0.000 ms
       0.000 probe_libc:inet_pton:(7f1083221350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ic3g837xg8ob3kcpkspxwz0g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ee85c29dbf70..531d43bf57e1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1644,7 +1644,7 @@ static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evse
 	struct addr_location al;
 
 	if (machine__resolve(trace->host, &al, sample) < 0 ||
-	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, trace->max_stack))
+	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, evsel->attr.sample_max_stack))
 		return -1;
 
 	return 0;
@@ -2423,6 +2423,18 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	trace->multiple_threads = thread_map__pid(evlist->threads, 0) == -1 ||
 				  evlist->threads->nr > 1 ||
 				  perf_evlist__first(evlist)->attr.inherit;
+
+	/*
+	 * Now that we already used evsel->attr to ask the kernel to setup the
+	 * events, lets reuse evsel->attr.sample_max_stack as the limit in
+	 * trace__resolve_callchain(), allowing per-event max-stack settings
+	 * to override an explicitely set --max-stack global setting.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		if ((evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		    evsel->attr.sample_max_stack == 0)
+			evsel->attr.sample_max_stack = trace->max_stack;
+	}
 again:
 	before = trace->nr_events;
 
-- 
2.14.3
