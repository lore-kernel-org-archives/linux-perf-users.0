From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/25] perf trace: Fix exclusion of not available syscall names from selector list
Date: Fri, 21 Jun 2019 14:38:21 -0300
Message-ID: <20190621173831.13780-16-acme@kernel.org>
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

We were just skipping the syscalls not available in a particular
architecture without reflecting this in the number of entries in the
ev_qualifier_ids.nr variable, fix it.

This was done with the most minimalistic way, reusing the index variable
'i', a followup patch will further clean this by making 'i' renamed to
'nr_used' and using 'nr_allocated' in a few more places.

Reported-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Fixes: 04c41bcb862b ("perf trace: Skip unknown syscalls when expanding strace like syscall groups")
Link: https://lkml.kernel.org/r/20190613181514.GC1402@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 12f5ad98f8c1..fa9eb467eb4c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1527,9 +1527,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
-	int err = 0, i;
+	int err = 0;
 	bool printed_invalid_prefix = false;
-	size_t nr_allocated;
+	size_t nr_allocated, i;
 	struct str_node *pos;
 
 	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
@@ -1574,7 +1574,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == trace->ev_qualifier_ids.nr) {
+			if (nr_allocated == i) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1587,11 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 				}
 				trace->ev_qualifier_ids.entries = entries;
 			}
-			trace->ev_qualifier_ids.nr++;
 			trace->ev_qualifier_ids.entries[i++] = id;
 		}
 	}
 
+	trace->ev_qualifier_ids.nr = i;
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
-- 
2.20.1
