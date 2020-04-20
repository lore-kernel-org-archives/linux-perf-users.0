From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/60] perf auxtrace: Add an option to synthesize callchains for regular events
Date: Mon, 20 Apr 2020 08:52:48 -0300
Message-ID: <20200420115316.18781-33-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Currently, callchains can be synthesized only for synthesized events. Add
an itrace option to synthesize callchains for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/builtin-report.c         | 3 ++-
 tools/perf/builtin-script.c         | 2 +-
 tools/perf/util/auxtrace.c          | 6 +++++-
 tools/perf/util/auxtrace.h          | 2 ++
 tools/perf/util/s390-cpumsf.c       | 2 +-
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7dad40c2..671e154ede03 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -10,6 +10,7 @@
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
+		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26d8fc27e427..c0cebd53ecf9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -339,6 +339,7 @@ static int report__setup_sample_type(struct report *rep)
 	bool is_pipe = perf_data__is_pipe(session->data);
 
 	if (session->itrace_synth_opts->callchain ||
+	    session->itrace_synth_opts->add_callchain ||
 	    (!is_pipe &&
 	     perf_header__has_feat(&session->header, HEADER_AUXTRACE) &&
 	     !session->itrace_synth_opts->set))
@@ -1332,7 +1333,7 @@ int cmd_report(int argc, const char **argv)
 	if (symbol_conf.cumulate_callchain && !callchain_param.order_set)
 		callchain_param.order = ORDER_CALLER;
 
-	if (itrace_synth_opts.callchain &&
+	if ((itrace_synth_opts.callchain || itrace_synth_opts.add_callchain) &&
 	    (int)itrace_synth_opts.callchain_sz > report.max_stack)
 		report.max_stack = itrace_synth_opts.callchain_sz;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8bf3ba280312..06b511c0a539 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3537,7 +3537,7 @@ int cmd_script(int argc, const char **argv)
 		return -1;
 	}
 
-	if (itrace_synth_opts.callchain &&
+	if ((itrace_synth_opts.callchain || itrace_synth_opts.add_callchain) &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b60bae8e395c..809a09e75c55 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1462,8 +1462,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			synth_opts->branches = true;
 			synth_opts->returns = true;
 			break;
+		case 'G':
 		case 'g':
-			synth_opts->callchain = true;
+			if (p[-1] == 'G')
+				synth_opts->add_callchain = true;
+			else
+				synth_opts->callchain = true;
 			synth_opts->callchain_sz =
 					PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
 			while (*p == ' ' || *p == ',')
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index db65aae5c2ea..dd8a4ff8209e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -74,6 +74,7 @@ enum itrace_period_type {
  * @calls: limit branch samples to calls (can be combined with @returns)
  * @returns: limit branch samples to returns (can be combined with @calls)
  * @callchain: add callchain to 'instructions' events
+ * @add_callchain: add callchain to existing event records
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
  * @callchain_sz: maximum callchain size
@@ -101,6 +102,7 @@ struct itrace_synth_opts {
 	bool			calls;
 	bool			returns;
 	bool			callchain;
+	bool			add_callchain;
 	bool			thread_stack;
 	bool			last_branch;
 	unsigned int		callchain_sz;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d7779e48652f..38a942881d1a 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1079,7 +1079,7 @@ static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
 		itops->pwr_events || itops->errors ||
 		itops->dont_decode || itops->calls || itops->returns ||
 		itops->callchain || itops->thread_stack ||
-		itops->last_branch;
+		itops->last_branch || itops->add_callchain;
 	if (!ison)
 		return true;
 	pr_err("Unsupported --itrace options specified\n");
-- 
2.21.1
