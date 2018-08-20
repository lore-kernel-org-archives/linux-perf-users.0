From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/21] perf mmap: Store real cpu number in 'struct perf_mmap'
Date: Mon, 20 Aug 2018 13:15:59 -0300
Message-ID: <20180820161602.6830-19-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>, Joe Mario <jmario@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Store the real cpu number in 'struct perf_mmap', which will be used by
python interface that allows user to read a particular memory map for
given cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817114556.28000-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/mmap.c   | 3 ++-
 tools/perf/util/mmap.h   | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..be440df29615 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -803,7 +803,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (*output == -1) {
 			*output = fd;
 
-			if (perf_mmap__mmap(&maps[idx], mp, *output)  < 0)
+			if (perf_mmap__mmap(&maps[idx], mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..215f69f41672 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -164,7 +164,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -191,6 +191,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		return -1;
 	}
 	map->fd = fd;
+	map->cpu = cpu;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..05a6d47c7956 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -18,6 +18,7 @@ struct perf_mmap {
 	void		 *base;
 	int		 mask;
 	int		 fd;
+	int		 cpu;
 	refcount_t	 refcnt;
 	u64		 prev;
 	u64		 start;
@@ -60,7 +61,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd);
+int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 
 void perf_mmap__get(struct perf_mmap *map);
-- 
2.14.4
