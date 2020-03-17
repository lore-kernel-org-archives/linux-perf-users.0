From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/23] perf record: Fix binding of AIO user space buffers to nodes
Date: Tue, 17 Mar 2020 18:32:55 -0300
Message-ID: <20200317213259.15494-20-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Correct maxnode parameter value passed to mbind() syscall to be the
amount of node mask bits to analyze plus 1. Dynamically allocate node
mask memory depending on the index of node of cpu being profiled.

Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com
[ Remove leftover nr_bits + 1 comment in mbind() call ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 3b664fa673a6..ab7108d22428 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 {
 	void *data;
 	size_t mmap_len;
-	unsigned long node_mask;
+	unsigned long *node_mask;
+	unsigned long node_index;
+	int err = 0;
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
 		data = map->aio.data[idx];
 		mmap_len = mmap__mmap_len(map);
-		node_mask = 1UL << cpu__get_node(cpu);
-		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
-			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
-				data, data + mmap_len, cpu__get_node(cpu));
+		node_index = cpu__get_node(cpu);
+		node_mask = bitmap_alloc(node_index + 1);
+		if (!node_mask) {
+			pr_err("Failed to allocate node mask for mbind: error %m\n");
 			return -1;
 		}
+		set_bit(node_index, node_mask);
+		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1, 0)) {
+			pr_err("Failed to bind [%p-%p] AIO buffer to node %lu: error %m\n",
+				data, data + mmap_len, node_index);
+			err = -1;
+		}
+		bitmap_free(node_mask);
 	}
 
-	return 0;
+	return err;
 }
 #else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
-- 
2.21.1
