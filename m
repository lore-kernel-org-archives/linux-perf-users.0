From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 73/86] perf header: Use struct feat_fd in read header records
Date: Wed, 19 Jul 2017 11:29:37 -0300
Message-ID: <20170719142950.3747-74-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

As preparation for using header records in-pipe mode, replace int fd
with struct feat_fd ff in read functions for all header record types.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-11-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 101 +++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 60394d27e8f5..14db9f204b0a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -126,54 +126,54 @@ static int do_write_string(struct feat_fd *ff, const char *str)
 	return write_padded(ff, str, olen, len);
 }
 
-static int __do_read(int fd, void *addr, ssize_t size)
+static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
 {
-	ssize_t ret = readn(fd, addr, size);
+	ssize_t ret = readn(ff->fd, addr, size);
 
 	if (ret != size)
 		return ret < 0 ? (int)ret : -1;
 	return 0;
 }
 
-static int do_read_u32(int fd, struct perf_header *ph, u32 *addr)
+static int do_read_u32(struct feat_fd *ff, u32 *addr)
 {
 	int ret;
 
-	ret = __do_read(fd, addr, sizeof(*addr));
+	ret = __do_read(ff, addr, sizeof(*addr));
 	if (ret)
 		return ret;
 
-	if (ph->needs_swap)
+	if (ff->ph->needs_swap)
 		*addr = bswap_32(*addr);
 	return 0;
 }
 
-static int do_read_u64(int fd, struct perf_header *ph, u64 *addr)
+static int do_read_u64(struct feat_fd *ff, u64 *addr)
 {
 	int ret;
 
-	ret = __do_read(fd, addr, sizeof(*addr));
+	ret = __do_read(ff, addr, sizeof(*addr));
 	if (ret)
 		return ret;
 
-	if (ph->needs_swap)
+	if (ff->ph->needs_swap)
 		*addr = bswap_64(*addr);
 	return 0;
 }
 
