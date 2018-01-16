From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/5] perf trace: Allow overriding global --max-stack per event
Date: Tue, 16 Jan 2018 11:24:37 -0300
Message-ID: <20180116142438.19520-5-acme@kernel.org>
References: <20180116142438.19520-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeAPOZF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 09:25:05 -0500
In-Reply-To: <20180116142438.19520-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

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
Link: https://lkml.kernel.org/n/tip-3uqo18od1m7pul581b9vjtj5@git.kernel.org
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
