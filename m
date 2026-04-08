Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089893B0AD4;
	Wed,  8 Apr 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669356; cv=none; b=OINg3vIGyX6vHaRDQ1fFO1tXoQZIvqYRUVXDC4GGzn7Ixk48JR/CnzNi6PDiOPPe+4aEsUV1f7my4CCRCeuSf6Xrtxcr0+21JGsZzxoNE6TNCDrxQCM5LVxGfTPa088r3zVCJ8b6JbW98ayNQKJv4Tw/zWSNNIhmSJLEYpFH05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669356; c=relaxed/simple;
	bh=lC85CU15ZO812aTcJJuR2lp5HN2I+E4nk2MpS9oRuhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up/UrS7quUxnDnt9mJN0kMx1Gu/N70QXva3zaj7iyn/4eB+Z92nhB2fkc/FmZIn/40E7y6zX2WRj9ea1J0i2xISsrYw7PoDNm9nI0mCIWIY2mmqdTNTPAFYuu1qGlBhdzQH8v4eDl3xCRkTiX85pVEcUfMvOaBizgrFXnuE1EO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok4cn7i9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok4cn7i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DD2C19421;
	Wed,  8 Apr 2026 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669355;
	bh=lC85CU15ZO812aTcJJuR2lp5HN2I+E4nk2MpS9oRuhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ok4cn7i9nWVTvpbPxoi8+VAQFNcm8hb2lmC8/qokzLqNiMEICobAQKQMvRA8OKp46
	 7hoD3EHGfAcpZsFewsI3AECHsDIsszKoMY0m6qkbdBTlC9WSkH8dyczNO8AfXIc7nc
	 QR7DTxM3gLR4EYciXjL1AjPZfAvHdAO3SCg3nXWJTqHQrSJjzVC/kKSfY4fRrAaAWl
	 FR5KM1CvatDwMNba+p3FiC1wiT3Dwq4nyieDzz8UEVWajPEDzFcX+18vpInhcGJpfF
	 9Qse1GyzDRwFLO2nm4IiHJvK83v5/SfvUDcFIvJJH99vdwOIgtQl+eGSUxNZZr9I09
	 B72qW3dktTRCA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Leo Yan <leo.yan@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/8] perf tools: Make more global variables static
Date: Wed,  8 Apr 2026 14:28:41 -0300
Message-ID: <20260408172846.96360-4-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172846.96360-1-acme@kernel.org>
References: <20260408172846.96360-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

`make check` will run sparse on the perf code base. A frequent warning
is "warning: symbol '...' was not declared. Should it be static?" Go
through and make global definitions without declarations static.

In some cases it is deliberate due to dlsym accessing the symbol, this
change doesn't clean up the missing declarations for perf test suites.

Sometimes things can opportunistically be made const.

Making somethings static exposed unused functions warnings, so
restructuring of ifdefs was necessary for that.

These changes reduce the size of the perf binary by 568 bytes.

Committer notes:

Refreshed the patch, the original one fell thru the cracks, updated the
size reduction.

Remove the trace-event-scripting.c changes, break the build, noticed
with container builds and with sashiko:

  https://sashiko.dev/#/patchset/20260401215306.2152898-1-acme%40kernel.org

Also make two variables static to address another sashiko review
comment:

  https://sashiko.dev/#/patchset/20260402001740.2220481-1-acme%40kernel.org

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Ankur Arora <ankur.a.arora@oracle.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.c                      |  22 ++--
 tools/perf/arch/sh/include/dwarf-regs-table.h |   2 +-
 tools/perf/bench/breakpoint.c                 |   4 +-
 tools/perf/bench/mem-functions.c              |   2 +-
 tools/perf/bench/numa.c                       |   2 +-
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/builtin-c2c.c                      |   7 +-
 tools/perf/builtin-config.c                   |   2 +-
 tools/perf/builtin-data.c                     |   8 +-
 tools/perf/builtin-diff.c                     |   4 +-
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-kwork.c                    |  12 +-
 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/builtin-top.c                      |   5 +-
 tools/perf/tests/bp_signal.c                  |   2 +-
 tools/perf/tests/dso-data.c                   |   2 +-
 tools/perf/tests/wp.c                         |   6 +-
 tools/perf/util/block-range.c                 |   2 +-
 tools/perf/util/bpf_counter.c                 |   4 +-
 tools/perf/util/bpf_off_cpu.c                 |   2 +-
 tools/perf/util/debug.c                       |   2 +-
 tools/perf/util/debuginfo.c                   |  19 ++--
 tools/perf/util/sort.c                        | 104 +++++++++---------
 tools/perf/util/util.c                        |   2 -
 24 files changed, 109 insertions(+), 112 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 4908d54dd33b2733..21836f70f231e42d 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -9,14 +9,14 @@
 #include "../util/debug.h"
 #include <linux/zalloc.h>
 
