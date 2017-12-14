From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/34] perf stat: Remove --per-thread pid/tid limitation
Date: Thu, 14 Dec 2017 14:42:23 -0300
Message-ID: <20171214174247.16841-11-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754103AbdLNRnW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Dec 2017 12:43:22 -0500
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jin Yao <yao.jin@linux.intel.com>

Currently, if we execute 'perf stat --per-thread' without specifying
pid/tid, perf will return error.

root@skl:/tmp# perf stat --per-thread
The --per-thread option is only available when monitoring via -p -t options.
    -p, --pid <pid>       stat events on existing process id
    -t, --tid <tid>       stat events on existing thread id

This patch removes this limitation. If no pid/tid specified, it returns
all threads (get threads from /proc).

Note that it doesn't support cpu_list yet so if it's a cpu_list case,
then skip.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-11-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 23 +++++++++++++++--------
 tools/perf/util/target.h  |  7 +++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f4129a5fbb01..ee708ba6f79a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -277,7 +277,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel)
 			attr->enable_on_exec = 1;
 	}
 
-	if (target__has_cpu(&target))
+	if (target__has_cpu(&target) && !target__has_per_thread(&target))
 		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
 
 	return perf_evsel__open_per_thread(evsel, evsel_list->threads);
@@ -340,7 +340,7 @@ static int read_counter(struct perf_evsel *counter)
 	int nthreads = thread_map__nr(evsel_list->threads);
 	int ncpus, cpu, thread;
 
-	if (target__has_cpu(&target))
+	if (target__has_cpu(&target) && !target__has_per_thread(&target))
 		ncpus = perf_evsel__nr_cpus(counter);
 	else
 		ncpus = 1;
@@ -2743,12 +2743,16 @@ int cmd_stat(int argc, const char **argv)
 		run_count = 1;
 	}
 
-	if ((stat_config.aggr_mode == AGGR_THREAD) && !target__has_task(&target)) {
-		fprintf(stderr, "The --per-thread option is only available "
-			"when monitoring via -p -t options.\n");
-		parse_options_usage(NULL, stat_options, "p", 1);
-		parse_options_usage(NULL, stat_options, "t", 1);
-		goto out;
+	if ((stat_config.aggr_mode == AGGR_THREAD) &&
+		!target__has_task(&target)) {
+		if (!target.system_wide || target.cpu_list) {
+			fprintf(stderr, "The --per-thread option is only "
+				"available when monitoring via -p -t -a "
+				"options or only --per-thread.\n");
+			parse_options_usage(NULL, stat_options, "p", 1);
+			parse_options_usage(NULL, stat_options, "t", 1);
+			goto out;
+		}
 	}
 
 	/*
@@ -2772,6 +2776,9 @@ int cmd_stat(int argc, const char **argv)
 
 	target__validate(&target);
 
+	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
+		target.per_thread = true;
+
 	if (perf_evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 446aa7a56f25..6ef01a83b24e 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -64,6 +64,11 @@ static inline bool target__none(struct target *target)
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
+static inline bool target__has_per_thread(struct target *target)
+{
+	return target->system_wide && target->per_thread;
+}
+
 static inline bool target__uses_dummy_map(struct target *target)
 {
 	bool use_dummy = false;
@@ -73,6 +78,8 @@ static inline bool target__uses_dummy_map(struct target *target)
 	else if (target__has_task(target) ||
 	         (!target__has_cpu(target) && !target->uses_mmap))
 		use_dummy = true;
+	else if (target__has_per_thread(target))
+		use_dummy = true;
 
 	return use_dummy;
 }
-- 
2.13.6
