From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/91] perf auxtrace: Add option to synthesize branch stack for regular events
Date: Wed,  6 May 2020 12:21:45 -0300
Message-ID: <20200506152234.21977-43-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

There is an existing option to synthesize branch stacks for synthesized
events. Add a new option to synthesize branch stacks for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/builtin-inject.c         | 3 ++-
 tools/perf/builtin-report.c         | 5 +++--
 tools/perf/util/auxtrace.c          | 6 +++++-
 tools/perf/util/auxtrace.h          | 2 ++
 tools/perf/util/s390-cpumsf.c       | 3 ++-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 671e154ede03..0326050beebd 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -12,6 +12,7 @@
 		g	synthesize a call chain (use with i or x)
 		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
+		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7e124a7b8bfd..7c4403cf8dcb 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -684,7 +684,8 @@ static int __cmd_inject(struct perf_inject *inject)
 
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
-			if (inject->itrace_synth_opts.last_branch)
+			if (inject->itrace_synth_opts.last_branch ||
+			    inject->itrace_synth_opts.add_last_branch)
 				perf_header__set_feat(&session->header,
 						      HEADER_BRANCH_STACK);
 			evsel = perf_evlist__id2evsel_strict(session->evlist,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7da1342a1f4e..0eea667bfb76 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -349,7 +349,8 @@ static int report__setup_sample_type(struct report *rep)
 	     !session->itrace_synth_opts->set))
 		sample_type |= PERF_SAMPLE_CALLCHAIN;
 
-	if (session->itrace_synth_opts->last_branch)
+	if (session->itrace_synth_opts->last_branch ||
+	    session->itrace_synth_opts->add_last_branch)
 		sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
 	if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN)) {
@@ -1393,7 +1394,7 @@ int cmd_report(int argc, const char **argv)
 		goto error;
 	}
 
-	if (itrace_synth_opts.last_branch)
+	if (itrace_synth_opts.last_branch || itrace_synth_opts.add_last_branch)
 		has_br_stack = true;
 
 	if (has_br_stack && branch_call_mode)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ac6e09965a78..83ea7ca24686 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1464,8 +1464,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 				synth_opts->callchain_sz = val;
 			}
 			break;
+		case 'L':
 		case 'l':
-			synth_opts->last_branch = true;
+			if (p[-1] == 'L')
+				synth_opts->add_last_branch = true;
+			else
+				synth_opts->last_branch = true;
 			synth_opts->last_branch_sz =
 					PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
 			while (*p == ' ' || *p == ',')
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index dd8a4ff8209e..0220a2e86c16 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -77,6 +77,7 @@ enum itrace_period_type {
  * @add_callchain: add callchain to existing event records
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
+ * @add_last_branch: add branch context to existing event records
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -105,6 +106,7 @@ struct itrace_synth_opts {
 	bool			add_callchain;
 	bool			thread_stack;
 	bool			last_branch;
+	bool			add_last_branch;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 38a942881d1a..f8861998e5bd 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1079,7 +1079,8 @@ static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
 		itops->pwr_events || itops->errors ||
 		itops->dont_decode || itops->calls || itops->returns ||
 		itops->callchain || itops->thread_stack ||
-		itops->last_branch || itops->add_callchain;
+		itops->last_branch || itops->add_callchain ||
+		itops->add_last_branch;
 	if (!ison)
 		return true;
 	pr_err("Unsupported --itrace options specified\n");
-- 
2.21.1
