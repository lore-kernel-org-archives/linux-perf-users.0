From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/60] perf auxtrace: Add ->evsel_is_auxtrace() callback
Date: Mon, 20 Apr 2020 08:52:41 -0300
Message-ID: <20200420115316.18781-26-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add ->evsel_is_auxtrace() callback to identify if a selected event
is an AUX area event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c |  9 +++++++++
 tools/perf/util/auxtrace.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3571ce72ca28..2c4ad6838766 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2577,3 +2577,12 @@ void auxtrace__free(struct perf_session *session)
 
 	return session->auxtrace->free(session);
 }
+
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
+				 struct evsel *evsel)
+{
+	if (!session->auxtrace || !session->auxtrace->evsel_is_auxtrace)
+		return false;
+
+	return session->auxtrace->evsel_is_auxtrace(session, evsel);
+}
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e58ef160b599..db65aae5c2ea 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -21,6 +21,7 @@
 union perf_event;
 struct perf_session;
 struct evlist;
+struct evsel;
 struct perf_tool;
 struct mmap;
 struct perf_sample;
@@ -166,6 +167,8 @@ struct auxtrace {
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
 	void (*free)(struct perf_session *session);
+	bool (*evsel_is_auxtrace)(struct perf_session *session,
+				  struct evsel *evsel);
 };
 
 /**
@@ -584,6 +587,8 @@ void auxtrace__dump_auxtrace_sample(struct perf_session *session,
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
+				 struct evsel *evsel);
 
 #define ITRACE_HELP \
 "				i:	    		synthesize instructions events\n"		\
@@ -749,6 +754,13 @@ void auxtrace_index__free(struct list_head *head __maybe_unused)
 {
 }
 
+static inline
+bool auxtrace__evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+				 struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
 static inline
 int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 {
-- 
2.21.1
