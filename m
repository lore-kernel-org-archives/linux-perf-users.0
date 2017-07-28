From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/15] perf stat: Use group read for event groups
Date: Fri, 28 Jul 2017 17:00:09 -0300
Message-ID: <20170728200021.11389-4-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Make perf stat use  group read if there  are groups defined. The group
read will get the values for all member of groups within a single
syscall instead of calling read syscall for every event.

We can see considerable less amount of kernel cycles spent on single
group read, than reading each event separately, like for following perf
stat command:

  # perf stat -e {cycles,instructions} -I 10 -a sleep 1

Monitored with "perf stat -r 5 -e '{cycles:u,cycles:k}'"

Before:

        24,325,676      cycles:u
       297,040,775      cycles:k

       1.038554134 seconds time elapsed

After:
        25,034,418      cycles:u
       158,256,395      cycles:k

       1.036864497 seconds time elapsed

The perf_evsel__open fallback changes contributed by Andi Kleen.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170726120206.9099-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 30 +++++++++++++++++++++++++++---
 tools/perf/util/counts.h  |  1 +
 tools/perf/util/evsel.c   | 10 ++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 48ac53b199fc..866da7aa54bf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -213,10 +213,20 @@ static void perf_stat__reset_stats(void)
 static int create_perf_stat_counter(struct perf_evsel *evsel)
 {
 	struct perf_event_attr *attr = &evsel->attr;
+	struct perf_evsel *leader = evsel->leader;
 
-	if (stat_config.scale)
+	if (stat_config.scale) {
 		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
 				    PERF_FORMAT_TOTAL_TIME_RUNNING;
+	}
+
+	/*
+	 * The event is part of non trivial group, let's enable
+	 * the group read (for leader) and ID retrieval for all
+	 * members.
+	 */
+	if (leader->nr_members > 1)
+		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !no_inherit;
 
@@ -333,13 +343,21 @@ static int read_counter(struct perf_evsel *counter)
 			struct perf_counts_values *count;
 
 			count = perf_counts(counter->counts, cpu, thread);
-			if (perf_evsel__read(counter, cpu, thread, count)) {
+
+			/*
+			 * The leader's group read loads data into its group members
+			 * (via perf_evsel__read_counter) and sets threir count->loaded.
+			 */
+			if (!count->loaded &&
+			    perf_evsel__read_counter(counter, cpu, thread)) {
 				counter->counts->scaled = -1;
 				perf_counts(counter->counts, cpu, thread)->ena = 0;
 				perf_counts(counter->counts, cpu, thread)->run = 0;
 				return -1;
 			}
 
+			count->loaded = false;
+
 			if (STAT_RECORD) {
 				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
 					pr_err("failed to write stat event\n");
@@ -559,6 +577,11 @@ static int store_counter_ids(struct perf_evsel *counter)
 	return __store_counter_ids(counter, cpus, threads);
 }
 
+static bool perf_evsel__should_store_id(struct perf_evsel *counter)
+{
+	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
+}
+
 static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
@@ -631,7 +654,8 @@ static int __run_perf_stat(int argc, const char **argv)
 		if (l > unit_width)
 			unit_width = l;
 
-		if (STAT_RECORD && store_counter_ids(counter))
+		if (perf_evsel__should_store_id(counter) &&
+		    store_counter_ids(counter))
 			return -1;
 	}
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 34d8baaf558a..cb45a6aecf9d 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -12,6 +12,7 @@ struct perf_counts_values {
 		};
 		u64 values[3];
 	};
+	bool	loaded;
 };
 
 struct perf_counts {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 89aecf3a35c7..3735c9e0080d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -49,6 +49,7 @@ static struct {
 	bool clockid_wrong;
 	bool lbr_flags;
 	bool write_backward;
+	bool group_read;
 } perf_missing_features;
 
 static clockid_t clockid;
@@ -1321,6 +1322,7 @@ perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
+	count->loaded = true;
 }
 
 static int
@@ -1677,6 +1679,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	if (perf_missing_features.lbr_flags)
 		evsel->attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
+	if (perf_missing_features.group_read && evsel->attr.inherit)
+		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1832,6 +1836,12 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		perf_missing_features.lbr_flags = true;
 		pr_debug2("switching off branch sample type no (cycles/flags)\n");
 		goto fallback_missing_features;
+	} else if (!perf_missing_features.group_read &&
+		    evsel->attr.inherit &&
+		   (evsel->attr.read_format & PERF_FORMAT_GROUP)) {
+		perf_missing_features.group_read = true;
+		pr_debug2("switching off group read\n");
+		goto fallback_missing_features;
 	}
 out_close:
 	do {
-- 
2.9.4
