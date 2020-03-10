From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/19] perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
Date: Tue, 10 Mar 2020 08:15:41 -0300
Message-ID: <20200310111551.25160-10-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new branch sample type PERF_SAMPLE_BRANCH_HW_INDEX has been introduced
in latest kernel.

Enable HW_INDEX by default in LBR call stack mode.

If kernel doesn't support the sample type, switching it off.

Add HW_INDEX in attr_fprintf as well. User can check whether the branch
sample type is set via debug information or header.

Committer testing:

First collect some samples with LBR callchains, system wide, for a few
seconds:

  # perf record --call-graph lbr -a sleep 5
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.625 MB perf.data (224 samples) ]
  #

Now lets use 'perf evlist -v' to look at the branch_sample_type:

  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES|HW_INDEX
  #

So the machine has the kernel feature, and it was correctly added to
perf_event_attr.branch_sample_type, for the default 'cycles' event.

If we do it in another machine, where the kernel lacks the HW_INDEX
feature, we get:

  # perf record --call-graph lbr -a sleep 2s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.690 MB perf.data (499 samples) ]
  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CALLCHAIN|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK|NO_FLAGS|NO_CYCLES
  #

No HW_INDEX in attr.branch_sample_type.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200228163011.19358-3-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c                   | 15 ++++++++++++---
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 05883a45de5b..816d930d774e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
 				attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
 							PERF_SAMPLE_BRANCH_CALL_STACK |
 							PERF_SAMPLE_BRANCH_NO_CYCLES |
-							PERF_SAMPLE_BRANCH_NO_FLAGS;
+							PERF_SAMPLE_BRANCH_NO_FLAGS |
+							PERF_SAMPLE_BRANCH_HW_INDEX;
 			}
 		} else
 			 pr_warning("Cannot use LBR callstack with branch stack. "
@@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
 	if (param->record_mode == CALLCHAIN_LBR) {
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 		attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
-					      PERF_SAMPLE_BRANCH_CALL_STACK);
+					      PERF_SAMPLE_BRANCH_CALL_STACK |
+					      PERF_SAMPLE_BRANCH_HW_INDEX);
 	}
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		perf_evsel__reset_sample_bit(evsel, REGS_USER);
@@ -1673,6 +1675,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.branch_hw_idx)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1784,7 +1788,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.branch_hw_idx &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
+		perf_missing_features.branch_hw_idx = true;
+		pr_debug2("switching off branch HW index support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 99a0cb60c556..33804740e2ca 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool branch_hw_idx;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 651203126c71..355d3458d4e6 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
+		bit_name(HW_INDEX),
 		{ .name = NULL, }
 	};
 #undef bit_name
-- 
2.21.1
