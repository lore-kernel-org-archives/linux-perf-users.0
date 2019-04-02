From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/44] tools lib traceevent: Implement a new API, tep_list_events_copy()
Date: Tue,  2 Apr 2019 13:05:18 -0300
Message-ID: <20190402160549.13544-14-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Existing API tep_list_events() is not thread safe, it uses the internal
array sort_events to keep cache of the sorted events and reuses it. This
patch implements a new API, tep_list_events_copy(), which allocates new
sorted array each time it is called. It could be used when a sorted
events functionality is needed in thread safe use cases. It is up to the
caller to free the array.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/linux-trace-devel/20181218133013.31094-1-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.117437443@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 109 +++++++++++++++++++++++------
 tools/lib/traceevent/event-parse.h |   5 +-
 2 files changed, 91 insertions(+), 23 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 666e23ded6ed..c00aebab3c33 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5651,32 +5651,26 @@ static int events_system_cmp(const void *a, const void *b)
 	return events_id_cmp(a, b);
 }
 
-struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sort_type sort_type)
+static struct tep_event **list_events_copy(struct tep_handle *tep)
 {
 	struct tep_event **events;
-	int (*sort)(const void *a, const void *b);
-
-	events = pevent->sort_events;
-
-	if (events && pevent->last_type == sort_type)
-		return events;
 
-	if (!events) {
-		events = malloc(sizeof(*events) * (pevent->nr_events + 1));
-		if (!events)
-			return NULL;
+	if (!tep)
+		return NULL;
 
-		memcpy(events, pevent->events, sizeof(*events) * pevent->nr_events);
-		events[pevent->nr_events] = NULL;
+	events = malloc(sizeof(*events) * (tep->nr_events + 1));
+	if (!events)
+		return NULL;
 
-		pevent->sort_events = events;
+	memcpy(events, tep->events, sizeof(*events) * tep->nr_events);
+	events[tep->nr_events] = NULL;
+	return events;
+}
 
-		/* the internal events are sorted by id */
-		if (sort_type == TEP_EVENT_SORT_ID) {
-			pevent->last_type = sort_type;
-			return events;
-		}
-	}
+static void list_events_sort(struct tep_event **events, int nr_events,
+			     enum tep_event_sort_type sort_type)
+{
+	int (*sort)(const void *a, const void *b);
 
 	switch (sort_type) {
 	case TEP_EVENT_SORT_ID:
@@ -5689,11 +5683,82 @@ struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sor
 		sort = events_system_cmp;
 		break;
 	default:
+		sort = NULL;
+	}
+
+	if (sort)
+		qsort(events, nr_events, sizeof(*events), sort);
+}
+
+/**
+ * tep_list_events - Get events, sorted by given criteria.
+ * @tep: a handle to the tep context
+ * @sort_type: desired sort order of the events in the array
+ *
+ * Returns an array of pointers to all events, sorted by the given
+ * @sort_type criteria. The last element of the array is NULL. The returned
+ * memory must not be freed, it is managed by the library.
+ * The function is not thread safe.
+ */
+struct tep_event **tep_list_events(struct tep_handle *tep,
+				   enum tep_event_sort_type sort_type)
+{
+	struct tep_event **events;
+
+	if (!tep)
+		return NULL;
+
+	events = tep->sort_events;
+	if (events && tep->last_type == sort_type)
 		return events;
+
+	if (!events) {
+		events = list_events_copy(tep);
+		if (!events)
+			return NULL;
+
+		tep->sort_events = events;
+
+		/* the internal events are sorted by id */
+		if (sort_type == TEP_EVENT_SORT_ID) {
+			tep->last_type = sort_type;
+			return events;
+		}
 	}
 
-	qsort(events, pevent->nr_events, sizeof(*events), sort);
-	pevent->last_type = sort_type;
+	list_events_sort(events, tep->nr_events, sort_type);
+	tep->last_type = sort_type;
+
+	return events;
+}
+
+
+/**
+ * tep_list_events_copy - Thread safe version of tep_list_events()
+ * @tep: a handle to the tep context
+ * @sort_type: desired sort order of the events in the array
+ *
+ * Returns an array of pointers to all events, sorted by the given
+ * @sort_type criteria. The last element of the array is NULL. The returned
+ * array is newly allocated inside the function and must be freed by the caller
+ */
+struct tep_event **tep_list_events_copy(struct tep_handle *tep,
+					enum tep_event_sort_type sort_type)
+{
+	struct tep_event **events;
+
+	if (!tep)
+		return NULL;
+
+	events = list_events_copy(tep);
+	if (!events)
+		return NULL;
+
+	/* the internal events are sorted by id */
+	if (sort_type == TEP_EVENT_SORT_ID)
+		return events;
+
+	list_events_sort(events, tep->nr_events, sort_type);
 
 	return events;
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index aec48f2aea8a..41159358abc2 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -544,7 +544,10 @@ void tep_event_info(struct trace_seq *s, struct tep_event *event,
 int tep_strerror(struct tep_handle *pevent, enum tep_errno errnum,
 		 char *buf, size_t buflen);
 
-struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sort_type);
+struct tep_event **tep_list_events(struct tep_handle *tep,
+				   enum tep_event_sort_type);
+struct tep_event **tep_list_events_copy(struct tep_handle *tep,
+					enum tep_event_sort_type);
 struct tep_format_field **tep_event_common_fields(struct tep_event *event);
 struct tep_format_field **tep_event_fields(struct tep_event *event);
 
-- 
2.20.1
