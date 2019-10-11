From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/69] libperf: Adopt perf_mmap__mmap_len() function from tools/perf
Date: Fri, 11 Oct 2019 17:05:34 -0300
Message-ID: <20191011200559.7156-45-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move perf_mmap__mmap_len() from tools/perf wto libperf, it will be used
in the following patches. And rename the existing perf's function to
mmap__mmap_len().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c            |  4 ++--
 tools/perf/lib/include/internal/mmap.h |  2 ++
 tools/perf/lib/mmap.c                  |  6 ++++++
 tools/perf/util/mmap.c                 | 20 ++++++++++----------
 tools/perf/util/mmap.h                 |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 23332861de6e..f05e8b7955e4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -276,7 +276,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 
 	if (record__comp_enabled(aio->rec)) {
 		size = zstd_compress(aio->rec->session, aio->data + aio->size,
-				     perf_mmap__mmap_len(map) - aio->size,
+				     mmap__mmap_len(map) - aio->size,
 				     buf, size);
 	} else {
 		memcpy(aio->data + aio->size, buf, size);
@@ -488,7 +488,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, perf_mmap__mmap_len(map), bf, size);
+		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
 	}
 
diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index b26806b36bb6..e7a67260940c 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -34,6 +34,8 @@ struct perf_mmap_param {
 	int	mask;
 };
 
+size_t perf_mmap__mmap_len(struct perf_mmap *map);
+
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 3da6177510e6..cc4284da4d99 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <internal/mmap.h>
+#include <internal/lib.h>
 
 void perf_mmap__init(struct perf_mmap *map, bool overwrite)
 {
@@ -7,3 +8,8 @@ void perf_mmap__init(struct perf_mmap *map, bool overwrite)
 	map->overwrite = overwrite;
 	refcount_set(&map->refcnt, 0);
 }
+
+size_t perf_mmap__mmap_len(struct perf_mmap *map)
+{
+	return map->mask + 1 + page_size;
+}
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a496ced5ed2a..a8e81c4cbae8 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,9 +23,9 @@
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
 
-size_t perf_mmap__mmap_len(struct mmap *map)
+size_t mmap__mmap_len(struct mmap *map)
 {
-	return map->core.mask + 1 + page_size;
+	return perf_mmap__mmap_len(&map->core);
 }
 
 /* When check_messup is true, 'end' must points to a good entry */
@@ -170,7 +170,7 @@ static int perf_mmap__aio_enabled(struct mmap *map)
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+	map->aio.data[idx] = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 	if (map->aio.data[idx] == MAP_FAILED) {
 		map->aio.data[idx] = NULL;
@@ -183,7 +183,7 @@ static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 static void perf_mmap__aio_free(struct mmap *map, int idx)
 {
 	if (map->aio.data[idx]) {
-		munmap(map->aio.data[idx], perf_mmap__mmap_len(map));
+		munmap(map->aio.data[idx], mmap__mmap_len(map));
 		map->aio.data[idx] = NULL;
 	}
 }
@@ -196,7 +196,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
 		data = map->aio.data[idx];
-		mmap_len = perf_mmap__mmap_len(map);
+		mmap_len = mmap__mmap_len(map);
 		node_mask = 1UL << cpu__get_node(cpu);
 		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
 			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
@@ -210,7 +210,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 #else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
 {
-	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
+	map->aio.data[idx] = malloc(mmap__mmap_len(map));
 	if (map->aio.data[idx] == NULL)
 		return -1;
 
@@ -315,11 +315,11 @@ void perf_mmap__munmap(struct mmap *map)
 {
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
-		munmap(map->data, perf_mmap__mmap_len(map));
+		munmap(map->data, mmap__mmap_len(map));
 		map->data = NULL;
 	}
 	if (map->core.base != NULL) {
-		munmap(map->core.base, perf_mmap__mmap_len(map));
+		munmap(map->core.base, mmap__mmap_len(map));
 		map->core.base = NULL;
 		map->core.fd = -1;
 		refcount_set(&map->core.refcnt, 0);
@@ -371,7 +371,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
 	map->core.mask = mp->core.mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
+	map->core.base = mmap(NULL, mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
@@ -389,7 +389,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	map->comp_level = mp->comp_level;
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
-		map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
 				 MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (map->data == MAP_FAILED) {
 			pr_debug2("failed to mmap data buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 4ff75d8aeb05..2b97dc6d9ee2 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -67,7 +67,7 @@ union perf_event *perf_mmap__read_event(struct mmap *map);
 int perf_mmap__push(struct mmap *md, void *to,
 		    int push(struct mmap *map, void *to, void *buf, size_t size));
 
-size_t perf_mmap__mmap_len(struct mmap *map);
+size_t mmap__mmap_len(struct mmap *map);
 
 int perf_mmap__read_init(struct mmap *md);
 void perf_mmap__read_done(struct mmap *map);
-- 
2.21.0
