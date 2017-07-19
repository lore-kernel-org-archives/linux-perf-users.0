From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 80/86] perf/core: Define the common branch type classification
Date: Wed, 19 Jul 2017 11:29:44 -0300
Message-ID: <20170719142950.3747-81-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It is often useful to know the branch types while analyzing branch data.
For example, a call is very different from a conditional branch.

Currently we have to look it up in binary while the binary may later not
be available and even the binary is available but user has to take some
time. It is very useful for user to check it directly in perf report.

Perf already has support for disassembling the branch instruction to get
the x86 branch type.

To keep consistent on kernel and userspace and make the classification
more common, the patch adds the common branch type classification
in perf_event.h.

The patch only defines a minimum but most common set of branch types.

PERF_BR_UNKNOWN         : unknown
PERF_BR_COND            ：conditional
PERF_BR_UNCOND          : unconditional
PERF_BR_IND             : indirect
PERF_BR_CALL            : function call
PERF_BR_IND_CALL        : indirect function call
PERF_BR_RET             : function return
PERF_BR_SYSCALL         : syscall
PERF_BR_SYSRET          : syscall return
PERF_BR_COND_CALL       : conditional function call
PERF_BR_COND_RET        : conditional function return

The patch also adds a new field type (4 bits) in perf_branch_entry
to record the branch type.

Since the disassembling of branch instruction needs some overhead,
a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
needs to disassemble the branch instruction and record the branch
type.

Change log:

v10: Not changed.

v9: Not changed.

v8: Change PERF_BR_NONE to PERF_BR_UNKNOWN.
    No other change.

v7: Just keep the most common branch types.
    Others are removed.

v6: Not changed.

v5: Not changed. The v5 patch series just change the userspace.

v4: Comparing to previous version, the major changes are:

1. Remove the PERF_BR_JCC_FWD/PERF_BR_JCC_BWD, they will be
   computed later in userspace.

2. Remove the "cross" field in perf_branch_entry. The cross page
   computing will be done later in userspace.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/1500379995-6449-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h       | 27 ++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b1c0b187acfe..642db5fa3286 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,30 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
 	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
+		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
+/*
+ * Common flow change classification
+ */
+enum {
+	PERF_BR_UNKNOWN		= 0,	/* unknown */
+	PERF_BR_COND		= 1,	/* conditional */
+	PERF_BR_UNCOND		= 2,	/* unconditional  */
+	PERF_BR_IND		= 3,	/* indirect */
+	PERF_BR_CALL		= 4,	/* function call */
+	PERF_BR_IND_CALL	= 5,	/* indirect function call */
+	PERF_BR_RET		= 6,	/* function return */
+	PERF_BR_SYSCALL		= 7,	/* syscall */
+	PERF_BR_SYSRET		= 8,	/* syscall return */
+	PERF_BR_COND_CALL	= 9,	/* conditional function call */
+	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1015,6 +1038,7 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1024,7 +1048,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		reserved:40;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b1c0b187acfe..642db5fa3286 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,30 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
 	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
+		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
+/*
+ * Common flow change classification
+ */
+enum {
+	PERF_BR_UNKNOWN		= 0,	/* unknown */
+	PERF_BR_COND		= 1,	/* conditional */
+	PERF_BR_UNCOND		= 2,	/* unconditional  */
+	PERF_BR_IND		= 3,	/* indirect */
+	PERF_BR_CALL		= 4,	/* function call */
+	PERF_BR_IND_CALL	= 5,	/* indirect function call */
+	PERF_BR_RET		= 6,	/* function return */
+	PERF_BR_SYSCALL		= 7,	/* syscall */
+	PERF_BR_SYSRET		= 8,	/* syscall return */
+	PERF_BR_COND_CALL	= 9,	/* conditional function call */
+	PERF_BR_COND_RET	= 10,	/* conditional function return */
+	PERF_BR_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1015,6 +1038,7 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1024,7 +1048,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		reserved:40;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.9.4
