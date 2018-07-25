From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/27] perf tools: Use perf_evsel__match instead of open coded equivalent
Date: Wed, 25 Jul 2018 14:59:59 -0300
Message-ID: <20180725180001.15108-26-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use perf_evsel__match() helper in perf_evsel__is_bpf_output().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180720110036.32251-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d277930b19a1..890babf9ce86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -402,10 +402,7 @@ bool perf_evsel__is_function_event(struct perf_evsel *evsel);
 
 static inline bool perf_evsel__is_bpf_output(struct perf_evsel *evsel)
 {
-	struct perf_event_attr *attr = &evsel->attr;
-
-	return (attr->config == PERF_COUNT_SW_BPF_OUTPUT) &&
-		(attr->type == PERF_TYPE_SOFTWARE);
+	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
 struct perf_attr_details {
-- 
2.14.4
