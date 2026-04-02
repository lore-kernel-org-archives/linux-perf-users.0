Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA91B4224;
	Thu,  2 Apr 2026 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089218; cv=none; b=gcKKDVnS4jc2eAM6nmZY+IPEpChhg5GiiOSEBy6sQ1qp3kG31HwcEU2+BrrCXgWsM8LHf7IW1xqJcJjwHePeQEVKum4DIut1nYRgT6TpmjDOxH4rg9yq/N3S/8A0a0J+x9yEJyxnQgBv5/npoWkklNQb/qrmcr78WtfxoSaTUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089218; c=relaxed/simple;
	bh=NYnQafwJqJBQYd4vWFl0yj7/JiiG6lhtMFWhqZdUrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWzAXKjOuK2Zzfhu7iwir9gZic74cABWUD5vhj5MYMjMmeMewMibIV+75pQfo1AyIpwACrFRTx5f2CPfwqcuo23nTFcz6EAfjXsiEmoBGHh23GZ03Ky1u2tc5RfqbiNqW7AJiQwVpOTXDYSZ7moZPlmp2EuXoi1adsjNlHhZTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME7+qO3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME7+qO3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8908FC2BCB0;
	Thu,  2 Apr 2026 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089217;
	bh=NYnQafwJqJBQYd4vWFl0yj7/JiiG6lhtMFWhqZdUrtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ME7+qO3PZmgNVp4wT/sdOGB1GOIJ4erMvhBh23NRECP/L2pSJ810xdA2FFO5w0u+x
	 bxjgpAhxezJf/KCW6OHdaIGhB4lfzDxDW9E4gy/h+yfBDYs34RSwKDWWA10j+dEQAZ
	 yTIETqxCuDO1YuD2/NPieIsfnbQBuu/O9+dfQMm297DoppatJcQSS5JZoE9BbhvssS
	 Sv+MI8pTI7Wmbh8znigtEoWhw/lDNCvmTEzZVPC3JJEZVrJXU4KdU//Aq6Iu2QqHw/
	 kXyhyjmZb0UMspuXizPUTV3BL77o/E6X+f0eN14WyAjYtmAfVGNEc/HhPuziev6TNZ
	 Q7yh3CFgJ4uig==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/4] perf tools: Use calloc() were applicable
Date: Wed,  1 Apr 2026 21:17:39 -0300
Message-ID: <20260402001740.2220481-4-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001740.2220481-1-acme@kernel.org>
References: <20260402001740.2220481-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of using zalloc(nr_entries * sizeof_entry) that is what calloc()
does.

In some places where linux/zalloc.h isn't needed, remove it, add when
needed and was getting it indirectly.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/auxtrace.c          |  6 +++---
 tools/perf/arch/powerpc/util/auxtrace.c      |  1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c   |  3 +--
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 11 +----------
 tools/perf/arch/x86/util/pmu.c               |  1 -
 tools/perf/bench/numa.c                      | 13 ++++---------
 tools/perf/bench/sched-messaging.c           |  2 +-
 tools/perf/builtin-annotate.c                |  1 -
 tools/perf/builtin-c2c.c                     |  6 +++---
 tools/perf/builtin-diff.c                    |  2 +-
 tools/perf/builtin-ftrace.c                  |  1 +
 tools/perf/builtin-kwork.c                   |  2 +-
 tools/perf/builtin-record.c                  | 10 +++++-----
 tools/perf/builtin-sched.c                   |  6 +++---
 tools/perf/builtin-script.c                  |  8 ++++----
 tools/perf/builtin-stat.c                    |  2 +-
 tools/perf/builtin-trace.c                   |  4 +---
 tools/perf/jvmti/libjvmti.c                  |  5 ++---
 tools/perf/tests/code-reading.c              |  1 +
 tools/perf/tests/thread-map.c                |  1 -
 tools/perf/util/annotate-arch/annotate-x86.c |  1 +
 tools/perf/util/bpf-event.c                  |  2 +-
 tools/perf/util/bpf_counter_cgroup.c         |  1 -
 tools/perf/util/data-convert-bt.c            |  2 +-
 tools/perf/util/data.c                       |  2 +-
 tools/perf/util/db-export.c                  |  1 -
 tools/perf/util/disasm.c                     |  1 +
 tools/perf/util/event.c                      |  1 -
 tools/perf/util/evlist.c                     |  3 +--
 tools/perf/util/header.c                     | 18 +++++++++---------
 tools/perf/util/hist.c                       |  2 +-
 tools/perf/util/mem2node.c                   |  2 +-
 tools/perf/util/pmus.c                       |  2 +-
 tools/perf/util/powerpc-vpadtl.c             |  1 +
 tools/perf/util/probe-event.c                | 17 ++++++++---------
 tools/perf/util/probe-file.c                 |  2 +-
 tools/perf/util/probe-finder.c               |  8 ++++----
 tools/perf/util/session.c                    |  2 +-
 tools/perf/util/srcline.c                    |  1 +
 tools/perf/util/stat-shadow.c                |  1 -
 tools/perf/util/unwind-libunwind-local.c     |  1 -
 tools/perf/util/values.c                     |  8 ++++----
 42 files changed, 72 insertions(+), 93 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index eb6404267f1715a9..27bb14c8b880068a 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -8,7 +8,7 @@
 #include <errno.h>
 #include <stdbool.h>
 #include <linux/coresight-pmu.h>
