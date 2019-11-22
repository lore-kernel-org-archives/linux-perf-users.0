From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/26] perf session: Fix decompression of PERF_RECORD_COMPRESSED records
Date: Fri, 22 Nov 2019 11:56:51 -0300
Message-ID: <20191122145711.3171-7-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Avoid termination of trace loading in case the last record in the
decompressed buffer partly resides in the following mmaped
PERF_RECORD_COMPRESSED record.

In this case NULL value returned by fetch_mmaped_event() means to
proceed to the next mmaped record then decompress it and load compressed
events.

The issue can be reproduced like this:

  $ perf record -z -- some_long_running_workload
  $ perf report --stdio -vv
  decomp (B): 44519 to 163000
  decomp (B): 48119 to 174800
  decomp (B): 65527 to 131072
  fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
  Error:
  failed to process sample
  ...

Testing:

  71: Zstd perf.data compression/decompression              : Ok

  $ tools/perf/perf report -vv --stdio
  decomp (B): 59593 to 262160
  decomp (B): 4438 to 16512
  decomp (B): 285 to 880
  Looking at the vmlinux_path (8 entries long)
  Using vmlinux for symbols
  decomp (B): 57474 to 261248
  prefetch_event: head=0x3fc78 event->header_size=0x28, mmap_size=0x3fc80: fuzzed or compressed perf.data?
  decomp (B): 25 to 32
  decomp (B): 52 to 120
  ...

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Link: https://marc.info/?l=linux-kernel&m=156580812427554&w=2
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..8454a650146b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1958,8 +1958,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 }
 
 static union perf_event *
-fetch_mmaped_event(struct perf_session *session,
-		   u64 head, size_t mmap_size, char *buf)
+prefetch_event(char *buf, u64 head, size_t mmap_size,
+	       bool needs_swap, union perf_event *error)
 {
 	union perf_event *event;
 
@@ -1971,20 +1971,32 @@ fetch_mmaped_event(struct perf_session *session,
 		return NULL;
 
 	event = (union perf_event *)(buf + head);
+	if (needs_swap)
+		perf_event_header__bswap(&event->header);
 
-	if (session->header.needs_swap)
+	if (head + event->header.size <= mmap_size)
+		return event;
+
+	/* We're not fetching the event so swap back again */
+	if (needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	if (head + event->header.size > mmap_size) {
-		/* We're not fetching the event so swap back again */
-		if (session->header.needs_swap)
-			perf_event_header__bswap(&event->header);
-		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
-			 __func__, head, event->header.size, mmap_size);
-		return ERR_PTR(-EINVAL);
-	}
+	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
+		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
 
-	return event;
+	return error;
+}
+
+static union perf_event *
+fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
+}
+
+static union perf_event *
+fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -1997,10 +2009,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
-
-		if (IS_ERR(event))
-			return PTR_ERR(event);
+		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
+							     session->header.needs_swap);
 
 		if (!event)
 			break;
@@ -2100,7 +2110,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	}
 
 more:
-	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-- 
2.21.0
