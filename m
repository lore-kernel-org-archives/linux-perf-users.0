From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/60] perf pmu: Add support for PMU capabilities
Date: Mon, 20 Apr 2020 08:53:00 -0300
Message-ID: <20200420115316.18781-45-acme@kernel.org>
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

The PMU capabilities information, which is located at
/sys/bus/event_source/devices/<dev>/caps, is required by perf tool.  For
example, the max LBR information is required to stitch LBR call stack.

Add perf_pmu__caps_parse() to parse the PMU capabilities information.
The information is stored in a list.

The following patch will store the capabilities information in perf
header.

Committer notes:

Here's an example of such directories and its files in an i5 7th gen
machine:

  [root@seventh ~]# ls -lad /sys/bus/event_source/devices/*/caps
  drwxr-xr-x. 2 root root 0 Apr 14 13:33 /sys/bus/event_source/devices/cpu/caps
  drwxr-xr-x. 2 root root 0 Apr 14 13:33 /sys/bus/event_source/devices/intel_pt/caps
  [root@seventh ~]# ls -la /sys/bus/event_source/devices/intel_pt/caps
  total 0
  drwxr-xr-x. 2 root root    0 Apr 14 13:33 .
  drwxr-xr-x. 5 root root    0 Apr 14 13:12 ..
  -r--r--r--. 1 root root 4096 Apr 16 13:10 cr3_filtering
  -r--r--r--. 1 root root 4096 Apr 16 11:42 cycle_thresholds
  -r--r--r--. 1 root root 4096 Apr 16 13:10 ip_filtering
  -r--r--r--. 1 root root 4096 Apr 16 13:10 max_subleaf
  -r--r--r--. 1 root root 4096 Apr 14 13:33 mtc
  -r--r--r--. 1 root root 4096 Apr 14 13:33 mtc_periods
  -r--r--r--. 1 root root 4096 Apr 16 13:10 num_address_ranges
  -r--r--r--. 1 root root 4096 Apr 16 13:10 output_subsys
  -r--r--r--. 1 root root 4096 Apr 16 13:10 payloads_lip
  -r--r--r--. 1 root root 4096 Apr 16 13:10 power_event_trace
  -r--r--r--. 1 root root 4096 Apr 14 13:33 psb_cyc
  -r--r--r--. 1 root root 4096 Apr 14 13:33 psb_periods
  -r--r--r--. 1 root root 4096 Apr 16 13:10 ptwrite
  -r--r--r--. 1 root root 4096 Apr 16 13:10 single_range_output
  -r--r--r--. 1 root root 4096 Apr 16 12:03 topa_multiple_entries
  -r--r--r--. 1 root root 4096 Apr 16 13:10 topa_output
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/topa_output
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/topa_multiple_entries
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/mtc
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/power_event_trace
  0
  [root@seventh ~]#

  [root@seventh ~]# ls -la /sys/bus/event_source/devices/cpu/caps/
  total 0
  drwxr-xr-x. 2 root root    0 Apr 14 13:33 .
  drwxr-xr-x. 6 root root    0 Apr 14 13:12 ..
  -r--r--r--. 1 root root 4096 Apr 16 13:10 branches
  -r--r--r--. 1 root root 4096 Apr 14 13:33 max_precise
  -r--r--r--. 1 root root 4096 Apr 16 13:10 pmu_name
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/max_precise
  3
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/branches
  32
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/pmu_name
  skylake
  [root@seventh ~]#

Wow, first time I've heard about
/sys/bus/event_source/devices/cpu/caps/max_precise, I think I'll use it!
:-)

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  9 +++++
 2 files changed, 91 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bc912a84b5e9..d9f89ed18dea 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -850,6 +850,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
@@ -1594,3 +1595,84 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	va_end(args);
 	return ret;
 }
+
+static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
+{
+	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
+
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name)
+		goto free_caps;
+	caps->value = strndup(value, strlen(value) - 1);
+	if (!caps->value)
+		goto free_name;
+	list_add_tail(&caps->list, list);
+	return 0;
+
+free_name:
+	zfree(caps->name);
+free_caps:
+	free(caps);
+
+	return -ENOMEM;
+}
+
+/*
+ * Reading/parsing the given pmu capabilities, which should be located at:
+ * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
+ * Return the number of capabilities
+ */
+int perf_pmu__caps_parse(struct perf_pmu *pmu)
+{
+	struct stat st;
+	char caps_path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	DIR *caps_dir;
+	struct dirent *evt_ent;
+	int nr_caps = 0;
+
+	if (!sysfs)
+		return -1;
+
+	snprintf(caps_path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
+
+	if (stat(caps_path, &st) < 0)
+		return 0;	/* no error if caps does not exist */
+
+	caps_dir = opendir(caps_path);
+	if (!caps_dir)
+		return -EINVAL;
+
+	while ((evt_ent = readdir(caps_dir)) != NULL) {
+		char path[PATH_MAX + NAME_MAX + 1];
+		char *name = evt_ent->d_name;
+		char value[128];
+		FILE *file;
+
+		if (!strcmp(name, ".") || !strcmp(name, ".."))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		if (!fgets(value, sizeof(value), file) ||
+		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
+			fclose(file);
+			continue;
+		}
+
+		nr_caps++;
+		fclose(file);
+	}
+
+	closedir(caps_dir);
+
+	return nr_caps;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5fb3f16828df..1edd214b75a5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -22,6 +22,12 @@ enum {
 
 struct perf_event_attr;
 
+struct perf_pmu_caps {
+	char *name;
+	char *value;
+	struct list_head list;
+};
+
 struct perf_pmu {
 	char *name;
 	__u32 type;
@@ -33,6 +39,7 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 };
 
@@ -107,4 +114,6 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+int perf_pmu__caps_parse(struct perf_pmu *pmu);
+
 #endif /* __PMU_H */
-- 
2.21.1
