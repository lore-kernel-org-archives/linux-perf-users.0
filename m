From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/60] perf machine: Refine the function for LBR call stack reconstruction
Date: Mon, 20 Apr 2020 08:53:05 -0300
Message-ID: <20200420115316.18781-50-acme@kernel.org>
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

LBR only collect the user call stack. To reconstruct a call stack, both
kernel call stack and user call stack are required. The function
resolve_lbr_callchain_sample() mix the kernel call stack and user call
stack.

Now, with the help of HW idx, perf tool can reconstruct a more complete
call stack by adding some user call stack from previous sample. However,
current implementation is hard to be extended to support it.

Current code path for resolve_lbr_callchain_sample()

  for (j = 0; j < mix_chain_nr; j++) {
       if (ORDER_CALLEE) {
             if (kernel callchain)
                  Fill callchain info
             else if (LBR callchain)
                  Fill callchain info
       } else {
             if (LBR callchain)
                  Fill callchain info
             else if (kernel callchain)
                  Fill callchain info
       }
       add_callchain_ip();
  }

With the patch,

  if (ORDER_CALLEE) {
       for (j = 0; j < NUM of kernel callchain) {
             Fill callchain info
             add_callchain_ip();
       }
       for (; j < mix_chain_nr) {
             Fill callchain info
             add_callchain_ip();
       }
  } else {
       for (; j < NUM of LBR callchain) {
             Fill callchain info
             add_callchain_ip();
       }
       for (j = 0; j < mix_chain_nr) {
             Fill callchain info
             add_callchain_ip();
       }
  }

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-7-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 111 ++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index be1bd9277471..0da540e6f803 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2214,6 +2214,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	bool branch;
 	struct branch_flags *flags;
 	int mix_chain_nr;
+	int err;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2239,50 +2240,90 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	 */
 	mix_chain_nr = i + 1 + lbr_nr + 1;
 
-	for (j = 0; j < mix_chain_nr; j++) {
-		int err;
-
-		branch = false;
-		flags = NULL;
-
-		if (callchain_param.order == ORDER_CALLEE) {
-			if (j < i + 1)
-				ip = chain->ips[j];
-			else if (j > i + 1) {
-				k = j - i - 2;
-				ip = entries[k].from;
-				branch = true;
-				flags = &entries[k].flags;
-			} else {
-				ip = entries[0].to;
-				branch = true;
-				flags = &entries[0].flags;
-				branch_from = entries[0].from;
-			}
-		} else {
-			if (j < lbr_nr) {
-				k = lbr_nr - j - 1;
-				ip = entries[k].from;
-				branch = true;
-				flags = &entries[k].flags;
-			} else if (j > lbr_nr)
-				ip = chain->ips[i + 1 - (j - lbr_nr)];
-			else {
-				ip = entries[0].to;
-				branch = true;
-				flags = &entries[0].flags;
-				branch_from = entries[0].from;
-			}
+	if (callchain_param.order == ORDER_CALLEE) {
+		/* Add kernel ip */
+		for (j = 0; j < i + 1; j++) {
+			ip = chain->ips[j];
+			branch = false;
+			flags = NULL;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
 		}
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		branch = true;
+		flags = &entries[0].flags;
+		branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       branch, flags, NULL,
+				       branch_from);
+		if (err)
+			goto error;
 
+		/* Add LBR ip from entries.from one by one. */
+		for (j = i + 2; j < mix_chain_nr; j++) {
+			k = j - i - 2;
+			ip = entries[k].from;
+			branch = true;
+			flags = &entries[k].flags;
+
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
+	} else {
+		/* Add LBR ip from entries.from one by one. */
+		for (j = 0; j < lbr_nr; j++) {
+			k = lbr_nr - j - 1;
+			ip = entries[k].from;
+			branch = true;
+			flags = &entries[k].flags;
+
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
+
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		branch = true;
+		flags = &entries[0].flags;
+		branch_from = entries[0].from;
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       branch, flags, NULL,
 				       branch_from);
 		if (err)
-			return (err < 0) ? err : 0;
+			goto error;
+
+		/* Add kernel ip */
+		for (j = lbr_nr + 1; j < mix_chain_nr; j++) {
+			ip = chain->ips[i + 1 - (j - lbr_nr)];
+			branch = false;
+			flags = NULL;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       branch, flags, NULL,
+					       branch_from);
+			if (err)
+				goto error;
+		}
 	}
 	return 1;
+
+error:
+	return (err < 0) ? err : 0;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
-- 
2.21.1
