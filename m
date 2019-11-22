From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/26] perf map: Move comparision of map's dso_id to a separate function
Date: Fri, 22 Nov 2019 11:56:48 -0300
Message-ID: <20191122145711.3171-4-acme@kernel.org>
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

We'll use it when doing DSO lookups using dso_ids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u2nr1oq03o0i29w2ay9jx03s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 25 +++++++++++++++++++++++++
 tools/perf/util/map.h  |  2 ++
 tools/perf/util/sort.c | 16 ++++------------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 3ea80d203587..ecf8d7346685 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,6 +2,7 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
+#include "map.h"
 #include "vdso.h"
 #include "namespaces.h"
 #include <libgen.h>
@@ -9,6 +10,30 @@
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (a == NULL)
+		return 0;
+
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	if (a->ino_generation > b->ino_generation) return -1;
+	if (a->ino_generation < b->ino_generation) return 1;
+
+	return 0;
+}
+
 bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 {
 	bool have_build_id = false;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f962eb9035c7..e1e573a28a55 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -28,6 +28,8 @@ struct dso_id {
 	u64	ino_generation;
 };
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+
 struct map {
 	union {
 		struct rb_node	rb_node;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index bc589438cd12..f1481002fafb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1194,6 +1194,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	u64 l, r;
 	struct map *l_map, *r_map;
+	int rc;
 
 	if (!left->mem_info)  return -1;
 	if (!right->mem_info) return 1;
@@ -1212,18 +1213,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	if (l_map->dso_id.maj > r_map->dso_id.maj) return -1;
-	if (l_map->dso_id.maj < r_map->dso_id.maj) return 1;
-
-	if (l_map->dso_id.min > r_map->dso_id.min) return -1;
-	if (l_map->dso_id.min < r_map->dso_id.min) return 1;
-
-	if (l_map->dso_id.ino > r_map->dso_id.ino) return -1;
-	if (l_map->dso_id.ino < r_map->dso_id.ino) return 1;
-
-	if (l_map->dso_id.ino_generation > r_map->dso_id.ino_generation) return -1;
-	if (l_map->dso_id.ino_generation < r_map->dso_id.ino_generation) return 1;
-
+	rc = dso_id__cmp(&l_map->dso_id, &r_map->dso_id);
+	if (rc)
+		return rc;
 	/*
 	 * Addresses with no major/minor numbers are assumed to be
 	 * anonymous in userspace.  Sort those on pid then address.
-- 
2.21.0
