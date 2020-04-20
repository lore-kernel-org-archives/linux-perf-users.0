From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/60] perf machine: Factor out lbr_callchain_add_lbr_ip()
Date: Mon, 20 Apr 2020 08:53:07 -0300
Message-ID: <20200420115316.18781-52-acme@kernel.org>
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

Both caller and callee needs to add ip from LBR to callchain.
Factor out lbr_callchain_add_lbr_ip() to improve code readability.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-9-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 143 +++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a7f75fd43b0f..f9d69fce584a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2224,6 +2224,74 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_lbr_ip(struct thread *thread,
+				    struct callchain_cursor *cursor,
+				    struct perf_sample *sample,
+				    struct symbol **parent,
+				    struct addr_location *root_al,
+				    u64 *branch_from,
+				    bool callee)
+{
+	struct branch_stack *lbr_stack = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int lbr_nr = lbr_stack->nr;
+	struct branch_flags *flags;
+	int err, i;
+	u64 ip;
+
+	if (callee) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+
+		/* Add LBR ip from entries.from one by one. */
+		for (i = 0; i < lbr_nr; i++) {
+			ip = entries[i].from;
+			flags = &entries[i].flags;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	/* Add LBR ip from entries.from one by one. */
+	for (i = lbr_nr - 1; i >= 0; i--) {
+		ip = entries[i].from;
+		flags = &entries[i].flags;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+	}
+
+	/* Add LBR ip from first entries.to */
+	ip = entries[0].to;
+	flags = &entries[0].flags;
+	*branch_from = entries[0].from;
+	err = add_callchain_ip(thread, cursor, parent,
+			       root_al, &cpumode, ip,
+			       true, flags, NULL,
+			       *branch_from);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2240,14 +2308,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
-	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip, branch_from = 0;
-	struct branch_stack *lbr_stack;
-	struct branch_entry *entries;
-	int lbr_nr, j, k;
-	bool branch;
-	struct branch_flags *flags;
-	int mix_chain_nr;
+	u64 branch_from = 0;
 	int err;
 
 	for (i = 0; i < chain_nr; i++) {
@@ -2259,21 +2320,6 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
-	lbr_stack = sample->branch_stack;
-	entries = perf_sample__branch_entries(sample);
-	lbr_nr = lbr_stack->nr;
-	/*
-	 * LBR callstack can only get user call chain.
-	 * The mix_chain_nr is kernel call chain
-	 * number plus LBR user call chain number.
-	 * i is kernel call chain number,
-	 * 1 is PERF_CONTEXT_USER,
-	 * lbr_nr + 1 is the user call chain number.
-	 * For details, please refer to the comments
-	 * in callchain__printf
-	 */
-	mix_chain_nr = i + 1 + lbr_nr + 1;
-
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
@@ -2282,57 +2328,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		if (err)
 			goto error;
 
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, true);
 		if (err)
 			goto error;
 
-		/* Add LBR ip from entries.from one by one. */
-		for (j = i + 2; j < mix_chain_nr; j++) {
-			k = j - i - 2;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
 	} else {
-		/* Add LBR ip from entries.from one by one. */
-		for (j = 0; j < lbr_nr; j++) {
-			k = lbr_nr - j - 1;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
-
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, false);
 		if (err)
 			goto error;
 
-- 
2.21.1
