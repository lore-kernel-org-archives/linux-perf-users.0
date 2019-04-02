From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/44] tools lib traceevent: Remove tep filter trivial APIs
Date: Tue,  2 Apr 2019 13:05:24 -0300
Message-ID: <20190402160549.13544-20-acme@kernel.org>
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

This patch removes trivial filter tep APIs:

  enum tep_filter_trivial_type
  tep_filter_event_has_trivial()
  tep_update_trivial()
  tep_filter_clear_trivial()

Trivial filters is an optimization, used only in the first version of
KernelShark. The API is deprecated, the next KernelShark release does
not use it.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190326154328.28718-4-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.968458918@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  |  16 ---
 tools/lib/traceevent/parse-filter.c | 169 ----------------------------
 2 files changed, 185 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index be082f9692f1..3833d1384599 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -732,12 +732,6 @@ struct tep_event_filter *tep_filter_alloc(struct tep_handle *pevent);
 #define FILTER_MISS		TEP_ERRNO__FILTER_MISS
 #define FILTER_MATCH		TEP_ERRNO__FILTER_MATCH
 
-enum tep_filter_trivial_type {
-	TEP_FILTER_TRIVIAL_FALSE,
-	TEP_FILTER_TRIVIAL_TRUE,
-	TEP_FILTER_TRIVIAL_BOTH,
-};
-
 enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 					 const char *filter_str);
 
@@ -752,9 +746,6 @@ int tep_event_filtered(struct tep_event_filter *filter,
 
 void tep_filter_reset(struct tep_event_filter *filter);
 
-int tep_filter_clear_trivial(struct tep_event_filter *filter,
-			     enum tep_filter_trivial_type type);
-
 void tep_filter_free(struct tep_event_filter *filter);
 
 char *tep_filter_make_string(struct tep_event_filter *filter, int event_id);
@@ -762,15 +753,8 @@ char *tep_filter_make_string(struct tep_event_filter *filter, int event_id);
 int tep_filter_remove_event(struct tep_event_filter *filter,
 			    int event_id);
 
-int tep_filter_event_has_trivial(struct tep_event_filter *filter,
-				 int event_id,
-				 enum tep_filter_trivial_type type);
-
 int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *source);
 
-int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
-			enum tep_filter_trivial_type type);
-
 int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter *filter2);
 
 #endif /* _PARSE_EVENTS_H */
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index cb5ce66dab6e..4ffd8b25a852 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1522,167 +1522,6 @@ int tep_filter_copy(struct tep_event_filter *dest, struct tep_event_filter *sour
 	return ret;
 }
 
