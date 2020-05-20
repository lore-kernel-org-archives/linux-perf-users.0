From: Ian Rogers <irogers@google.com>
Subject: [PATCH 7/7] perf metricgroup: Remove unnecessary ',' from events
Date: Wed, 20 May 2020 00:28:14 -0700
Message-ID: <20200520072814.128267-8-irogers@google.com>
References: <20200520072814.128267-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200520072814.128267-1-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Remove unnecessary commas from events before they are parsed. This
avoids ',' being echoed by parse-events.l.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 432ae2e4c7b1..570285132cf6 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -501,9 +501,14 @@ static void metricgroup__add_metric_non_group(struct strbuf *events,
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
+	bool first = true;
 
-	hashmap__for_each_entry((&ctx->ids), cur, bkt)
-		strbuf_addf(events, ",%s", (const char *)cur->key);
+	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+		if (!first)
+			strbuf_addf(events, ",");
+		strbuf_addf(events, "%s", (const char *)cur->key);
+		first = false;
+	}
 }
 
 static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
@@ -637,8 +642,10 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 	if (!ret) {
+		bool first = true;
+
 		list_for_each_entry(eg, group_list, nd) {
-			if (events->len > 0)
+			if (events->len > 0 && !first)
 				strbuf_addf(events, ",");
 
 			if (eg->has_constraint) {
@@ -648,6 +655,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				metricgroup__add_metric_weak_group(events,
 								   &eg->pctx);
 			}
+			first = false;
 		}
 	}
 	return ret;
-- 
2.26.2.761.g0e0b3e54be-goog
