From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/28] perf session: Avoid infinite loop when seeing invalid header.size
Date: Wed, 14 Aug 2019 15:40:24 -0300
Message-ID: <20190814184051.3125-2-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Vince Weaver <vincent.weaver@maine.edu>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Vince reported that when fuzzing the userland perf tool with a bogus
perf.data file he got into a infinite loop in 'perf report'.

Changing the return of fetch_mmaped_event() to ERR_PTR(-EINVAL) for that
case gets us out of that infinite loop.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726211415.GE24867@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 11e6093c941b..b9fe71d11bf6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <traceevent/event-parse.h>
@@ -1955,7 +1956,9 @@ fetch_mmaped_event(struct perf_session *session,
 		/* We're not fetching the event so swap back again */
 		if (session->header.needs_swap)
 			perf_event_header__bswap(&event->header);
-		return NULL;
+		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
+			 __func__, head, event->header.size, mmap_size);
+		return ERR_PTR(-EINVAL);
 	}
 
 	return event;
@@ -1973,6 +1976,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	while (decomp->head < decomp->size && !session_done()) {
 		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
 
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+
 		if (!event)
 			break;
 
@@ -2072,6 +2078,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 more:
 	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
 	if (!event) {
 		if (mmaps[map_idx]) {
 			munmap(mmaps[map_idx], mmap_size);
-- 
2.21.0
