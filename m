From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/69] perf evlist: Introduce perf_evlist__mmap_cb_mmap()
Date: Fri, 11 Oct 2019 17:05:51 -0300
Message-ID: <20191011200559.7156-62-acme@kernel.org>
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

Add the perf_evlist__mmap_cb_mmap() function to call perf specific
mmap__mmap() function during perf_evlist__mmap_ops() call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f50ee5cb6554..d57b684b4b7b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -773,6 +773,16 @@ perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 	return &maps[idx].core;
 }
 
+static int
+perf_evlist__mmap_cb_mmap(struct perf_mmap *_map, struct perf_mmap_param *_mp,
+			  int output, int cpu)
+{
+	struct mmap *map = container_of(_map, struct mmap, core);
+	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+
+	return mmap__mmap(map, mp, output, cpu);
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -970,8 +980,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.comp_level	= comp_level
 	};
 	struct perf_evlist_mmap_ops ops __maybe_unused = {
-		.idx = perf_evlist__mmap_cb_idx,
-		.get = perf_evlist__mmap_cb_get,
+		.idx  = perf_evlist__mmap_cb_idx,
+		.get  = perf_evlist__mmap_cb_get,
+		.mmap = perf_evlist__mmap_cb_mmap,
 	};
 
 	if (!evlist->mmap)
-- 
2.21.0
