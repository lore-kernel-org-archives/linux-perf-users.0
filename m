From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/66] libperf: Add 'cpu' to struct perf_mmap
Date: Wed, 25 Sep 2019 21:32:04 -0300
Message-ID: <20190926003244.13962-27-acme@kernel.org>
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

Move 'cpu' from tools/perf's mmap to libperf's perf_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 1 +
 tools/perf/util/mmap.c                 | 8 ++++----
 tools/perf/util/mmap.h                 | 1 -
 tools/perf/util/python.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 892cbd401d8d..f7d1809fa34c 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -11,6 +11,7 @@ struct perf_mmap {
 	void		*base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 40bf124cb658..dc8320891344 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -256,7 +256,7 @@ static int perf_mmap__aio_mmap(struct mmap *map, struct mmap_params *mp)
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
-			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
+			ret = perf_mmap__aio_bind(map, i, map->core.cpu, mp->affinity);
 			if (ret == -1)
 				return -1;
 			/*
@@ -347,9 +347,9 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params
 {
 	CPU_ZERO(&map->affinity_mask);
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
-		build_node_mask(cpu__get_node(map->cpu), &map->affinity_mask);
+		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		CPU_SET(map->cpu, &map->affinity_mask);
+		CPU_SET(map->core.cpu, &map->affinity_mask);
 }
 
 int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
@@ -379,7 +379,7 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		return -1;
 	}
 	map->core.fd = fd;
-	map->cpu = cpu;
+	map->core.cpu = cpu;
 
 	perf_mmap__setup_affinity_mask(map, mp);
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index de991194af8d..8ab779c98f4d 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -22,7 +22,6 @@ struct aiocb;
  */
 struct mmap {
 	struct perf_mmap	core;
-	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 60a6b6e8e176..ba4085d7ae9f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -991,7 +991,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
-		if (md->cpu == cpu)
+		if (md->core.cpu == cpu)
 			return md;
 	}
 
-- 
2.21.0
