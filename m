From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/10] perf cpumap: Fix writing to illegal memory in handling cpumap mask
Date: Thu,  8 Aug 2019 15:53:53 -0300
Message-ID: <20190808185358.20125-6-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

cpu_map__snprint_mask() would write to illegal memory pointed by
zalloc(0) when there is only one cpu.

This patch fixes the calculation and adds sanity check against the input
parameters.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: 4400ac8a9a90 ("perf cpumap: Introduce cpu_map__snprint_mask()")
Link: http://lkml.kernel.org/r/1564734592-15624-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..39cce66b4ebc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -751,7 +751,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	int last_cpu = cpu_map__cpu(map, map->nr - 1);
 
-	bitmap = zalloc((last_cpu + 7) / 8);
+	if (buf == NULL)
+		return 0;
+
+	bitmap = zalloc(last_cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
-- 
2.21.0
