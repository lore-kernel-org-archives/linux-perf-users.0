From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/75] tools lib traceevent: Rename tep_free_format() to tep_free_event()
Date: Thu,  6 Dec 2018 18:25:18 -0300
Message-ID: <20181206212602.20474-32-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. This renames tep_free_format() to tep_free_event(), which
describes more closely the purpose of the function.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.591673556@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 6 +++---
 tools/lib/traceevent/event-parse.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 047be5f700b5..a3e7d0a75e11 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6154,7 +6154,7 @@ __parse_event(struct tep_handle *pevent,
 	return 0;
 
 event_add_failed:
-	tep_free_format(event);
+	tep_free_event(event);
 	return ret;
 }
 
@@ -6763,7 +6763,7 @@ static void free_formats(struct tep_format *format)
 	free_format_fields(format->fields);
 }
 
-void tep_free_format(struct tep_event *event)
+void tep_free_event(struct tep_event *event)
 {
 	free(event->name);
 	free(event->system);
@@ -6849,7 +6849,7 @@ void tep_free(struct tep_handle *pevent)
 	}
 
 	for (i = 0; i < pevent->nr_events; i++)
-		tep_free_format(pevent->events[i]);
+		tep_free_event(pevent->events[i]);
 
 	while (pevent->handlers) {
 		handle = pevent->handlers;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 2a1a644c5ec8..950ad185a5c4 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -475,7 +475,7 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				struct tep_event **eventp,
 				const char *buf,
 				unsigned long size, const char *sys);
-void tep_free_format(struct tep_event *event);
+void tep_free_event(struct tep_event *event);
 void tep_free_format_field(struct tep_format_field *field);
 
 void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
-- 
2.19.2
