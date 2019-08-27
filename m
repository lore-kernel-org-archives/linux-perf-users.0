From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/33] perf tools: Rename perf_event::bpf_event to perf_event::bpf
Date: Mon, 26 Aug 2019 22:36:32 -0300
Message-ID: <20190827013634.3173-32-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like all the other meta events, that extra _event suffix is just
redundant, ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-505qwpaizq1k0t6pk13v1ibd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 18 ++++++++----------
 tools/perf/util/event.c     |  3 +--
 tools/perf/util/event.h     |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 69795c32ecf3..28fa2b1ce66e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -35,7 +35,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_info_node *info_node;
 	struct perf_env *env = machine->env;
-	int id = event->bpf_event.id;
+	int id = event->bpf.id;
 	unsigned int i;
 
 	/* perf-record, no need to handle bpf-event */
@@ -71,7 +71,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
 
-	switch (event->bpf_event.type) {
+	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
 		return machine__process_bpf_event_load(machine, event, sample);
 
@@ -83,8 +83,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n",
-			 event->bpf_event.type);
+		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
 		break;
 	}
 	return 0;
@@ -162,7 +161,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       struct record_opts *opts)
 {
 	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol;
-	struct perf_record_bpf_event *bpf_event = &event->bpf_event;
+	struct perf_record_bpf_event *bpf_event = &event->bpf;
 	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool = session->tool;
 	struct bpf_prog_info_node *info_node;
@@ -302,7 +301,7 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	int err;
 	int fd;
 
-	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN + machine->id_hdr_size);
+	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
 	while (true) {
@@ -399,9 +398,9 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 	if (event->header.type != PERF_RECORD_BPF_EVENT)
 		return -1;
 
-	switch (event->bpf_event.type) {
+	switch (event->bpf.type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
-		perf_env__add_bpf_info(env, event->bpf_event.id);
+		perf_env__add_bpf_info(env, event->bpf.id);
 
 	case PERF_BPF_EVENT_PROG_UNLOAD:
 		/*
@@ -411,8 +410,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 		 */
 		break;
 	default:
-		pr_debug("unexpected bpf_event type of %d\n",
-			 event->bpf_event.type);
+		pr_debug("unexpected bpf_event type of %d\n", event->bpf.type);
 		break;
 	}
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bdeaad434e52..17304df44fc2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1494,8 +1494,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " type %u, flags %u, id %u\n",
-		       event->bpf_event.type, event->bpf_event.flags,
-		       event->bpf_event.id);
+		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 34190e01f307..7251e2eee441 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -560,7 +560,7 @@ union perf_event {
 	struct perf_record_read		read;
 	struct perf_record_throttle	throttle;
 	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf_event;
+	struct perf_record_bpf_event	bpf;
 	struct perf_record_ksymbol	ksymbol;
 	struct attr_event		attr;
 	struct event_update_event	event_update;
-- 
2.21.0