-static char *do_read_string(int fd, struct perf_header *ph)
+static char *do_read_string(struct feat_fd *ff)
 {
 	u32 len;
 	char *buf;
 
-	if (do_read_u32(fd, ph, &len))
+	if (do_read_u32(ff, &len))
 		return NULL;
 
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
 
-	if (!__do_read(fd, buf, len)) {
+	if (!__do_read(ff, buf, len)) {
 		/*
 		 * strings are padded by zeroes
 		 * thus the actual strlen of buf
@@ -1208,8 +1208,7 @@ static void free_event_desc(struct perf_evsel *events)
 	free(events);
 }
 
-static struct perf_evsel *
-read_event_desc(struct perf_header *ph, int fd)
+static struct perf_evsel *read_event_desc(struct feat_fd *ff)
 {
 	struct perf_evsel *evsel, *events = NULL;
 	u64 *id;
@@ -1218,10 +1217,10 @@ read_event_desc(struct perf_header *ph, int fd)
 	size_t msz;
 
 	/* number of events */
-	if (do_read_u32(fd, ph, &nre))
+	if (do_read_u32(ff, &nre))
 		goto error;
 
-	if (do_read_u32(fd, ph, &sz))
+	if (do_read_u32(ff, &sz))
 		goto error;
 
 	/* buffer to hold on file attr struct */
@@ -1245,21 +1244,21 @@ read_event_desc(struct perf_header *ph, int fd)
 		 * must read entire on-file attr struct to
 		 * sync up with layout.
 		 */
-		if (__do_read(fd, buf, sz))
+		if (__do_read(ff, buf, sz))
 			goto error;
 
-		if (ph->needs_swap)
+		if (ff->ph->needs_swap)
 			perf_event__attr_swap(buf);
 
 		memcpy(&evsel->attr, buf, msz);
 
-		if (do_read_u32(fd, ph, &nr))
+		if (do_read_u32(ff, &nr))
 			goto error;
 
-		if (ph->needs_swap)
+		if (ff->ph->needs_swap)
 			evsel->needs_swap = true;
 
-		evsel->name = do_read_string(fd, ph);
+		evsel->name = do_read_string(ff);
 		if (!evsel->name)
 			goto error;
 
@@ -1273,7 +1272,7 @@ read_event_desc(struct perf_header *ph, int fd)
 		evsel->id = id;
 
 		for (j = 0 ; j < nr; j++) {
-			if (do_read_u64(fd, ph, id))
+			if (do_read_u64(ff, id))
 				goto error;
 			id++;
 		}
@@ -1295,7 +1294,7 @@ static int __desc_attr__fprintf(FILE *fp, const char *name, const char *val,
 
 static void print_event_desc(struct feat_fd *ff, FILE *fp)
 {
-	struct perf_evsel *evsel, *events = read_event_desc(ff->ph, ff->fd);
+	struct perf_evsel *evsel, *events = read_event_desc(ff);
 	u32 j;
 	u64 *id;
 
@@ -1597,7 +1596,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
 #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
 static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
 {\
-	ff->ph->env.__feat_env = do_read_string(ff->fd, ff->ph); \
+	ff->ph->env.__feat_env = do_read_string(ff); \
 	return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
 }
 
@@ -1627,11 +1626,11 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	int ret;
 	u32 nr_cpus_avail, nr_cpus_online;
 
-	ret = do_read_u32(ff->fd, ff->ph, &nr_cpus_avail);
+	ret = do_read_u32(ff, &nr_cpus_avail);
 	if (ret)
 		return ret;
 
-	ret = do_read_u32(ff->fd, ff->ph, &nr_cpus_online);
+	ret = do_read_u32(ff, &nr_cpus_online);
 	if (ret)
 		return ret;
 	ff->ph->env.nr_cpus_avail = (int)nr_cpus_avail;
@@ -1644,7 +1643,7 @@ static int process_total_mem(struct feat_fd *ff, void *data __maybe_unused)
 	u64 total_mem;
 	int ret;
 
-	ret = do_read_u64(ff->fd, ff->ph, &total_mem);
+	ret = do_read_u64(ff, &total_mem);
 	if (ret)
 		return -1;
 	ff->ph->env.total_mem = (unsigned long long)total_mem;
@@ -1687,7 +1686,7 @@ static int
 process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_session *session;
-	struct perf_evsel *evsel, *events = read_event_desc(ff->ph, ff->fd);
+	struct perf_evsel *evsel, *events = read_event_desc(ff);
 
 	if (!events)
 		return 0;
@@ -1706,7 +1705,7 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 	char *str, *cmdline = NULL, **argv = NULL;
 	u32 nr, i, len = 0;
 
-	if (do_read_u32(ff->fd, ff->ph, &nr))
+	if (do_read_u32(ff, &nr))
 		return -1;
 
 	ff->ph->env.nr_cmdline = nr;
@@ -1720,7 +1719,7 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 		goto error;
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(ff->fd, ff->ph);
+		str = do_read_string(ff);
 		if (!str)
 			goto error;
 
@@ -1752,7 +1751,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (!ph->env.cpu)
 		return -1;
 
-	if (do_read_u32(ff->fd, ph, &nr))
+	if (do_read_u32(ff, &nr))
 		goto free_cpu;
 
 	ph->env.nr_sibling_cores = nr;
@@ -1761,7 +1760,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		goto free_cpu;
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(ff->fd, ph);
+		str = do_read_string(ff);
 		if (!str)
 			goto error;
 
@@ -1773,14 +1772,14 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	}
 	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
 
-	if (do_read_u32(ff->fd, ph, &nr))
+	if (do_read_u32(ff, &nr))
 		return -1;
 
 	ph->env.nr_sibling_threads = nr;
 	size += sizeof(u32);
 
 	for (i = 0; i < nr; i++) {
-		str = do_read_string(ff->fd, ph);
+		str = do_read_string(ff);
 		if (!str)
 			goto error;
 
@@ -1802,12 +1801,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	}
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
-		if (do_read_u32(ff->fd, ph, &nr))
+		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
 		ph->env.cpu[i].core_id = nr;
 
-		if (do_read_u32(ff->fd, ph, &nr))
+		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
 		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
@@ -1835,7 +1834,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 	char *str;
 
 	/* nr nodes */
-	if (do_read_u32(ff->fd, ff->ph, &nr))
+	if (do_read_u32(ff, &nr))
 		return -1;
 
 	nodes = zalloc(sizeof(*nodes) * nr);
@@ -1846,16 +1845,16 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 		n = &nodes[i];
 
 		/* node number */
-		if (do_read_u32(ff->fd, ff->ph, &n->node))
+		if (do_read_u32(ff, &n->node))
 			goto error;
 
-		if (do_read_u64(ff->fd, ff->ph, &n->mem_total))
+		if (do_read_u64(ff, &n->mem_total))
 			goto error;
 
-		if (do_read_u64(ff->fd, ff->ph, &n->mem_free))
+		if (do_read_u64(ff, &n->mem_free))
 			goto error;
 
-		str = do_read_string(ff->fd, ff->ph);
+		str = do_read_string(ff);
 		if (!str)
 			goto error;
 
@@ -1881,7 +1880,7 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 	u32 type;
 	struct strbuf sb;
 
-	if (do_read_u32(ff->fd, ff->ph, &pmu_num))
+	if (do_read_u32(ff, &pmu_num))
 		return -1;
 
 	if (!pmu_num) {
@@ -1894,10 +1893,10 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		return -1;
 
 	while (pmu_num) {
-		if (do_read_u32(ff->fd, ff->ph, &type))
+		if (do_read_u32(ff, &type))
 			goto error;
 
-		name = do_read_string(ff->fd, ff->ph);
+		name = do_read_string(ff);
 		if (!name)
 			goto error;
 
@@ -1933,7 +1932,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 		u32 nr_members;
 	} *desc;
 
-	if (do_read_u32(ff->fd, ff->ph, &nr_groups))
+	if (do_read_u32(ff, &nr_groups))
 		return -1;
 
 	ff->ph->env.nr_groups = nr_groups;
@@ -1947,14 +1946,14 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 		return -1;
 
 	for (i = 0; i < nr_groups; i++) {
-		desc[i].name = do_read_string(ff->fd, ff->ph);
+		desc[i].name = do_read_string(ff);
 		if (!desc[i].name)
 			goto out_free;
 
-		if (do_read_u32(ff->fd, ff->ph, &desc[i].leader_idx))
+		if (do_read_u32(ff, &desc[i].leader_idx))
 			goto out_free;
 
-		if (do_read_u32(ff->fd, ff->ph, &desc[i].nr_members))
+		if (do_read_u32(ff, &desc[i].nr_members))
 			goto out_free;
 	}
 
@@ -2024,13 +2023,13 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
 
-	if (do_read_u32(ff->fd, ff->ph, &version))
+	if (do_read_u32(ff, &version))
 		return -1;
 
 	if (version != 1)
 		return -1;
 
-	if (do_read_u32(ff->fd, ff->ph, &cnt))
+	if (do_read_u32(ff, &cnt))
 		return -1;
 
 	caches = zalloc(sizeof(*caches) * cnt);
@@ -2041,7 +2040,7 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		struct cpu_cache_level c;
 
 		#define _R(v)						\
-			if (do_read_u32(ff->fd, ff->ph, &c.v))\
+			if (do_read_u32(ff, &c.v))\
 				goto out_free_caches;			\
 
 		_R(level)
@@ -2051,7 +2050,7 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 		#undef _R
 
 		#define _R(v)					\
-			c.v = do_read_string(ff->fd, ff->ph);	\
+			c.v = do_read_string(ff);		\
 			if (!c.v)				\
 				goto out_free_caches;
 
-- 
2.9.4
