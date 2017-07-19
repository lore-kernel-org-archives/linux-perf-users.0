From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 72/86] perf header: Don't pass struct perf_file_section to process_##_feat
Date: Wed, 19 Jul 2017 11:29:36 -0300
Message-ID: <20170719142950.3747-73-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

struct perf_file_section is used in process_##_feat as container for
size and offset in the file descriptor. These attributes are meaninful
in pipe-mode but struct perf_file_section is not.

Add offset and size variables to struct feat_fd to store
perf_file_section's values in file-mode. Later on, the same variables
can be reused for pipe-mode.

This patch does not change behavior.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-10-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 58 ++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 22b52e5636a6..60394d27e8f5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -62,6 +62,8 @@ struct perf_file_attr {
 struct feat_fd {
 	struct perf_header	*ph;
 	int			fd;
+	ssize_t			offset;
+	size_t			size;
 };
 
 void perf_header__set_feat(struct perf_header *header, int feat)
@@ -1593,8 +1595,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
 
 /* Macro for features that simply need to read and store a string. */
 #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
-static int process_##__feat(struct perf_file_section *section __maybe_unused, \
-			    struct feat_fd *ff, void *data __maybe_unused) \
+static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
 {\
 	ff->ph->env.__feat_env = do_read_string(ff->fd, ff->ph); \
 	return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
@@ -1607,24 +1608,21 @@ FEAT_PROCESS_STR_FUN(arch, arch);
 FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
 
-static int process_tracing_data(struct perf_file_section *section __maybe_unused,
-				struct feat_fd *ff, void *data)
+static int process_tracing_data(struct feat_fd *ff, void *data)
 {
 	ssize_t ret = trace_report(ff->fd, data, false);
 
 	return ret < 0 ? -1 : 0;
 }
 
-static int process_build_id(struct perf_file_section *section,
-			    struct feat_fd *ff, void *data __maybe_unused)
+static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 {
-	if (perf_header__read_build_ids(ff->ph, ff->fd, section->offset, section->size))
+	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
 		pr_debug("Failed to read buildids, continuing...\n");
 	return 0;
 }
 
-static int process_nrcpus(struct perf_file_section *section __maybe_unused,
-			  struct feat_fd *ff, void *data __maybe_unused)
+static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 {
 	int ret;
 	u32 nr_cpus_avail, nr_cpus_online;
@@ -1641,8 +1639,7 @@ static int process_nrcpus(struct perf_file_section *section __maybe_unused,
 	return 0;
 }
 
-static int process_total_mem(struct perf_file_section *section __maybe_unused,
-			     struct feat_fd *ff, void *data __maybe_unused)
+static int process_total_mem(struct feat_fd *ff, void *data __maybe_unused)
 {
 	u64 total_mem;
 	int ret;
@@ -1687,8 +1684,7 @@ perf_evlist__set_event_name(struct perf_evlist *evlist,
 }
 
 static int
-process_event_desc(struct perf_file_section *section __maybe_unused,
-		   struct feat_fd *ff, void *data __maybe_unused)
+process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
 	struct perf_evsel *evsel, *events = read_event_desc(ff->ph, ff->fd);
@@ -1705,8 +1701,7 @@ process_event_desc(struct perf_file_section *section __maybe_unused,
 	return 0;
 }
 
-static int process_cmdline(struct perf_file_section *section __maybe_unused,
-			   struct feat_fd *ff, void *data __maybe_unused)
+static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 {
 	char *str, *cmdline = NULL, **argv = NULL;
 	u32 nr, i, len = 0;
@@ -1716,7 +1711,7 @@ static int process_cmdline(struct perf_file_section *section __maybe_unused,
 
 	ff->ph->env.nr_cmdline = nr;
 
-	cmdline = zalloc(section->size + nr + 1);
+	cmdline = zalloc(ff->size + nr + 1);
 	if (!cmdline)
 		return -1;
 
@@ -1744,8 +1739,7 @@ static int process_cmdline(struct perf_file_section *section __maybe_unused,
 	return -1;
 }
 
-static int process_cpu_topology(struct perf_file_section *section __maybe_unused,
-				struct feat_fd *ff, void *data __maybe_unused)
+static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 {
 	u32 nr, i;
 	char *str;
@@ -1802,7 +1796,7 @@ static int process_cpu_topology(struct perf_file_section *section __maybe_unused
 	 * The header may be from old perf,
 	 * which doesn't include core id and socket id information.
 	 */
-	if (section->size <= size) {
+	if (ff->size <= size) {
 		zfree(&ph->env.cpu);
 		return 0;
 	}
@@ -1834,8 +1828,7 @@ static int process_cpu_topology(struct perf_file_section *section __maybe_unused
 	return -1;
 }
 
-static int process_numa_topology(struct perf_file_section *section __maybe_unused,
-				 struct feat_fd *ff, void *data __maybe_unused)
+static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct numa_node *nodes, *n;
 	u32 nr, i;
@@ -1881,8 +1874,7 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 	return -1;
 }
 
-static int process_pmu_mappings(struct perf_file_section *section __maybe_unused,
-				struct feat_fd *ff, void *data __maybe_unused)
+static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 {
 	char *name;
 	u32 pmu_num;
@@ -1929,8 +1921,7 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 	return -1;
 }
 
-static int process_group_desc(struct perf_file_section *section __maybe_unused,
-			      struct feat_fd *ff, void *data __maybe_unused)
+static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
 	size_t ret = -1;
 	u32 i, nr, nr_groups;
@@ -2014,23 +2005,21 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 	return ret;
 }
 
-static int process_auxtrace(struct perf_file_section *section __maybe_unused,
-			    struct feat_fd *ff, void *data __maybe_unused)
+static int process_auxtrace(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
 
 	session = container_of(ff->ph, struct perf_session, header);
 
-	err = auxtrace_index__process(ff->fd, section->size, session,
+	err = auxtrace_index__process(ff->fd, ff->size, session,
 				      ff->ph->needs_swap);
 	if (err < 0)
 		pr_err("Failed to process auxtrace index\n");
 	return err;
 }
 
-static int process_cache(struct perf_file_section *section __maybe_unused,
-			 struct feat_fd *ff, void *data __maybe_unused)
+static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
@@ -2085,8 +2074,7 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
-	int (*process)(struct perf_file_section *section,
-		       struct feat_fd *ff, void *data);
+	int (*process)(struct feat_fd *ff, void *data);
 	const char *name;
 	bool full_only;
 };
@@ -2617,9 +2605,11 @@ static int perf_file_section__process(struct perf_file_section *section,
 				      struct perf_header *ph,
 				      int feat, int fd, void *data)
 {
-	struct feat_fd ff = {
+	struct feat_fd fdd = {
 		.fd	= fd,
 		.ph	= ph,
+		.size	= section->size,
+		.offset	= section->offset,
 	};
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
@@ -2636,7 +2626,7 @@ static int perf_file_section__process(struct perf_file_section *section,
 	if (!feat_ops[feat].process)
 		return 0;
 
-	return feat_ops[feat].process(section, &ff, data);
+	return feat_ops[feat].process(&fdd, data);
 }
 
 static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
-- 
2.9.4
