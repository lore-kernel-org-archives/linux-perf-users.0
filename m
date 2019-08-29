From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/37] perf tools: Warn that perf_event_paranoid can restrict kernel symbols
Date: Thu, 29 Aug 2019 11:38:46 -0300
Message-ID: <20190829143917.29745-7-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Igor Lubashev <ilubashe@akamai.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, James Morris <jmorris@namei.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

Warn that /proc/sys/kernel/perf_event_paranoid can also restrict kernel
symbols.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-6-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/builtin-trace.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 359bb8f33e57..afe558449677 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2372,7 +2372,7 @@ int cmd_record(int argc, const char **argv)
 	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-"check /proc/sys/kernel/kptr_restrict.\n\n"
+"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Samples in kernel functions may not be resolved if a suitable vmlinux\n"
 "file is not found in the buildid cache or in the vmlinux path.\n\n"
 "Samples in kernel modules won't be resolved at all.\n\n"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5970723cd55a..29e910fb2d9a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -770,7 +770,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		if (!perf_evlist__exclude_kernel(top->session->evlist)) {
 			ui__warning(
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-"Check /proc/sys/kernel/kptr_restrict.\n\n"
+"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Kernel%s samples will not be resolved.\n",
 			  al.map && map__has_symbols(al.map) ?
 			  " modules" : "");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8ea62fd2591d..58a75dd3a571 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1382,7 +1382,7 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 
 	if (symbol_conf.kptr_restrict) {
 		pr_warning("Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-			   "Check /proc/sys/kernel/kptr_restrict.\n\n"
+			   "Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 			   "Kernel samples will not be resolved.\n");
 		machine->kptr_restrict_warned = true;
 		return NULL;
-- 
2.21.0
