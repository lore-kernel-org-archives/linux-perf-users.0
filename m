From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 1/2]: perf util: map data buffer for preserving collected
 data
Date: Tue, 21 Aug 2018 11:25:56 +0300
Message-ID: <f5d77b16-25fe-58c9-19c0-138638e0ae9e@linux.intel.com>
References: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

The data buffer and accompanying AIO control block are allocated at 
perf_mmap object and the mapped data buffer size is equal to 
the kernel one.

The buffer is then used to preserve profiling data ready for dumping 
and queue it for asynchronous writing into perf trace thru implemented 
record__aio_write() function.

mmap_aio control structure of the size equal to the number of per-cpu 
kernel buffers is used to keep pointers to enqueued AIO control 
blocks for monitoring of completed AIO operations.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 18 ++++++++++++++++++
 tools/perf/util/evlist.c    |  9 +++++++++
 tools/perf/util/evlist.h    |  2 ++
 tools/perf/util/mmap.c      | 12 ++++++++++++
 tools/perf/util/mmap.h      |  3 +++
 5 files changed, 44 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..a35675e9f3aa 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <linux/time64.h>
+#include <aio.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -121,6 +122,23 @@ static int record__write(struct record *rec, void *bf, size_t size)
 	return 0;
 }
 
+static int record__aio_write(int trace_fd, struct aiocb *cblock,
+		void *buf, size_t size, off_t off)
+{
+	cblock->aio_fildes = trace_fd;
+	cblock->aio_buf    = buf;
+	cblock->aio_nbytes = size;
+	cblock->aio_offset = off;
+	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
+
+	if (aio_write(cblock) == -1) {
+		pr_err("failed to write perf data, error: %m\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..6bce307d2cfb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -718,6 +718,8 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
 void perf_evlist__munmap(struct perf_evlist *evlist)
 {
 	perf_evlist__munmap_nofree(evlist);
+	if (&evlist->mmap_aio)
+		zfree(&evlist->mmap_aio);
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
 }
@@ -749,6 +751,13 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
 		 */
 		refcount_set(&map[i].refcnt, 0);
 	}
+
+	evlist->mmap_aio = zalloc(evlist->nr_mmaps * sizeof(struct aiocb *));
+	if (!evlist->mmap_aio) {
+		zfree(&map);
+		return NULL;
+	}
+
 	return map;
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..f98b949561fd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -15,6 +15,7 @@
 #include "util.h"
 #include <signal.h>
 #include <unistd.h>
+#include <aio.h>
 
 struct pollfd;
 struct thread_map;
@@ -43,6 +44,7 @@ struct perf_evlist {
 	} workload;
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
+	struct aiocb	 **mmap_aio;
 	struct perf_mmap *overwrite_mmap;
 	struct thread_map *threads;
 	struct cpu_map	  *cpus;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..e71d46cb01cc 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	if (map->data != NULL) {
+		munmap(map->data, perf_mmap__mmap_len(map));
+		map->data = NULL;
+	}
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		map->base = NULL;
 		return -1;
 	}
+	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (map->data == MAP_FAILED) {
+		pr_debug2("failed to mmap perf event data buffer, error %d\n",
+				errno);
+		map->data = NULL;
+		return -1;
+	}
 	map->fd = fd;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..1974e621e36b 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <stdbool.h>
+#include <aio.h>
 #include "auxtrace.h"
 #include "event.h"
 
@@ -25,6 +26,8 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void 		 *data;
+	struct aiocb	 cblock;
 };
 
 /*
 
