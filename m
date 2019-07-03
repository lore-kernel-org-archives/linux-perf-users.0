From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/18] perf tools metric: Don't include duration_time in group
Date: Wed,  3 Jul 2019 00:27:44 -0300
Message-ID: <20190703032746.21692-17-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Memory_BW metric generates groups including duration_time, which
maps to a software event.

For some reason this makes the group always not count.

Always put duration_time outside a group when generating metrics.  It's
always the same time, so no need to group it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7d36435fa84c..d8164574cb16 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -409,6 +409,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
+			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -419,11 +420,25 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				strbuf_addf(events, ",");
 			for (j = 0; j < idnum; j++) {
 				pr_debug("found event %s\n", ids[j]);
+				/*
+				 * Duration time maps to a software event and can make
+				 * groups not count. Always use it outside a
+				 * group.
+				 */
+				if (!strcmp(ids[j], "duration_time")) {
+					if (j > 0)
+						strbuf_addf(events, "}:W,");
+					strbuf_addf(events, "duration_time");
+					no_group = true;
+					continue;
+				}
 				strbuf_addf(events, "%s%s",
-					j == 0 ? "{" : ",",
+					j == 0 || no_group ? "{" : ",",
 					ids[j]);
+				no_group = false;
 			}
-			strbuf_addf(events, "}:W");
+			if (!no_group)
+				strbuf_addf(events, "}:W");
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
-- 
2.20.1
