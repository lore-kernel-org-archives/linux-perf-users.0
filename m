From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/60] perf machine: Factor out lbr_callchain_add_kernel_ip()
Date: Mon, 20 Apr 2020 08:53:06 -0300
Message-ID: <20200420115316.18781-51-acme@kernel.org>
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

Both caller and callee needs to add kernel ip to callchain.  Factor out
lbr_callchain_add_kernel_ip() to improve code readability.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-8-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 67 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0da540e6f803..a7f75fd43b0f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2190,6 +2190,40 @@ static int remove_loops(struct branch_entry *l, int nr,
 	return nr;
 }
 
+static int lbr_callchain_add_kernel_ip(struct thread *thread,
+				       struct callchain_cursor *cursor,
+				       struct perf_sample *sample,
+				       struct symbol **parent,
+				       struct addr_location *root_al,
+				       u64 branch_from,
+				       bool callee, int end)
+{
+	struct ip_callchain *chain = sample->callchain;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int err, i;
+
+	if (callee) {
+		for (i = 0; i < end + 1; i++) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, chain->ips[i],
+					       false, NULL, NULL, branch_from);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	for (i = end; i >= 0; i--) {
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, chain->ips[i],
+				       false, NULL, NULL, branch_from);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2242,17 +2276,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
-		for (j = 0; j < i + 1; j++) {
-			ip = chain->ips[j];
-			branch = false;
-			flags = NULL;
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, branch_from,
+						  true, i);
+		if (err)
+			goto error;
+
 		/* Add LBR ip from first entries.to */
 		ip = entries[0].to;
 		branch = true;
@@ -2308,17 +2337,11 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 			goto error;
 
 		/* Add kernel ip */
-		for (j = lbr_nr + 1; j < mix_chain_nr; j++) {
-			ip = chain->ips[i + 1 - (j - lbr_nr)];
-			branch = false;
-			flags = NULL;
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, branch_from,
+						  false, i);
+		if (err)
+			goto error;
 	}
 	return 1;
 
-- 
2.21.1