-#include <linux/zalloc.h>
+#include <stdlib.h>
 #include <api/fs/fs.h>
 
 #include "../../../util/auxtrace.h"
@@ -27,7 +27,7 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 	/* arm_spe_xxxxxxxxx\0 */
 	char arm_spe_pmu_name[sizeof(ARM_SPE_PMU_NAME) + 10];
 
-	arm_spe_pmus = zalloc(sizeof(struct perf_pmu *) * nr_cpus);
+	arm_spe_pmus = calloc(nr_cpus, sizeof(struct perf_pmu *));
 	if (!arm_spe_pmus) {
 		pr_err("spes alloc failed\n");
 		*err = -ENOMEM;
@@ -79,7 +79,7 @@ static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
 	if (!(*nr_ptts))
 		goto out;
 
-	hisi_ptt_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_ptts));
+	hisi_ptt_pmus = calloc((*nr_ptts), sizeof(struct perf_pmu *));
 	if (!hisi_ptt_pmus) {
 		pr_err("hisi_ptt alloc failed\n");
 		*err = -ENOMEM;
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index 292ea335e4fff6b9..e39deff6c857a82a 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 
 #include "../../util/evlist.h"
 #include "../../util/debug.h"
diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 223e059e04deb005..cee9e11c05e08c09 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -8,7 +8,6 @@
 
 #include "arch-tests.h"
 #include "linux/perf_event.h"
-#include "linux/zalloc.h"
 #include "tests/tests.h"
 #include "../perf-sys.h"
 #include "pmu.h"
@@ -60,7 +59,7 @@ static int dummy_workload_1(unsigned long count)
 		0xcc, /* int 3 */
 	};
 