-
-/**
- * tep_update_trivial - update the trivial filters with the given filter
- * @dest - the filter to update
- * @source - the filter as the source of the update
- * @type - the type of trivial filter to update.
- *
- * Scan dest for trivial events matching @type to replace with the source.
- *
- * Returns 0 on success and -1 if there was a problem updating, but
- *   events may have still been updated on error.
- */
-int tep_update_trivial(struct tep_event_filter *dest, struct tep_event_filter *source,
-		       enum tep_filter_trivial_type type)
-{
-	struct tep_handle *src_pevent;
-	struct tep_handle *dest_pevent;
-	struct tep_event *event;
-	struct tep_filter_type *filter_type;
-	struct tep_filter_arg *arg;
-	char *str;
-	int i;
-
-	src_pevent = source->pevent;
-	dest_pevent = dest->pevent;
-
-	/* Do nothing if either of the filters has nothing to filter */
-	if (!dest->filters || !source->filters)
-		return 0;
-
-	for (i = 0; i < dest->filters; i++) {
-		filter_type = &dest->event_filters[i];
-		arg = filter_type->filter;
-		if (arg->type != TEP_FILTER_ARG_BOOLEAN)
-			continue;
-		if ((arg->boolean.value && type == TEP_FILTER_TRIVIAL_FALSE) ||
-		    (!arg->boolean.value && type == TEP_FILTER_TRIVIAL_TRUE))
-			continue;
-
-		event = filter_type->event;
-
-		if (src_pevent != dest_pevent) {
-			/* do a look up */
-			event = tep_find_event_by_name(src_pevent,
-						       event->system,
-						       event->name);
-			if (!event)
-				return -1;
-		}
-
-		str = tep_filter_make_string(source, event->id);
-		if (!str)
-			continue;
-
-		/* Don't bother if the filter is trivial too */
-		if (strcmp(str, "TRUE") != 0 && strcmp(str, "FALSE") != 0)
-			filter_event(dest, event, str, NULL);
-		free(str);
-	}
-	return 0;
-}
-
-/**
- * tep_filter_clear_trivial - clear TRUE and FALSE filters
- * @filter: the filter to remove trivial filters from
- * @type: remove only true, false, or both
- *
- * Removes filters that only contain a TRUE or FALES boolean arg.
- *
- * Returns 0 on success and -1 if there was a problem.
- */
-int tep_filter_clear_trivial(struct tep_event_filter *filter,
-			     enum tep_filter_trivial_type type)
-{
-	struct tep_filter_type *filter_type;
-	int count = 0;
-	int *ids = NULL;
-	int i;
-
-	if (!filter->filters)
-		return 0;
-
-	/*
-	 * Two steps, first get all ids with trivial filters.
-	 *  then remove those ids.
-	 */
-	for (i = 0; i < filter->filters; i++) {
-		int *new_ids;
-
-		filter_type = &filter->event_filters[i];
-		if (filter_type->filter->type != TEP_FILTER_ARG_BOOLEAN)
-			continue;
-		switch (type) {
-		case TEP_FILTER_TRIVIAL_FALSE:
-			if (filter_type->filter->boolean.value)
-				continue;
-			break;
-		case TEP_FILTER_TRIVIAL_TRUE:
-			if (!filter_type->filter->boolean.value)
-				continue;
-		default:
-			break;
-		}
-
-		new_ids = realloc(ids, sizeof(*ids) * (count + 1));
-		if (!new_ids) {
-			free(ids);
-			return -1;
-		}
-
-		ids = new_ids;
-		ids[count++] = filter_type->event_id;
-	}
-
-	if (!count)
-		return 0;
-
-	for (i = 0; i < count; i++)
-		tep_filter_remove_event(filter, ids[i]);
-
-	free(ids);
-	return 0;
-}
-
-/**
- * tep_filter_event_has_trivial - return true event contains trivial filter
- * @filter: the filter with the information
- * @event_id: the id of the event to test
- * @type: trivial type to test for (TRUE, FALSE, EITHER)
- *
- * Returns 1 if the event contains a matching trivial type
- *  otherwise 0.
- */
-int tep_filter_event_has_trivial(struct tep_event_filter *filter,
-				 int event_id,
-				 enum tep_filter_trivial_type type)
-{
-	struct tep_filter_type *filter_type;
-
-	if (!filter->filters)
-		return 0;
-
-	filter_type = find_filter_type(filter, event_id);
-
-	if (!filter_type)
-		return 0;
-
-	if (filter_type->filter->type != TEP_FILTER_ARG_BOOLEAN)
-		return 0;
-
-	switch (type) {
-	case TEP_FILTER_TRIVIAL_FALSE:
-		return !filter_type->filter->boolean.value;
-
-	case TEP_FILTER_TRIVIAL_TRUE:
-		return filter_type->filter->boolean.value;
-	default:
-		return 1;
-	}
-}
-
 static int test_filter(struct tep_event *event, struct tep_filter_arg *arg,
 		       struct tep_record *record, enum tep_errno *err);
 
@@ -2409,14 +2248,6 @@ int tep_filter_compare(struct tep_event_filter *filter1, struct tep_event_filter
 			break;
 		if (filter_type1->filter->type != filter_type2->filter->type)
 			break;
-		switch (filter_type1->filter->type) {
-		case TEP_FILTER_TRIVIAL_FALSE:
-		case TEP_FILTER_TRIVIAL_TRUE:
-			/* trivial types just need the type compared */
-			continue;
-		default:
-			break;
-		}
 		/* The best way to compare complex filters is with strings */
 		str1 = arg_to_str(filter1, filter_type1->filter);
 		str2 = arg_to_str(filter2, filter_type2->filter);
-- 
2.20.1
