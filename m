From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/8] perf mem/c2c: Fix perf_mem_events to support powerpc
Date: Tue,  5 Feb 2019 12:07:02 -0300
Message-ID: <20190205150708.9012-3-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Dick Fowles <fowles@inreach.com>, Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

PowerPC hardware does not have a builtin latency filter (--ldlat) for
the "mem-load" event and perf_mem_events by default includes
"/ldlat=30/" which is causing a failure on PowerPC. Refactor the code to
support "perf mem/c2c" on PowerPC.

This patch depends on kernel side changes done my Madhavan:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Dick Fowles <fowles@inreach.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20190129132412.771-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt     |  2 +-
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
 tools/perf/util/mem-events.c              |  2 +-
 5 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 095aebdc5bb7..e6150f21267d 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-The tool is based on x86's load latency and precise store facility events
-provided by Intel CPUs. These events provide:
+On x86, the tool is based on load latency and precise store facility events
+provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
+with thresholding feature.
+
+These events provide:
   - memory address of the access
   - type of the access (load and store details)
   - latency (in cycles) of the load access
@@ -46,7 +49,7 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency.
+	Configure mem-loads latency. (x86 only)
 
 -k::
 --all-kernel::
@@ -119,11 +122,16 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default:
+default on x86:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+and following on PowerPC:
+
+  cpu/mem-loads/
+  cpu/mem-stores/
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167cf3e7..199ea0f0a6c0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -82,7 +82,7 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event.
+	Specify desired latency for loads event. (x86 only)
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 2e6595310420..ba98bd006488 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += mem-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
new file mode 100644
index 000000000000..d08311f04e95
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mem-events.h"
+
+/* PowerPC does not support 'ldlat' parameter. */
+char *perf_mem_events__name(int i)
+{
+	if (i == PERF_MEM_EVENTS__LOAD)
+		return (char *) "cpu/mem-loads/";
+
+	return (char *) "cpu/mem-stores/";
+}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 93f74d8d3cdd..42c3e5a229d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
-char *perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i)
 {
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
-- 
2.20.1
