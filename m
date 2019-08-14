From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/28] perf tools: Add itrace option 'o' to synthesize aux-output events
Date: Wed, 14 Aug 2019 15:40:43 -0300
Message-ID: <20190814184051.3125-21-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add itrace option 'o' to synthesize events recorded in the AUX area due
to the use of perf record's aux-output config term.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-5-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c2182cbabde3..82ff7dad40c2 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -5,6 +5,8 @@
 		x	synthesize transactions events
 		w	synthesize ptwrite events
 		p	synthesize power events
+		o	synthesize other events recorded due to the use
+			of aux-output (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72ce4c5e7c78..60428576426e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -974,6 +974,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
+	synth_opts->other_events = true;
 	synth_opts->errors = true;
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
@@ -1071,6 +1072,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'p':
 			synth_opts->pwr_events = true;
 			break;
+		case 'o':
+			synth_opts->other_events = true;
+			break;
 		case 'e':
 			synth_opts->errors = true;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8ccabacd0b11..8e637ac3918e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -60,6 +60,8 @@ enum itrace_period_type {
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
+ * @other_events: whether to synthesize other events recorded due to the use of
+ *                aux_output
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
  * @log: write a decoding log
@@ -86,6 +88,7 @@ struct itrace_synth_opts {
 	bool			transactions;
 	bool			ptwrites;
 	bool			pwr_events;
+	bool			other_events;
 	bool			errors;
 	bool			dont_decode;
 	bool			log;
-- 
2.21.0
