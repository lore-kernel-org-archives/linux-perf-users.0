From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/54] perf mmap: Use stored 'overwrite' in perf_mmap__consume()
Date: Thu,  8 Mar 2018 16:50:01 -0300
Message-ID: <20180308195029.14991-27-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The 'overwrite' is set at allocation. It will not be changed.  Using it
to replace the parameter of perf_mmap__consume().  The parameters will
be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2933942abfe2..8a2dac90056c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -118,9 +118,9 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite)
+void perf_mmap__consume(struct perf_mmap *map, bool overwrite __maybe_unused)
 {
-	if (!overwrite) {
+	if (!map->overwrite) {
 		u64 old = map->prev;
 
 		perf_mmap__write_tail(map, old);
-- 
2.14.3
