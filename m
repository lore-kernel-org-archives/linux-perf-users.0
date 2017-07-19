From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 71/86] perf header: Use struct feat_fd to process header records
Date: Wed, 19 Jul 2017 11:29:35 -0300
Message-ID: <20170719142950.3747-72-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

As preparation for using header records in pipe-mode, replace int fd
with struct feat_fd ff in process functions for all header record types.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-9-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 164 +++++++++++++++++++++++------------------------
 1 file changed, 79 insertions(+), 85 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 58e888ae13d4..22b52e5636a6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1594,11 +1594,10 @@ static int perf_header__read_build_ids(struct perf_header *header,
 /* Macro for features that simply need to read and store a string. */
 #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
 static int process_##__feat(struct perf_file_section *section __maybe_unused, \
-			    struct perf_header *ph, int fd,		      \
-			    void *data __maybe_unused) \
+			    struct feat_fd *ff, void *data __maybe_unused) \
 {\
-	ph->env.__feat_env = do_read_string(fd, ph); \
-	return ph->env.__feat_env ? 0 : -ENOMEM; \
+	ff->ph->env.__feat_env = do_read_string(ff->fd, ff->ph); \
+	return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
 }
 
 FEAT_PROCESS_STR_FUN(hostname, hostname);
@@ -1609,52 +1608,49 @@ FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
 
 static int process_tracing_data(struct perf_file_section *section __maybe_unused,
-				struct perf_header *ph __maybe_unused,
-				int fd, void *data)
+				struct feat_fd *ff, void *data)
 {
-	ssize_t ret = trace_report(fd, data, false);
+	ssize_t ret = trace_report(ff->fd, data, false);
+
 	return ret < 0 ? -1 : 0;
 }
 
 static int process_build_id(struct perf_file_section *section,
-			    struct perf_header *ph, int fd,
-			    void *data __maybe_unused)
+			    struct feat_fd *ff, void *data __maybe_unused)
 {
-	if (perf_header__read_build_ids(ph, fd, section->offset, section->size))
+	if (perf_header__read_build_ids(ff->ph, ff->fd, section->offset, section->size))
 		pr_debug("Failed to read buildids, continuing...\n");
 	return 0;
 }
 
 static int process_nrcpus(struct perf_file_section *section __maybe_unused,
-			  struct perf_header *ph, int fd,
-			  void *data __maybe_unused)
+			  struct feat_fd *ff, void *data __maybe_unused)
 {
 	int ret;
 	u32 nr_cpus_avail, nr_cpus_online;
 
-	ret = do_read_u32(fd, ph, &nr_cpus_avail);
+	ret = do_read_u32(ff->fd, ff->ph, &nr_cpus_avail);
 	if (ret)
 		return ret;
 
-	ret = do_read_u32(fd, ph, &nr_cpus_online);
+	ret = do_read_u32(ff->fd, ff->ph, &nr_cpus_online);
 	if (ret)
 		return ret;
-	ph->env.nr_cpus_avail = (int)nr_cpus_avail;
-	ph->env.nr_cpus_online = (int)nr_cpus_online;
+	ff->ph->env.nr_cpus_avail = (int)nr_cpus_avail;
+	ff->ph->env.nr_cpus_online = (int)nr_cpus_online;
 	return 0;
 }
 
 static int process_total_mem(struct perf_file_section *section __maybe_unused,
-			     struct perf_header *ph, int fd,
-			     void *data __maybe_unused)
+			     struct feat_fd *ff, void *data __maybe_unused)
 {
 	u64 total_mem;
 	int ret;
 
-	ret = do_read_u64(fd, ph, &total_mem);
+	ret = do_read_u64(ff->fd, ff->ph, &total_mem);
 	if (ret)
 		return -1;
-	ph->env.total_mem = (unsigned long long)total_mem;
+	ff->ph->env.total_mem = (unsigned long long)total_mem;
 	return 0;
 }
 
