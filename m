From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/60] perf header: Support CPU PMU capabilities
Date: Mon, 20 Apr 2020 08:53:03 -0300
Message-ID: <20200420115316.18781-48-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Gerasimov <pavel.gerasimov@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To stitch LBR call stack, the max LBR information is required. So the
CPU PMU capabilities information has to be stored in perf header.

Add a new feature HEADER_CPU_PMU_CAPS for CPU PMU capabilities.
Retrieve all CPU PMU capabilities, not just max LBR information.

Add variable max_branches to facilitate future usage.

Committer testing:

  # ls -la /sys/devices/cpu/caps/
  total 0
  drwxr-xr-x. 2 root root    0 Apr 17 10:53 .
  drwxr-xr-x. 6 root root    0 Apr 17 07:02 ..
  -r--r--r--. 1 root root 4096 Apr 17 10:53 max_precise
  #
  # cat /sys/devices/cpu/caps/max_precise
  0
  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.033 MB perf.data (7 samples) ]
  #
  # perf report --header-only | egrep 'cpu(desc|.*capabilities)'
  # cpudesc : AMD Ryzen 5 3600X 6-Core Processor
  # cpu pmu capabilities: max_precise=0
  #

And then on an Intel machine:

  $ ls -la /sys/devices/cpu/caps/
  total 0
  drwxr-xr-x. 2 root root    0 Apr 17 10:51 .
  drwxr-xr-x. 6 root root    0 Apr 17 10:04 ..
  -r--r--r--. 1 root root 4096 Apr 17 11:37 branches
  -r--r--r--. 1 root root 4096 Apr 17 10:51 max_precise
  -r--r--r--. 1 root root 4096 Apr 17 11:37 pmu_name
  $ cat /sys/devices/cpu/caps/max_precise
  3
  $ cat /sys/devices/cpu/caps/branches
  32
  $ cat /sys/devices/cpu/caps/pmu_name
  skylake
  $ perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
  $ perf report --header-only | egrep 'cpu(desc|.*capabilities)'
  # cpudesc : Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
  $

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Link: http://lore.kernel.org/lkml/20200319202517.23423-3-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   |  16 +++
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/header.c                      | 108 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 4 files changed, 128 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b0152e1095c5..b6472e463284 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -373,6 +373,22 @@ struct {
 Indicates that trace contains records of PERF_RECORD_COMPRESSED type
 that have perf_events records in compressed form.
 
+	HEADER_CPU_PMU_CAPS = 28,
+
+	A list of cpu PMU capabilities. The format of data is as below.
+
+struct {
+	u32 nr_cpu_pmu_caps;
+	{
+		char	name[];
+		char	value[];
+	} [nr_cpu_pmu_caps]
+};
+
+
+Example:
+ cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 7632075a8792..1ab2682d5d2b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -48,6 +48,7 @@ struct perf_env {
 	char			*cpuid;
 	unsigned long long	total_mem;
 	unsigned int		msr_pmu_type;
+	unsigned int		max_branches;
 
 	int			nr_cmdline;
 	int			nr_sibling_cores;
@@ -57,12 +58,14 @@ struct perf_env {
 	int			nr_memory_nodes;
 	int			nr_pmu_mappings;
 	int			nr_groups;
+	int			nr_cpu_pmu_caps;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
 	char			*sibling_dies;
 	char			*sibling_threads;
 	char			*pmu_mappings;
+	char			*cpu_pmu_caps;
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index acbd046bf95c..28e82da04b7a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1395,6 +1395,38 @@ static int write_compressed(struct feat_fd *ff __maybe_unused,
 	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
 }
 
+static int write_cpu_pmu_caps(struct feat_fd *ff,
+			      struct evlist *evlist __maybe_unused)
+{
+	struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");
+	struct perf_pmu_caps *caps = NULL;
+	int nr_caps;
+	int ret;
+
+	if (!cpu_pmu)
+		return -ENOENT;
+
+	nr_caps = perf_pmu__caps_parse(cpu_pmu);
+	if (nr_caps < 0)
+		return nr_caps;
+
+	ret = do_write(ff, &nr_caps, sizeof(nr_caps));
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(caps, &cpu_pmu->caps, list) {
+		ret = do_write_string(ff, caps->name);
+		if (ret < 0)
+			return ret;
+
+		ret = do_write_string(ff, caps->value);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1809,6 +1841,27 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
 }
 
+static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	const char *delimiter = "# cpu pmu capabilities: ";
+	u32 nr_caps = ff->ph->env.nr_cpu_pmu_caps;
+	char *str;
+
+	if (!nr_caps) {
+		fprintf(fp, "# cpu pmu capabilities: not available\n");
+		return;
+	}
+
+	str = ff->ph->env.cpu_pmu_caps;
+	while (nr_caps--) {
+		fprintf(fp, "%s%s", delimiter, str);
+		delimiter = ", ";
+		str += strlen(str) + 1;
+	}
+
+	fprintf(fp, "\n");
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -2846,6 +2899,60 @@ static int process_compressed(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_cpu_pmu_caps(struct feat_fd *ff,
+				void *data __maybe_unused)
+{
+	char *name, *value;
+	struct strbuf sb;
+	u32 nr_caps;
+
+	if (do_read_u32(ff, &nr_caps))
+		return -1;
+
+	if (!nr_caps) {
+		pr_debug("cpu pmu capabilities not available\n");
+		return 0;
+	}
+
+	ff->ph->env.nr_cpu_pmu_caps = nr_caps;
+
+	if (strbuf_init(&sb, 128) < 0)
+		return -1;
+
+	while (nr_caps--) {
+		name = do_read_string(ff);
+		if (!name)
+			goto error;
+
+		value = do_read_string(ff);
+		if (!value)
+			goto free_name;
+
+		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
+			goto free_value;
+
+		/* include a NULL character at the end */
+		if (strbuf_add(&sb, "", 1) < 0)
+			goto free_value;
+
+		if (!strcmp(name, "branches"))
+			ff->ph->env.max_branches = atoi(value);
+
+		free(value);
+		free(name);
+	}
+	ff->ph->env.cpu_pmu_caps = strbuf_detach(&sb, NULL);
+	return 0;
+
+free_value:
+	free(value);
+free_name:
+	free(name);
+error:
+	strbuf_release(&sb);
+	return -1;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -2903,6 +3010,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
 	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
 	FEAT_OPR(COMPRESSED,	compressed,	false),
+	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 840f95cee349..650bd1c7a99b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -43,6 +43,7 @@ enum {
 	HEADER_BPF_PROG_INFO,
 	HEADER_BPF_BTF,
 	HEADER_COMPRESSED,
+	HEADER_CPU_PMU_CAPS,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.21.1
