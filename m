From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 70/86] perf header: Use struct feat_fd for print
Date: Wed, 19 Jul 2017 11:29:34 -0300
Message-ID: <20170719142950.3747-71-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

As preparation for using header records in pipe mode, replace int fd
with struct feat_fd ff in print functions for all header record types.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-8-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 102 ++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a5db9aded45b..58e888ae13d4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1116,62 +1116,56 @@ static int write_stat(struct feat_fd *ff __maybe_unused,
 	return 0;
 }
 
-static void print_hostname(struct perf_header *ph, int fd __maybe_unused,
-			   FILE *fp)
+static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# hostname : %s\n", ph->env.hostname);
+	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
 }
 
-static void print_osrelease(struct perf_header *ph, int fd __maybe_unused,
-			    FILE *fp)
+static void print_osrelease(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# os release : %s\n", ph->env.os_release);
+	fprintf(fp, "# os release : %s\n", ff->ph->env.os_release);
 }
 
-static void print_arch(struct perf_header *ph, int fd __maybe_unused, FILE *fp)
+static void print_arch(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# arch : %s\n", ph->env.arch);
+	fprintf(fp, "# arch : %s\n", ff->ph->env.arch);
 }
 
-static void print_cpudesc(struct perf_header *ph, int fd __maybe_unused,
-			  FILE *fp)
+static void print_cpudesc(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# cpudesc : %s\n", ph->env.cpu_desc);
+	fprintf(fp, "# cpudesc : %s\n", ff->ph->env.cpu_desc);
 }
 
-static void print_nrcpus(struct perf_header *ph, int fd __maybe_unused,
-			 FILE *fp)
+static void print_nrcpus(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# nrcpus online : %u\n", ph->env.nr_cpus_online);
-	fprintf(fp, "# nrcpus avail : %u\n", ph->env.nr_cpus_avail);
+	fprintf(fp, "# nrcpus online : %u\n", ff->ph->env.nr_cpus_online);
+	fprintf(fp, "# nrcpus avail : %u\n", ff->ph->env.nr_cpus_avail);
 }
 
-static void print_version(struct perf_header *ph, int fd __maybe_unused,
-			  FILE *fp)
+static void print_version(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# perf version : %s\n", ph->env.version);
+	fprintf(fp, "# perf version : %s\n", ff->ph->env.version);
 }
 
-static void print_cmdline(struct perf_header *ph, int fd __maybe_unused,
-			  FILE *fp)
+static void print_cmdline(struct feat_fd *ff, FILE *fp)
 {
 	int nr, i;
 
-	nr = ph->env.nr_cmdline;
+	nr = ff->ph->env.nr_cmdline;
 
 	fprintf(fp, "# cmdline : ");
 
 	for (i = 0; i < nr; i++)
-		fprintf(fp, "%s ", ph->env.cmdline_argv[i]);
+		fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
 	fputc('\n', fp);
 }
 
-static void print_cpu_topology(struct perf_header *ph, int fd __maybe_unused,
-			       FILE *fp)
+static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 {
+	struct perf_header *ph = ff->ph;
+	int cpu_nr = ph->env.nr_cpus_avail;
 	int nr, i;
 	char *str;
-	int cpu_nr = ph->env.nr_cpus_avail;
 
 	nr = ph->env.nr_sibling_cores;
 	str = ph->env.sibling_cores;
@@ -1297,9 +1291,9 @@ static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,
 	return fprintf(fp, ", %s = %s", name, val);
 }
 
-static void print_event_desc(struct perf_header *ph, int fd, FILE *fp)
+static void print_event_desc(struct feat_fd *ff, FILE *fp)
 {
-	struct perf_evsel *evsel, *events = read_event_desc(ph, fd);
+	struct perf_evsel *evsel, *events = read_event_desc(ff->ph, ff->fd);
 	u32 j;
 	u64 *id;
 
@@ -1329,20 +1323,18 @@ static void print_event_desc(struct perf_header *ph, int fd, FILE *fp)
 	free_event_desc(events);
 }
 
-static void print_total_mem(struct perf_header *ph, int fd __maybe_unused,
-			    FILE *fp)
+static void print_total_mem(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# total memory : %Lu kB\n", ph->env.total_mem);
+	fprintf(fp, "# total memory : %llu kB\n", ff->ph->env.total_mem);
 }
 
