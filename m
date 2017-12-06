From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/36] perf tools arm64: Add support for get_cpuid_str
 function.
Date: Wed,  6 Dec 2017 11:40:59 -0300
Message-ID: <20171206144115.15097-21-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ganapatrao Kulkarni <gklkml16@gmail.com>, Jayachandran C <jnair@caviumnetworks.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Robert Richter <robert.richter@cavium.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

The get_cpuid_str function returns the MIDR string of the first online
cpu from the range of cpus associated with the PMU CORE device.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20171016183222.25750-3-ganapatrao.kulkarni@cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/Build    |  1 +
 tools/perf/arch/arm64/util/header.c | 65 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/header.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index cef6fb38d17e..b1ab72d2a42e 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,3 +1,4 @@
+libperf-y += header.o
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 
diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
new file mode 100644
index 000000000000..534cd2507d83
--- /dev/null
+++ b/tools/perf/arch/arm64/util/header.c
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include "header.h"
+
+#define MIDR "/regs/identification/midr_el1"
+#define MIDR_SIZE 19
+#define MIDR_REVISION_MASK      0xf
+#define MIDR_VARIANT_SHIFT      20
+#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	int cpu;
+	u64 midr = 0;
+	struct cpu_map *cpus;
+	FILE *file;
+
+	if (!sysfs || !pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	cpus = cpu_map__get(pmu->cpus);
+	for (cpu = 0; cpu < cpus->nr; cpu++) {
+		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
+				sysfs, cpus->map[cpu]);
+
+		file = fopen(path, "r");
+		if (!file) {
+			pr_debug("fopen failed for file %s\n", path);
+			continue;
+		}
+
+		if (!fgets(buf, MIDR_SIZE, file)) {
+			fclose(file);
+			continue;
+		}
+		fclose(file);
+
+		/* Ignore/clear Variant[23:20] and
+		 * Revision[3:0] of MIDR
+		 */
+		midr = strtoul(buf, NULL, 16);
+		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
+		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
+		/* got midr break loop */
+		break;
+	}
+
+	if (!midr) {
+		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
+		free(buf);
+		buf = NULL;
+	}
+
+	cpu_map__put(cpus);
+	return buf;
+}
-- 
2.13.6
