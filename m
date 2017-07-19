From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/86] perf header: Encapsulate read and swap
Date: Wed, 19 Jul 2017 11:29:28 -0300
Message-ID: <20170719142950.3747-65-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Most callers of readn() in perf header read either a 32 or a 64 bits
number, error check it and swap it, if necessary.

Create do_read_u32 and do_read_u64 to simplify these use cases.

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
Link: http://lkml.kernel.org/r/20170718042549.145161-2-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 210 +++++++++++++++++------------------------------
 1 file changed, 77 insertions(+), 133 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 76ed7d03e500..24e842c02027 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -119,25 +119,54 @@ static int do_write_string(int fd, const char *str)
 	return write_padded(fd, str, olen, len);
 }
 
+static int __do_read(int fd, void *addr, ssize_t size)
+{
+	ssize_t ret = readn(fd, addr, size);
+
+	if (ret != size)
+		return ret < 0 ? (int)ret : -1;
+	return 0;
+}
+
+static int do_read_u32(int fd, struct perf_header *ph, u32 *addr)
+{
+	int ret;
+
+	ret = __do_read(fd, addr, sizeof(*addr));
+	if (ret)
+		return ret;
+
+	if (ph->needs_swap)
+		*addr = bswap_32(*addr);
+	return 0;
+}
+
+static int do_read_u64(int fd, struct perf_header *ph, u64 *addr)
+{
+	int ret;
+
+	ret = __do_read(fd, addr, sizeof(*addr));
+	if (ret)
+		return ret;
+
+	if (ph->needs_swap)
+		*addr = bswap_64(*addr);
+	return 0;
+}
+
 static char *do_read_string(int fd, struct perf_header *ph)
 {
-	ssize_t sz, ret;
 	u32 len;
 	char *buf;
 
-	sz = readn(fd, &len, sizeof(len));
-	if (sz < (ssize_t)sizeof(len))
+	if (do_read_u32(fd, ph, &len))
 		return NULL;
 
-	if (ph->needs_swap)
-		len = bswap_32(len);
-
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
 
-	ret = readn(fd, buf, len);
-	if (ret == (ssize_t)len) {
+	if (!__do_read(fd, buf, len)) {
 		/*
 		 * strings are padded by zeroes
 		 * thus the actual strlen of buf
@@ -1188,24 +1217,15 @@ read_event_desc(struct perf_header *ph, int fd)
 	u64 *id;
 	void *buf = NULL;
 	u32 nre, sz, nr, i, j;
-	ssize_t ret;
 	size_t msz;
 
 	/* number of events */
-	ret = readn(fd, &nre, sizeof(nre));
-	if (ret != (ssize_t)sizeof(nre))
+	if (do_read_u32(fd, ph, &nre))
 		goto error;
 
-	if (ph->needs_swap)
-		nre = bswap_32(nre);
-
-	ret = readn(fd, &sz, sizeof(sz));
-	if (ret != (ssize_t)sizeof(sz))
+	if (do_read_u32(fd, ph, &sz))
 		goto error;
 
-	if (ph->needs_swap)
-		sz = bswap_32(sz);
-
 	/* buffer to hold on file attr struct */
 	buf = malloc(sz);
 	if (!buf)
@@ -1227,8 +1247,7 @@ read_event_desc(struct perf_header *ph, int fd)
 		 * must read entire on-file attr struct to
 		 * sync up with layout.
 		 */
-		ret = readn(fd, buf, sz);
-		if (ret != (ssize_t)sz)
+		if (__do_read(fd, buf, sz))
 			goto error;
 
 		if (ph->needs_swap)
@@ -1236,16 +1255,15 @@ read_event_desc(struct perf_header *ph, int fd)
 
 		memcpy(&evsel->attr, buf, msz);
 
-		ret = readn(fd, &nr, sizeof(nr));
-		if (ret != (ssize_t)sizeof(nr))
+		if (do_read_u32(fd, ph, &nr))
 			goto error;
 
-		if (ph->needs_swap) {
-			nr = bswap_32(nr);
+		if (ph->needs_swap)
 			evsel->needs_swap = true;
-		}
 
 		evsel->name = do_read_string(fd, ph);
+		if (!evsel->name)
+			goto error;
 
 		if (!nr)
 			continue;
@@ -1257,11 +1275,8 @@ read_event_desc(struct perf_header *ph, int fd)
 		evsel->id = id;
 
 		for (j = 0 ; j < nr; j++) {
-			ret = readn(fd, id, sizeof(*id));
-			if (ret != (ssize_t)sizeof(*id))
+			if (do_read_u64(fd, ph, id))
 				goto error;
-			if (ph->needs_swap)
-				*id = bswap_64(*id);
 			id++;
 		}
 	}
@@ -1641,26 +1656,18 @@ static int process_nrcpus(struct perf_file_section *section __maybe_unused,
 			  struct perf_header *ph, int fd,
 			  void *data __maybe_unused)
 {
-	ssize_t ret;
-	u32 nr;
-
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
-		return -1;
-
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
-
-	ph->env.nr_cpus_avail = nr;
-
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
-		return -1;
+	int ret;
+	u32 nr_cpus_avail, nr_cpus_online;
 
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
+	ret = do_read_u32(fd, ph, &nr_cpus_avail);
+	if (ret)
+		return ret;
 
-	ph->env.nr_cpus_online = nr;
+	ret = do_read_u32(fd, ph, &nr_cpus_online);
+	if (ret)
+		return ret;
+	ph->env.nr_cpus_avail = (int)nr_cpus_avail;
+	ph->env.nr_cpus_online = (int)nr_cpus_online;
 	return 0;
 }
 
@@ -1684,17 +1691,13 @@ static int process_total_mem(struct perf_file_section *section __maybe_unused,
 			     struct perf_header *ph, int fd,
 			     void *data __maybe_unused)
 {
-	uint64_t mem;
-	ssize_t ret;
+	u64 total_mem;
+	int ret;
 
-	ret = readn(fd, &mem, sizeof(mem));
-	if (ret != sizeof(mem))
+	ret = do_read_u64(fd, ph, &total_mem);
+	if (ret)
 		return -1;
-
-	if (ph->needs_swap)
-		mem = bswap_64(mem);
-
-	ph->env.total_mem = mem;
+	ph->env.total_mem = (unsigned long long)total_mem;
 	return 0;
 }
 
@@ -1754,17 +1757,12 @@ static int process_cmdline(struct perf_file_section *section,
 			   struct perf_header *ph, int fd,
 			   void *data __maybe_unused)
 {
-	ssize_t ret;
 	char *str, *cmdline = NULL, **argv = NULL;
 	u32 nr, i, len = 0;
 
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
+	if (do_read_u32(fd, ph, &nr))
 		return -1;
 
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
-
 	ph->env.nr_cmdline = nr;
 
 	cmdline = zalloc(section->size + nr + 1);
@@ -1799,7 +1797,6 @@ static int process_cpu_topology(struct perf_file_section *section,
 				struct perf_header *ph, int fd,
 				void *data __maybe_unused)
 {
-	ssize_t ret;
 	u32 nr, i;
 	char *str;
 	struct strbuf sb;
@@ -1810,13 +1807,9 @@ static int process_cpu_topology(struct perf_file_section *section,
 	if (!ph->env.cpu)
 		return -1;
 
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
+	if (do_read_u32(fd, ph, &nr))
 		goto free_cpu;
 
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
-
 	ph->env.nr_sibling_cores = nr;
 	size += sizeof(u32);
 	if (strbuf_init(&sb, 128) < 0)
@@ -1835,13 +1828,9 @@ static int process_cpu_topology(struct perf_file_section *section,
 	}
 	ph->env.sibling_cores = strbuf_detach(&sb, NULL);
 
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
+	if (do_read_u32(fd, ph, &nr))
 		return -1;
 
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
-
 	ph->env.nr_sibling_threads = nr;
 	size += sizeof(u32);
 
@@ -1868,22 +1857,14 @@ static int process_cpu_topology(struct perf_file_section *section,
 	}
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
-		ret = readn(fd, &nr, sizeof(nr));
-		if (ret != sizeof(nr))
+		if (do_read_u32(fd, ph, &nr))
 			goto free_cpu;
 
-		if (ph->needs_swap)
-			nr = bswap_32(nr);
-
 		ph->env.cpu[i].core_id = nr;
 
-		ret = readn(fd, &nr, sizeof(nr));
-		if (ret != sizeof(nr))
+		if (do_read_u32(fd, ph, &nr))
 			goto free_cpu;
 
-		if (ph->needs_swap)
-			nr = bswap_32(nr);
-
 		if (nr != (u32)-1 && nr > (u32)cpu_nr) {
 			pr_debug("socket_id number is too big."
 				 "You may need to upgrade the perf tool.\n");
@@ -1907,18 +1888,13 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 				 void *data __maybe_unused)
 {
 	struct numa_node *nodes, *n;
-	ssize_t ret;
 	u32 nr, i;
 	char *str;
 
 	/* nr nodes */
-	ret = readn(fd, &nr, sizeof(nr));
-	if (ret != sizeof(nr))
+	if (do_read_u32(fd, ph, &nr))
 		return -1;
 
-	if (ph->needs_swap)
-		nr = bswap_32(nr);
-
 	nodes = zalloc(sizeof(*nodes) * nr);
 	if (!nodes)
 		return -ENOMEM;
@@ -1927,24 +1903,15 @@ static int process_numa_topology(struct perf_file_section *section __maybe_unuse
 		n = &nodes[i];
 
 		/* node number */
-		ret = readn(fd, &n->node, sizeof(u32));
-		if (ret != sizeof(n->node))
+		if (do_read_u32(fd, ph, &n->node))
 			goto error;
 
-		ret = readn(fd, &n->mem_total, sizeof(u64));
-		if (ret != sizeof(u64))
+		if (do_read_u64(fd, ph, &n->mem_total))
 			goto error;
 
-		ret = readn(fd, &n->mem_free, sizeof(u64));
-		if (ret != sizeof(u64))
+		if (do_read_u64(fd, ph, &n->mem_free))
 			goto error;
 
-		if (ph->needs_swap) {
-			n->node      = bswap_32(n->node);
-			n->mem_total = bswap_64(n->mem_total);
-			n->mem_free  = bswap_64(n->mem_free);
-		}
-
 		str = do_read_string(fd, ph);
 		if (!str)
 			goto error;
@@ -1968,19 +1935,14 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 				struct perf_header *ph, int fd,
 				void *data __maybe_unused)
 {
-	ssize_t ret;
 	char *name;
 	u32 pmu_num;
 	u32 type;
 	struct strbuf sb;
 
-	ret = readn(fd, &pmu_num, sizeof(pmu_num));
-	if (ret != sizeof(pmu_num))
+	if (do_read_u32(fd, ph, &pmu_num))
 		return -1;
 
-	if (ph->needs_swap)
-		pmu_num = bswap_32(pmu_num);
-
 	if (!pmu_num) {
 		pr_debug("pmu mappings not available\n");
 		return 0;
@@ -1991,10 +1953,8 @@ static int process_pmu_mappings(struct perf_file_section *section __maybe_unused
 		return -1;
 
 	while (pmu_num) {
-		if (readn(fd, &type, sizeof(type)) != sizeof(type))
+		if (do_read_u32(fd, ph, &type))
 			goto error;
-		if (ph->needs_swap)
-			type = bswap_32(type);
 
 		name = do_read_string(fd, ph);
 		if (!name)
@@ -2034,12 +1994,9 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 		u32 nr_members;
 	} *desc;
 
-	if (readn(fd, &nr_groups, sizeof(nr_groups)) != sizeof(nr_groups))
+	if (do_read_u32(fd, ph, &nr_groups))
 		return -1;
 
-	if (ph->needs_swap)
-		nr_groups = bswap_32(nr_groups);
-
 	ph->env.nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
@@ -2055,16 +2012,11 @@ static int process_group_desc(struct perf_file_section *section __maybe_unused,
 		if (!desc[i].name)
 			goto out_free;
 
-		if (readn(fd, &desc[i].leader_idx, sizeof(u32)) != sizeof(u32))
+		if (do_read_u32(fd, ph, &desc[i].leader_idx))
 			goto out_free;
 
-		if (readn(fd, &desc[i].nr_members, sizeof(u32)) != sizeof(u32))
+		if (do_read_u32(fd, ph, &desc[i].nr_members))
 			goto out_free;
-
-		if (ph->needs_swap) {
-			desc[i].leader_idx = bswap_32(desc[i].leader_idx);
-			desc[i].nr_members = bswap_32(desc[i].nr_members);
-		}
 	}
 
 	/*
@@ -2137,21 +2089,15 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 	struct cpu_cache_level *caches;
 	u32 cnt, i, version;
 
-	if (readn(fd, &version, sizeof(version)) != sizeof(version))
+	if (do_read_u32(fd, ph, &version))
 		return -1;
 
-	if (ph->needs_swap)
-		version = bswap_32(version);
-
 	if (version != 1)
 		return -1;
 
-	if (readn(fd, &cnt, sizeof(cnt)) != sizeof(cnt))
+	if (do_read_u32(fd, ph, &cnt))
 		return -1;
 
-	if (ph->needs_swap)
-		cnt = bswap_32(cnt);
-
 	caches = zalloc(sizeof(*caches) * cnt);
 	if (!caches)
 		return -1;
@@ -2160,10 +2106,8 @@ static int process_cache(struct perf_file_section *section __maybe_unused,
 		struct cpu_cache_level c;
 
 		#define _R(v)						\
-			if (readn(fd, &c.v, sizeof(u32)) != sizeof(u32))\
+			if (do_read_u32(fd, ph, &c.v))\
 				goto out_free_caches;			\
-			if (ph->needs_swap)				\
-				c.v = bswap_32(c.v);			\
 
 		_R(level)
 		_R(line_size)
-- 
2.9.4
