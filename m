From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v2 02/11] perf tools report: Support nano seconds
Date: Mon, 25 Feb 2019 19:04:03 -0800
Message-ID: <20190226030412.23485-3-andi@firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Upcoming changes add timestamp output in perf report. Add a --ns
argument similar to perf script to support nanoseconds resolution
when needed.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move flag into symbol_conf and change all users
---
 tools/perf/Documentation/perf-report.txt |  3 +++
 tools/perf/builtin-report.c              |  1 +
 tools/perf/builtin-script.c              | 11 +++++------
 tools/perf/util/symbol.c                 |  1 +
 tools/perf/util/symbol_conf.h            |  1 +
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a27bfe05039..51dbc519dbce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,9 @@ include::itrace.txt[]
 	Please note that not all mmaps are stored, options affecting which ones
 	are include 'perf record --data', for instance.
 
+--ns::
+	Show time stamps in nanoseconds.
+
 --stats::
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2e8c74d6430c..6b2cc91ee26a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1147,6 +1147,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1d651a9b110e..1e6f2f095152 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -60,7 +60,6 @@ static bool			no_callchain;
 static bool			latency_format;
 static bool			system_wide;
 static bool			print_flags;
-static bool			nanosecs;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
@@ -691,7 +690,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 		secs = nsecs / NSEC_PER_SEC;
 		nsecs -= secs * NSEC_PER_SEC;
 
-		if (nanosecs)
+		if (symbol_conf.nanosecs)
 			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
@@ -3238,7 +3237,7 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "+insn,-event,-period", 0);
 	itrace_parse_synth_opts(opt, "i0ns", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3256,7 +3255,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
 	itrace_parse_synth_opts(opt, "cewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3266,7 +3265,7 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
 	itrace_parse_synth_opts(opt, "crewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3402,7 +3401,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
-	OPT_BOOLEAN(0, "ns", &nanosecs,
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs,
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 758bf5f74e6e..eb873ea1c405 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -39,6 +39,7 @@ int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
 struct symbol_conf symbol_conf = {
+	.nanosecs		= false,
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
 	.demangle		= true,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index fffea68c1203..095a297c8b47 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -8,6 +8,7 @@ struct strlist;
 struct intlist;
 
 struct symbol_conf {
+	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
 			init_annotation,
-- 
2.17.2
