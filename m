From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/36] perf pmu: Add helper function is_pmu_core to detect PMU CORE devices
Date: Wed,  6 Dec 2017 11:41:00 -0300
Message-ID: <20171206144115.15097-22-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

On some platforms, PMU core devices sysfs name is not cpu.
Adding function is_pmu_core to detect PMU core devices using
core device specific hints in sysfs.

For arm64 platforms, all core devices have file "cpus" in sysfs.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Tested-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-y1woxt1k2pqqwpprhonnft2s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4e7dd3a0f123..732ff579ec65 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -537,6 +537,34 @@ static bool pmu_is_uncore(const char *name)
 }
 
 /*
+ *  PMU CORE devices have different name other than cpu in sysfs on some
+ *  platforms. looking for possible sysfs files to identify as core device.
+ */
+static int is_pmu_core(const char *name)
+{
+	struct stat st;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs)
+		return 0;
+
+	/* Look for cpu sysfs (x86 and others) */
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
+	if ((stat(path, &st) == 0) &&
+			(strncmp(name, "cpu", strlen("cpu")) == 0))
+		return 1;
+
+	/* Look for cpu sysfs (specific to arm) */
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
+				sysfs, name);
+	if (stat(path, &st) == 0)
+		return 1;
+
+	return 0;
+}
+
+/*
  * Return the CPU id as a raw string.
  *
  * Each architecture should provide a more precise id string that
@@ -609,7 +637,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	 */
 	i = 0;
 	while (1) {
-		const char *pname;
 
 		pe = &map->table[i++];
 		if (!pe->name) {
@@ -618,9 +645,13 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		pname = pe->pmu ? pe->pmu : "cpu";
-		if (strncmp(pname, name, strlen(pname)))
-			continue;
+		if (!is_pmu_core(name)) {
+			/* check for uncore devices */
+			if (pe->pmu == NULL)
+				continue;
+			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+				continue;
+		}
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-- 
2.13.6
