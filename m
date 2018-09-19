From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/13] perf ordered_events: Prevent crossing max_alloc_size
Date: Wed, 19 Sep 2018 11:25:28 -0300
Message-ID: <20180919142537.29985-5-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Stephane reported a possible issue in the ordered events code, which
could lead to allocating more memory than guarded by max_alloc_size.

He also suggested the fix to properly check that the new size is below
the max_alloc_size limit.

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180907102455.7030-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 84ce25272c13..1904e7f6ec84 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -101,6 +101,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	struct list_head *cache = &oe->cache;
 	struct ordered_event *new = NULL;
 	union perf_event *new_event;
+	size_t size;
 
 	new_event = dup_event(oe, event);
 	if (!new_event)
@@ -133,6 +134,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	 * Removal of ordered event object moves it from events to
 	 * the cache list.
 	 */
+	size = sizeof(*oe->buffer) + MAX_SAMPLE_BUFFER * sizeof(*new);
+
 	if (!list_empty(cache)) {
 		new = list_entry(cache->next, struct ordered_event, list);
 		list_del(&new->list);
@@ -140,10 +143,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
 			oe->buffer = NULL;
-	} else if (oe->cur_alloc_size < oe->max_alloc_size) {
-		size_t size = sizeof(*oe->buffer) +
-			      MAX_SAMPLE_BUFFER * sizeof(*new);
-
+	} else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
 		oe->buffer = malloc(size);
 		if (!oe->buffer) {
 			free_dup_event(oe, new_event);
-- 
2.14.4
