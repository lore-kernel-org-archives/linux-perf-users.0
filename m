From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/53] perf record: Allocate affinity masks
Date: Wed,  6 Feb 2019 15:48:37 -0300
Message-ID: <20190206184903.24054-28-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Allocate affinity option and masks for mmap data buffers and record
thread as well as initialize allocated objects.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/526fa2b0-07de-6dbd-a7e9-26ba875593c9@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 13 ++++++++++++-
 tools/perf/perf.h           |  8 ++++++++
 tools/perf/util/evlist.c    |  6 +++---
 tools/perf/util/evlist.h    |  2 +-
 tools/perf/util/mmap.c      |  2 ++
 tools/perf/util/mmap.h      |  3 ++-
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 56e9d9e8c174..7ced5f3e8100 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -81,12 +81,17 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	cpu_set_t		affinity_mask;
 };
 
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
 static DEFINE_TRIGGER(switch_output_trigger);
 
+static const char *affinity_tags[PERF_AFFINITY_MAX] = {
+	"SYS", "NODE", "CPU"
+};
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -533,7 +538,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks, opts->affinity) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -1977,6 +1983,9 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
+	CPU_ZERO(&rec->affinity_mask);
+	rec->opts.affinity = PERF_AFFINITY_SYS;
+
 	rec->evlist = perf_evlist__new();
 	if (rec->evlist == NULL)
 		return -ENOMEM;
@@ -2140,6 +2149,8 @@ int cmd_record(int argc, const char **argv)
 	if (verbose > 0)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
+	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 5941fb6eccfc..b120e547ddc7 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,14 @@ struct record_opts {
 	clockid_t    clockid;
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
+	int	     affinity;
+};
+
+enum perf_affinity {
+	PERF_AFFINITY_SYS = 0,
+	PERF_AFFINITY_NODE,
+	PERF_AFFINITY_CPU,
+	PERF_AFFINITY_MAX
 };
 
 struct option;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8c902276d4b4..08cedb643ea6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1032,7 +1032,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1064,7 +1064,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 00ab43c6dd15..744906dd4887 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -165,7 +165,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks);
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8fc39311a30d..e68ba754a8e2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -343,6 +343,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
+	CPU_ZERO(&map->affinity_mask);
+
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index aeb6942fdb00..e566c19b242b 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -38,6 +38,7 @@ struct perf_mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
+	cpu_set_t	affinity_mask;
 };
 
 /*
@@ -69,7 +70,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks;
+	int			    prot, mask, nr_cblocks, affinity;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.20.1
