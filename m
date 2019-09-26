From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/66] libperf: Add 'event_copy' to 'struct perf_mmap'
Date: Wed, 25 Sep 2019 21:32:08 -0300
Message-ID: <20190926003244.13962-31-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move 'event_copy' from tools/perf's mmap to libperf's perf_mmap struct.

Committer notes:

Add linux/compiler.h as we need it for '__aligned'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h | 5 +++++
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 47c09f375fb6..10653b6e864e 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -2,10 +2,14 @@
 #ifndef __LIBPERF_INTERNAL_MMAP_H
 #define __LIBPERF_INTERNAL_MMAP_H
 
+#include <linux/compiler.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <stdbool.h>
 
+/* perf sample has 16 bits size limit */
+#define PERF_SAMPLE_MAX_SIZE (1 << 16)
+
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
@@ -21,6 +25,7 @@ struct perf_mmap {
 	u64		 start;
 	u64		 end;
 	bool		 overwrite;
+	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a8850ce2c2ff..4b8ec8dd79c5 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -51,7 +51,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
 			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
-			void *dst = map->event_copy;
+			void *dst = map->core.event_copy;
 
 			do {
 				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
@@ -61,7 +61,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 				len -= cpy;
 			} while (len);
 
-			event = (union perf_event *)map->event_copy;
+			event = (union perf_event *)map->core.event_copy;
 		}
 
 		*startp += size;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d3e74c8da51a..75c77fa57121 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -23,7 +23,6 @@ struct aiocb;
 struct mmap {
 	struct perf_mmap	core;
 	struct auxtrace_mmap auxtrace_mmap;
-	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
 	struct {
 		void		 **data;
-- 
2.21.0
