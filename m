From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/20] perf mmap: Declare type for cpu mask of arbitrary length
Date: Mon,  6 Jan 2020 13:06:47 -0300
Message-ID: <20200106160705.10899-3-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Declare a dedicated struct map_cpu_mask type for cpu masks of arbitrary
length.

The mask is available thru bits pointer and the mask length is kept in
nbits field. MMAP_CPU_MASK_BYTES() macro returns mask storage size in
bytes.

The mmap_cpu_mask__scnprintf() function can be used to log text
representation of the mask.

Committer notes:

To print the 'nbits' struct member we must use %zd, since it is a
size_t, this fixes the build in some toolchains/arches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 12 ++++++++++++
 tools/perf/util/mmap.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 063d1b93c53d..2ee4faacca21 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,6 +23,18 @@
 #include "mmap.h"
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
+#include <linux/bitmap.h>
+
+#define MASK_SIZE 1023
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
+{
+	char buf[MASK_SIZE + 1];
+	size_t len;
+
+	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
+	buf[len] = '\0';
+	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
+}
 
 size_t mmap__mmap_len(struct mmap *map)
 {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bee4e83f7109..ef51667fabcb 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,6 +15,15 @@
 #include "event.h"
 
 struct aiocb;
+
+struct mmap_cpu_mask {
+	unsigned long *bits;
+	size_t nbits;
+};
+
+#define MMAP_CPU_MASK_BYTES(m) \
+	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
+
 /**
  * struct mmap - perf's ring buffer mmap details
  *
@@ -52,4 +61,6 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
+
 #endif /*__PERF_MMAP_H */
-- 
2.21.1
