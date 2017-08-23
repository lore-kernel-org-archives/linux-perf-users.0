From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/15] perf xyarray: Save max_x, max_y
Date: Wed, 23 Aug 2017 16:36:00 -0300
Message-ID: <20170823193614.20394-2-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Save the original array dimensions in xyarrays, so that users can
retrieve them later. Add some inline functions to access these fields.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-1-andi@firstfloor.org
[ As noticed by Jiri, fix up namespacing: xy__method() -> xyarray__method() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/xyarray.c |  2 ++
 tools/perf/util/xyarray.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/xyarray.c b/tools/perf/util/xyarray.c
index 7251fdbabced..c8f415d9877b 100644
--- a/tools/perf/util/xyarray.c
+++ b/tools/perf/util/xyarray.c
@@ -12,6 +12,8 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size)
 		xy->entry_size = entry_size;
 		xy->row_size   = row_size;
 		xy->entries    = xlen * ylen;
+		xy->max_x      = xlen;
+		xy->max_y      = ylen;
 	}
 
 	return xy;
diff --git a/tools/perf/util/xyarray.h b/tools/perf/util/xyarray.h
index 7f30af371b7e..4ba726c90870 100644
--- a/tools/perf/util/xyarray.h
+++ b/tools/perf/util/xyarray.h
@@ -7,6 +7,8 @@ struct xyarray {
 	size_t row_size;
 	size_t entry_size;
 	size_t entries;
+	size_t max_x;
+	size_t max_y;
 	char contents[];
 };
 
@@ -19,4 +21,14 @@ static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
 	return &xy->contents[x * xy->row_size + y * xy->entry_size];
 }
 
+static inline int xyarray__max_y(struct xyarray *xy)
+{
+	return xy->max_x;
+}
+
+static inline int xyarray__max_x(struct xyarray *xy)
+{
+	return xy->max_y;
+}
+
 #endif /* _PERF_XYARRAY_H_ */
-- 
2.13.5
