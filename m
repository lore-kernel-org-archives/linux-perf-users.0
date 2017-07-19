From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 69/86] perf header: Add struct feat_fd for write
Date: Wed, 19 Jul 2017 11:29:33 -0300
Message-ID: <20170719142950.3747-70-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Introduce struct feat_fd. This patch uses it as a wrapper around fd in
write_* functions for feature headers. Next patches will extend its
functionality to other feature header functions.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-7-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c |   8 +-
 tools/perf/util/build-id.h |   4 +-
 tools/perf/util/header.c   | 230 ++++++++++++++++++++++++---------------------
 tools/perf/util/header.h   |   7 +-
 4 files changed, 138 insertions(+), 111 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 4baa5329439f..c1a06fcd7e70 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -289,7 +289,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 		else
 
 static int write_buildid(const char *name, size_t name_len, u8 *build_id,
-			 pid_t pid, u16 misc, int fd)
+			 pid_t pid, u16 misc, struct feat_fd *fd)
 {
 	int err;
 	struct build_id_event b;
@@ -311,7 +311,8 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
 	return write_padded(fd, name, name_len + 1, len);
 }
 
-static int machine__write_buildid_table(struct machine *machine, int fd)
+static int machine__write_buildid_table(struct machine *machine,
+					struct feat_fd *fd)
 {
 	int err = 0;
 	char nm[PATH_MAX];
@@ -356,7 +357,8 @@ static int machine__write_buildid_table(struct machine *machine, int fd)
 	return err;
 }
 
-int perf_session__write_buildid_table(struct perf_session *session, int fd)
+int perf_session__write_buildid_table(struct perf_session *session,
+				      struct feat_fd *fd)
 {
 	struct rb_node *nd;
 	int err = machine__write_buildid_table(&session->machines.host, fd);
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 113dc0615c57..c94b0dcbfd74 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -10,6 +10,7 @@
 
 extern struct perf_tool build_id__mark_dso_hit_ops;
 struct dso;
+struct feat_fd;
 
 int build_id__sprintf(const u8 *build_id, int len, char *bf);
 int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
@@ -27,7 +28,8 @@ int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 int dsos__hit_all(struct perf_session *session);
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
-int perf_session__write_buildid_table(struct perf_session *session, int fd);
+int perf_session__write_buildid_table(struct perf_session *session,
+				      struct feat_fd *fd);
 int perf_session__cache_build_ids(struct perf_session *session);
 
 char *build_id_cache__origname(const char *sbuild_id);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 954f0ef8e712..a5db9aded45b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -59,6 +59,11 @@ struct perf_file_attr {
 	struct perf_file_section	ids;
 };
 
+struct feat_fd {
+	struct perf_header	*ph;
+	int			fd;
+};
+
 void perf_header__set_feat(struct perf_header *header, int feat)
 {
 	set_bit(feat, header->adds_features);
@@ -75,11 +80,11 @@ bool perf_header__has_feat(const struct perf_header *header, int feat)
 }
 
 /* Return: 0 if succeded, -ERR if failed. */
-int do_write(int fd, const void *buf, size_t size)
+int do_write(struct feat_fd *ff, const void *buf, size_t size)
 {
 	ssize_t ret;
 
-	ret  = writen(fd, buf, size);
+	ret  = writen(ff->fd, buf, size);
 	if (ret != (ssize_t)size)
 		return ret < 0 ? (int)ret : -1;
 
@@ -87,13 +92,14 @@ int do_write(int fd, const void *buf, size_t size)
 }
 
 /* Return: 0 if succeded, -ERR if failed. */
-int write_padded(int fd, const void *bf, size_t count, size_t count_aligned)
+int write_padded(struct feat_fd *ff, const void *bf,
+		 size_t count, size_t count_aligned)
 {
 	static const char zero_buf[NAME_ALIGN];
-	int err = do_write(fd, bf, count);
+	int err = do_write(ff, bf, count);
 
 	if (!err)
-		err = do_write(fd, zero_buf, count_aligned - count);
+		err = do_write(ff, zero_buf, count_aligned - count);
 
 	return err;
 }
@@ -102,7 +108,7 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned)
 	(PERF_ALIGN((strlen(str) + 1), NAME_ALIGN) + sizeof(u32))
 
 /* Return: 0 if succeded, -ERR if failed. */
