From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/60] perf machine: Remove the indent in resolve_lbr_callchain_sample
Date: Mon, 20 Apr 2020 08:53:04 -0300
Message-ID: <20200420115316.18781-49-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The indent is unnecessary in resolve_lbr_callchain_sample.  Removing it
will make the following patch simpler.

Current code path for resolve_lbr_callchain_sample()

        /* LBR only affects the user callchain */
        if (i != chain_nr) {
                body of the function
                ....
                return 1;
        }

        return 0;

With the patch,

        /* LBR only affects the user callchain */
        if (i == chain_nr)
                return 0;

        body of the function
        ...
        return 1;

No functional changes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-6-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 123 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 09845eae9c03..be1bd9277471 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2208,6 +2208,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	u64 ip, branch_from = 0;
+	struct branch_stack *lbr_stack;
+	struct branch_entry *entries;
+	int lbr_nr, j, k;
+	bool branch;
+	struct branch_flags *flags;
+	int mix_chain_nr;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2215,71 +2221,68 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	}
 
 	/* LBR only affects the user callchain */
-	if (i != chain_nr) {
-		struct branch_stack *lbr_stack = sample->branch_stack;
-		struct branch_entry *entries = perf_sample__branch_entries(sample);
-		int lbr_nr = lbr_stack->nr, j, k;
-		bool branch;
-		struct branch_flags *flags;
-		/*
-		 * LBR callstack can only get user call chain.
-		 * The mix_chain_nr is kernel call chain
-		 * number plus LBR user call chain number.
-		 * i is kernel call chain number,
-		 * 1 is PERF_CONTEXT_USER,
-		 * lbr_nr + 1 is the user call chain number.
-		 * For details, please refer to the comments
-		 * in callchain__printf
-		 */
-		int mix_chain_nr = i + 1 + lbr_nr + 1;
-
-		for (j = 0; j < mix_chain_nr; j++) {
-			int err;
-			branch = false;
-			flags = NULL;
+	if (i == chain_nr)
+		return 0;
 
-			if (callchain_param.order == ORDER_CALLEE) {
-				if (j < i + 1)
-					ip = chain->ips[j];
-				else if (j > i + 1) {
-					k = j - i - 2;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				} else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+	lbr_stack = sample->branch_stack;
+	entries = perf_sample__branch_entries(sample);
+	lbr_nr = lbr_stack->nr;
+	/*
+	 * LBR callstack can only get user call chain.
+	 * The mix_chain_nr is kernel call chain
+	 * number plus LBR user call chain number.
+	 * i is kernel call chain number,
+	 * 1 is PERF_CONTEXT_USER,
+	 * lbr_nr + 1 is the user call chain number.
+	 * For details, please refer to the comments
+	 * in callchain__printf
+	 */
+	mix_chain_nr = i + 1 + lbr_nr + 1;
+
+	for (j = 0; j < mix_chain_nr; j++) {
+		int err;
+
+		branch = false;
+		flags = NULL;
+
+		if (callchain_param.order == ORDER_CALLEE) {
+			if (j < i + 1)
+				ip = chain->ips[j];
+			else if (j > i + 1) {
+				k = j - i - 2;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
 			} else {
-				if (j < lbr_nr) {
-					k = lbr_nr - j - 1;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				}
-				else if (j > lbr_nr)
-					ip = chain->ips[i + 1 - (j - lbr_nr)];
-				else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
+			}
+		} else {
+			if (j < lbr_nr) {
+				k = lbr_nr - j - 1;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
+			} else if (j > lbr_nr)
+				ip = chain->ips[i + 1 - (j - lbr_nr)];
+			else {
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
 			}
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				return (err < 0) ? err : 0;
 		}
-		return 1;
-	}
 
-	return 0;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       branch, flags, NULL,
+				       branch_from);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
+	return 1;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
-- 
2.21.1
