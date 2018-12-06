From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 69/75] perf record: Fix memory leak on AIO objects deallocation
Date: Thu,  6 Dec 2018 18:25:56 -0300
Message-ID: <20181206212602.20474-70-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Sending a part which was missed between v12 and v13 of the patch set
introducing AIO trace streaming for perf record mode.

The part is essential to avoid memory leakage during deallocation of AIO
related trace data buffers.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com
[ No need to test for NULL before calling zfree() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab30555d2afc..8fc39311a30d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -207,8 +207,14 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 
 static void perf_mmap__aio_munmap(struct perf_mmap *map)
 {
+	int i;
+
+	for (i = 0; i < map->aio.nr_cblocks; ++i)
+		zfree(&map->aio.data[i]);
 	if (map->aio.data)
 		zfree(&map->aio.data);
+	zfree(&map->aio.cblocks);
+	zfree(&map->aio.aiocb);
 }
 
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-- 
2.19.2
