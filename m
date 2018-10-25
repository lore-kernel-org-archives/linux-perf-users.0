From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/37] perf trace: Drop addr_location refcounts
Date: Thu, 25 Oct 2018 08:10:04 -0300
Message-ID: <20181025111031.3440-11-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we use machine__resolve() we grab a reference to
addr_location.thread (and in the future to other elements there) via
machine__findnew_thread(), so we must pair that with
addr_location__put(), else we'll never drop that thread when it exits
and no other remaining data structures have pointers to it. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ivg9hifzeuokb1f5jxc2wob4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 74638034861c..77b8748ad5ed 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1814,12 +1814,14 @@ static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evse
 	int max_stack = evsel->attr.sample_max_stack ?
 			evsel->attr.sample_max_stack :
 			trace->max_stack;
+	int err;
 
-	if (machine__resolve(trace->host, &al, sample) < 0 ||
-	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack))
+	if (machine__resolve(trace->host, &al, sample) < 0)
 		return -1;
 
-	return 0;
+	err = thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack);
+	addr_location__put(&al);
+	return err;
 }
 
 static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sample)
-- 
2.14.4