-	p = zalloc(2 * page_size);
+	p = calloc(2, page_size);
 	if (!p) {
 		printf("malloc() failed. %m");
 		return 1;
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index e91a73d09cecfd83..99d2b7ed016fd63f 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -54,22 +54,13 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread)
 {
 	struct regs_dump *regs = perf_sample__user_regs(sample);
-	u64 *buf;
+	u64 *buf = calloc(PERF_REGS_MAX, sizeof(u64));
 
-	buf = malloc(sizeof(u64) * PERF_REGS_MAX);
 	if (!buf) {
 		pr_debug("failed to allocate sample uregs data\n");
 		return -1;
 	}
 
-#ifdef MEMORY_SANITIZER
-	/*
-	 * Assignments to buf in the assembly function perf_regs_load aren't
-	 * seen by memory sanitizer. Zero the memory to convince memory
-	 * sanitizer the memory is initialized.
-	 */
-	memset(buf, 0, sizeof(u64) * PERF_REGS_MAX);
-#endif
 	perf_regs_load(buf);
 	regs->abi  = PERF_SAMPLE_REGS_ABI;
 	regs->regs = buf;
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 0661e0f0b02d03cd..7c9d238922a6ce57 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -7,7 +7,6 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/perf_event.h>
-#include <linux/zalloc.h>
 #include <api/fs/fs.h>
 #include <api/io_dir.h>
 #include <internal/cpumap.h>
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 6588a9b0b15aec6d..42d7afc03f9b9ed2 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -32,7 +32,6 @@
 #include <linux/kernel.h>
 #include <linux/time64.h>
 #include <linux/numa.h>
-#include <linux/zalloc.h>
 
 #include "../util/header.h"
 #include "../util/mutex.h"
@@ -980,10 +979,8 @@ static int count_process_nodes(int process_nr)
 	int nodes;
 	int n, t;
 
-	node_present = (char *)malloc(g->p.nr_nodes * sizeof(char));
+	node_present = calloc(g->p.nr_nodes, sizeof(char));
 	BUG_ON(!node_present);
-	for (nodes = 0; nodes < g->p.nr_nodes; nodes++)
-		node_present[nodes] = 0;
 
 	for (t = 0; t < g->p.nr_threads; t++) {
 		struct thread_data *td;
@@ -1090,10 +1087,8 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	if (!g->p.show_convergence && !g->p.measure_convergence)
 		return;
 
-	nodes = (int *)malloc(g->p.nr_nodes * sizeof(int));
+	nodes = calloc(g->p.nr_nodes, sizeof(int));
 	BUG_ON(!nodes);
-	for (node = 0; node < g->p.nr_nodes; node++)
-		nodes[node] = 0;
 
 	loops_done_min = -1;
 	loops_done_max = 0;
@@ -1423,7 +1418,7 @@ static void worker_process(int process_nr)
 	bind_to_memnode(td->bind_node);
 	bind_to_cpumask(td->bind_cpumask);
 
-	pthreads = zalloc(g->p.nr_threads * sizeof(pthread_t));
+	pthreads = calloc(g->p.nr_threads, sizeof(pthread_t));
 	process_data = setup_private_data(g->p.bytes_process);
 
 	if (g->p.show_details >= 3) {
@@ -1629,7 +1624,7 @@ static int __bench_numa(const char *name)
 	if (init())
 		return -1;
 
-	pids = zalloc(g->p.nr_proc * sizeof(*pids));
+	pids = calloc(g->p.nr_proc, sizeof(*pids));
 	pid = -1;
 
 	if (g->p.serialize_startup) {
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 93dcd9dba3d0dcb2..4fb6657fc826c76c 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -301,7 +301,7 @@ int bench_sched_messaging(int argc, const char **argv)
 	argc = parse_options(argc, argv, options,
 			     bench_sched_message_usage, 0);
 
-	worker_tab = malloc(num_fds * 2 * num_groups * sizeof(union messaging_worker));
+	worker_tab = calloc(num_fds * 2 * num_groups, sizeof(union messaging_worker));
 	if (!worker_tab)
 		err(EXIT_FAILURE, "main:malloc()");
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 686ad08561d66924..0924f0711a522a9f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -13,7 +13,6 @@
 #include <linux/list.h>
 #include "util/cache.h"
 #include <linux/rbtree.h>
-#include <linux/zalloc.h>
 #include "util/symbol.h"
 
 #include "util/debug.h"
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3ce5f0adec2f31c2..72a7802775ee965f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -155,7 +155,7 @@ static void *c2c_he_zalloc(size_t size)
 	if (!c2c_he->nodeset)
 		goto out_free;
 
-	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
+	c2c_he->node_stats = calloc(c2c.nodes_cnt, sizeof(*c2c_he->node_stats));
 	if (!c2c_he->node_stats)
 		goto out_free;
 
@@ -2324,13 +2324,13 @@ static int setup_nodes(struct perf_session *session)
 	if (!n)
 		return -EINVAL;
 
-	nodes = zalloc(sizeof(unsigned long *) * c2c.nodes_cnt);
+	nodes = calloc(c2c.nodes_cnt, sizeof(unsigned long *));
 	if (!nodes)
 		return -ENOMEM;
 
 	c2c.nodes = nodes;
 
-	cpu2node = zalloc(sizeof(int) * c2c.cpus_cnt);
+	cpu2node = calloc(c2c.cpus_cnt, sizeof(int));
 	if (!cpu2node)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e45f0ac1381ab2df..0188b3d7636f6983 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1891,7 +1891,7 @@ static int data_init(int argc, const char **argv)
 		return -EINVAL;
 	}
 
-	data__files = zalloc(sizeof(*data__files) * data__files_cnt);
+	data__files = calloc(data__files_cnt, sizeof(*data__files));
 	if (!data__files)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4cc33452d79b626b..8a7dbfb14535e2ba 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -20,6 +20,7 @@
 #include <linux/capability.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <sys/stat.h>
 
 #include "debug.h"
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 1140e00e874f4eed..9d3a4c779a41e383 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2208,7 +2208,7 @@ static int perf_kwork__top(struct perf_kwork *kwork)
 	struct __top_cpus_runtime *cpus_runtime;
 	int ret = 0;
 
-	cpus_runtime = zalloc(sizeof(struct __top_cpus_runtime) * (MAX_NR_CPUS + 1));
+	cpus_runtime = calloc(MAX_NR_CPUS + 1, sizeof(struct __top_cpus_runtime));
 	if (!cpus_runtime)
 		return -1;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e919d1f021c3cdbf..1adc37b451528798 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1070,12 +1070,12 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
 						      thread_data->mask->maps.nbits);
 	if (mmap) {
-		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		thread_data->maps = calloc(thread_data->nr_mmaps, sizeof(struct mmap *));
 		if (!thread_data->maps)
 			return -ENOMEM;
 	}
 	if (overwrite_mmap) {
-		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		thread_data->overwrite_maps = calloc(thread_data->nr_mmaps, sizeof(struct mmap *));
 		if (!thread_data->overwrite_maps) {
 			zfree(&thread_data->maps);
 			return -ENOMEM;
@@ -1220,7 +1220,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 	int t, ret;
 	struct record_thread *thread_data;
 
-	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
+	rec->thread_data = calloc(rec->nr_threads, sizeof(*(rec->thread_data)));
 	if (!rec->thread_data) {
 		pr_err("Failed to allocate thread data\n");
 		return -ENOMEM;
@@ -3710,7 +3710,7 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
 {
 	int t, ret;
 
-	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
+	rec->thread_masks = calloc(nr_threads, sizeof(*(rec->thread_masks)));
 	if (!rec->thread_masks) {
 		pr_err("Failed to allocate thread masks\n");
 		return -ENOMEM;
@@ -3920,7 +3920,7 @@ static int record__init_thread_numa_masks(struct record *rec, struct perf_cpu_ma
 		return -ENOMEM;
 	}
 
-	spec = zalloc(topo->nr * sizeof(char *));
+	spec = calloc(topo->nr, sizeof(char *));
 	if (!spec) {
 		pr_err("Failed to allocate NUMA spec\n");
 		ret = -ENOMEM;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d083e2bb770303a4..150f4c6f42685dbb 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2405,7 +2405,7 @@ static int init_idle_threads(int ncpu)
 {
 	int i, ret;
 
-	idle_threads = zalloc(ncpu * sizeof(struct thread *));
+	idle_threads = calloc(ncpu, sizeof(struct thread *));
 	if (!idle_threads)
 		return -ENOMEM;
 
@@ -3483,7 +3483,7 @@ static int setup_cpus_switch_event(struct perf_sched *sched)
 	if (!sched->cpu_last_switched)
 		return -1;
 
-	sched->curr_pid = malloc(MAX_CPUS * sizeof(*(sched->curr_pid)));
+	sched->curr_pid = calloc(MAX_CPUS, sizeof(*(sched->curr_pid)));
 	if (!sched->curr_pid) {
 		zfree(&sched->cpu_last_switched);
 		return -1;
@@ -3559,7 +3559,7 @@ static int setup_map_cpus(struct perf_sched *sched)
 	sched->max_cpu.cpu  = sysconf(_SC_NPROCESSORS_CONF);
 
 	if (sched->map.comp) {
-		sched->map.comp_cpus = zalloc(sched->max_cpu.cpu * sizeof(int));
+		sched->map.comp_cpus = calloc(sched->max_cpu.cpu, sizeof(int));
 		if (!sched->map.comp_cpus)
 			return -1;
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 15a58da599581a7b..b44773a0adb46948 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3819,7 +3819,7 @@ static int has_required_arg(char *script_path)
 
 static int have_cmd(int argc, const char **argv)
 {
-	char **__argv = malloc(sizeof(const char *) * argc);
+	char **__argv = calloc(argc, sizeof(const char *));
 
 	if (!__argv) {
 		pr_err("malloc failed\n");
@@ -4317,7 +4317,7 @@ int cmd_script(int argc, const char **argv)
 				}
 			}
 
-			__argv = malloc((argc + 6) * sizeof(const char *));
+			__argv = calloc(argc + 6, sizeof(const char *));
 			if (!__argv) {
 				pr_err("malloc failed\n");
 				err = -ENOMEM;
@@ -4343,7 +4343,7 @@ int cmd_script(int argc, const char **argv)
 		dup2(live_pipe[0], 0);
 		close(live_pipe[1]);
 
-		__argv = malloc((argc + 4) * sizeof(const char *));
+		__argv = calloc(argc + 4, sizeof(const char *));
 		if (!__argv) {
 			pr_err("malloc failed\n");
 			err = -ENOMEM;
@@ -4381,7 +4381,7 @@ int cmd_script(int argc, const char **argv)
 			}
 		}
 
-		__argv = malloc((argc + 2) * sizeof(const char *));
+		__argv = calloc(argc + 2, sizeof(const char *));
 		if (!__argv) {
 			pr_err("malloc failed\n");
 			err = -ENOMEM;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a24326c44297c534..94b753d25550324f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2766,7 +2766,7 @@ int cmd_stat(int argc, const char **argv)
 	}
 
 	if (stat_config.walltime_run_table) {
-		stat_config.walltime_run = zalloc(stat_config.run_count * sizeof(stat_config.walltime_run[0]));
+		stat_config.walltime_run = calloc(stat_config.run_count, sizeof(stat_config.walltime_run[0]));
 		if (!stat_config.walltime_run) {
 			pr_err("failed to setup -r option");
 			goto out;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad60028..8cdfd126115e1b69 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2265,9 +2265,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 	struct str_node *pos;
 	size_t nr_used = 0, nr_allocated = strlist__nr_entries(trace->ev_qualifier);
 
-	trace->ev_qualifier_ids.entries = malloc(nr_allocated *
-						 sizeof(trace->ev_qualifier_ids.entries[0]));
-
+	trace->ev_qualifier_ids.entries = calloc(nr_allocated, sizeof(trace->ev_qualifier_ids.entries[0]));
 	if (trace->ev_qualifier_ids.entries == NULL) {
 		fputs("Error:\tNot enough memory for allocating events qualifier ids\n",
 		       trace->output);
diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 87bfd4781003a331..d3dc53010e768669 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -98,7 +98,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 	/*
 	 * Phase 2 -- allocate big enough line table
 	 */
-	*tab = malloc(nr_total * sizeof(**tab));
+	*tab = calloc(nr_total, sizeof(**tab));
 	if (!*tab)
 		return JVMTI_ERROR_OUT_OF_MEMORY;
 
@@ -262,11 +262,10 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 			}
 			nr_lines = 0;
 		} else if (nr_lines > 0) {
-			line_file_names = malloc(sizeof(char*) * nr_lines);
+			line_file_names = calloc(nr_lines, sizeof(char *));
 			if (!line_file_names) {
 				warnx("jvmti: cannot allocate space for line table method names");
 			} else {
-				memset(line_file_names, 0, sizeof(char*) * nr_lines);
 				ret = fill_source_filenames(jvmti, nr_lines, line_tab, line_file_names);
 				if (ret != JVMTI_ERROR_NONE) {
 					warnx("jvmti: fill_source_filenames failed");
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 5927d1ea20e22331..47043a3a2fb4f833 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/types.h>
+#include <linux/zalloc.h>
 #include <inttypes.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 54209592168d8aaf..877868107455e87e 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -9,7 +9,6 @@
 #include "debug.h"
 #include "event.h"
 #include "util/synthetic-events.h"
-#include <linux/zalloc.h>
 #include <perf/event.h>
 #include <internal/threadmap.h>
 
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index c77aabd48ebab693..7e61365363938728 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include <assert.h>
 #include <inttypes.h>
 #include "../annotate-data.h"
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 67e7786bb878b396..a27945c279efb779 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -349,7 +349,7 @@ static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
 	if (!metadata)
 		return NULL;
 
-	metadata->prog_names = zalloc(nr_prog_tags * sizeof(char *));
+	metadata->prog_names = calloc(nr_prog_tags, sizeof(char *));
 	if (!metadata->prog_names) {
 		bpf_metadata_free(metadata);
 		return NULL;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 5572ceccf86092ff..519fee3dc3d03685 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -11,7 +11,6 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <linux/err.h>
-#include <linux/zalloc.h>
 #include <linux/perf_event.h>
 #include <api/fs/fs.h>
 #include <bpf/bpf.h>
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index ba1c8e48d4952e4a..d4927d31a7a3a8d9 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1360,7 +1360,7 @@ static int setup_streams(struct ctf_writer *cw, struct perf_session *session)
 	 */
 	ncpus = env->nr_cpus_avail ?: MAX_CPUS;
 
-	stream = zalloc(sizeof(*stream) * ncpus);
+	stream = calloc(ncpus, sizeof(*stream));
 	if (!stream) {
 		pr_err("Failed to allocate streams.\n");
 		return -ENOMEM;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 90df41da1a32b315..14fa83dae71a8b80 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -43,7 +43,7 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
-	files = zalloc(nr * sizeof(*files));
+	files = calloc(nr, sizeof(*files));
 	if (!files)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index ae9a9065aab76c63..cc2bb1af4243446c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -19,7 +19,6 @@
 #include "callchain.h"
 #include "call-path.h"
 #include "db-export.h"
-#include <linux/zalloc.h>
 
 int db_export__init(struct db_export *dbe)
 {
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 40fcaed5d0b1a3b8..4f5bd915355242ec 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -13,6 +13,7 @@
 #include <unistd.h>
 
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <subcmd/run-command.h>
 
 #include "annotate.h"
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc045fddf7d57569..66f4843bb235df53 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <linux/perf_event.h>
-#include <linux/zalloc.h>
 #include "cpumap.h"
 #include "dso.h"
 #include "event.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c702741a917380b9..73ea382d826364dd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -825,9 +825,8 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 				       bool overwrite)
 {
 	int i;
-	struct mmap *map;
+	struct mmap *map = calloc(evlist->core.nr_mmaps, sizeof(struct mmap));
 
-	map = zalloc(evlist->core.nr_mmaps * sizeof(struct mmap));
 	if (!map)
 		return NULL;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba401957c6..a0a5c96288af2674 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2761,7 +2761,7 @@ static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 	if (!cmdline)
 		return -1;
 
-	argv = zalloc(sizeof(char *) * (nr + 1));
+	argv = calloc(nr + 1, sizeof(char *));
 	if (!argv)
 		goto error;
 
@@ -2915,7 +2915,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	nodes = zalloc(sizeof(*nodes) * nr);
+	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -ENOMEM;
 
@@ -3113,7 +3113,7 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &cnt))
 		return -1;
 
-	caches = zalloc(sizeof(*caches) * cnt);
+	caches = calloc(cnt, sizeof(*caches));
 	if (!caches)
 		return -1;
 
@@ -3195,7 +3195,7 @@ static int process_mem_topology(struct feat_fd *ff,
 	if (do_read_u64(ff, &nr))
 		return -1;
 
-	nodes = zalloc(sizeof(*nodes) * nr);
+	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -1;
 
@@ -3285,7 +3285,7 @@ static int process_hybrid_topology(struct feat_fd *ff,
 	if (do_read_u32(ff, &nr))
 		return -1;
 
-	nodes = zalloc(sizeof(*nodes) * nr);
+	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -ENOMEM;
 
@@ -3492,7 +3492,7 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
 	if (!nr_pmu_caps)
 		return 0;
 
-	*caps = zalloc(sizeof(char *) * nr_pmu_caps);
+	*caps = calloc(nr_pmu_caps, sizeof(char *));
 	if (!*caps)
 		return -1;
 
@@ -3569,7 +3569,7 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
-	pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
+	pmu_caps = calloc(nr_pmu, sizeof(*pmu_caps));
 	if (!pmu_caps)
 		return -ENOMEM;
 
@@ -3622,7 +3622,7 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	nra = env->nr_cpus_avail;
 	nr = env->nr_cpus_online;
 
-	cd_map = zalloc(sizeof(*cd_map) * nra);
+	cd_map = calloc(nra, sizeof(*cd_map));
 	if (!cd_map)
 		return -1;
 
@@ -3655,7 +3655,7 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 
 		cd_map[cpu]->nr_domains = nr_domains;
 
-		cd_map[cpu]->domains = zalloc(sizeof(*d_info) * max_sched_domains);
+		cd_map[cpu]->domains = calloc(max_sched_domains, sizeof(*d_info));
 		if (!cd_map[cpu]->domains)
 			return -1;
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fc737a0a8e4d7acd..747fdc455c80ec0f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1151,7 +1151,7 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	 * cumulated only one time to prevent entries more than 100%
 	 * overhead.
 	 */
-	he_cache = malloc(sizeof(*he_cache) * (cursor->nr + 1));
+	he_cache = calloc(cursor->nr + 1, sizeof(*he_cache));
 	if (he_cache == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 03a7d7b2773774a0..51a2292cbf7ef44f 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -59,7 +59,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 		max += bitmap_weight(n->set, n->size);
 	}
 
-	entries = zalloc(sizeof(*entries) * max);
+	entries = calloc(max, sizeof(*entries));
 	if (!entries)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 98be2eb8f1f03923..9a2023ceeefd933a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -621,7 +621,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	while ((pmu = scan_fn(pmu)) != NULL)
 		len += perf_pmu__num_events(pmu);
 
-	aliases = zalloc(sizeof(struct sevent) * len);
+	aliases = calloc(len, sizeof(struct sevent));
 	if (!aliases) {
 		pr_err("FATAL: not enough memory to print PMU events\n");
 		return;
diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index d1c3396f182fdd83..5884ae2ff5fff218 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/zalloc.h>
 #include <errno.h>
 #include <inttypes.h>
 #include "color.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 710e4620923ea8b2..f37a783ea7723197 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1850,7 +1850,7 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 
 	/* Copy arguments and ensure return probe has no C argument */
 	pev->nargs = argc - 1;
-	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
+	pev->args = calloc(pev->nargs, sizeof(struct perf_probe_arg));
 	if (pev->args == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -2000,7 +2000,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 	}
 
 	tev->nargs = argc - 2;
-	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
+	tev->args = calloc(tev->nargs, sizeof(struct probe_trace_arg));
 	if (tev->args == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -2373,7 +2373,7 @@ static int convert_to_perf_probe_event(struct probe_trace_event *tev,
 
 	/* Convert trace_arg to probe_arg */
 	pev->nargs = tev->nargs;
-	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
+	pev->args = calloc(pev->nargs, sizeof(struct perf_probe_arg));
 	if (pev->args == NULL)
 		return -ENOMEM;
 	for (i = 0; i < tev->nargs && ret >= 0; i++) {
@@ -2480,7 +2480,7 @@ int perf_probe_event__copy(struct perf_probe_event *dst,
 	if (perf_probe_point__copy(&dst->point, &src->point) < 0)
 		goto out_err;
 
-	dst->args = zalloc(sizeof(struct perf_probe_arg) * src->nargs);
+	dst->args = calloc(src->nargs, sizeof(struct perf_probe_arg));
 	if (!dst->args)
 		goto out_err;
 	dst->nargs = src->nargs;
@@ -3179,7 +3179,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	}
 
 	/* Setup result trace-probe-events */
-	*tevs = zalloc(sizeof(*tev) * num_matched_functions);
+	*tevs = calloc(num_matched_functions, sizeof(*tev));
 	if (!*tevs) {
 		ret = -ENOMEM;
 		goto out;
@@ -3251,8 +3251,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 		tev->uprobes = pev->uprobes;
 		tev->nargs = pev->nargs;
 		if (tev->nargs) {
-			tev->args = zalloc(sizeof(struct probe_trace_arg) *
-					   tev->nargs);
+			tev->args = calloc(tev->nargs, sizeof(struct probe_trace_arg));
 			if (tev->args == NULL)
 				goto nomem_out;
 		}
@@ -3363,7 +3362,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
 	}
 
 	tev->nargs = pev->nargs;
-	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
+	tev->args = calloc(tev->nargs, sizeof(struct probe_trace_arg));
 	if (!tev->args)
 		goto errout;
 
@@ -3549,7 +3548,7 @@ static int find_probe_trace_events_from_cache(struct perf_probe_event *pev,
 		goto out;
 	}
 
-	*tevs = zalloc(ret * sizeof(*tev));
+	*tevs = calloc(ret, sizeof(*tev));
 	if (!*tevs) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index f78c3bc3d601ea95..4032572cbf55df12 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -414,7 +414,7 @@ int probe_cache_entry__get_event(struct probe_cache_entry *entry,
 	if (ret > probe_conf.max_probes)
 		return -E2BIG;
 
-	*tevs = zalloc(ret * sizeof(*tev));
+	*tevs = calloc(ret, sizeof(*tev));
 	if (!*tevs)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 5ffd97ee4898e51e..64328abeef8b2427 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1305,7 +1305,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 		 tev->point.offset);
 
 	/* Expand special probe argument if exist */
-	args = zalloc(sizeof(struct perf_probe_arg) * MAX_PROBE_ARGS);
+	args = calloc(MAX_PROBE_ARGS, sizeof(struct perf_probe_arg));
 	if (args == NULL) {
 		ret = -ENOMEM;
 		goto end;
@@ -1316,7 +1316,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 		goto end;
 
 	tev->nargs = ret;
-	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
+	tev->args = calloc(tev->nargs, sizeof(struct probe_trace_arg));
 	if (tev->args == NULL) {
 		ret = -ENOMEM;
 		goto end;
@@ -1393,7 +1393,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	int ret, i;
 
 	/* Allocate result tevs array */
-	*tevs = zalloc(sizeof(struct probe_trace_event) * tf.max_tevs);
+	*tevs = calloc(tf.max_tevs, sizeof(struct probe_trace_event));
 	if (*tevs == NULL)
 		return -ENOMEM;
 
@@ -1566,7 +1566,7 @@ int debuginfo__find_available_vars_at(struct debuginfo *dbg,
 	int ret;
 
 	/* Allocate result vls array */
-	*vls = zalloc(sizeof(struct variable_list) * af.max_vls);
+	*vls = calloc(af.max_vls, sizeof(struct variable_list));
 	if (*vls == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 09de5288f9e15bb0..7996c4c654b0f5b7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2533,7 +2533,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 			nr_readers++;
 	}
 
-	rd = zalloc(nr_readers * sizeof(struct reader));
+	rd = calloc(nr_readers, sizeof(struct reader));
 	if (!rd)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 9be42f3984405f9e..b58710624eadfe1b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <linux/string.h>
+#include <linux/zalloc.h>
 
 bool srcline_full_filename;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 59d2cd4f2188de72..bc2d44df7bafa4d5 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -13,7 +13,6 @@
 #include "metricgroup.h"
 #include "cgroup.h"
 #include "units.h"
-#include <linux/zalloc.h>
 #include "iostat.h"
 #include "util/hashmap.h"
 #include "tool_pmu.h"
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 5b39ce21e33351f8..87d496e9dfa6669c 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -25,7 +25,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <linux/list.h>
-#include <linux/zalloc.h>
 #ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include <libunwind-ptrace.h>
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index ec72d29f3d586d47..6eaddfcf833e52a2 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -13,9 +13,9 @@
 int perf_read_values_init(struct perf_read_values *values)
 {
 	values->threads_max = 16;
-	values->pid = malloc(values->threads_max * sizeof(*values->pid));
-	values->tid = malloc(values->threads_max * sizeof(*values->tid));
-	values->value = zalloc(values->threads_max * sizeof(*values->value));
+	values->pid = calloc(values->threads_max, sizeof(*values->pid));
+	values->tid = calloc(values->threads_max, sizeof(*values->tid));
+	values->value = calloc(values->threads_max, sizeof(*values->value));
 	if (!values->pid || !values->tid || !values->value) {
 		pr_debug("failed to allocate read_values threads arrays");
 		goto out_free_pid;
@@ -96,7 +96,7 @@ static int perf_read_values__findnew_thread(struct perf_read_values *values,
 
 	i = values->threads;
 
-	values->value[i] = zalloc(values->counters_max * sizeof(**values->value));
+	values->value[i] = calloc(values->counters_max, sizeof(**values->value));
 	if (!values->value[i]) {
 		pr_debug("failed to allocate read_values counters array");
 		return -ENOMEM;
-- 
2.53.0

