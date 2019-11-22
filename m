From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/26] perf inject: Cut AUX area samples
Date: Fri, 22 Nov 2019 11:57:00 -0300
Message-ID: <20191122145711.3171-16-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

After decoding AUX area samples, the AUX area data is no longer needed
(having been replaced by synthesized events) so cut it out.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1e5d28311e14..9664a72a089d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -45,6 +45,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
+	char			event_copy[PERF_SAMPLE_MAX_SIZE];
 };
 
 struct event_entry {
@@ -214,6 +215,28 @@ static int perf_event__drop_aux(struct perf_tool *tool,
 	return 0;
 }
 
+static union perf_event *
+perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
+				 union perf_event *event,
+				 struct perf_sample *sample)
+{
+	size_t sz1 = sample->aux_sample.data - (void *)event;
+	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	union perf_event *ev = (union perf_event *)inject->event_copy;
+
+	if (sz1 > event->header.size || sz2 > event->header.size ||
+	    sz1 + sz2 > event->header.size ||
+	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
+		return event;
+
+	memcpy(ev, event, sz1);
+	memcpy((void *)ev + sz1, (void *)event + event->header.size - sz2, sz2);
+	ev->header.size = sz1 + sz2;
+	((u64 *)((void *)ev + sz1))[-1] = 0;
+
+	return ev;
+}
+
 typedef int (*inject_handler)(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -226,6 +249,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct evsel *evsel,
 				     struct machine *machine)
 {
+	struct perf_inject *inject = container_of(tool, struct perf_inject,
+						  tool);
+
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
@@ -233,6 +259,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+
 	return perf_event__repipe_synth(tool, event);
 }
 
-- 
2.21.0