@@ -1692,16 +1688,15 @@ perf_evlist__set_event_name(struct perf_evlist *evlist,
 
 static int
 process_event_desc(struct perf_file_section *section __maybe_unused,
-		   struct perf_header *header, int fd,
-		   void *data __maybe_unused)
+		   struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
-	struct perf_evsel *evsel, *events = read_event_desc(header, fd);
+	struct perf_evsel *evsel, *events = read_event_desc(ff->ph, ff->fd);
 
 	if (!events)
 		return 0;
 
-	session = container_of(header, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 	for (evsel = events; evsel->attr.size; evsel++)
 		perf_evlist__set_event_name(session->evlist, evsel);
 
@@ -1710,17 +1705,16 @@ process_event_desc(struct perf_file_section *section __maybe_unused,
 	return 0;
 }
 
-static int process_cmdline(struct perf_file_section *section,
-			   struct perf_header *ph, int fd,
-			   void *data __maybe_unused)
+static int process_cmdline(struct perf_file_section *section __maybe_unused,
+			   struct feat_fd *ff, void *data __maybe_unused)
 {
 	char *str, *cmdline = NULL, **argv = NULL;
 	u32 nr, i, len = 0;
 
-	if (do_read_u32(fd, ph, &nr))
+	if (do_read_u32(ff->fd, ff->ph, &nr))
 		return -1;
 
-	ph->env.nr_cmdline = nr;
+	ff->ph->env.nr_cmdline = nr;
 
 	cmdline = zalloc(section->size + nr + 1);
 	if (!cmdline)
@@ -1731,7 +1725,7 @@ static int process_cmdline(struct perf_file_section *section,
 		goto error;
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(fd, ph);
+		str = do_read_string(ff->fd, ff->ph);
 		if (!str)
 			goto error;
 
@@ -1740,8 +1734,8 @@ static int process_cmdline(struct perf_file_section *section,
 		len += strlen(str) + 1;
 		free(str);
 	}
-	ph->env.cmdline = cmdline;
-	ph->env.cmdline_argv = (const char **) argv;
+	ff->ph->env.cmdline = cmdline;
+	ff->ph->env.cmdline_argv = (const char **) argv;
 	return 0;
 
 error:
@@ -1750,21 +1744,21 @@ static int process_cmdline(struct perf_file_section *section,
 	return -1;
 }
 
-static int process_cpu_topology(struct perf_file_section *section,
-				struct perf_header *ph, int fd,
-				void *data __maybe_unused)
+static int process_cpu_topology(struct perf_file_section *section __maybe_unused,
+				struct feat_fd *ff, void *data __maybe_unused)
 {
 	u32 nr, i;
 	char *str;
 	struct strbuf sb;
-	int cpu_nr = ph->env.nr_cpus_avail;
+	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
+	struct perf_header *ph = ff->ph;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
 		return -1;
 
-	if (do_read_u32(fd, ph, &nr))
+	if (do_read_u32(ff->fd, ph, &nr))
 		goto free_cpu;
 
 	ph->env.nr_sibling_cores = nr;
@@ -1773,7 +1767,7 @@ static int process_cpu_topology(struct perf_file_section *section,
 		goto free_cpu;
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(fd, ph);
+		str = do_read_string(ff->fd, ph);
 		if (!str)
 			goto error;
 
@@ -1785,14 +1779,14 @@ static int process_cpu_topology(struct perf_file_section *section,
 	}
 	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
 
-	if (do_read_u32(fd, ph, &nr))
+	if (do_read_u32(ff->fd, ph, &nr))
 		return -1;
 
 	ph->env.nr_sibling_threads = nr;
 	size += sizeof(u32);
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(fd, ph);
+		str = do_read_string(ff->fd, ph);
 		if (!str)
 			goto error;
 
@@ -1814,12 +1808,12 @@ static int process_cpu_topology(struct perf_file_section *section,
 	}
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
-		if (do_read_u32(fd, ph, &nr))
+		if (do_read_u32(ff->fd, ph, &nr))
 			goto free_cpu;
 
 		ph->env.cpu[i].core_id = nr;
 
-		if (do_read_u32(fd, ph, &nr))
+		if (do_read_u32(ff->fd, ph, &nr))
 			goto free_cpu;
 
 		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
@@ -1841,15 +1835,14 @@ static int process_cpu_topology(struct perf_file_section *section,
 }
 
 static int process_numa_topology(struct perf_file_section *section __maybe_unused,
-				 struct perf_header *ph, int fd,
-				 void *data __maybe_unused)
+				 struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct numa_node *nodes, *n;
 	u32 nr, i;
 	char *str;
 
 	/* nr nodes */
-	if (do_read_u32(fd, ph, &nr))
+	if (do_read_u32(ff->fd, ff->ph, &nr))
 		return -1;
 
 	nodes = zalloc(sizeof(*nodes) * nr);
@@ -1860,16 +1853,16 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 		n = &nodes[i];
 
 		/* node number */
-		if (do_read_u32(fd, ph, &n->node))
+		if (do_read_u32(ff->fd, ff->ph, &n->node))
 			goto error;
 
-		if (do_read_u64(fd, ph, &n->mem_total))
+		if (do_read_u64(ff->fd, ff->ph, &n->mem_total))
 			goto error;
 
-		if (do_read_u64(fd, ph, &n->mem_free))
+		if (do_read_u64(ff->fd, ff->ph, &n->mem_free))
 			goto error;
 
-		str = do_read_string(fd, ph);
+		str = do_read_string(ff->fd, ff->ph);
 		if (!str)
 			goto error;
 
@@ -1879,8 +1872,8 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 
 		free(str);
 	}
-	ph->env.nr_numa_nodes = nr;
-	ph->env.numa_nodes = nodes;
+	ff->ph->env.nr_numa_nodes = nr;
+	ff->ph->env.numa_nodes = nodes;
 	return 0;
 
 error:
@@ -1889,15 +1882,14 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 }
 
 static int process_pmu_mappings(struct perf_file_section *section __maybe_unused,
-				struct perf_header *ph, int fd,
-				void *data __maybe_unused)
+				struct feat_fd *ff, void *data __maybe_unused)
 {
 	char *name;
 	u32 pmu_num;
 	u32 type;
 	struct strbuf sb;
 
-	if (do_read_u32(fd, ph, &pmu_num))
+	if (do_read_u32(ff->fd, ff->ph, &pmu_num))
 		return -1;
 
 	if (!pmu_num) {
@@ -1905,15 +1897,15 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 		return 0;
 	}
 
-	ph->env.nr_pmu_mappings = pmu_num;
+	ff->ph->env.nr_pmu_mappings = pmu_num;
 	if (strbuf_init(&sb, 128) < 0)
 		return -1;
 
 	while (pmu_num) {
-		if (do_read_u32(fd, ph, &type))
+		if (do_read_u32(ff->fd, ff->ph, &type))
 			goto error;
 
-		name = do_read_string(fd, ph);
+		name = do_read_string(ff->fd, ff->ph);
 		if (!name)
 			goto error;
 
@@ -1924,12 +1916,12 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 			goto error;
 
 		if (!strcmp(name, "msr"))
-			ph->env.msr_pmu_type = type;
+			ff->ph->env.msr_pmu_type = type;
 
 		free(name);
 		pmu_num--;
 	}
-	ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
+	ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
 	return 0;
 
 error:
@@ -1938,8 +1930,7 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 }
 
 static int process_group_desc(struct perf_file_section *section __maybe_unused,
-			      struct perf_header *ph, int fd,
-			      void *data __maybe_unused)
+			      struct feat_fd *ff, void *data __maybe_unused)
 {
 	size_t ret = -1;
 	u32 i, nr, nr_groups;
@@ -1951,10 +1942,10 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 		u32 nr_members;
 	} *desc;
 
-	if (do_read_u32(fd, ph, &nr_groups))
+	if (do_read_u32(ff->fd, ff->ph, &nr_groups))
 		return -1;
 
-	ph->env.nr_groups = nr_groups;
+	ff->ph->env.nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
 		return 0;
@@ -1965,21 +1956,21 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 		return -1;
 
 	for (i = 0; i < nr_groups; i++) {
-		desc[i].name = do_read_string(fd, ph);
+		desc[i].name = do_read_string(ff->fd, ff->ph);
 		if (!desc[i].name)
 			goto out_free;
 
-		if (do_read_u32(fd, ph, &desc[i].leader_idx))
+		if (do_read_u32(ff->fd, ff->ph, &desc[i].leader_idx))
 			goto out_free;
 
-		if (do_read_u32(fd, ph, &desc[i].nr_members))
+		if (do_read_u32(ff->fd, ff->ph, &desc[i].nr_members))
 			goto out_free;
 	}
 
 	/*
 	 * Rebuild group relationship based on the group_desc
 	 */
-	session = container_of(ph, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 	session->evlist->nr_groups = nr_groups;
 
 	i = nr = 0;
@@ -2023,36 +2014,34 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 	return ret;
 }
 
-static int process_auxtrace(struct perf_file_section *section,
-			    struct perf_header *ph, int fd,
-			    void *data __maybe_unused)
+static int process_auxtrace(struct perf_file_section *section __maybe_unused,
+			    struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
 
-	session = container_of(ph, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 
-	err = auxtrace_index__process(fd, section->size, session,
-				      ph->needs_swap);
+	err = auxtrace_index__process(ff->fd, section->size, session,
+				      ff->ph->needs_swap);
 	if (err < 0)
 		pr_err("Failed to process auxtrace index\n");
 	return err;
 }
 
 static int process_cache(struct perf_file_section *section __maybe_unused,
-			 struct perf_header *ph __maybe_unused, int fd __maybe_unused,
-			 void *data __maybe_unused)
+			 struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
 
-	if (do_read_u32(fd, ph, &version))
+	if (do_read_u32(ff->fd, ff->ph, &version))
 		return -1;
 
 	if (version != 1)
 		return -1;
 
-	if (do_read_u32(fd, ph, &cnt))
+	if (do_read_u32(ff->fd, ff->ph, &cnt))
 		return -1;
 
 	caches = zalloc(sizeof(*caches) * cnt);
@@ -2063,7 +2052,7 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 		struct cpu_cache_level c;
 
 		#define _R(v)						\
-			if (do_read_u32(fd, ph, &c.v))\
+			if (do_read_u32(ff->fd, ff->ph, &c.v))\
 				goto out_free_caches;			\
 
 		_R(level)
@@ -2072,9 +2061,9 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 		_R(ways)
 		#undef _R
 
-		#define _R(v)				\
-			c.v = do_read_string(fd, ph);	\
-			if (!c.v)			\
+		#define _R(v)					\
+			c.v = do_read_string(ff->fd, ff->ph);	\
+			if (!c.v)				\
 				goto out_free_caches;
 
 		_R(type)
@@ -2085,8 +2074,8 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 		caches[i] = c;
 	}
 
-	ph->env.caches = caches;
-	ph->env.caches_cnt = cnt;
+	ff->ph->env.caches = caches;
+	ff->ph->env.caches_cnt = cnt;
 	return 0;
 out_free_caches:
 	free(caches);
@@ -2097,7 +2086,7 @@ struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
 	int (*process)(struct perf_file_section *section,
-		       struct perf_header *h, int fd, void *data);
+		       struct feat_fd *ff, void *data);
 	const char *name;
 	bool full_only;
 };
@@ -2628,6 +2617,11 @@ static int perf_file_section__process(struct perf_file_section *section,
 				      struct perf_header *ph,
 				      int feat, int fd, void *data)
 {
+	struct feat_fd ff = {
+		.fd	= fd,
+		.ph	= ph,
+	};
+
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
 		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
 			  "%d, continuing...\n", section->offset, feat);
@@ -2642,7 +2636,7 @@ static int perf_file_section__process(struct perf_file_section *section,
 	if (!feat_ops[feat].process)
 		return 0;
 
-	return feat_ops[feat].process(section, ph, fd, data);
+	return feat_ops[feat].process(section, &ff, data);
 }
 
 static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
-- 
2.9.4
