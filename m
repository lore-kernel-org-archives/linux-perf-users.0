From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/27] perf script: Allow sym and dso without ip, addr
Date: Mon, 24 Sep 2018 12:02:19 -0300
Message-ID: <20180924150242.14235-5-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Currently sym and dso require printing ip and addr because the print
function is tied to those outputs. With callindent it makes sense to
print the symbol or dso without numerical IP or ADDR. So change the
dependency check to only check the underlying attribute.

Also the branch target output relies on the user_set flag to determine
if the branch target should be implicitely printed. When modifying the
fields with + or - also set user_set, so that ADDR can be removed. We
also need to set wildcard_set to make the initial sanity check pass.

This allows to remove a lot of noise in callindent output by dropping
the numerical addresses, which are not all that useful.

Before

% perf script --itrace=cr -F +callindent
         swapper     0 [000] 156546.354971:          1   branches: pt_config                                       0 [unknown] ([unknown]) => ffffffff81010486 pt_config ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     pt_config                    ffffffff81010499 pt_config ([kernel.kallsyms]) => ffffffff8101063e pt_event_add ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     pt_event_add                 ffffffff81010635 pt_event_add ([kernel.kallsyms]) => ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_enable              ffffffff8115e726 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff811579b0 perf_pmu_enable ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     perf_pmu_nop_void            ffffffff81151730 perf_pmu_nop_void ([kernel.kallsyms]) => ffffffff8115e72b event_sched_in.isra.107 ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     event_sched_in.isra.107      ffffffff8115e737 event_sched_in.isra.107 ([kernel.kallsyms]) => ffffffff8115e7a5 group_sched_in ([kernel.kallsyms])
         swapper     0 [000] 156546.354971:          1   branches:     __x86_indirect_thunk_rax     ffffffff8115e7f6 group_sched_in ([kernel.kallsyms]) => ffffffff81a03000 __x86_indirect_thunk_rax ([kernel.kallsyms])

After

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff
       swapper     0 [000] 156546.354971:          1   branches:  pt_config
         swapper     0 [000] 156546.354971:          1   branches:      pt_config
         swapper     0 [000] 156546.354971:          1   branches:      pt_event_add
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_enable
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_void
         swapper     0 [000] 156546.354971:          1   branches:       event_sched_in.isra.107
         swapper     0 [000] 156546.354971:          1   branches:       __x86_indirect_thunk_rax
         swapper     0 [000] 156546.354971:          1   branches:       perf_pmu_nop_int
         swapper     0 [000] 156546.354971:          1   branches:       group_sched_in
         swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
         swapper     0 [000] 156546.354971:          1   branches:       event_filter_match
         swapper     0 [000] 156546.354971:          1   branches:       group_sched_in

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180918123214.26728-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 66699dd351e0..7aa59696e97a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -406,9 +406,10 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					PERF_OUTPUT_WEIGHT))
 		return -EINVAL;
 
-	if (PRINT_FIELD(SYM) && !PRINT_FIELD(IP) && !PRINT_FIELD(ADDR)) {
+	if (PRINT_FIELD(SYM) &&
+		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
-			   "sample address\nis selected. Hence, no addresses to convert "
+			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
 		return -EINVAL;
 	}
@@ -417,10 +418,9 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 		       "selected.\n");
 		return -EINVAL;
 	}
-	if (PRINT_FIELD(DSO) && !PRINT_FIELD(IP) && !PRINT_FIELD(ADDR) &&
-	    !PRINT_FIELD(BRSTACK) && !PRINT_FIELD(BRSTACKSYM) && !PRINT_FIELD(BRSTACKOFF)) {
-		pr_err("Display of DSO requested but no address to convert.  Select\n"
-		       "sample IP, sample address, brstack, brstacksym, or brstackoff.\n");
+	if (PRINT_FIELD(DSO) &&
+		!(evsel->attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(SRCLINE) && !PRINT_FIELD(IP)) {
@@ -2491,6 +2491,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 						output[j].fields &= ~all_output_options[i].field;
 					else
 						output[j].fields |= all_output_options[i].field;
+					output[j].user_set = true;
+					output[j].wildcard_set = true;
 				}
 			}
 		} else {
@@ -2501,7 +2503,8 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
-			output[type].fields |= all_output_options[i].field;
+			output[type].user_set = true;
+			output[type].wildcard_set = true;
 		}
 	}
 
-- 
2.14.4
