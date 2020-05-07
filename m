From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 4/7] perf metricgroup: always place duration_time last
Date: Thu,  7 May 2020 01:14:33 -0700
Message-ID: <20200507081436.49071-5-irogers@google.com>
References: <20200507081436.49071-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200507081436.49071-1-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

If a metric contains the duration_time event then the event is placed
outside of the metric's group of events. Rather than split the group,
make it so the duration_time is immediately after the group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2356dda92a07..48d0143b4b0c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -421,8 +421,8 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 					       struct expr_parse_ctx *ctx)
 {
 	struct hashmap_entry *cur;
-	size_t bkt, i = 0;
-	bool no_group = false;
+	size_t bkt;
+	bool no_group = true, has_duration = false;
 
 	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
 		pr_debug("found event %s\n", (const char*)cur->key);
@@ -432,20 +432,20 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		 * group.
 		 */
 		if (!strcmp(cur->key, "duration_time")) {
-			if (i > 0)
-				strbuf_addf(events, "}:W,");
-			strbuf_addf(events, "duration_time");
-			no_group = true;
+			has_duration = true;
 			continue;
 		}
 		strbuf_addf(events, "%s%s",
-			i == 0 || no_group ? "{" : ",",
+			no_group ? "{" : ",",
 			(const char*)cur->key);
 		no_group = false;
-		i++;
 	}
-	if (!no_group)
-		strbuf_addf(events, "}:W");
+	if (!no_group) {
+                strbuf_addf(events, "}:W");
+		if (has_duration)
+			strbuf_addf(events, ",duration_time");
+	} else if (has_duration)
+		strbuf_addf(events, "duration_time");
 }
 
 static void metricgroup__add_metric_non_group(struct strbuf *events,
-- 
2.26.2.526.g744177e7f7-goog