-static int do_write_string(int fd, const char *str)
+static int do_write_string(struct feat_fd *ff, const char *str)
 {
 	u32 len, olen;
 	int ret;
@@ -111,11 +117,11 @@ static int do_write_string(int fd, const char *str)
 	len = PERF_ALIGN(olen, NAME_ALIGN);
 
 	/* write len, incl. \0 */
-	ret = do_write(fd, &len, sizeof(len));
+	ret = do_write(ff, &len, sizeof(len));
 	if (ret < 0)
 		return ret;
 
-	return write_padded(fd, str, olen, len);
+	return write_padded(ff, str, olen, len);
 }
 
 static int __do_read(int fd, void *addr, ssize_t size)
@@ -178,25 +184,24 @@ static char *do_read_string(int fd, struct perf_header *ph)
 	return NULL;
 }
 
-static int write_tracing_data(int fd, struct perf_header *h __maybe_unused,
-			    struct perf_evlist *evlist)
+static int write_tracing_data(struct feat_fd *ff,
+			      struct perf_evlist *evlist)
 {
-	return read_tracing_data(fd, &evlist->entries);
+	return read_tracing_data(ff->fd, &evlist->entries);
 }
 
-
-static int write_build_id(int fd, struct perf_header *h,
+static int write_build_id(struct feat_fd *ff,
 			  struct perf_evlist *evlist __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
 
-	session = container_of(h, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 
 	if (!perf_session__read_build_ids(session, true))
 		return -1;
 
-	err = perf_session__write_buildid_table(session, fd);
+	err = perf_session__write_buildid_table(session, ff);
 	if (err < 0) {
 		pr_debug("failed to write buildid table\n");
 		return err;
@@ -206,7 +211,7 @@ static int write_build_id(int fd, struct perf_header *h,
 	return 0;
 }
 
-static int write_hostname(int fd, struct perf_header *h __maybe_unused,
+static int write_hostname(struct feat_fd *ff,
 			  struct perf_evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
@@ -216,10 +221,10 @@ static int write_hostname(int fd, struct perf_header *h __maybe_unused,
 	if (ret < 0)
 		return -1;
 
-	return do_write_string(fd, uts.nodename);
+	return do_write_string(ff, uts.nodename);
 }
 
-static int write_osrelease(int fd, struct perf_header *h __maybe_unused,
+static int write_osrelease(struct feat_fd *ff,
 			   struct perf_evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
@@ -229,10 +234,10 @@ static int write_osrelease(int fd, struct perf_header *h __maybe_unused,
 	if (ret < 0)
 		return -1;
 
-	return do_write_string(fd, uts.release);
+	return do_write_string(ff, uts.release);
 }
 
-static int write_arch(int fd, struct perf_header *h __maybe_unused,
+static int write_arch(struct feat_fd *ff,
 		      struct perf_evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
@@ -242,16 +247,16 @@ static int write_arch(int fd, struct perf_header *h __maybe_unused,
 	if (ret < 0)
 		return -1;
 
-	return do_write_string(fd, uts.machine);
+	return do_write_string(ff, uts.machine);
 }
 
-static int write_version(int fd, struct perf_header *h __maybe_unused,
+static int write_version(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
-	return do_write_string(fd, perf_version_string);
+	return do_write_string(ff, perf_version_string);
 }
 
-static int __write_cpudesc(int fd, const char *cpuinfo_proc)
+static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 {
 	FILE *file;
 	char *buf = NULL;
@@ -301,14 +306,14 @@ static int __write_cpudesc(int fd, const char *cpuinfo_proc)
 		}
 		p++;
 	}
-	ret = do_write_string(fd, s);
+	ret = do_write_string(ff, s);
 done:
 	free(buf);
 	fclose(file);
 	return ret;
 }
 
-static int write_cpudesc(int fd, struct perf_header *h __maybe_unused,
+static int write_cpudesc(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
 {
 #ifndef CPUINFO_PROC
@@ -319,7 +324,7 @@ static int write_cpudesc(int fd, struct perf_header *h __maybe_unused,
 
 	for (i = 0; i < ARRAY_SIZE(cpuinfo_procs); i++) {
 		int ret;
-		ret = __write_cpudesc(fd, cpuinfo_procs[i]);
+		ret = __write_cpudesc(ff, cpuinfo_procs[i]);
 		if (ret >= 0)
 			return ret;
 	}
@@ -327,7 +332,7 @@ static int write_cpudesc(int fd, struct perf_header *h __maybe_unused,
 }
 
 
-static int write_nrcpus(int fd, struct perf_header *h __maybe_unused,
+static int write_nrcpus(struct feat_fd *ff,
 			struct perf_evlist *evlist __maybe_unused)
 {
 	long nr;
@@ -342,14 +347,14 @@ static int write_nrcpus(int fd, struct perf_header *h __maybe_unused,
 
 	nra = (u32)(nr & UINT_MAX);
 
-	ret = do_write(fd, &nrc, sizeof(nrc));
+	ret = do_write(ff, &nrc, sizeof(nrc));
 	if (ret < 0)
 		return ret;
 
-	return do_write(fd, &nra, sizeof(nra));
+	return do_write(ff, &nra, sizeof(nra));
 }
 
-static int write_event_desc(int fd, struct perf_header *h __maybe_unused,
+static int write_event_desc(struct feat_fd *ff,
 			    struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
@@ -361,7 +366,7 @@ static int write_event_desc(int fd, struct perf_header *h __maybe_unused,
 	/*
 	 * write number of events
 	 */
-	ret = do_write(fd, &nre, sizeof(nre));
+	ret = do_write(ff, &nre, sizeof(nre));
 	if (ret < 0)
 		return ret;
 
@@ -369,12 +374,12 @@ static int write_event_desc(int fd, struct perf_header *h __maybe_unused,
 	 * size of perf_event_attr struct
 	 */
 	sz = (u32)sizeof(evsel->attr);
-	ret = do_write(fd, &sz, sizeof(sz));
+	ret = do_write(ff, &sz, sizeof(sz));
 	if (ret < 0)
 		return ret;
 
 	evlist__for_each_entry(evlist, evsel) {
-		ret = do_write(fd, &evsel->attr, sz);
+		ret = do_write(ff, &evsel->attr, sz);
 		if (ret < 0)
 			return ret;
 		/*
@@ -385,27 +390,27 @@ static int write_event_desc(int fd, struct perf_header *h __maybe_unused,
 		 * type of ids,
 		 */
 		nri = evsel->ids;
-		ret = do_write(fd, &nri, sizeof(nri));
+		ret = do_write(ff, &nri, sizeof(nri));
 		if (ret < 0)
 			return ret;
 
 		/*
 		 * write event string as passed on cmdline
 		 */
-		ret = do_write_string(fd, perf_evsel__name(evsel));
+		ret = do_write_string(ff, perf_evsel__name(evsel));
 		if (ret < 0)
 			return ret;
 		/*
 		 * write unique ids for this event
 		 */
-		ret = do_write(fd, evsel->id, evsel->ids * sizeof(u64));
+		ret = do_write(ff, evsel->id, evsel->ids * sizeof(u64));
 		if (ret < 0)
 			return ret;
 	}
 	return 0;
 }
 
-static int write_cmdline(int fd, struct perf_header *h __maybe_unused,
+static int write_cmdline(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
 	char buf[MAXPATHLEN];
@@ -423,16 +428,16 @@ static int write_cmdline(int fd, struct perf_header *h __maybe_unused,
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
 
-	ret = do_write(fd, &n, sizeof(n));
+	ret = do_write(ff, &n, sizeof(n));
 	if (ret < 0)
 		return ret;
 
-	ret = do_write_string(fd, buf);
+	ret = do_write_string(ff, buf);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0 ; i < perf_env.nr_cmdline; i++) {
-		ret = do_write_string(fd, perf_env.cmdline_argv[i]);
+		ret = do_write_string(ff, perf_env.cmdline_argv[i]);
 		if (ret < 0)
 			return ret;
 	}
@@ -585,8 +590,8 @@ static struct cpu_topo *build_cpu_topology(void)
 	return tp;
 }
 
-static int write_cpu_topology(int fd, struct perf_header *h __maybe_unused,
-			  struct perf_evlist *evlist __maybe_unused)
+static int write_cpu_topology(struct feat_fd *ff,
+			      struct perf_evlist *evlist __maybe_unused)
 {
 	struct cpu_topo *tp;
 	u32 i;
@@ -596,21 +601,21 @@ static int write_cpu_topology(int fd, struct perf_header *h __maybe_unused,
 	if (!tp)
 		return -1;
 
-	ret = do_write(fd, &tp->core_sib, sizeof(tp->core_sib));
+	ret = do_write(ff, &tp->core_sib, sizeof(tp->core_sib));
 	if (ret < 0)
 		goto done;
 
 	for (i = 0; i < tp->core_sib; i++) {
-		ret = do_write_string(fd, tp->core_siblings[i]);
+		ret = do_write_string(ff, tp->core_siblings[i]);
 		if (ret < 0)
 			goto done;
 	}
-	ret = do_write(fd, &tp->thread_sib, sizeof(tp->thread_sib));
+	ret = do_write(ff, &tp->thread_sib, sizeof(tp->thread_sib));
 	if (ret < 0)
 		goto done;
 
 	for (i = 0; i < tp->thread_sib; i++) {
-		ret = do_write_string(fd, tp->thread_siblings[i]);
+		ret = do_write_string(ff, tp->thread_siblings[i]);
 		if (ret < 0)
 			break;
 	}
@@ -620,11 +625,11 @@ static int write_cpu_topology(int fd, struct perf_header *h __maybe_unused,
 		goto done;
 
 	for (j = 0; j < perf_env.nr_cpus_avail; j++) {
-		ret = do_write(fd, &perf_env.cpu[j].core_id,
+		ret = do_write(ff, &perf_env.cpu[j].core_id,
 			       sizeof(perf_env.cpu[j].core_id));
 		if (ret < 0)
 			return ret;
-		ret = do_write(fd, &perf_env.cpu[j].socket_id,
+		ret = do_write(ff, &perf_env.cpu[j].socket_id,
 			       sizeof(perf_env.cpu[j].socket_id));
 		if (ret < 0)
 			return ret;
@@ -636,8 +641,8 @@ static int write_cpu_topology(int fd, struct perf_header *h __maybe_unused,
 
 
 
-static int write_total_mem(int fd, struct perf_header *h __maybe_unused,
-			  struct perf_evlist *evlist __maybe_unused)
+static int write_total_mem(struct feat_fd *ff,
+			   struct perf_evlist *evlist __maybe_unused)
 {
 	char *buf = NULL;
 	FILE *fp;
@@ -657,7 +662,7 @@ static int write_total_mem(int fd, struct perf_header *h __maybe_unused,
 	if (!ret) {
 		n = sscanf(buf, "%*s %"PRIu64, &mem);
 		if (n == 1)
-			ret = do_write(fd, &mem, sizeof(mem));
+			ret = do_write(ff, &mem, sizeof(mem));
 	} else
 		ret = -1;
 	free(buf);
@@ -665,7 +670,7 @@ static int write_total_mem(int fd, struct perf_header *h __maybe_unused,
 	return ret;
 }
 
-static int write_topo_node(int fd, int node)
+static int write_topo_node(struct feat_fd *ff, int node)
 {
 	char str[MAXPATHLEN];
 	char field[32];
@@ -695,11 +700,11 @@ static int write_topo_node(int fd, int node)
 	fclose(fp);
 	fp = NULL;
 
-	ret = do_write(fd, &mem_total, sizeof(u64));
+	ret = do_write(ff, &mem_total, sizeof(u64));
 	if (ret)
 		goto done;
 
-	ret = do_write(fd, &mem_free, sizeof(u64));
+	ret = do_write(ff, &mem_free, sizeof(u64));
 	if (ret)
 		goto done;
 
@@ -717,7 +722,7 @@ static int write_topo_node(int fd, int node)
 	if (p)
 		*p = '\0';
 
-	ret = do_write_string(fd, buf);
+	ret = do_write_string(ff, buf);
 done:
 	free(buf);
 	if (fp)
@@ -725,8 +730,8 @@ static int write_topo_node(int fd, int node)
 	return ret;
 }
 
-static int write_numa_topology(int fd, struct perf_header *h __maybe_unused,
-			  struct perf_evlist *evlist __maybe_unused)
+static int write_numa_topology(struct feat_fd *ff,
+			       struct perf_evlist *evlist __maybe_unused)
 {
 	char *buf = NULL;
 	size_t len = 0;
@@ -753,17 +758,17 @@ static int write_numa_topology(int fd, struct perf_header *h __maybe_unused,
 
 	nr = (u32)node_map->nr;
 
-	ret = do_write(fd, &nr, sizeof(nr));
+	ret = do_write(ff, &nr, sizeof(nr));
 	if (ret < 0)
 		goto done;
 
 	for (i = 0; i < nr; i++) {
 		j = (u32)node_map->map[i];
-		ret = do_write(fd, &j, sizeof(j));
+		ret = do_write(ff, &j, sizeof(j));
 		if (ret < 0)
 			break;
 
-		ret = write_topo_node(fd, i);
+		ret = write_topo_node(ff, i);
 		if (ret < 0)
 			break;
 	}
@@ -786,16 +791,16 @@ static int write_numa_topology(int fd, struct perf_header *h __maybe_unused,
  * };
  */
 
-static int write_pmu_mappings(int fd, struct perf_header *h __maybe_unused,
+static int write_pmu_mappings(struct feat_fd *ff,
 			      struct perf_evlist *evlist __maybe_unused)
 {
 	struct perf_pmu *pmu = NULL;
-	off_t offset = lseek(fd, 0, SEEK_CUR);
+	off_t offset = lseek(ff->fd, 0, SEEK_CUR);
 	__u32 pmu_num = 0;
 	int ret;
 
 	/* write real pmu_num later */
-	ret = do_write(fd, &pmu_num, sizeof(pmu_num));
+	ret = do_write(ff, &pmu_num, sizeof(pmu_num));
 	if (ret < 0)
 		return ret;
 
@@ -804,18 +809,18 @@ static int write_pmu_mappings(int fd, struct perf_header *h __maybe_unused,
 			continue;
 		pmu_num++;
 
-		ret = do_write(fd, &pmu->type, sizeof(pmu->type));
+		ret = do_write(ff, &pmu->type, sizeof(pmu->type));
 		if (ret < 0)
 			return ret;
 
-		ret = do_write_string(fd, pmu->name);
+		ret = do_write_string(ff, pmu->name);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (pwrite(fd, &pmu_num, sizeof(pmu_num), offset) != sizeof(pmu_num)) {
+	if (pwrite(ff->fd, &pmu_num, sizeof(pmu_num), offset) != sizeof(pmu_num)) {
 		/* discard all */
-		lseek(fd, offset, SEEK_SET);
+		lseek(ff->fd, offset, SEEK_SET);
 		return -1;
 	}
 
@@ -834,14 +839,14 @@ static int write_pmu_mappings(int fd, struct perf_header *h __maybe_unused,
  *	}[nr_groups];
  * };
  */
-static int write_group_desc(int fd, struct perf_header *h __maybe_unused,
+static int write_group_desc(struct feat_fd *ff,
 			    struct perf_evlist *evlist)
 {
 	u32 nr_groups = evlist->nr_groups;
 	struct perf_evsel *evsel;
 	int ret;
 
-	ret = do_write(fd, &nr_groups, sizeof(nr_groups));
+	ret = do_write(ff, &nr_groups, sizeof(nr_groups));
 	if (ret < 0)
 		return ret;
 
@@ -852,15 +857,15 @@ static int write_group_desc(int fd, struct perf_header *h __maybe_unused,
 			u32 leader_idx = evsel->idx;
 			u32 nr_members = evsel->nr_members;
 
-			ret = do_write_string(fd, name);
+			ret = do_write_string(ff, name);
 			if (ret < 0)
 				return ret;
 
-			ret = do_write(fd, &leader_idx, sizeof(leader_idx));
+			ret = do_write(ff, &leader_idx, sizeof(leader_idx));
 			if (ret < 0)
 				return ret;
 
-			ret = do_write(fd, &nr_members, sizeof(nr_members));
+			ret = do_write(ff, &nr_members, sizeof(nr_members));
 			if (ret < 0)
 				return ret;
 		}
@@ -877,7 +882,7 @@ int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
 	return -1;
 }
 
-static int write_cpuid(int fd, struct perf_header *h __maybe_unused,
+static int write_cpuid(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
 {
 	char buffer[64];
@@ -889,25 +894,24 @@ static int write_cpuid(int fd, struct perf_header *h __maybe_unused,
 
 	return -1;
 write_it:
-	return do_write_string(fd, buffer);
+	return do_write_string(ff, buffer);
 }
 
-static int write_branch_stack(int fd __maybe_unused,
-			      struct perf_header *h __maybe_unused,
-		       struct perf_evlist *evlist __maybe_unused)
+static int write_branch_stack(struct feat_fd *ff __maybe_unused,
+			      struct perf_evlist *evlist __maybe_unused)
 {
 	return 0;
 }
 
-static int write_auxtrace(int fd, struct perf_header *h,
+static int write_auxtrace(struct feat_fd *ff,
 			  struct perf_evlist *evlist __maybe_unused)
 {
 	struct perf_session *session;
 	int err;
 
-	session = container_of(h, struct perf_session, header);
+	session = container_of(ff->ph, struct perf_session, header);
 
-	err = auxtrace_index__write(fd, &session->auxtrace_index);
+	err = auxtrace_index__write(ff->fd, &session->auxtrace_index);
 	if (err < 0)
 		pr_err("Failed to write auxtrace index\n");
 	return err;
@@ -1054,8 +1058,8 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 
 #define MAX_CACHES 2000
 
-static int write_cache(int fd, struct perf_header *h __maybe_unused,
-			  struct perf_evlist *evlist __maybe_unused)
+static int write_cache(struct feat_fd *ff,
+		       struct perf_evlist *evlist __maybe_unused)
 {
 	struct cpu_cache_level caches[MAX_CACHES];
 	u32 cnt = 0, i, version = 1;
@@ -1067,11 +1071,11 @@ static int write_cache(int fd, struct perf_header *h __maybe_unused,
 
 	qsort(&caches, cnt, sizeof(struct cpu_cache_level), cpu_cache_level__sort);
 
-	ret = do_write(fd, &version, sizeof(u32));
+	ret = do_write(ff, &version, sizeof(u32));
 	if (ret < 0)
 		goto out;
 
-	ret = do_write(fd, &cnt, sizeof(u32));
+	ret = do_write(ff, &cnt, sizeof(u32));
 	if (ret < 0)
 		goto out;
 
@@ -1079,7 +1083,7 @@ static int write_cache(int fd, struct perf_header *h __maybe_unused,
 		struct cpu_cache_level *c = &caches[i];
 
 		#define _W(v)					\
-			ret = do_write(fd, &c->v, sizeof(u32));	\
+			ret = do_write(ff, &c->v, sizeof(u32));	\
 			if (ret < 0)				\
 				goto out;
 
@@ -1090,7 +1094,7 @@ static int write_cache(int fd, struct perf_header *h __maybe_unused,
 		#undef _W
 
 		#define _W(v)						\
-			ret = do_write_string(fd, (const char *) c->v);	\
+			ret = do_write_string(ff, (const char *) c->v);	\
 			if (ret < 0)					\
 				goto out;
 
@@ -1106,8 +1110,7 @@ static int write_cache(int fd, struct perf_header *h __maybe_unused,
 	return ret;
 }
 
-static int write_stat(int fd __maybe_unused,
-		      struct perf_header *h __maybe_unused,
+static int write_stat(struct feat_fd *ff __maybe_unused,
 		      struct perf_evlist *evlist __maybe_unused)
 {
 	return 0;
@@ -2105,7 +2108,7 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 }
 
 struct feature_ops {
-	int (*write)(int fd, struct perf_header *h, struct perf_evlist *evlist);
+	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct perf_header *h, int fd, FILE *fp);
 	int (*process)(struct perf_file_section *section,
 		       struct perf_header *h, int fd, void *data);
@@ -2214,29 +2217,29 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	return 0;
 }
 
-static int do_write_feat(int fd, struct perf_header *h, int type,
+static int do_write_feat(struct feat_fd *ff, int type,
 			 struct perf_file_section **p,
 			 struct perf_evlist *evlist)
 {
 	int err;
 	int ret = 0;
 
-	if (perf_header__has_feat(h, type)) {
+	if (perf_header__has_feat(ff->ph, type)) {
 		if (!feat_ops[type].write)
 			return -1;
 
-		(*p)->offset = lseek(fd, 0, SEEK_CUR);
+		(*p)->offset = lseek(ff->fd, 0, SEEK_CUR);
 
-		err = feat_ops[type].write(fd, h, evlist);
+		err = feat_ops[type].write(ff, evlist);
 		if (err < 0) {
 			pr_debug("failed to write feature %s\n", feat_ops[type].name);
 
 			/* undo anything written */
-			lseek(fd, (*p)->offset, SEEK_SET);
+			lseek(ff->fd, (*p)->offset, SEEK_SET);
 
 			return -1;
 		}
-		(*p)->size = lseek(fd, 0, SEEK_CUR) - (*p)->offset;
+		(*p)->size = lseek(ff->fd, 0, SEEK_CUR) - (*p)->offset;
 		(*p)++;
 	}
 	return ret;
@@ -2246,12 +2249,18 @@ static int perf_header__adds_write(struct perf_header *header,
 				   struct perf_evlist *evlist, int fd)
 {
 	int nr_sections;
+	struct feat_fd ff;
 	struct perf_file_section *feat_sec, *p;
 	int sec_size;
 	u64 sec_start;
 	int feat;
 	int err;
 
+	ff = (struct feat_fd){
+		.fd  = fd,
+		.ph = header,
+	};
+
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
 	if (!nr_sections)
 		return 0;
@@ -2266,7 +2275,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	lseek(fd, sec_start + sec_size, SEEK_SET);
 
 	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
-		if (do_write_feat(fd, header, feat, &p, evlist))
+		if (do_write_feat(&ff, feat, &p, evlist))
 			perf_header__clear_feat(header, feat);
 	}
 
@@ -2275,7 +2284,7 @@ static int perf_header__adds_write(struct perf_header *header,
 	 * may write more than needed due to dropped feature, but
 	 * this is okay, reader will skip the mising entries
 	 */
-	err = do_write(fd, feat_sec, sec_size);
+	err = do_write(&ff, feat_sec, sec_size);
 	if (err < 0)
 		pr_debug("failed to write feature section\n");
 	free(feat_sec);
@@ -2285,14 +2294,17 @@ static int perf_header__adds_write(struct perf_header *header,
 int perf_header__write_pipe(int fd)
 {
 	struct perf_pipe_file_header f_header;
+	struct feat_fd ff;
 	int err;
 
+	ff = (struct feat_fd){ .fd = fd };
+
 	f_header = (struct perf_pipe_file_header){
 		.magic	   = PERF_MAGIC,
 		.size	   = sizeof(f_header),
 	};
 
-	err = do_write(fd, &f_header, sizeof(f_header));
+	err = do_write(&ff, &f_header, sizeof(f_header));
 	if (err < 0) {
 		pr_debug("failed to write perf pipe header\n");
 		return err;
@@ -2309,21 +2321,23 @@ int perf_session__write_header(struct perf_session *session,
 	struct perf_file_attr   f_attr;
 	struct perf_header *header = &session->header;
 	struct perf_evsel *evsel;
+	struct feat_fd ff;
 	u64 attr_offset;
 	int err;
 
+	ff = (struct feat_fd){ .fd = fd};
 	lseek(fd, sizeof(f_header), SEEK_SET);
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(fd, evsel->id, evsel->ids * sizeof(u64));
+		err = do_write(&ff, evsel->id, evsel->ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
 			return err;
 		}
 	}
 
-	attr_offset = lseek(fd, 0, SEEK_CUR);
+	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
 
 	evlist__for_each_entry(evlist, evsel) {
 		f_attr = (struct perf_file_attr){
@@ -2333,7 +2347,7 @@ int perf_session__write_header(struct perf_session *session,
 				.size   = evsel->ids * sizeof(u64),
 			}
 		};
-		err = do_write(fd, &f_attr, sizeof(f_attr));
+		err = do_write(&ff, &f_attr, sizeof(f_attr));
 		if (err < 0) {
 			pr_debug("failed to write perf header attribute\n");
 			return err;
@@ -2368,7 +2382,7 @@ int perf_session__write_header(struct perf_session *session,
 	memcpy(&f_header.adds_features, &header->adds_features, sizeof(header->adds_features));
 
 	lseek(fd, 0, SEEK_SET);
-	err = do_write(fd, &f_header, sizeof(f_header));
+	err = do_write(&ff, &f_header, sizeof(f_header));
 	if (err < 0) {
 		pr_debug("failed to write perf header\n");
 		return err;
@@ -2643,6 +2657,10 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 				       struct perf_header *ph, int fd,
 				       bool repipe)
 {
+	struct feat_fd ff = {
+		.fd = STDOUT_FILENO,
+		.ph = ph,
+	};
 	ssize_t ret;
 
 	ret = readn(fd, header, sizeof(*header));
@@ -2657,7 +2675,7 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 	if (ph->needs_swap)
 		header->size = bswap_64(header->size);
 
-	if (repipe && do_write(STDOUT_FILENO, header, sizeof(*header)) < 0)
+	if (repipe && do_write(&ff, header, sizeof(*header)) < 0)
 		return -1;
 
 	return 0;
@@ -3165,6 +3183,7 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	union perf_event ev;
 	struct tracing_data *tdata;
 	ssize_t size = 0, aligned_size = 0, padding;
+	struct feat_fd ff;
 	int err __maybe_unused = 0;
 
 	/*
@@ -3199,7 +3218,8 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	 */
 	tracing_data_put(tdata);
 
-	if (write_padded(fd, NULL, 0, padding))
+	ff = (struct feat_fd){ .fd = fd };
+	if (write_padded(&ff, NULL, 0, padding))
 		return -1;
 
 	return aligned_size;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e98489c8bba7..9d8dcd5eb727 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -144,9 +144,12 @@ bool is_perf_magic(u64 magic);
 
 #define NAME_ALIGN 64
 
-int do_write(int fd, const void *buf, size_t size);
+struct feat_fd;
 
-int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
+int do_write(struct feat_fd *fd, const void *buf, size_t size);
+
+int write_padded(struct feat_fd *fd, const void *bf,
+		 size_t count, size_t count_aligned);
 
 /*
  * arch specific callback
-- 
2.9.4
