From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/25] perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel
Date: Tue,  9 Jul 2019 15:31:10 -0300
Message-ID: <20190709183126.30257-10-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll return "unknown", no need to open code it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4okvjmm18arjrcyfhuahgfxm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/util/session.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aef59f318a67..93d4b12e248e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -298,7 +298,7 @@ static int process_read_event(struct perf_tool *tool,
 	struct report *rep = container_of(tool, struct report, tool);
 
 	if (rep->show_threads) {
-		const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
+		const char *name = perf_evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
 					   evsel->idx,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2e61dd6a3574..e3463df18493 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1246,7 +1246,7 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
 		return;
 
 	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
-	       evsel ? perf_evsel__name(evsel) : "FAIL",
+	       perf_evsel__name(evsel),
 	       event->read.value);
 
 	if (!evsel)
-- 
2.21.0