-static void print_numa_topology(struct perf_header *ph, int fd __maybe_unused,
-				FILE *fp)
+static void print_numa_topology(struct feat_fd *ff, FILE *fp)
 {
 	int i;
 	struct numa_node *n;
 
-	for (i = 0; i < ph->env.nr_numa_nodes; i++) {
-		n = &ph->env.numa_nodes[i];
+	for (i = 0; i < ff->ph->env.nr_numa_nodes; i++) {
+		n = &ff->ph->env.numa_nodes[i];
 
 		fprintf(fp, "# node%u meminfo  : total = %"PRIu64" kB,"
 			    " free = %"PRIu64" kB\n",
@@ -1353,56 +1345,51 @@ static void print_numa_topology(struct perf_header *ph, int fd __maybe_unused,
 	}
 }
 
-static void print_cpuid(struct perf_header *ph, int fd __maybe_unused, FILE *fp)
+static void print_cpuid(struct feat_fd *ff, FILE *fp)
 {
-	fprintf(fp, "# cpuid : %s\n", ph->env.cpuid);
+	fprintf(fp, "# cpuid : %s\n", ff->ph->env.cpuid);
 }
 
-static void print_branch_stack(struct perf_header *ph __maybe_unused,
-			       int fd __maybe_unused, FILE *fp)
+static void print_branch_stack(struct feat_fd *ff __maybe_unused, FILE *fp)
 {
 	fprintf(fp, "# contains samples with branch stack\n");
 }
 
-static void print_auxtrace(struct perf_header *ph __maybe_unused,
-			   int fd __maybe_unused, FILE *fp)
+static void print_auxtrace(struct feat_fd *ff __maybe_unused, FILE *fp)
 {
 	fprintf(fp, "# contains AUX area data (e.g. instruction trace)\n");
 }
 
-static void print_stat(struct perf_header *ph __maybe_unused,
-		       int fd __maybe_unused, FILE *fp)
+static void print_stat(struct feat_fd *ff __maybe_unused, FILE *fp)
 {
 	fprintf(fp, "# contains stat data\n");
 }
 
-static void print_cache(struct perf_header *ph __maybe_unused,
-			int fd __maybe_unused, FILE *fp __maybe_unused)
+static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
 {
 	int i;
 
 	fprintf(fp, "# CPU cache info:\n");
-	for (i = 0; i < ph->env.caches_cnt; i++) {
+	for (i = 0; i < ff->ph->env.caches_cnt; i++) {
 		fprintf(fp, "#  ");
-		cpu_cache_level__fprintf(fp, &ph->env.caches[i]);
+		cpu_cache_level__fprintf(fp, &ff->ph->env.caches[i]);
 	}
 }
 
-static void print_pmu_mappings(struct perf_header *ph, int fd __maybe_unused,
-			       FILE *fp)
+static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
 	char *str, *tmp;
 	u32 pmu_num;
 	u32 type;
 
-	pmu_num = ph->env.nr_pmu_mappings;
+	pmu_num = ff->ph->env.nr_pmu_mappings;
 	if (!pmu_num) {
 		fprintf(fp, "# pmu mappings: not available\n");
 		return;
 	}
 
-	str = ph->env.pmu_mappings;
+	str = ff->ph->env.pmu_mappings;
 
 	while (pmu_num) {
 		type = strtoul(str, &tmp, 0);
@@ -1425,14 +1412,13 @@ static void print_pmu_mappings(struct perf_header *ph, int fd __maybe_unused,
 	fprintf(fp, "# pmu mappings: unable to read\n");
 }
 
-static void print_group_desc(struct perf_header *ph, int fd __maybe_unused,
-			     FILE *fp)
+static void print_group_desc(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_session *session;
 	struct perf_evsel *evsel;
 	u32 nr = 0;
 
-	session = container_of(ph, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel) &&
@@ -2109,7 +2095,7 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
-	void (*print)(struct perf_header *h, int fd, FILE *fp);
+	void (*print)(struct feat_fd *ff, FILE *fp);
 	int (*process)(struct perf_file_section *section,
 		       struct perf_header *h, int fd, void *data);
 	const char *name;
@@ -2162,6 +2148,7 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 					   int feat, int fd, void *data)
 {
 	struct header_print_data *hd = data;
+	struct feat_fd ff;
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
 		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
@@ -2175,8 +2162,13 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 	if (!feat_ops[feat].print)
 		return 0;
 
+	ff = (struct  feat_fd) {
+		.fd = fd,
+		.ph = ph,
+	};
+
 	if (!feat_ops[feat].full_only || hd->full)
-		feat_ops[feat].print(ph, fd, hd->fp);
+		feat_ops[feat].print(&ff, hd->fp);
 	else
 		fprintf(hd->fp, "# %s info available, use -I to display\n",
 			feat_ops[feat].name);
-- 
2.9.4
