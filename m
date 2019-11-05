From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/3] perf scripting engines: Iterate on tep event arrays directly
Date: Tue,  5 Nov 2019 15:18:16 -0300
Message-ID: <20191105181818.26748-2-acme@kernel.org>
References: <20191105181818.26748-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105181818.26748-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, linux-trace-devel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of calling a useless (and broken) helper function to get the
next event of a tep event array, just get the array directly and iterate
over it.

Note, the broken part was from trace_find_next_event() which after this
will no longer be used, and can be removed.

Committer notes:

This fixes a segfault when generating python scripts from perf.data
files with multiple tracepoint events, i.e. the following use case is
fixed by this patch:

  # perf record -e sched:* sleep 1
  [ perf record: Woken up 31 times to write data ]
  [ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]
  # perf script -g python
  Segmentation fault (core dumped)
  #

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20191017153733.630cd5eb@gandalf.local.home
Link: http://lore.kernel.org/lkml/20191017210636.061448713@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-perl.c   | 8 ++++++--
 tools/perf/util/scripting-engines/trace-event-python.c | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 15961854ba67..741f040648b5 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -539,10 +539,11 @@ static int perl_stop_script(void)
 
 static int perl_generate_script(struct tep_handle *pevent, const char *outfile)
 {
+	int i, not_first, count, nr_events;
+	struct tep_event **all_events;
 	struct tep_event *event = NULL;
 	struct tep_format_field *f;
 	char fname[PATH_MAX];
-	int not_first, count;
 	FILE *ofp;
 
 	sprintf(fname, "%s.pl", outfile);
@@ -603,8 +604,11 @@ sub print_backtrace\n\
 }\n\n\
 ");
 
+	nr_events = tep_get_events_count(pevent);
+	all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
 
-	while ((event = trace_find_next_event(pevent, event))) {
+	for (i = 0; all_events && i < nr_events; i++) {
+		event = all_events[i];
 		fprintf(ofp, "sub %s::%s\n{\n", event->system, event->name);
 		fprintf(ofp, "\tmy (");
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 5d341efc3237..93c03b39cd9c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1687,10 +1687,11 @@ static int python_stop_script(void)
 
 static int python_generate_script(struct tep_handle *pevent, const char *outfile)
 {
+	int i, not_first, count, nr_events;
+	struct tep_event **all_events;
 	struct tep_event *event = NULL;
 	struct tep_format_field *f;
 	char fname[PATH_MAX];
-	int not_first, count;
 	FILE *ofp;
 
 	sprintf(fname, "%s.py", outfile);
@@ -1735,7 +1736,11 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
 	fprintf(ofp, "def trace_end():\n");
 	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
 
-	while ((event = trace_find_next_event(pevent, event))) {
+	nr_events = tep_get_events_count(pevent);
+	all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
+
+	for (i = 0; all_events && i < nr_events; i++) {
+		event = all_events[i];
 		fprintf(ofp, "def %s__%s(", event->system, event->name);
 		fprintf(ofp, "event_name, ");
 		fprintf(ofp, "context, ");
-- 
2.21.0
