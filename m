From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/24] perf mmap: Adopt push method from builtin-record.c
Date: Mon, 23 Oct 2017 20:47:25 -0300
Message-ID: <20171023234736.5335-14-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbdJWXs2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 19:48:28 -0400
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The previous prep patch was just to show exactly what changed in that
function, now its time to move that method and things only it uses to
the right place, mmap.[ch]

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-aaxywfgw3d44x6xlu8zm1avu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 100 --------------------------------------------
 tools/perf/util/mmap.c      | 100 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mmap.h      |   3 ++
 3 files changed, 103 insertions(+), 100 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 47a761133aed..a6cbf1640269 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -129,53 +129,6 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, event, event->header.size);
 }
 
-static int
-backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
-{
-	struct perf_event_header *pheader;
-	u64 evt_head = head;
-	int size = mask + 1;
-
-	pr_debug2("backward_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
-	pheader = (struct perf_event_header *)(buf + (head & mask));
-	*start = head;
-	while (true) {
-		if (evt_head - head >= (unsigned int)size) {
-			pr_debug("Finished reading backward ring buffer: rewind\n");
-			if (evt_head - head > (unsigned int)size)
-				evt_head -= pheader->size;
-			*end = evt_head;
-			return 0;
-		}
-
-		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
-
-		if (pheader->size == 0) {
-			pr_debug("Finished reading backward ring buffer: get start\n");
-			*end = evt_head;
-			return 0;
-		}
-
-		evt_head += pheader->size;
-		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
-	}
-	WARN_ONCE(1, "Shouldn't get here\n");
-	return -1;
-}
-
-static int
-rb_find_range(void *data, int mask, u64 head, u64 old,
-	      u64 *start, u64 *end, bool backward)
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
 static int record__pushfn(void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
@@ -184,59 +137,6 @@ static int record__pushfn(void *to, void *bf, size_t size)
 	return record__write(rec, bf, size);
 }
 
-static int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
-			   void *to, int push(void *to, void *buf, size_t size))
-{
-	u64 head = perf_mmap__read_head(md);
-	u64 old = md->prev;
-	u64 end = head, start = old;
-	unsigned char *data = md->base + page_size;
-	unsigned long size;
-	void *buf;
-	int rc = 0;
-
-	if (rb_find_range(data, md->mask, head,
-			  old, &start, &end, backward))
-		return -1;
-
-	if (start == end)
-		return 0;
-
-	size = end - start;
-	if (size > (unsigned long)(md->mask) + 1) {
-		WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
-
-		md->prev = head;
-		perf_mmap__consume(md, overwrite || backward);
-		return 0;
-	}
-
-	if ((start & md->mask) + size != (end & md->mask)) {
-		buf = &data[start & md->mask];
-		size = md->mask + 1 - (start & md->mask);
-		start += size;
-
-		if (push(to, buf, size) < 0) {
-			rc = -1;
-			goto out;
-		}
-	}
-
-	buf = &data[start & md->mask];
-	size = end - start;
-	start += size;
-
-	if (push(to, buf, size) < 0) {
-		rc = -1;
-		goto out;
-	}
-
-	md->prev = head;
-	perf_mmap__consume(md, overwrite || backward);
-out:
-	return rc;
-}
-
 static volatile int done;
 static volatile int signr = -1;
 static volatile int child_finished;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index dfc4a007f2c6..9fe5f9c7d577 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -8,6 +8,9 @@
  */
 
 #include <sys/mman.h>
+#include <inttypes.h>
+#include <asm/bug.h>
+#include "debug.h"
 #include "event.h"
 #include "mmap.h"
 #include "util.h" /* page_size */
@@ -250,3 +253,100 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 
 	return 0;
 }
+
+static int backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
+{
+	struct perf_event_header *pheader;
+	u64 evt_head = head;
+	int size = mask + 1;
+
+	pr_debug2("backward_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
+	pheader = (struct perf_event_header *)(buf + (head & mask));
+	*start = head;
+	while (true) {
+		if (evt_head - head >= (unsigned int)size) {
+			pr_debug("Finished reading backward ring buffer: rewind\n");
+			if (evt_head - head > (unsigned int)size)
+				evt_head -= pheader->size;
+			*end = evt_head;
+			return 0;
+		}
+
+		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
+
+		if (pheader->size == 0) {
+			pr_debug("Finished reading backward ring buffer: get start\n");
+			*end = evt_head;
+			return 0;
+		}
+
+		evt_head += pheader->size;
+		pr_debug3("move evt_head: %"PRIx64"\n", evt_head);
+	}
+	WARN_ONCE(1, "Shouldn't get here\n");
+	return -1;
+}
+
+static int rb_find_range(void *data, int mask, u64 head, u64 old,
+			 u64 *start, u64 *end, bool backward)
+{
+	if (!backward) {
+		*start = old;
+		*end = head;
+		return 0;
+	}
+
+	return backward_rb_find_range(data, mask, head, start, end);
+}
+
+int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
+		    void *to, int push(void *to, void *buf, size_t size))
+{
+	u64 head = perf_mmap__read_head(md);
+	u64 old = md->prev;
+	u64 end = head, start = old;
+	unsigned char *data = md->base + page_size;
+	unsigned long size;
+	void *buf;
+	int rc = 0;
+
+	if (rb_find_range(data, md->mask, head, old, &start, &end, backward))
+		return -1;
+
+	if (start == end)
+		return 0;
+
+	size = end - start;
+	if (size > (unsigned long)(md->mask) + 1) {
+		WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
+
+		md->prev = head;
+		perf_mmap__consume(md, overwrite || backward);
+		return 0;
+	}
+
+	if ((start & md->mask) + size != (end & md->mask)) {
+		buf = &data[start & md->mask];
+		size = md->mask + 1 - (start & md->mask);
+		start += size;
+
+		if (push(to, buf, size) < 0) {
+			rc = -1;
+			goto out;
+		}
+	}
+
+	buf = &data[start & md->mask];
+	size = end - start;
+	start += size;
+
+	if (push(to, buf, size) < 0) {
+		rc = -1;
+		goto out;
+	}
+
+	md->prev = head;
+	perf_mmap__consume(md, overwrite || backward);
+out:
+	return rc;
+}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index f37ff45c8ec1..efd78b827b05 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -89,6 +89,9 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map, bool check_messup);
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
+int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
+		    void *to, int push(void *to, void *buf, size_t size));
+
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
 #endif /*__PERF_MMAP_H */
-- 
2.13.6
