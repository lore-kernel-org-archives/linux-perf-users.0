From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/26] perf map: Move maj/min/ino/ino_generation to separate struct
Date: Fri, 22 Nov 2019 11:56:46 -0300
Message-ID: <20191122145711.3171-2-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And this patch highlights where these fields are being used: in the sort
order where it uses it to compare maps and classify samples taking into
account not just the DSO, but those DSO id fields.

I think these should be used to differentiate DSOs with the same name
but different 'struct dso_id' fields, i.e. these fields should move to
'struct dso' and then be used as part of the key when doing lookups for
DSOs, in addition to the DSO name.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8v5isitqy0dup47nnwkpc80f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/util/map.c       |  8 ++++----
 tools/perf/util/map.h       | 14 +++++++++++---
 tools/perf/util/sort.c      | 24 ++++++++++++------------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 585805f51f15..04c197d3beea 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -771,7 +771,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 				   map->prot & PROT_EXEC ? 'x' : '-',
 				   map->flags & MAP_SHARED ? 's' : 'p',
 				   map->pgoff,
-				   map->ino, map->dso->name);
+				   map->dso_id.ino, map->dso->name);
 	}
 
 	return printed;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 67e0f81416cb..4f50b1b2961f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -162,10 +162,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 
-		map->maj = d_maj;
-		map->min = d_min;
-		map->ino = ino;
-		map->ino_generation = ino_gen;
+		map->dso_id.maj = d_maj;
+		map->dso_id.min = d_min;
+		map->dso_id.ino = ino;
+		map->dso_id.ino_generation = ino_gen;
 		map->prot = prot;
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0a6c45f85cd9..70d87dcbe35d 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -18,6 +18,16 @@ struct map_groups;
 struct machine;
 struct evsel;
 
+/*
+ * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events
+ */
+struct dso_id {
+	u32	maj;
+	u32	min;
+	u64	ino;
+	u64	ino_generation;
+};
+
 struct map {
 	union {
 		struct rb_node	rb_node;
@@ -30,9 +40,6 @@ struct map {
 	u32			prot;
 	u64			pgoff;
 	u64			reloc;
-	u32			maj, min; /* only valid for MMAP2 record */
-	u64			ino;      /* only valid for MMAP2 record */
-	u64			ino_generation;/* only valid for MMAP2 record */
 
 	/* ip -> dso rip */
 	u64			(*map_ip)(struct map *, u64);
@@ -40,6 +47,7 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
+	struct dso_id		dso_id;
 	refcount_t		refcnt;
 	u32			flags;
 };
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6b626e6b111e..bc589438cd12 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1212,17 +1212,17 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->maj > r_map->maj) return -1;
-	if (l_map->maj < r_map->maj) return 1;
+	if (l_map->dso_id.maj > r_map->dso_id.maj) return -1;
+	if (l_map->dso_id.maj < r_map->dso_id.maj) return 1;
 
-	if (l_map->min > r_map->min) return -1;
-	if (l_map->min < r_map->min) return 1;
+	if (l_map->dso_id.min > r_map->dso_id.min) return -1;
+	if (l_map->dso_id.min < r_map->dso_id.min) return 1;
 
-	if (l_map->ino > r_map->ino) return -1;
-	if (l_map->ino < r_map->ino) return 1;
+	if (l_map->dso_id.ino > r_map->dso_id.ino) return -1;
+	if (l_map->dso_id.ino < r_map->dso_id.ino) return 1;
 
-	if (l_map->ino_generation > r_map->ino_generation) return -1;
-	if (l_map->ino_generation < r_map->ino_generation) return 1;
+	if (l_map->dso_id.ino_generation > r_map->dso_id.ino_generation) return -1;
+	if (l_map->dso_id.ino_generation < r_map->dso_id.ino_generation) return 1;
 
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
@@ -1234,8 +1234,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
 	    (!(l_map->flags & MAP_SHARED)) &&
-	    !l_map->maj && !l_map->min && !l_map->ino &&
-	    !l_map->ino_generation) {
+	    !l_map->dso_id.maj && !l_map->dso_id.min &&
+	    !l_map->dso_id.ino && !l_map->dso_id.ino_generation) {
 		/* userspace anonymous */
 
 		if (left->thread->pid_ > right->thread->pid_) return -1;
@@ -1271,8 +1271,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map->prot & PROT_EXEC) &&
 		    (map->flags & MAP_SHARED) &&
-		    (map->maj || map->min || map->ino ||
-		     map->ino_generation))
+		    (map->dso_id.maj || map->dso_id.min ||
+		     map->dso_id.ino || map->dso_id.ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
-- 
2.21.0
