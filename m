From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/15] perf evsel: Add read_counter()
Date: Fri, 28 Jul 2017 17:00:08 -0300
Message-ID: <20170728200021.11389-3-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evsel__read_counter() to read single or group counter. After
calling this function the counter's evsel::counts struct is filled with
values for the counter and member of its group if there are any.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170726120206.9099-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |   2 +
 tools/perf/util/stat.c  |   4 ++
 tools/perf/util/stat.h  |   5 ++-
 4 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4dd0fcc06db9..89aecf3a35c7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1302,6 +1302,106 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	return 0;
 }
 
+static int
+perf_evsel__read_one(struct perf_evsel *evsel, int cpu, int thread)
+{
+	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
+
+	return perf_evsel__read(evsel, cpu, thread, count);
+}
+
+static void
+perf_evsel__set_count(struct perf_evsel *counter, int cpu, int thread,
+		      u64 val, u64 ena, u64 run)
+{
+	struct perf_counts_values *count;
+
+	count = perf_counts(counter->counts, cpu, thread);
+
+	count->val    = val;
+	count->ena    = ena;
+	count->run    = run;
+}
+
+static int
+perf_evsel__process_group_data(struct perf_evsel *leader,
+			       int cpu, int thread, u64 *data)
+{
+	u64 read_format = leader->attr.read_format;
+	struct sample_read_value *v;
+	u64 nr, ena = 0, run = 0, i;
+
+	nr = *data++;
+
+	if (nr != (u64) leader->nr_members)
+		return -EINVAL;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		ena = *data++;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		run = *data++;
+
+	v = (struct sample_read_value *) data;
+
+	perf_evsel__set_count(leader, cpu, thread,
+			      v[0].value, ena, run);
+
+	for (i = 1; i < nr; i++) {
+		struct perf_evsel *counter;
+
+		counter = perf_evlist__id2evsel(leader->evlist, v[i].id);
+		if (!counter)
+			return -EINVAL;
+
+		perf_evsel__set_count(counter, cpu, thread,
+				      v[i].value, ena, run);
+	}
+
+	return 0;
+}
+
+static int
+perf_evsel__read_group(struct perf_evsel *leader, int cpu, int thread)
+{
+	struct perf_stat_evsel *ps = leader->priv;
+	u64 read_format = leader->attr.read_format;
+	int size = perf_evsel__read_size(leader);
+	u64 *data = ps->group_data;
+
+	if (!(read_format & PERF_FORMAT_ID))
+		return -EINVAL;
+
+	if (!perf_evsel__is_group_leader(leader))
+		return -EINVAL;
+
+	if (!data) {
+		data = zalloc(size);
+		if (!data)
+			return -ENOMEM;
+
+		ps->group_data = data;
+	}
+
+	if (FD(leader, cpu, thread) < 0)
+		return -EINVAL;
+
+	if (readn(FD(leader, cpu, thread), data, size) <= 0)
+		return -errno;
+
+	return perf_evsel__process_group_data(leader, cpu, thread, data);
+}
+
+int perf_evsel__read_counter(struct perf_evsel *evsel, int cpu, int thread)
+{
+	u64 read_format = evsel->attr.read_format;
+
+	if (read_format & PERF_FORMAT_GROUP)
+		return perf_evsel__read_group(evsel, cpu, thread);
+	else
+		return perf_evsel__read_one(evsel, cpu, thread);
+}
+
 int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
 			      int cpu, int thread, bool scale)
 {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index fb40ca3c6519..de03c18daaf0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -299,6 +299,8 @@ static inline bool perf_evsel__match2(struct perf_evsel *e1,
 int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 		     struct perf_counts_values *count);
 
+int perf_evsel__read_counter(struct perf_evsel *evsel, int cpu, int thread);
+
 int __perf_evsel__read_on_cpu(struct perf_evsel *evsel,
 			      int cpu, int thread, bool scale);
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 53b9a994a3dc..35e9848734d6 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -128,6 +128,10 @@ static int perf_evsel__alloc_stat_priv(struct perf_evsel *evsel)
 
 static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
 {
+	struct perf_stat_evsel *ps = evsel->priv;
+
+	if (ps)
+		free(ps->group_data);
 	zfree(&evsel->priv);
 }
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 7522bf10b03e..eacaf958e19d 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -28,8 +28,9 @@ enum perf_stat_evsel_id {
 };
 
 struct perf_stat_evsel {
-	struct stats		res_stats[3];
-	enum perf_stat_evsel_id	id;
+	struct stats		 res_stats[3];
+	enum perf_stat_evsel_id	 id;
+	u64			*group_data;
 };
 
 enum aggr_mode {
-- 
2.9.4
