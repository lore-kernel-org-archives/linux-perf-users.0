From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/54] perf mmap: Use the stored data in perf_mmap__read_event()
Date: Thu,  8 Mar 2018 16:50:00 -0300
Message-ID: <20180308195029.14991-26-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Using the 'start', 'end' and 'overwrite' which are stored in
struct perf_mmap to replace the parameters of perf_mmap__read_event().
The parameters will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8c1d033638c2..2933942abfe2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -76,8 +76,9 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * perf_mmap__read_done()
  */
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end)
+					bool overwrite __maybe_unused,
+					u64 *startp __maybe_unused,
+					u64 end __maybe_unused)
 {
 	union perf_event *event;
 
@@ -87,17 +88,14 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	if (startp == NULL)
-		return NULL;
-
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!overwrite)
-		end = perf_mmap__read_head(map);
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
 
-	event = perf_mmap__read(map, startp, end);
+	event = perf_mmap__read(map, &map->start, map->end);
 
-	if (!overwrite)
-		map->prev = *startp;
+	if (!map->overwrite)
+		map->prev = map->start;
 
 	return event;
 }
-- 
2.14.3
