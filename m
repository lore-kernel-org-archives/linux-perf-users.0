From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/27] perf script: Print DSO for callindent
Date: Mon, 24 Sep 2018 12:02:20 -0300
Message-ID: <20180924150242.14235-6-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Now that we don't need to print the IP/ADDR for callindent the DSO is
also not printed. It's useful for some cases, so add an own DSO printout
for callindent for the case when IP/ADDR is not enabled.

Before:

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff,-addr
         swapper     0 [000]  3377.917072:          1   branches: pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_event_add
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches:     event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches:     __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in

After:

         swapper     0 [000]  3377.917072:          1   branches: ([unknown])   pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_event_add
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           perf_pmu_nop_txn
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           event_sched_in.isra.107

(in the kernel case of course it's not very useful, but it's important
with user programs where symbols are not unique)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180918123214.26728-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7aa59696e97a..7732346bd9dd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1115,6 +1115,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
+	int dlen = 0;
 	u64 ip = 0;
 
 	/*
@@ -1141,6 +1142,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 			ip = sample->ip;
 	}
 
+	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
+		dlen += fprintf(fp, "(");
+		dlen += map__fprintf_dsoname(al->map, fp);
+		dlen += fprintf(fp, ")\t");
+	}
+
 	if (name)
 		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
@@ -1159,7 +1166,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (len < spacing)
 		len += fprintf(fp, "%*s", spacing - len, "");
 
-	return len;
+	return len + dlen;
 }
 
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
-- 
2.14.4
