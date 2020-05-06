From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 79/91] perf lock: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:22 -0300
Message-ID: <20200506152234.21977-80-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-lock.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5a19dc2f1636..f0a1dbacb46c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -657,32 +657,28 @@ static struct trace_lock_handler report_lock_ops  = {
 
 static struct trace_lock_handler *trace_handler;
 
-static int perf_evsel__process_lock_acquire(struct evsel *evsel,
-					     struct perf_sample *sample)
+static int evsel__process_lock_acquire(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->acquire_event)
 		return trace_handler->acquire_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_acquired(struct evsel *evsel,
-					      struct perf_sample *sample)
+static int evsel__process_lock_acquired(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->acquired_event)
 		return trace_handler->acquired_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_contended(struct evsel *evsel,
-					      struct perf_sample *sample)
+static int evsel__process_lock_contended(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->contended_event)
 		return trace_handler->contended_event(evsel, sample);
 	return 0;
 }
 
-static int perf_evsel__process_lock_release(struct evsel *evsel,
-					    struct perf_sample *sample)
+static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *sample)
 {
 	if (trace_handler->release_event)
 		return trace_handler->release_event(evsel, sample);
@@ -849,10 +845,10 @@ static void sort_result(void)
 }
 
 static const struct evsel_str_handler lock_tracepoints[] = {
-	{ "lock:lock_acquire",	 perf_evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
-	{ "lock:lock_acquired",	 perf_evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_contended", perf_evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
-	{ "lock:lock_release",	 perf_evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
+	{ "lock:lock_acquire",	 evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
+	{ "lock:lock_acquired",	 evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
+	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
 static bool force;
-- 
2.21.1
