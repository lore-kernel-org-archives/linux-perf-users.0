From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/66] libperf: Add 'fd' to struct perf_mmap
Date: Wed, 25 Sep 2019 21:32:03 -0300
Message-ID: <20190926003244.13962-26-acme@kernel.org>
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

Move 'fd' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/evlist.c               | 4 ++--
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 1caa1e8ee5c6..892cbd401d8d 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -10,6 +10,7 @@
 struct perf_mmap {
 	void		*base;
 	int		 mask;
+	int		 fd;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f700dbe043b7..a4e1c19c969f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -652,7 +652,7 @@ static int perf_evlist__set_paused(struct evlist *evlist, bool value)
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		int fd = evlist->overwrite_mmap[i].fd;
+		int fd = evlist->overwrite_mmap[i].core.fd;
 		int err;
 
 		if (fd < 0)
@@ -708,7 +708,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 		return NULL;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		map[i].fd = -1;
+		map[i].core.fd = -1;
 		map[i].overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 702e8e0b90ea..40bf124cb658 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -320,7 +320,7 @@ void perf_mmap__munmap(struct mmap *map)
 	if (map->core.base != NULL) {
 		munmap(map->core.base, perf_mmap__mmap_len(map));
 		map->core.base = NULL;
-		map->fd = -1;
+		map->core.fd = -1;
 		refcount_set(&map->refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
@@ -378,7 +378,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		map->core.base = NULL;
 		return -1;
 	}
-	map->fd = fd;
+	map->core.fd = fd;
 	map->cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 370138e395fc..de991194af8d 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 fd;
 	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
-- 
2.21.0
