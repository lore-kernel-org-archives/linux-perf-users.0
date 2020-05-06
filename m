From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 80/91] perf sched: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:23 -0300
Message-ID: <20200506152234.21977-81-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b99398031131..459e4229945e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1848,7 +1848,7 @@ static inline void print_sched_time(unsigned long long nsecs, int width)
  * returns runtime data for event, allocating memory for it the
  * first time it is used.
  */
-static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
+static struct evsel_runtime *evsel__get_runtime(struct evsel *evsel)
 {
 	struct evsel_runtime *r = evsel->priv;
 
@@ -1863,10 +1863,9 @@ static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
 /*
  * save last time event was seen per cpu
  */
-static void perf_evsel__save_time(struct evsel *evsel,
-				  u64 timestamp, u32 cpu)
+static void evsel__save_time(struct evsel *evsel, u64 timestamp, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if (r == NULL)
 		return;
@@ -1890,9 +1889,9 @@ static void perf_evsel__save_time(struct evsel *evsel,
 }
 
 /* returns last time this event was seen on the given cpu */
-static u64 perf_evsel__get_time(struct evsel *evsel, u32 cpu)
+static u64 evsel__get_time(struct evsel *evsel, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if ((r == NULL) || (r->last_time == NULL) || (cpu >= r->ncpu))
 		return 0;
@@ -2548,7 +2547,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		goto out;
 	}
 
-	tprev = perf_evsel__get_time(evsel, sample->cpu);
+	tprev = evsel__get_time(evsel, sample->cpu);
 
 	/*
 	 * If start time given:
@@ -2631,7 +2630,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		tr->ready_to_run = 0;
 	}
 
-	perf_evsel__save_time(evsel, sample->time, sample->cpu);
+	evsel__save_time(evsel, sample->time, sample->cpu);
 
 	return rc;
 }
@@ -2941,7 +2940,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel_runtime *er;
 
 	list_for_each_entry(evsel, &evlist->core.entries, core.node) {
-		er = perf_evsel__get_runtime(evsel);
+		er = evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
 			return -1;
-- 
2.21.1
