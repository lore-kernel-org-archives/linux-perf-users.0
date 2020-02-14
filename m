From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/23] perf tools: Add arm64 version of get_cpuid()
Date: Fri, 14 Feb 2020 16:10:50 -0300
Message-ID: <20200214191057.26266-17-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add an arm64 version of get_cpuid(), which is used for various annotation
and headers - for example, I now get the CPUID in "perf report --header",
as shown in this snippet:

  # hostname : ubuntu
  # os release : 5.5.0-rc1-dirty
  # perf version : 5.5.rc1.gbf8a13dc9851
  # arch : aarch64
  # nrcpus online : 96
  # nrcpus avail : 96
  # cpuid : 0x00000000480fd010

Since much of the code to read the MIDR is already in get_cpuid_str(),
factor out this code.

Tester notes:

I tested this patch on my new ARM64 Kunpeng 920 server.
[root@node1 zsk]# ./perf --version
perf version 5.6.rc1.g2cdb955b7252

Both perf list and perf stat can work.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1576245255-210926-1-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/header.c | 63 ++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index a32e4b72a98f..d730666ab95d 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,8 +1,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
+#include <util/cpumap.h>
 #include <internal/cpumap.h>
 #include <api/fs/fs.h>
+#include <errno.h>
 #include "debug.h"
 #include "header.h"
 
@@ -12,26 +14,21 @@
 #define MIDR_VARIANT_SHIFT      20
 #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
 
-char *get_cpuid_str(struct perf_pmu *pmu)
+static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
-	char *buf = NULL;
-	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
-	int cpu;
 	u64 midr = 0;
-	struct perf_cpu_map *cpus;
-	FILE *file;
+	int cpu;
 
-	if (!sysfs || !pmu || !pmu->cpus)
-		return NULL;
+	if (!sysfs || sz < MIDR_SIZE)
+		return EINVAL;
 
-	buf = malloc(MIDR_SIZE);
-	if (!buf)
-		return NULL;
+	cpus = perf_cpu_map__get(cpus);
 
-	/* read midr from list of cpus mapped to this pmu */
-	cpus = perf_cpu_map__get(pmu->cpus);
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+		char path[PATH_MAX];
+		FILE *file;
+
 		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
 				sysfs, cpus->map[cpu]);
 
@@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		break;
 	}
 
-	if (!midr) {
+	perf_cpu_map__put(cpus);
+
+	if (!midr)
+		return EINVAL;
+
+	return 0;
+}
+
+int get_cpuid(char *buf, size_t sz)
+{
+	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
+	int ret;
+
+	if (!cpus)
+		return EINVAL;
+
+	ret = _get_cpuid(buf, sz, cpus);
+
+	perf_cpu_map__put(cpus);
+
+	return ret;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	char *buf = NULL;
+	int res;
+
+	if (!pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
+	if (res) {
 		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
 		free(buf);
 		buf = NULL;
 	}
 
-	perf_cpu_map__put(cpus);
 	return buf;
 }
-- 
2.21.1
