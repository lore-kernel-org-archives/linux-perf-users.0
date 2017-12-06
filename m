From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/36] perf mmap: Don't discard prev in backward mode
Date: Wed,  6 Dec 2017 11:41:14 -0300
Message-ID: <20171206144115.15097-36-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Mengting Zhang <zhangmengting@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

'perf record' can switch its output data file. The new output should
only store the data after switching. However, in overwrite backward
mode, the new output still can have data from before switching. That
also brings extra overhead.

At the end of mmap_read(), the position of the processed ring buffer is
saved in md->prev. Next mmap_read should be end in md->prev if it is not
overwriten. That avoids processing duplicate data.  However, md->prev is
discarded. So next the mmap_read() has to process whole valid ring
buffer, which probably includes old processed data.

Avoid calling backward_rb_find_range() when md->prev is still
available.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Tested-by: Kan Liang <kan.liang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mengting Zhang <zhangmengting@huawei.com>
Link: http://lkml.kernel.org/r/20171204165107.95327-3-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 3f262e707a41..5f8cb1583e53 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -267,18 +267,6 @@ static int backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64
 	return -1;
 }
 
-static int rb_find_range(void *data, int mask, u64 head, u64 old,
-			 u64 *start, u64 *end, bool backward)
-{
-	if (!backward) {
-		*start = old;
-		*end = head;
-		return 0;
-	}
-
-	return backward_rb_find_range(data, mask, head, start, end);
-}
-
 int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size))
 {
@@ -290,19 +278,28 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 	void *buf;
 	int rc = 0;
 
-	if (rb_find_range(data, md->mask, head, old, &start, &end, backward))
-		return -1;
+	start = backward ? head : old;
+	end = backward ? old : head;
 
 	if (start == end)
 		return 0;
 
 	size = end - start;
 	if (size > (unsigned long)(md->mask) + 1) {
-		WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
+		if (!backward) {
+			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
-		md->prev = head;
-		perf_mmap__consume(md, backward);
-		return 0;
+			md->prev = head;
+			perf_mmap__consume(md, backward);
+			return 0;
+		}
+
+		/*
+		 * Backward ring buffer is full. We still have a chance to read
+		 * most of data from it.
+		 */
+		if (backward_rb_find_range(data, md->mask, head, &start, &end))
+			return -1;
 	}
 
 	if ((start & md->mask) + size != (end & md->mask)) {
-- 
2.13.6
