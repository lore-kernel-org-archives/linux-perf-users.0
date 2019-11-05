From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/3] perf tools: Remove unused trace_find_next_event()
Date: Tue,  5 Nov 2019 15:18:17 -0300
Message-ID: <20191105181818.26748-3-acme@kernel.org>
References: <20191105181818.26748-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105181818.26748-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, linux-trace-devel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

trace_find_next_event() was buggy and pretty much a useless helper. As
there are no more users, just remove it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/lkml/20191017210636.224045576@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-parse.c | 31 -----------------------------
 tools/perf/util/trace-event.h       |  2 --
 2 files changed, 33 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 5d6bfc70b210..9634f0ae57be 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -173,37 +173,6 @@ int parse_event_file(struct tep_handle *pevent,
 	return tep_parse_event(pevent, buf, size, sys);
 }
 
-struct tep_event *trace_find_next_event(struct tep_handle *pevent,
-					struct tep_event *event)
-{
-	static int idx;
-	int events_count;
-	struct tep_event *all_events;
-
-	all_events = tep_get_first_event(pevent);
-	events_count = tep_get_events_count(pevent);
-	if (!pevent || !all_events || events_count < 1)
-		return NULL;
-
-	if (!event) {
-		idx = 0;
-		return all_events;
-	}
-
-	if (idx < events_count && event == (all_events + idx)) {
-		idx++;
-		if (idx == events_count)
-			return NULL;
-		return (all_events + idx);
-	}
-
-	for (idx = 1; idx < events_count; idx++) {
-		if (event == (all_events + (idx - 1)))
-			return (all_events + idx);
-	}
-	return NULL;
-}
-
 struct flag {
 	const char *name;
 	unsigned long long value;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 2e158387b3d7..72fdf2a3577c 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -47,8 +47,6 @@ void parse_saved_cmdline(struct tep_handle *pevent, char *file, unsigned int siz
 
 ssize_t trace_report(int fd, struct trace_event *tevent, bool repipe);
 
-struct tep_event *trace_find_next_event(struct tep_handle *pevent,
-					struct tep_event *event);
 unsigned long long read_size(struct tep_event *event, void *ptr, int size);
 unsigned long long eval_flag(const char *flag);
 
-- 
2.21.0
