From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/26] perf auxtrace: Add support for dumping AUX area samples
Date: Fri, 22 Nov 2019 11:57:01 -0300
Message-ID: <20191122145711.3171-17-acme@kernel.org>
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

Add support for dumping AUX area samples i.e. via the perf script/report
 -D (--dump-raw-trace) option.

Committer notes:

Add __maybe_unused to the two args for auxtrace__dump_auxtrace_sample()
for when we don't HAVE_AUXTRACE_SUPPORT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++++
 tools/perf/util/auxtrace.h | 11 +++++++++++
 tools/perf/util/session.c  |  9 +++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 026585b67a3c..4f5c5fe3516b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2417,6 +2417,16 @@ int auxtrace__process_event(struct perf_session *session, union perf_event *even
 	return session->auxtrace->process_event(session, event, sample, tool);
 }
 
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample)
+{
+	if (!session->auxtrace || !session->auxtrace->dump_auxtrace_sample ||
+	    auxtrace__dont_decode(session))
+		return;
+
+	session->auxtrace->dump_auxtrace_sample(session, sample);
+}
+
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
 {
 	if (!session->auxtrace)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index ab48de13c353..4a8ac7de6e22 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,7 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -153,6 +154,8 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	void (*dump_auxtrace_sample)(struct perf_session *session,
+				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
@@ -555,6 +558,8 @@ int auxtrace_parse_filters(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, struct perf_tool *tool);
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample);
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
@@ -674,6 +679,12 @@ int auxtrace__process_event(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static inline
+void auxtrace__dump_auxtrace_sample(struct perf_session *session __maybe_unused,
+				    struct perf_sample *sample __maybe_unused)
+{
+}
+
 static inline
 int auxtrace__flush_events(struct perf_session *session __maybe_unused,
 			   struct perf_tool *tool __maybe_unused)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbdb47624dec..ab4dae1efea3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1496,8 +1496,13 @@ static int perf_session__deliver_event(struct perf_session *session,
 	if (ret > 0)
 		return 0;
 
-	return machines__deliver_event(&session->machines, session->evlist,
-				       event, &sample, tool, file_offset);
+	ret = machines__deliver_event(&session->machines, session->evlist,
+				      event, &sample, tool, file_offset);
+
+	if (dump_trace && sample.aux_sample.size)
+		auxtrace__dump_auxtrace_sample(session, &sample);
+
+	return ret;
 }
 
 static s64 perf_session__process_user_event(struct perf_session *session,
-- 
2.21.0
