From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/66] libperf: Move 'nr_mmaps' from 'struct evlist' to 'struct perf_evlist'
Date: Wed, 25 Sep 2019 21:32:11 -0300
Message-ID: <20190926003244.13962-34-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Moving 'nr_mmaps' from 'struct evlist' to 'struct perf_evlist', it will
be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c            |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c         |  2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-record.c                  |  6 +++---
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/internal/evlist.h     |  1 +
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  2 +-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/switch-tracking.c           |  2 +-
 tools/perf/util/evlist.c                     | 16 ++++++++--------
 tools/perf/util/evlist.h                     |  1 -
 tools/perf/util/python.c                     |  2 +-
 20 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5d120b1e35ed..051e9066fb38 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -648,7 +648,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	if (priv_size != cs_etm_info_priv_size(itr, session->evlist))
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	/* If the cpu_map is empty all online CPUs are involved */
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eebbf31f995c..9302c6566f53 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -51,7 +51,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index bd404db94b3a..10b7acebc0eb 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -115,7 +115,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	evlist__disable(evlist);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 130925141369..e81535c8e9c5 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -75,7 +75,7 @@ static int intel_bts_info_fill(struct auxtrace_record *itr,
 	if (priv_size != INTEL_BTS_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	pc = session->evlist->mmap[0].core.base;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1aa86a88884a..886b3ac60f23 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -352,7 +352,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	filter = intel_pt_find_filter(session->evlist, ptr->intel_pt_pmu);
 	filter_str_len = filter ? strlen(filter) : 0;
 
-	if (!session->evlist->nr_mmaps)
+	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
 	pc = session->evlist->mmap[0].core.base;
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 30852848ed9c..e2b42efc86fa 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -802,7 +802,7 @@ static int perf_kvm__mmap_read(struct perf_kvm_stat *kvm)
 	s64 n, ntotal = 0;
 	u64 flush_time = ULLONG_MAX, mmap_time;
 
-	for (i = 0; i < kvm->evlist->nr_mmaps; i++) {
+	for (i = 0; i < kvm->evlist->core.nr_mmaps; i++) {
 		n = perf_kvm__mmap_read_idx(kvm, i, &mmap_time);
 		if (n < 0)
 			return -1;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 06738efd9820..8577bf33a556 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -357,7 +357,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	if (!record__aio_enabled(rec))
 		return;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &maps[i];
 
 		if (map->core.base)
@@ -603,7 +603,7 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
 	int i;
 	int rc = 0;
 
-	for (i = 0; i < rec->evlist->nr_mmaps; i++) {
+	for (i = 0; i < rec->evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &rec->evlist->mmap[i];
 
 		if (!map->auxtrace_mmap.base)
@@ -966,7 +966,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e637a08655db..474b9860cfd4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -904,7 +904,7 @@ static void perf_top__mmap_read(struct perf_top *top)
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
-	for (i = 0; i < top->evlist->nr_mmaps; i++)
+	for (i = 0; i < top->evlist->core.nr_mmaps; i++)
 		perf_top__mmap_read_idx(top, i);
 
 	if (overwrite) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c44280358e58..91c73c7472ba 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3443,7 +3443,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 again:
 	before = trace->nr_events;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		union perf_event *event;
 		struct mmap *md;
 
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 448891f06e3e..035c1e1cc324 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -13,6 +13,7 @@ struct perf_evlist {
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map	*threads;
+	int			 nr_mmaps;
 };
 
 /**
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index c59d3752d48d..338cd9faa835 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -33,7 +33,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 {
 	int i;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 3c8533fdbce5..1eb0bffaed6c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -179,7 +179,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	(*func)();
 	evlist__disable(evlist);
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		union perf_event *event;
 		struct mmap *md;
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index bc6db3e7a1c5..7dac69a375f9 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -423,7 +423,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 	struct mmap *md;
 	int i, ret;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index c6030fdf7d4c..bd4ae8e5cd5d 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -36,7 +36,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 	int i, found;
 
 	found = 0;
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index e20eaadb1a35..4629fa33c8ad 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -87,7 +87,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 	while (1) {
 		int before = nr_events;
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			union perf_event *event;
 			struct mmap *md;
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index ea8bcaa13ea5..199a66444e60 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -165,7 +165,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	while (1) {
 		int before = total_events;
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			union perf_event *event;
 			struct mmap *md;
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index de700aad1fed..30a70db6473d 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -267,7 +267,7 @@ static int process_events(struct evlist *evlist,
 	struct mmap *md;
 	int i, ret;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md) < 0)
 			continue;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 16866533745c..d147834fbe60 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -651,7 +651,7 @@ static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 	if (!evlist->overwrite_mmap)
 		return 0;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		int fd = evlist->overwrite_mmap[i].core.fd;
 		int err;
 
@@ -679,11 +679,11 @@ static void evlist__munmap_nofree(struct evlist *evlist)
 	int i;
 
 	if (evlist->mmap)
-		for (i = 0; i < evlist->nr_mmaps; i++)
+		for (i = 0; i < evlist->core.nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->mmap[i]);
 
 	if (evlist->overwrite_mmap)
-		for (i = 0; i < evlist->nr_mmaps; i++)
+		for (i = 0; i < evlist->core.nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
@@ -700,14 +700,14 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct mmap *map;
 
-	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
+	evlist->core.nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
 	if (perf_cpu_map__empty(evlist->core.cpus))
-		evlist->nr_mmaps = perf_thread_map__nr(evlist->core.threads);
-	map = zalloc(evlist->nr_mmaps * sizeof(struct mmap));
+		evlist->core.nr_mmaps = perf_thread_map__nr(evlist->core.threads);
+	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		map[i].core.fd = -1;
 		map[i].core.overwrite = overwrite;
 		/*
@@ -1847,7 +1847,7 @@ static void *perf_evlist__poll_thread(void *arg)
 		if (!draining)
 			perf_evlist__poll(evlist, 1000);
 
-		for (i = 0; i < evlist->nr_mmaps; i++) {
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
 			struct mmap *map = &evlist->mmap[i];
 			union perf_event *event;
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 8b9c35efea67..816b72a2b1e5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -55,7 +55,6 @@ struct evlist {
 	struct perf_evlist core;
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
-	int		 nr_mmaps;
 	bool		 enabled;
 	size_t		 mmap_len;
 	int		 id_pos;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ba4085d7ae9f..62144b97e17b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -988,7 +988,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 {
 	int i;
 
-	for (i = 0; i < evlist->nr_mmaps; i++) {
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
 		if (md->core.cpu == cpu)
-- 
2.21.0
