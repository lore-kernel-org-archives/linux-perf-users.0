From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/31] perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc
Date: Fri, 20 Sep 2019 11:25:42 -0300
Message-ID: <20190920142542.12047-32-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Use 'trace_imc/trace_cycles' as the default event for 'perf kvm record'
in powerpc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-3-anju@linux.vnet.ibm.com
[ Add missing pmu.h header, needed because this patch uses pmu_have_event() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index ec5b771029e4..9cc1c4a9dec4 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -5,6 +5,7 @@
 #include "util/debug.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
+#include "util/pmu.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
@@ -177,8 +178,9 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
 /*
  * Incase of powerpc architecture, pmu registers are programmable
  * by guest kernel. So monitoring guest via host may not provide
- * valid samples. It is better to fail the "perf kvm record"
- * with default "cycles" event to monitor guest in powerpc.
+ * valid samples with default 'cycles' event. It is better to use
+ * 'trace_imc/trace_cycles' event for guest profiling, since it
+ * can track the guest instruction pointer in the trace-record.
  *
  * Function to parse the arguments and return appropriate values.
  */
@@ -202,8 +204,14 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
 
 	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
 	if (!event) {
-		free(tmp);
-		return -EINVAL;
+		if (pmu_have_event("trace_imc", "trace_cycles")) {
+			argv[j++] = strdup("-e");
+			argv[j++] = strdup("trace_imc/trace_cycles/");
+			*argc += 2;
+		} else {
+			free(tmp);
+			return -EINVAL;
+		}
 	}
 
 	free(tmp);
-- 
2.21.0
