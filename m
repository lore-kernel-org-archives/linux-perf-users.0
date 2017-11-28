From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/30] perf trace: Fix an exit code of trace__symbols_init
Date: Tue, 28 Nov 2017 12:01:54 -0300
Message-ID: <20171128150220.5064-5-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753367AbdK1PCp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 10:02:45 -0500
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andrei Vagin <avagin@openvz.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Averin <vvs@virtuozzo.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andrei Vagin <avagin@openvz.org>

Currently if trace_event__register_resolver() fails, we return -errno,
but we can't be sure that errno isn't zero in this case.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vasily Averin <vvs@virtuozzo.com>
Link: http://lkml.kernel.org/r/20171108002246.8924-2-avagin@openvz.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f2757d38c7d7..84debdbad327 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1152,12 +1152,14 @@ static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
 	if (trace->host == NULL)
 		return -ENOMEM;
 
-	if (trace_event__register_resolver(trace->host, trace__machine__resolve_kernel_addr) < 0)
-		return -errno;
+	err = trace_event__register_resolver(trace->host, trace__machine__resolve_kernel_addr);
+	if (err < 0)
+		goto out;
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
 					    evlist->threads, trace__tool_process, false,
 					    trace->opts.proc_map_timeout, 1);
+out:
 	if (err)
 		symbol__exit();
 
-- 
2.13.6
