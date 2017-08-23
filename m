From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/15] perf tools: Add support for printing new mem_info encodings
Date: Wed, 23 Aug 2017 16:36:09 -0300
Message-ID: <20170823193614.20394-11-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add decoding for the new "lvlx" and "snoopx" meminfo fields added
earlier to the kernel so that "perf mem report" and other tools can
print it properly.

v2: Merge with persistent memory patch.
Switch to new bit encoding for each combination.

v3: Switch to generic lvlnum field.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170816222156.19953-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 30 ++++++++++++++++++++++--
 tools/perf/util/mem-events.c          | 43 ++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 642db5fa3286..2a37ae925d85 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -954,14 +954,20 @@ union perf_mem_data_src {
 			mem_snoop:5,	/* snoop mode */
 			mem_lock:2,	/* lock instr */
 			mem_dtlb:7,	/* tlb access */
-			mem_rsvd:31;
+			mem_lvl_num:4,	/* memory hierarchy level number */
+			mem_remote:1,   /* remote */
+			mem_snoopx:2,	/* snoop mode, ext */
+			mem_rsvd:24;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:31,
+		__u64	mem_rsvd:24,
+			mem_snoopx:2,	/* snoop mode, ext */
+			mem_remote:1,   /* remote */
+			mem_lvl_num:4,	/* memory hierarchy level number */
 			mem_dtlb:7,	/* tlb access */
 			mem_lock:2,	/* lock instr */
 			mem_snoop:5,	/* snoop mode */
@@ -998,6 +1004,22 @@ union perf_mem_data_src {
 #define PERF_MEM_LVL_UNC	0x2000 /* Uncached memory */
 #define PERF_MEM_LVL_SHIFT	5
 
+#define PERF_MEM_REMOTE_REMOTE	0x01  /* Remote */
+#define PERF_MEM_REMOTE_SHIFT	37
+
+#define PERF_MEM_LVLNUM_L1	0x01 /* L1 */
+#define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
+#define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
+#define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
+/* 5-0xa available */
+#define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
+#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
+#define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
+#define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
+#define PERF_MEM_LVLNUM_NA	0x0f /* N/A */
+
+#define PERF_MEM_LVLNUM_SHIFT	33
+
 /* snoop mode */
 #define PERF_MEM_SNOOP_NA	0x01 /* not available */
 #define PERF_MEM_SNOOP_NONE	0x02 /* no snoop */
@@ -1006,6 +1028,10 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_HITM	0x10 /* snoop hit modified */
 #define PERF_MEM_SNOOP_SHIFT	19
 
+#define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
+/* 1 free */
+#define PERF_MEM_SNOOPX_SHIFT	37
+
 /* locked instruction */
 #define PERF_MEM_LOCK_NA	0x01 /* not available */
 #define PERF_MEM_LOCK_LOCKED	0x02 /* locked transaction */
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 06f5a3a4295c..ced4f3fff035 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -166,11 +166,20 @@ static const char * const mem_lvl[] = {
 	"Uncached",
 };
 
+static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
+	[PERF_MEM_LVLNUM_LFB] = "LFB",
+	[PERF_MEM_LVLNUM_RAM] = "RAM",
+	[PERF_MEM_LVLNUM_PMEM] = "PMEM",
+	[PERF_MEM_LVLNUM_NA] = "N/A",
+};
+
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
 	u64 m =  PERF_MEM_LVL_NA;
 	u64 hit, miss;
+	int printed;
 
 	if (mem_info)
 		m  = mem_info->data_src.mem_lvl;
@@ -184,17 +193,37 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	/* already taken care of */
 	m &= ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
 
+
+	if (mem_info && mem_info->data_src.mem_remote) {
+		strcat(out, "Remote ");
+		l += 7;
+	}
+
+	printed = 0;
 	for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
 		if (!(m & 0x1))
 			continue;
-		if (l) {
+		if (printed++) {
 			strcat(out, " or ");
 			l += 4;
 		}
 		l += scnprintf(out + l, sz - l, mem_lvl[i]);
 	}
-	if (*out == '\0')
-		l += scnprintf(out, sz - l, "N/A");
+
+	if (mem_info && mem_info->data_src.mem_lvl_num) {
+		int lvl = mem_info->data_src.mem_lvl_num;
+		if (printed++) {
+			strcat(out, " or ");
+			l += 4;
+		}
+		if (mem_lvlnum[lvl])
+			l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
+		else
+			l += scnprintf(out + l, sz - l, "L%d", lvl);
+	}
+
+	if (l == 0)
+		l += scnprintf(out + l, sz - l, "N/A");
 	if (hit)
 		l += scnprintf(out + l, sz - l, " hit");
 	if (miss)
@@ -231,6 +260,14 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		}
 		l += scnprintf(out + l, sz - l, snoop_access[i]);
 	}
+	if (mem_info &&
+	     (mem_info->data_src.mem_snoopx & PERF_MEM_SNOOPX_FWD)) {
+		if (l) {
+			strcat(out, " or ");
+			l += 4;
+		}
+		l += scnprintf(out + l, sz - l, "Fwd");
+	}
 
 	if (*out == '\0')
 		l += scnprintf(out, sz - l, "N/A");
-- 
2.13.5
