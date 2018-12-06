From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 73/75] perf trace: Move event delivery to a new deliver_event() function
Date: Thu,  6 Dec 2018 18:26:00 -0300
Message-ID: <20181206212602.20474-74-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dmitry Levin <ldv@altlinux.org>, Eugene Syromiatnikov <esyr@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Mov event delivery code to a new trace__deliver_event() function, so
it's easier to add ordered delivery coming in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-8-jolsa@kernel.org
[ Add trace__ prefix to the deliver_event method ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 98aff12af9e6..3b6b1fecf2bb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2637,6 +2637,21 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
+static int trace__deliver_event(struct trace *trace, union perf_event *event)
+{
+	struct perf_evlist *evlist = trace->evlist;
+	struct perf_sample sample;
+	int err;
+
+	err = perf_evlist__parse_sample(evlist, event, &sample);
+	if (err)
+		fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
+	else
+		trace__handle_event(trace, event, &sample);
+
+	return 0;
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct perf_evlist *evlist = trace->evlist;
@@ -2802,18 +2817,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
-			struct perf_sample sample;
-
 			++trace->nr_events;
 
-			err = perf_evlist__parse_sample(evlist, event, &sample);
-			if (err) {
-				fprintf(trace->output, "Can't parse sample, err = %d, skipping...\n", err);
-				goto next_event;
-			}
+			trace__deliver_event(trace, event);
 
-			trace__handle_event(trace, event, &sample);
-next_event:
 			perf_mmap__consume(md);
 
 			if (interrupted)
-- 
2.19.2
