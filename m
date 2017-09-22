From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/44] perf record: Support direct --user-regs arguments
Date: Fri, 22 Sep 2017 11:41:49 -0300
Message-ID: <20170922144220.9411-14-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

USER_REGS can currently only collected implicitely with call graph
recording. Sometimes it is useful to see them separately, and filter
them. Add a new --user-regs option to record that is similar to
--intr-regs, but acts on user regs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170905170029.19722-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 2 ++
 tools/perf/builtin-record.c              | 3 +++
 tools/perf/perf.h                        | 1 +
 tools/perf/util/evsel.c                  | 7 ++++++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e397453e5a46..68a1ffb0a8a5 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -377,6 +377,8 @@ symbolic names, e.g. on x86, ax, si. To list the available registers use
 --intr-regs=\?. To name registers, pass a comma separated list such as
 --intr-regs=ax,bx. The list of register is architecture dependent.
 
+--user-regs::
+Capture user registers at sample time. Same arguments as -I.
 
 --running-time::
 Record running and enabled time for read events (:S)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 56f8142ff97f..9b379f3a3d99 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1643,6 +1643,9 @@ static struct option __record_options[] = {
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
 		    " use -I ? to list register names", parse_regs),
+	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
+		    "sample selected machine registers on interrupt,"
+		    " use -I ? to list register names", parse_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index dc442ba21bf6..fbb0a9cd0ac6 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -65,6 +65,7 @@ struct record_opts {
 	unsigned int user_freq;
 	u64          branch_stack;
 	u64	     sample_intr_regs;
+	u64	     sample_user_regs;
 	u64	     default_interval;
 	u64	     user_interval;
 	size_t	     auxtrace_snapshot_size;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4bb89373eb52..7389746c0dc4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -678,7 +678,7 @@ void perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user = PERF_REGS_MASK;
+			attr->sample_regs_user |= PERF_REGS_MASK;
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
@@ -931,6 +931,11 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		perf_evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
+	if (opts->sample_user_regs) {
+		attr->sample_regs_user |= opts->sample_user_regs;
+		perf_evsel__set_sample_bit(evsel, REGS_USER);
+	}
+
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
 
-- 
2.13.5
