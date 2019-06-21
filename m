From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/25] perf trace: Streamline validation of select syscall names list
Date: Fri, 21 Jun 2019 14:38:22 -0300
Message-ID: <20190621173831.13780-17-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Leach <mike.leach@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rename the 'i' variable to 'nr_used' and use set 'nr_allocated' since
the start of this function, leaving the final assignment of the longer
named trace->ev_qualifier_ids.nr state to 'nr_used' at the end of the
function.

No change in behaviour intended.

Cc: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-kpgyn8xjdjgt0timrrnniquv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fa9eb467eb4c..d5b2e4d8bf41 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,11 +1529,10 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
 	bool printed_invalid_prefix = false;
-	size_t nr_allocated, i;
 	struct str_node *pos;
+	size_t nr_used = 0, nr_allocated = strlist__nr_entries(trace->ev_qualifier);
 
-	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
-	trace->ev_qualifier_ids.entries = malloc(trace->ev_qualifier_ids.nr *
+	trace->ev_qualifier_ids.entries = malloc(nr_allocated *
 						 sizeof(trace->ev_qualifier_ids.entries[0]));
 
 	if (trace->ev_qualifier_ids.entries == NULL) {
@@ -1543,9 +1542,6 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		goto out;
 	}
 
-	nr_allocated = trace->ev_qualifier_ids.nr;
-	i = 0;
-
 	strlist__for_each_entry(pos, trace->ev_qualifier) {
 		const char *sc = pos->s;
 		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
@@ -1566,7 +1562,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			continue;
 		}
 matches:
-		trace->ev_qualifier_ids.entries[i++] = id;
+		trace->ev_qualifier_ids.entries[nr_used++] = id;
 		if (match_next == -1)
 			continue;
 
@@ -1574,7 +1570,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == i) {
+			if (nr_allocated == nr_used) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1583,11 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 				}
 				trace->ev_qualifier_ids.entries = entries;
 			}
-			trace->ev_qualifier_ids.entries[i++] = id;
+			trace->ev_qualifier_ids.entries[nr_used++] = id;
 		}
 	}
 
-	trace->ev_qualifier_ids.nr = i;
+	trace->ev_qualifier_ids.nr = nr_used;
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
-- 
2.20.1
