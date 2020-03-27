From: Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v7 3/6] perf/tools: Refactoring metricgroup__add_metric function
Date: Fri, 27 Mar 2020 15:55:25 +0530
Message-ID: <20200327102528.4267-4-kjain@linux.ibm.com>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200327102528.4267-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

This patch refactor metricgroup__add_metric function where
some part of it move to function metricgroup__add_metric_param.
No logic change.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 61 +++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 926449a7cdbf..b905eaa907a7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -485,6 +485,40 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
+static int __metricgroup__add_metric(struct strbuf *events,
+			struct list_head *group_list, struct pmu_event *pe)
+{
+
+	const char **ids;
+	int idnum;
+	struct egroup *eg;
+	int ret = -EINVAL;
+
+	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
+		return ret;
+
+	if (events->len > 0)
+		strbuf_addf(events, ",");
+
+	if (metricgroup__has_constraint(pe))
+		metricgroup__add_metric_non_group(events, ids, idnum);
+	else
+		metricgroup__add_metric_weak_group(events, ids, idnum);
+
+	eg = malloc(sizeof(*eg));
+	if (!eg)
+		return -ENOMEM;
+
+	eg->ids = ids;
+	eg->idnum = idnum;
+	eg->metric_name = pe->metric_name;
+	eg->metric_expr = pe->metric_expr;
+	eg->metric_unit = pe->unit;
+	list_add_tail(&eg->nd, group_list);
+
+	return 0;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -504,35 +538,12 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-			const char **ids;
-			int idnum;
-			struct egroup *eg;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
-			if (expr__find_other(pe->metric_expr,
-					     NULL, &ids, &idnum) < 0)
+			ret = __metricgroup__add_metric(events,	group_list, pe);
+			if (ret == -EINVAL || !ret)
 				continue;
-			if (events->len > 0)
-				strbuf_addf(events, ",");
-
-			if (metricgroup__has_constraint(pe))
-				metricgroup__add_metric_non_group(events, ids, idnum);
-			else
-				metricgroup__add_metric_weak_group(events, ids, idnum);
-
-			eg = malloc(sizeof(struct egroup));
-			if (!eg) {
-				ret = -ENOMEM;
-				break;
-			}
-			eg->ids = ids;
-			eg->idnum = idnum;
-			eg->metric_name = pe->metric_name;
-			eg->metric_expr = pe->metric_expr;
-			eg->metric_unit = pe->unit;
-			list_add_tail(&eg->nd, group_list);
-			ret = 0;
 		}
 	}
 	return ret;
-- 
2.18.1
