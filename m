From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/7] perf parse-events: Add parse_events_option() variant that creates evlist
Date: Mon, 27 Apr 2020 18:19:33 -0300
Message-ID: <20200427211935.25789-6-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For the upcoming --switch-output-event option we want to create the side
band event, populate it with the specified events and then, if it is
present multiple times, go on adding to it, then, if the BPF tracking is
required, use the first event to set its attr.bpf_event to get those
PERF_RECORD_BPF_EVENT metadata events too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 23 +++++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 10107747b361..5795f3a8f71c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2190,6 +2190,29 @@ int parse_events_option(const struct option *opt, const char *str,
 	return ret;
 }
 
+int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset)
+{
+	struct evlist **evlistp = opt->value;
+	int ret;
+
+	if (*evlistp == NULL) {
+		*evlistp = evlist__new();
+
+		if (*evlistp == NULL) {
+			fprintf(stderr, "Not enough memory to create evlist\n");
+			return -1;
+		}
+	}
+
+	ret = parse_events_option(opt, str, unset);
+	if (ret) {
+		evlist__delete(*evlistp);
+		*evlistp = NULL;
+	}
+
+	return ret;
+}
+
 static int
 foreach_evsel_in_last_glob(struct evlist *evlist,
 			   int (*func)(struct evsel *evsel,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 27596cbd0ba0..6ead9661238c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -31,6 +31,7 @@ bool have_tracepoints(struct list_head *evlist);
 const char *event_type(int type);
 
 int parse_events_option(const struct option *opt, const char *str, int unset);
+int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 int parse_events(struct evlist *evlist, const char *str,
 		 struct parse_events_error *error);
 int parse_events_terms(struct list_head *terms, const char *str);
-- 
2.21.1