-const char *const arc_triplets[] = {
+static const char *const arc_triplets[] = {
 	"arc-linux-",
 	"arc-snps-linux-uclibc-",
 	"arc-snps-linux-gnu-",
 	NULL
 };
 
-const char *const arm_triplets[] = {
+static const char *const arm_triplets[] = {
 	"arm-eabi-",
 	"arm-linux-androideabi-",
 	"arm-unknown-linux-",
@@ -28,13 +28,13 @@ const char *const arm_triplets[] = {
 	NULL
 };
 
-const char *const arm64_triplets[] = {
+static const char *const arm64_triplets[] = {
 	"aarch64-linux-android-",
 	"aarch64-linux-gnu-",
 	NULL
 };
 
-const char *const powerpc_triplets[] = {
+static const char *const powerpc_triplets[] = {
 	"powerpc-unknown-linux-gnu-",
 	"powerpc-linux-gnu-",
 	"powerpc64-unknown-linux-gnu-",
@@ -43,40 +43,40 @@ const char *const powerpc_triplets[] = {
 	NULL
 };
 
-const char *const riscv32_triplets[] = {
+static const char *const riscv32_triplets[] = {
 	"riscv32-unknown-linux-gnu-",
 	"riscv32-linux-android-",
 	"riscv32-linux-gnu-",
 	NULL
 };
 
-const char *const riscv64_triplets[] = {
+static const char *const riscv64_triplets[] = {
 	"riscv64-unknown-linux-gnu-",
 	"riscv64-linux-android-",
 	"riscv64-linux-gnu-",
 	NULL
 };
 
-const char *const s390_triplets[] = {
+static const char *const s390_triplets[] = {
 	"s390-ibm-linux-",
 	"s390x-linux-gnu-",
 	NULL
 };
 
-const char *const sh_triplets[] = {
+static const char *const sh_triplets[] = {
 	"sh-unknown-linux-gnu-",
 	"sh-linux-gnu-",
 	NULL
 };
 
-const char *const sparc_triplets[] = {
+static const char *const sparc_triplets[] = {
 	"sparc-unknown-linux-gnu-",
 	"sparc64-unknown-linux-gnu-",
 	"sparc64-linux-gnu-",
 	NULL
 };
 
-const char *const x86_triplets[] = {
+static const char *const x86_triplets[] = {
 	"x86_64-pc-linux-gnu-",
 	"x86_64-unknown-linux-gnu-",
 	"i686-pc-linux-gnu-",
@@ -90,7 +90,7 @@ const char *const x86_triplets[] = {
 	NULL
 };
 
-const char *const mips_triplets[] = {
+static const char *const mips_triplets[] = {
 	"mips-unknown-linux-gnu-",
 	"mipsel-linux-android-",
 	"mips-linux-gnu-",
diff --git a/tools/perf/arch/sh/include/dwarf-regs-table.h b/tools/perf/arch/sh/include/dwarf-regs-table.h
index 900e6961997091c7..b5974a090fb44a79 100644
--- a/tools/perf/arch/sh/include/dwarf-regs-table.h
+++ b/tools/perf/arch/sh/include/dwarf-regs-table.h
@@ -2,7 +2,7 @@
 #ifdef DEFINE_DWARF_REGSTR_TABLE
 /* This is included in perf/util/dwarf-regs.c */
 
-const char * const sh_regstr_tbl[] = {
+static const char * const sh_regstr_tbl[] = {
 	"r0",
 	"r1",
 	"r2",
diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
index dfd18f5db97dbc7e..1b7cd4481bd224aa 100644
--- a/tools/perf/bench/breakpoint.c
+++ b/tools/perf/bench/breakpoint.c
@@ -16,7 +16,7 @@
 #include "bench.h"
 #include "futex.h"
 
-struct {
+static struct {
 	unsigned int nbreakpoints;
 	unsigned int nparallel;
 	unsigned int nthreads;
@@ -173,7 +173,7 @@ int bench_breakpoint_thread(int argc, const char **argv)
 	return 0;
 }
 
-struct {
+static struct {
 	unsigned int npassive;
 	unsigned int nactive;
 } enable_params = {
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index f5ab41bb85bf67a0..5ede528539535b6a 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -399,7 +399,7 @@ static void mem_free(struct bench_mem_info *info __maybe_unused,
 	*dst = *src = NULL;
 }
 
-struct function memcpy_functions[] = {
+static struct function memcpy_functions[] = {
 	{ .name		= "default",
 	  .desc		= "Default memcpy() provided by glibc",
 	  .fn.init	= mem_alloc,
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 19be2aaf4dc0c07e..6588a9b0b15aec6d 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -166,7 +166,7 @@ static struct global_info	*g = NULL;
 static int parse_cpus_opt(const struct option *opt, const char *arg, int unset);
 static int parse_nodes_opt(const struct option *opt, const char *arg, int unset);
 
-struct params p0;
+static struct params p0;
 
 static const struct option options[] = {
 	OPT_INTEGER('p', "nr_proc"	, &p0.nr_proc,		"number of processes"),
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index c4dac868f1eea401..89697ff788ef3035 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -58,7 +58,7 @@ static const char * const bench_uprobe_usage[] = {
 		goto cleanup; \
 	}
 
-struct bench_uprobe_bpf *skel;
+static struct bench_uprobe_bpf *skel;
 
 static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 {
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e60eea62c2fc76d6..3ce5f0adec2f31c2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2892,9 +2892,10 @@ static int ui_quirks(void)
 
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 
-const char callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
-				CALLCHAIN_REPORT_HELP
-				"\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
+static const char callchain_help[] =
+	"Display call graph (stack chain/backtrace):\n\n"
+	CALLCHAIN_REPORT_HELP
+	"\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
 
 static int
 parse_callchain_opt(const struct option *opt, const char *arg, int unset)
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 45b5312fbe8370e8..237600643bbd6f33 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -23,7 +23,7 @@ static const char * const config_usage[] = {
 	NULL
 };
 
-enum actions {
+static enum actions {
 	ACTION_LIST = 1
 } actions;
 
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 85f59886b5cf0045..4c08ccb8c06b7598 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -28,15 +28,15 @@ static const char *data_usage[] = {
 	NULL
 };
 
-const char *to_json;
-const char *to_ctf;
-struct perf_data_convert_opts opts = {
+static const char *to_json;
+static const char *to_ctf;
+static struct perf_data_convert_opts opts = {
 	.force = false,
 	.all = false,
 	.time_str = NULL,
 };
 
-const struct option data_options[] = {
+static const struct option data_options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING('i', "input", &input_name, "file", "input file name"),
 		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 69069926dd0ba07b..e45f0ac1381ab2df 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -113,7 +113,7 @@ enum {
 	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
 };
 
-const char *compute_names[COMPUTE_MAX] = {
+static const char *compute_names[COMPUTE_MAX] = {
 	[COMPUTE_DELTA] = "delta",
 	[COMPUTE_DELTA_ABS] = "delta-abs",
 	[COMPUTE_RATIO] = "ratio",
@@ -382,7 +382,7 @@ static void block_hist_free(void *he)
 	free(bh);
 }
 
-struct hist_entry_ops block_hist_ops = {
+static struct hist_entry_ops block_hist_ops = {
 	.new    = block_hist_zalloc,
 	.free   = block_hist_free,
 };
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 7929a5fa5f462b32..9c64a0d7482378cc 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -82,7 +82,7 @@ static unsigned long nr_allocs, nr_cross_allocs;
 
 /* filters for controlling start and stop of time of analysis */
 static struct perf_time_interval ptime;
-const char *time_str;
+static const char *time_str;
 
 static int insert_alloc_stat(unsigned long call_site, unsigned long ptr,
 			     int bytes_req, int bytes_alloc, int cpu)
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 6f94a8f45f605f34..1140e00e874f4eed 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -985,7 +985,7 @@ static int process_irq_handler_exit_event(const struct perf_tool *tool,
 	return 0;
 }
 
-const struct evsel_str_handler irq_tp_handlers[] = {
+static const struct evsel_str_handler irq_tp_handlers[] = {
 	{ "irq:irq_handler_entry", process_irq_handler_entry_event, },
 	{ "irq:irq_handler_exit",  process_irq_handler_exit_event,  },
 };
@@ -1080,7 +1080,7 @@ static int process_softirq_exit_event(const struct perf_tool *tool,
 	return 0;
 }
 
-const struct evsel_str_handler softirq_tp_handlers[] = {
+static const struct evsel_str_handler softirq_tp_handlers[] = {
 	{ "irq:softirq_raise", process_softirq_raise_event, },
 	{ "irq:softirq_entry", process_softirq_entry_event, },
 	{ "irq:softirq_exit",  process_softirq_exit_event,  },
@@ -1211,7 +1211,7 @@ static int process_workqueue_execute_end_event(const struct perf_tool *tool,
 	return 0;
 }
 
-const struct evsel_str_handler workqueue_tp_handlers[] = {
+static const struct evsel_str_handler workqueue_tp_handlers[] = {
 	{ "workqueue:workqueue_activate_work", process_workqueue_activate_work_event, },
 	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
 	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event,   },
@@ -1281,7 +1281,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	return 0;
 }
 
-const struct evsel_str_handler sched_tp_handlers[] = {
+static const struct evsel_str_handler sched_tp_handlers[] = {
 	{ "sched:sched_switch",  process_sched_switch_event, },
 };
 
@@ -1561,13 +1561,13 @@ static void print_bad_events(struct perf_kwork *kwork)
 	}
 }
 
-const char *graph_load = "||||||||||||||||||||||||||||||||||||||||||||||||";
-const char *graph_idle = "                                                ";
 static void top_print_per_cpu_load(struct perf_kwork *kwork)
 {
 	int i, load_width;
 	u64 total, load, load_ratio;
 	struct kwork_top_stat *stat = &kwork->top_stat;
+	const char *graph_load = "||||||||||||||||||||||||||||||||||||||||||||||||";
+	const char *graph_idle = "                                                ";
 
 	for (i = 0; i < MAX_NR_CPUS; i++) {
 		total = stat->cpus_runtime[i].total;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 42d4cc1620397b9f..43ce119dac3ed9f9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -166,7 +166,7 @@ struct perf_script {
 	int			range_num;
 };
 
-struct output_option {
+static struct output_option {
 	const char *str;
 	enum perf_output_field field;
 } all_output_options[] = {
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 37950efb28aca8cc..f6eb543de537a3d3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1449,11 +1449,10 @@ parse_percent_limit(const struct option *opt, const char *arg,
 	return 0;
 }
 
-const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
-	"\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
-
 int cmd_top(int argc, const char **argv)
 {
+	static const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
+		"\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
 	char errbuf[BUFSIZ];
 	struct perf_top top = {
 		.count_filter	     = 5,
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 3faeb5b6fe0bb24a..f580ba7486b1d8ab 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -36,7 +36,7 @@ static int fd3;
 static int overflows;
 static int overflows_2;
 
-volatile long the_var;
+static volatile long the_var;
 
 
 /*
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index a1fff4203b75f665..46bc3f59726004fa 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -58,7 +58,7 @@ struct test_data_offset {
 	int size;
 };
 
-struct test_data_offset offsets[] = {
+static struct test_data_offset offsets[] = {
 	/* Fill first cache page. */
 	{
 		.offset = 10,
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 6c178985e37f5eba..69b31f00eed04c5b 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -22,11 +22,11 @@ do {                                            \
 
 #ifdef __i386__
 /* Only breakpoint length less-than 8 has hardware support on i386. */
-volatile u32 data1;
+static volatile u32 data1;
 #else
-volatile u64 data1;
+static volatile u64 data1;
 #endif
-volatile u8 data2[3];
+static volatile u8 data2[3];
 
 #ifndef __s390x__
 static int wp_read(int fd, long long *count, int size)
diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 15c42196c24c8230..7c559fcfd7e0a6db 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -4,7 +4,7 @@
 #include <assert.h>
 #include <stdlib.h>
 
-struct {
+static struct {
 	struct rb_root root;
 	u64 blocks;
 } block_ranges;
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 2ffd7aefb6eb3bf8..34b6b0da18b738c7 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -353,7 +353,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 	return 0;
 }
 
-struct bpf_counter_ops bpf_program_profiler_ops = {
+static struct bpf_counter_ops bpf_program_profiler_ops = {
 	.load       = bpf_program_profiler__load,
 	.enable	    = bpf_program_profiler__enable,
 	.disable    = bpf_program_profiler__disable,
@@ -833,7 +833,7 @@ static int bperf__destroy(struct evsel *evsel)
  * the leader prog.
  */
 
-struct bpf_counter_ops bperf_ops = {
+static struct bpf_counter_ops bperf_ops = {
 	.load       = bperf__load,
 	.enable     = bperf__enable,
 	.disable    = bperf__disable,
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 0891d9c736609cfa..a3b699a5322f1e51 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -39,7 +39,7 @@ union off_cpu_data {
 	u64 array[1024 / sizeof(u64)];
 };
 
-u64 off_cpu_raw[MAX_STACKS + 5];
+static u64 off_cpu_raw[MAX_STACKS + 5];
 
 static int off_cpu_config(struct evlist *evlist)
 {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 1dfa4d0eec4d7d5a..6b5ffe81f14121b7 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -48,7 +48,7 @@ int debug_ordered_events;
 static int redirect_to_stderr;
 int debug_data_convert;
 static FILE *_debug_file;
-bool debug_display_time;
+static bool debug_display_time;
 int debug_type_profile;
 
 FILE *debug_file(void)
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 4a559b3e8cdce60a..0e35c13abd041c46 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -88,18 +88,17 @@ static struct debuginfo *__debuginfo__new(const char *path)
 	return dbg;
 }
 
-enum dso_binary_type distro_dwarf_types[] = {
-	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
-	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
-	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
-	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
-	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
-	DSO_BINARY_TYPE__NOT_FOUND,
-};
-
 struct debuginfo *debuginfo__new(const char *path)
 {
-	enum dso_binary_type *type;
+	static const enum dso_binary_type distro_dwarf_types[] = {
+		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
+		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+		DSO_BINARY_TYPE__NOT_FOUND,
+	};
+	const enum dso_binary_type *type;
 	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
 	struct debuginfo *dinfo = NULL;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 5c9656cc4f9dacdb..6ce684d68bd61edb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -44,11 +44,11 @@ regex_t		parent_regex;
 const char	default_parent_pattern[] = "^sys_|^do_page_fault";
 const char	*parent_pattern = default_parent_pattern;
 const char	*default_sort_order = "comm,dso,symbol";
-const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
+static const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
 const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc";
-const char	default_top_sort_order[] = "dso,symbol";
-const char	default_diff_sort_order[] = "dso,symbol";
-const char	default_tracepoint_sort_order[] = "trace";
+static const char	default_top_sort_order[] = "dso,symbol";
+static const char	default_diff_sort_order[] = "dso,symbol";
+static const char	default_tracepoint_sort_order[] = "trace";
 const char	*sort_order;
 const char	*field_order;
 regex_t		ignore_callees_regex;
@@ -173,7 +173,7 @@ static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
 }
 
-struct sort_entry sort_tgid = {
+static struct sort_entry sort_tgid = {
 	.se_header	= "   Tgid:Command",
 	.se_cmp		= sort__tgid_cmp,
 	.se_snprintf	= hist_entry__tgid_snprintf,
@@ -219,7 +219,7 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "[.] %s", name);
 }
 
-struct sort_entry sort_simd = {
+static struct sort_entry sort_simd = {
 	.se_header	= "Simd   ",
 	.se_cmp		= sort__simd_cmp,
 	.se_snprintf	= hist_entry__simd_snprintf,
@@ -605,7 +605,7 @@ hist_entry__symoff_snprintf(struct hist_entry *he, char *bf, size_t size, unsign
 	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym->name, he->ip - sym->start);
 }
 
-struct sort_entry sort_sym_offset = {
+static struct sort_entry sort_sym_offset = {
 	.se_header	= "Symbol Offset",
 	.se_cmp		= sort__symoff_cmp,
 	.se_sort	= sort__symoff_sort,
@@ -716,7 +716,7 @@ static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, he->branch_info->srcline_from);
 }
 
-struct sort_entry sort_srcline_from = {
+static struct sort_entry sort_srcline_from = {
 	.se_header	= "From Source:Line",
 	.se_cmp		= sort__srcline_from_cmp,
 	.se_collapse	= sort__srcline_from_collapse,
@@ -764,7 +764,7 @@ static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, he->branch_info->srcline_to);
 }
 
-struct sort_entry sort_srcline_to = {
+static struct sort_entry sort_srcline_to = {
 	.se_header	= "To Source:Line",
 	.se_cmp		= sort__srcline_to_cmp,
 	.se_collapse	= sort__srcline_to_collapse,
@@ -800,7 +800,7 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*s", width, tmp);
 }
 
-struct sort_entry sort_sym_ipc = {
+static struct sort_entry sort_sym_ipc = {
 	.se_header	= "IPC   [IPC Coverage]",
 	.se_cmp		= sort__sym_cmp,
 	.se_snprintf	= hist_entry__sym_ipc_snprintf,
@@ -818,7 +818,7 @@ static int hist_entry__sym_ipc_null_snprintf(struct hist_entry *he
 	return repsep_snprintf(bf, size, "%-*s", width, tmp);
 }
 
-struct sort_entry sort_sym_ipc_null = {
+static struct sort_entry sort_sym_ipc_null = {
 	.se_header	= "IPC   [IPC Coverage]",
 	.se_cmp		= sort__sym_cmp,
 	.se_snprintf	= hist_entry__sym_ipc_null_snprintf,
@@ -851,7 +851,7 @@ static int hist_entry__callchain_branch_predicted_snprintf(
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
 }
 
-struct sort_entry sort_callchain_branch_predicted = {
+static struct sort_entry sort_callchain_branch_predicted = {
 	.se_header	= "Predicted",
 	.se_cmp		= sort__callchain_branch_predicted_cmp,
 	.se_snprintf	= hist_entry__callchain_branch_predicted_snprintf,
@@ -881,7 +881,7 @@ static int hist_entry__callchain_branch_abort_snprintf(struct hist_entry *he,
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
 }
 
-struct sort_entry sort_callchain_branch_abort = {
+static struct sort_entry sort_callchain_branch_abort = {
 	.se_header	= "Abort",
 	.se_cmp		= sort__callchain_branch_abort_cmp,
 	.se_snprintf	= hist_entry__callchain_branch_abort_snprintf,
@@ -914,7 +914,7 @@ static int hist_entry__callchain_branch_cycles_snprintf(struct hist_entry *he,
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
 }
 
-struct sort_entry sort_callchain_branch_cycles = {
+static struct sort_entry sort_callchain_branch_cycles = {
 	.se_header	= "Cycles",
 	.se_cmp		= sort__callchain_branch_cycles_cmp,
 	.se_snprintf	= hist_entry__callchain_branch_cycles_snprintf,
@@ -981,7 +981,7 @@ static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcfile);
 }
 
-struct sort_entry sort_srcfile = {
+static struct sort_entry sort_srcfile = {
 	.se_header	= "Source File",
 	.se_cmp		= sort__srcfile_cmp,
 	.se_collapse	= sort__srcfile_collapse,
@@ -1033,7 +1033,7 @@ static int hist_entry__cpu_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%*.*d", width, width, he->cpu);
 }
 
-struct sort_entry sort_cpu = {
+static struct sort_entry sort_cpu = {
 	.se_header      = "CPU",
 	.se_cmp	        = sort__cpu_cmp,
 	.se_snprintf    = hist_entry__cpu_snprintf,
@@ -1064,7 +1064,7 @@ static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
 }
 
-struct sort_entry sort_parallelism = {
+static struct sort_entry sort_parallelism = {
 	.se_header      = "Parallelism",
 	.se_cmp	        = sort__parallelism_cmp,
 	.se_filter	= hist_entry__parallelism_filter,
@@ -1105,7 +1105,7 @@ static int hist_entry__cgroup_id_snprintf(struct hist_entry *he,
 			       he->cgroup_id.ino);
 }
 
-struct sort_entry sort_cgroup_id = {
+static struct sort_entry sort_cgroup_id = {
 	.se_header      = "cgroup id (dev/inode)",
 	.se_cmp	        = sort__cgroup_id_cmp,
 	.se_snprintf    = hist_entry__cgroup_id_snprintf,
@@ -1138,7 +1138,7 @@ static int hist_entry__cgroup_snprintf(struct hist_entry *he,
 	return repsep_snprintf(bf, size, "%s", cgrp_name);
 }
 
-struct sort_entry sort_cgroup = {
+static struct sort_entry sort_cgroup = {
 	.se_header      = "Cgroup",
 	.se_cmp	        = sort__cgroup_cmp,
 	.se_snprintf    = hist_entry__cgroup_snprintf,
@@ -1169,7 +1169,7 @@ static int hist_entry__socket_filter(struct hist_entry *he, int type, const void
 	return sk >= 0 && he->socket != sk;
 }
 
-struct sort_entry sort_socket = {
+static struct sort_entry sort_socket = {
 	.se_header      = "Socket",
 	.se_cmp	        = sort__socket_cmp,
 	.se_snprintf    = hist_entry__socket_snprintf,
@@ -1200,7 +1200,7 @@ static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-.*s", width, he_time);
 }
 
-struct sort_entry sort_time = {
+static struct sort_entry sort_time = {
 	.se_header      = "Time",
 	.se_cmp	        = sort__time_cmp,
 	.se_snprintf    = hist_entry__time_snprintf,
@@ -1269,7 +1269,7 @@ static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-.*s", width, he->trace_output);
 }
 
-struct sort_entry sort_trace = {
+static struct sort_entry sort_trace = {
 	.se_header      = "Trace output",
 	.se_cmp	        = sort__trace_cmp,
 	.se_snprintf    = hist_entry__trace_snprintf,
@@ -1564,7 +1564,7 @@ sort__addr_to_cmp(struct hist_entry *left, struct hist_entry *right)
 	return _sort__addr_cmp(to_l->addr, to_r->addr);
 }
 
-struct sort_entry sort_addr_from = {
+static struct sort_entry sort_addr_from = {
 	.se_header	= "Source Address",
 	.se_cmp		= sort__addr_from_cmp,
 	.se_snprintf	= hist_entry__addr_from_snprintf,
@@ -1572,7 +1572,7 @@ struct sort_entry sort_addr_from = {
 	.se_width_idx	= HISTC_ADDR_FROM,
 };
 
-struct sort_entry sort_addr_to = {
+static struct sort_entry sort_addr_to = {
 	.se_header	= "Target Address",
 	.se_cmp		= sort__addr_to_cmp,
 	.se_snprintf	= hist_entry__addr_to_snprintf,
@@ -1629,7 +1629,7 @@ static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
 			       he->branch_info->flags.cycles);
 }
 
-struct sort_entry sort_cycles = {
+static struct sort_entry sort_cycles = {
 	.se_header	= "Basic Block Cycles",
 	.se_cmp		= sort__cycles_cmp,
 	.se_snprintf	= hist_entry__cycles_snprintf,
@@ -1919,7 +1919,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 	return _hist_entry__sym_snprintf(ms, addr, level, bf, size, width);
 }
 
-struct sort_entry sort_mispredict = {
+static struct sort_entry sort_mispredict = {
 	.se_header	= "Branch Mispredicted",
 	.se_cmp		= sort__mispredict_cmp,
 	.se_snprintf	= hist_entry__mispredict_snprintf,
@@ -1938,7 +1938,7 @@ static int hist_entry__local_weight_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*llu", width, he->weight);
 }
 
-struct sort_entry sort_local_weight = {
+static struct sort_entry sort_local_weight = {
 	.se_header	= "Local Weight",
 	.se_cmp		= sort__weight_cmp,
 	.se_snprintf	= hist_entry__local_weight_snprintf,
@@ -1952,7 +1952,7 @@ static int hist_entry__global_weight_snprintf(struct hist_entry *he, char *bf,
 			       he->weight * he->stat.nr_events);
 }
 
-struct sort_entry sort_global_weight = {
+static struct sort_entry sort_global_weight = {
 	.se_header	= "Weight",
 	.se_cmp		= sort__weight_cmp,
 	.se_snprintf	= hist_entry__global_weight_snprintf,
@@ -1971,7 +1971,7 @@ static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*u", width, he->ins_lat);
 }
 
-struct sort_entry sort_local_ins_lat = {
+static struct sort_entry sort_local_ins_lat = {
 	.se_header	= "Local INSTR Latency",
 	.se_cmp		= sort__ins_lat_cmp,
 	.se_snprintf	= hist_entry__local_ins_lat_snprintf,
@@ -1985,7 +1985,7 @@ static int hist_entry__global_ins_lat_snprintf(struct hist_entry *he, char *bf,
 			       he->ins_lat * he->stat.nr_events);
 }
 
-struct sort_entry sort_global_ins_lat = {
+static struct sort_entry sort_global_ins_lat = {
 	.se_header	= "INSTR Latency",
 	.se_cmp		= sort__ins_lat_cmp,
 	.se_snprintf	= hist_entry__global_ins_lat_snprintf,
@@ -2011,70 +2011,70 @@ static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*u", width, he->weight3);
 }
 
-struct sort_entry sort_local_p_stage_cyc = {
+static struct sort_entry sort_local_p_stage_cyc = {
 	.se_header      = "Local Pipeline Stage Cycle",
 	.se_cmp         = sort__p_stage_cyc_cmp,
 	.se_snprintf	= hist_entry__p_stage_cyc_snprintf,
 	.se_width_idx	= HISTC_LOCAL_P_STAGE_CYC,
 };
 
-struct sort_entry sort_global_p_stage_cyc = {
+static struct sort_entry sort_global_p_stage_cyc = {
 	.se_header      = "Pipeline Stage Cycle",
 	.se_cmp         = sort__p_stage_cyc_cmp,
 	.se_snprintf    = hist_entry__global_p_stage_cyc_snprintf,
 	.se_width_idx   = HISTC_GLOBAL_P_STAGE_CYC,
 };
 
-struct sort_entry sort_mem_daddr_sym = {
+static struct sort_entry sort_mem_daddr_sym = {
 	.se_header	= "Data Symbol",
 	.se_cmp		= sort__daddr_cmp,
 	.se_snprintf	= hist_entry__daddr_snprintf,
 	.se_width_idx	= HISTC_MEM_DADDR_SYMBOL,
 };
 
-struct sort_entry sort_mem_iaddr_sym = {
+static struct sort_entry sort_mem_iaddr_sym = {
 	.se_header	= "Code Symbol",
 	.se_cmp		= sort__iaddr_cmp,
 	.se_snprintf	= hist_entry__iaddr_snprintf,
 	.se_width_idx	= HISTC_MEM_IADDR_SYMBOL,
 };
 
-struct sort_entry sort_mem_daddr_dso = {
+static struct sort_entry sort_mem_daddr_dso = {
 	.se_header	= "Data Object",
 	.se_cmp		= sort__dso_daddr_cmp,
 	.se_snprintf	= hist_entry__dso_daddr_snprintf,
 	.se_width_idx	= HISTC_MEM_DADDR_DSO,
 };
 
-struct sort_entry sort_mem_locked = {
+static struct sort_entry sort_mem_locked = {
 	.se_header	= "Locked",
 	.se_cmp		= sort__locked_cmp,
 	.se_snprintf	= hist_entry__locked_snprintf,
 	.se_width_idx	= HISTC_MEM_LOCKED,
 };
 
-struct sort_entry sort_mem_tlb = {
+static struct sort_entry sort_mem_tlb = {
 	.se_header	= "TLB access",
 	.se_cmp		= sort__tlb_cmp,
 	.se_snprintf	= hist_entry__tlb_snprintf,
 	.se_width_idx	= HISTC_MEM_TLB,
 };
 
-struct sort_entry sort_mem_lvl = {
+static struct sort_entry sort_mem_lvl = {
 	.se_header	= "Memory access",
 	.se_cmp		= sort__lvl_cmp,
 	.se_snprintf	= hist_entry__lvl_snprintf,
 	.se_width_idx	= HISTC_MEM_LVL,
 };
 
-struct sort_entry sort_mem_snoop = {
+static struct sort_entry sort_mem_snoop = {
 	.se_header	= "Snoop",
 	.se_cmp		= sort__snoop_cmp,
 	.se_snprintf	= hist_entry__snoop_snprintf,
 	.se_width_idx	= HISTC_MEM_SNOOP,
 };
 
-struct sort_entry sort_mem_dcacheline = {
+static struct sort_entry sort_mem_dcacheline = {
 	.se_header	= "Data Cacheline",
 	.se_cmp		= sort__dcacheline_cmp,
 	.se_snprintf	= hist_entry__dcacheline_snprintf,
@@ -2109,7 +2109,7 @@ static int hist_entry__blocked_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%.*s", width, out);
 }
 
-struct sort_entry sort_mem_blocked = {
+static struct sort_entry sort_mem_blocked = {
 	.se_header	= "Blocked",
 	.se_cmp		= sort__blocked_cmp,
 	.se_snprintf	= hist_entry__blocked_snprintf,
@@ -2150,7 +2150,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
 	return width;
 }
 
-struct sort_entry sort_mem_phys_daddr = {
+static struct sort_entry sort_mem_phys_daddr = {
 	.se_header	= "Data Physical Address",
 	.se_cmp		= sort__phys_daddr_cmp,
 	.se_snprintf	= hist_entry__phys_daddr_snprintf,
@@ -2179,7 +2179,7 @@ static int hist_entry__data_page_size_snprintf(struct hist_entry *he, char *bf,
 			get_page_size_name(mem_info__daddr(he->mem_info)->data_page_size, str));
 }
 
-struct sort_entry sort_mem_data_page_size = {
+static struct sort_entry sort_mem_data_page_size = {
 	.se_header	= "Data Page Size",
 	.se_cmp		= sort__data_page_size_cmp,
 	.se_snprintf	= hist_entry__data_page_size_snprintf,
@@ -2204,7 +2204,7 @@ static int hist_entry__code_page_size_snprintf(struct hist_entry *he, char *bf,
 			       get_page_size_name(he->code_page_size, str));
 }
 
-struct sort_entry sort_code_page_size = {
+static struct sort_entry sort_code_page_size = {
 	.se_header	= "Code Page Size",
 	.se_cmp		= sort__code_page_size_cmp,
 	.se_snprintf	= hist_entry__code_page_size_snprintf,
@@ -2236,7 +2236,7 @@ static int hist_entry__abort_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*s", width, out);
 }
 
-struct sort_entry sort_abort = {
+static struct sort_entry sort_abort = {
 	.se_header	= "Transaction abort",
 	.se_cmp		= sort__abort_cmp,
 	.se_snprintf	= hist_entry__abort_snprintf,
@@ -2268,7 +2268,7 @@ static int hist_entry__in_tx_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*s", width, out);
 }
 
-struct sort_entry sort_in_tx = {
+static struct sort_entry sort_in_tx = {
 	.se_header	= "Branch in transaction",
 	.se_cmp		= sort__in_tx_cmp,
 	.se_snprintf	= hist_entry__in_tx_snprintf,
@@ -2340,7 +2340,7 @@ static int hist_entry__transaction_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-*s", width, buf);
 }
 
-struct sort_entry sort_transaction = {
+static struct sort_entry sort_transaction = {
 	.se_header	= "Transaction                ",
 	.se_cmp		= sort__transaction_cmp,
 	.se_snprintf	= hist_entry__transaction_snprintf,
@@ -2379,7 +2379,7 @@ static int hist_entry__sym_size_snprintf(struct hist_entry *he, char *bf,
 	return _hist_entry__sym_size_snprintf(he->ms.sym, bf, size, width);
 }
 
-struct sort_entry sort_sym_size = {
+static struct sort_entry sort_sym_size = {
 	.se_header	= "Symbol size",
 	.se_cmp		= sort__sym_size_cmp,
 	.se_snprintf	= hist_entry__sym_size_snprintf,
@@ -2418,7 +2418,7 @@ static int hist_entry__dso_size_snprintf(struct hist_entry *he, char *bf,
 	return _hist_entry__dso_size_snprintf(he->ms.map, bf, size, width);
 }
 
-struct sort_entry sort_dso_size = {
+static struct sort_entry sort_dso_size = {
 	.se_header	= "DSO size",
 	.se_cmp		= sort__dso_size_cmp,
 	.se_snprintf	= hist_entry__dso_size_snprintf,
@@ -2455,7 +2455,7 @@ static int hist_entry__addr_snprintf(struct hist_entry *he, char *bf,
 	return repsep_snprintf(bf, size, "%-#*llx", width, ip);
 }
 
-struct sort_entry sort_addr = {
+static struct sort_entry sort_addr = {
 	.se_header	= "Address",
 	.se_cmp		= sort__addr_cmp,
 	.se_snprintf	= hist_entry__addr_snprintf,
@@ -2573,7 +2573,7 @@ static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
 			       he->mem_type_off, buf);
 }
 
-struct sort_entry sort_type_offset = {
+static struct sort_entry sort_type_offset = {
 	.se_header	= "Data Type Offset",
 	.se_cmp		= sort__type_cmp,
 	.se_collapse	= sort__typeoff_sort,
@@ -2645,7 +2645,7 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
 			       he->mem_type_off / cln_size);
 }
 
-struct sort_entry sort_type_cacheline = {
+static struct sort_entry sort_type_cacheline = {
 	.se_header	= "Data Type Cacheline",
 	.se_cmp		= sort__type_cmp,
 	.se_collapse	= sort__typecln_sort,
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8b893de35f777db0..c5fee8e394805544 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -77,8 +77,6 @@ bool sysctl__nmi_watchdog_enabled(void)
 	return nmi_watchdog;
 }
 
-bool test_attr__enabled;
-
 bool exclude_GH_default;
 
 bool perf_host  = true;
-- 
2.53.0

