Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC52264D6;
	Mon, 25 May 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671499; cv=none; b=fNHc3czuMaA8s4wQ8GRsmxqyZiO1ZP+u0XIcA0T0M5VEImJUEkuvwLQPG4SKemuPjs7jYiDctt09/fc61sxX8WChjdYta7ATtBRtLglh5sj70K1u8nH77IelAV3fpqAO6kX2gBaAs/Y59ac0UQsU4jduxOgtXvNwyylz6rbSXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671499; c=relaxed/simple;
	bh=AcSNWXxFQZUQcKjBPLviy+UvLNcbmaXaZ81VJF0hQ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZd3mo9TBYa/YMClboPxr3rM9EALpoYhtkrUmQPbhTjmawhRX/Bfrp8WgCKGFVOmqbx5bNEZ3DEtd6+QPqg75l/2oiNphmppIQfj+j7hYN0Uznopk7ykML3EJz/9aRKkIBD0bbzGuvBwtovFcsmbCcRn+JwHyy3G3AmV+RTROuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZFpXEyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZFpXEyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE561F00A3F;
	Mon, 25 May 2026 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671497;
	bh=rfTfYExoKRje12P93f3tsPmLMGtr0HubGOurHwdlBPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZFpXEyU9HLUEHG3tA5D1Gc7pi9PTVkLg5+kEV056HXqFadGHOlKyXsxzNWxdSYvY
	 gLQwuZKhYjfyrt+T+ulVr51J/4HaOirJAQyzYLRwXdbMKImtgO65epjbUg9ejFh9UG
	 2xLjViUIWAfCCxgAibm/qlxB2o8uruzYMRw3+Gcic9dpK9ThHHAISMUxnaLWl5C5mc
	 xS48cUV2PgOiTLt7jOgFrSnp1VHVbbxxig9EhbhT/dmL7KLS7li/VklSEvKrNGc/mj
	 oDGAiG1sfQy/41wHNXTy6Ou/l0JQGpRMXRWHgHMpTgsSGrcSvvtOYfeh9ykjr6sUGR
	 f+Eo/osX6vmGw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf trace: Copy uapi/linux/futex.h for beautifier
Date: Sun, 24 May 2026 18:11:33 -0700
Message-ID: <20260525011133.179130-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260525011133.179130-1-namhyung@kernel.org>
References: <20260525011133.179130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make sure perf trace will see the latest definitions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/trace/beauty/futex_op.c            |  17 +-
 tools/perf/trace/beauty/futex_val3.c          |   5 +-
 .../trace/beauty/include/uapi/linux/futex.h   | 212 ++++++++++++++++++
 4 files changed, 215 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/futex.h

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 24660b2bd45e971f..59fe80075c951176 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -94,6 +94,7 @@ declare -a BEAUTY_FILES=(
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
+  "include/uapi/linux/futex.h"
   "include/uapi/linux/mount.h"
   "include/uapi/linux/prctl.h"
   "include/uapi/linux/sched.h"
diff --git a/tools/perf/trace/beauty/futex_op.c b/tools/perf/trace/beauty/futex_op.c
index 05d2111e504b8aad..0ff245dffdb432df 100644
--- a/tools/perf/trace/beauty/futex_op.c
+++ b/tools/perf/trace/beauty/futex_op.c
@@ -1,22 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include "trace/beauty/beauty.h"
-#include <linux/futex.h>
+#include "trace/beauty/include/uapi/linux/futex.h"
 
-#ifndef FUTEX_WAIT_BITSET
-#define FUTEX_WAIT_BITSET	  9
-#endif
-#ifndef FUTEX_WAKE_BITSET
-#define FUTEX_WAKE_BITSET	 10
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI
-#define FUTEX_WAIT_REQUEUE_PI	 11
-#endif
-#ifndef FUTEX_CMP_REQUEUE_PI
-#define FUTEX_CMP_REQUEUE_PI	 12
-#endif
-#ifndef FUTEX_CLOCK_REALTIME
-#define FUTEX_CLOCK_REALTIME	256
-#endif
 
 size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/futex_val3.c b/tools/perf/trace/beauty/futex_val3.c
index fe4e82741ffc1c8c..848c544ea8f686c0 100644
--- a/tools/perf/trace/beauty/futex_val3.c
+++ b/tools/perf/trace/beauty/futex_val3.c
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include "trace/beauty/beauty.h"
-#include <linux/futex.h>
+#include "trace/beauty/include/uapi/linux/futex.h"
 
-#ifndef FUTEX_BITSET_MATCH_ANY
-#define FUTEX_BITSET_MATCH_ANY 0xffffffff
-#endif
 
 size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/include/uapi/linux/futex.h b/tools/perf/trace/beauty/include/uapi/linux/futex.h
new file mode 100644
index 0000000000000000..7e2744ec89336a26
--- /dev/null
+++ b/tools/perf/trace/beauty/include/uapi/linux/futex.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_FUTEX_H
+#define _UAPI_LINUX_FUTEX_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/* Second argument to futex syscall */
+
+
+#define FUTEX_WAIT		0
+#define FUTEX_WAKE		1
+#define FUTEX_FD		2
+#define FUTEX_REQUEUE		3
+#define FUTEX_CMP_REQUEUE	4
+#define FUTEX_WAKE_OP		5
+#define FUTEX_LOCK_PI		6
+#define FUTEX_UNLOCK_PI		7
+#define FUTEX_TRYLOCK_PI	8
+#define FUTEX_WAIT_BITSET	9
+#define FUTEX_WAKE_BITSET	10
+#define FUTEX_WAIT_REQUEUE_PI	11
+#define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_LOCK_PI2		13
+
+#define FUTEX_PRIVATE_FLAG	128
+#define FUTEX_CLOCK_REALTIME	256
+#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+#define FUTEX_WAIT_PRIVATE	(FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_PRIVATE	(FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_REQUEUE_PRIVATE	(FUTEX_REQUEUE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_CMP_REQUEUE_PRIVATE (FUTEX_CMP_REQUEUE | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_OP_PRIVATE	(FUTEX_WAKE_OP | FUTEX_PRIVATE_FLAG)
+#define FUTEX_LOCK_PI_PRIVATE	(FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_LOCK_PI2_PRIVATE	(FUTEX_LOCK_PI2 | FUTEX_PRIVATE_FLAG)
+#define FUTEX_UNLOCK_PI_PRIVATE	(FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_TRYLOCK_PI_PRIVATE (FUTEX_TRYLOCK_PI | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAIT_BITSET_PRIVATE	(FUTEX_WAIT_BITSET | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAKE_BITSET_PRIVATE	(FUTEX_WAKE_BITSET | FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
+					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
+					 FUTEX_PRIVATE_FLAG)
+
+/*
+ * Flags for futex2 syscalls.
+ *
+ * NOTE: these are not pure flags, they can also be seen as:
+ *
+ *   union {
+ *     u32  flags;
+ *     struct {
+ *       u32 size    : 2,
+ *           numa    : 1,
+ *                   : 4,
+ *           private : 1;
+ *     };
+ *   };
+ */
+#define FUTEX2_SIZE_U8		0x00
+#define FUTEX2_SIZE_U16		0x01
+#define FUTEX2_SIZE_U32		0x02
+#define FUTEX2_SIZE_U64		0x03
+#define FUTEX2_NUMA		0x04
+#define FUTEX2_MPOL		0x08
+			/*	0x10 */
+			/*	0x20 */
+			/*	0x40 */
+#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
+
+#define FUTEX2_SIZE_MASK	0x03
+
+/* do not use */
+#define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
+
+/*
+ * When FUTEX2_NUMA doubles the futex word, the second word is a node value.
+ * The special value -1 indicates no-node. This is the same value as
+ * NUMA_NO_NODE, except that value is not ABI, this is.
+ */
+#define FUTEX_NO_NODE		(-1)
+
+/*
+ * Max numbers of elements in a futex_waitv array
+ */
+#define FUTEX_WAITV_MAX		128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:	Expected value at uaddr
+ * @uaddr:	User address to wait on
+ * @flags:	Flags for this waiter
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct futex_waitv {
+	__u64 val;
+	__u64 uaddr;
+	__u32 flags;
+	__u32 __reserved;
+};
+
+/*
+ * Support for robust futexes: the kernel cleans up held futexes at
+ * thread exit time.
+ */
+
+/*
+ * Per-lock list entry - embedded in user-space locks, somewhere close
+ * to the futex field. (Note: user-space uses a double-linked list to
+ * achieve O(1) list add and remove, but the kernel only needs to know
+ * about the forward link)
+ *
+ * NOTE: this structure is part of the syscall ABI, and must not be
+ * changed.
+ */
+struct robust_list {
+	struct robust_list __user *next;
+};
+
+/*
+ * Per-thread list head:
+ *
+ * NOTE: this structure is part of the syscall ABI, and must only be
+ * changed if the change is first communicated with the glibc folks.
+ * (When an incompatible change is done, we'll increase the structure
+ *  size, which glibc will detect)
+ */
+struct robust_list_head {
+	/*
+	 * The head of the list. Points back to itself if empty:
+	 */
+	struct robust_list list;
+
+	/*
+	 * This relative offset is set by user-space, it gives the kernel
+	 * the relative position of the futex field to examine. This way
+	 * we keep userspace flexible, to freely shape its data-structure,
+	 * without hardcoding any particular offset into the kernel:
+	 */
+	long futex_offset;
+
+	/*
+	 * The death of the thread may race with userspace setting
+	 * up a lock's links. So to handle this race, userspace first
+	 * sets this field to the address of the to-be-taken lock,
+	 * then does the lock acquire, and then adds itself to the
+	 * list, and then clears this field. Hence the kernel will
+	 * always have full knowledge of all locks that the thread
+	 * _might_ have taken. We check the owner TID in any case,
+	 * so only truly owned locks will be handled.
+	 */
+	struct robust_list __user *list_op_pending;
+};
+
+/*
+ * Are there any waiters for this robust futex:
+ */
+#define FUTEX_WAITERS		0x80000000
+
+/*
+ * The kernel signals via this bit that a thread holding a futex
+ * has exited without unlocking the futex. The kernel also does
+ * a FUTEX_WAKE on such futexes, after setting the bit, to wake
+ * up any possible waiters:
+ */
+#define FUTEX_OWNER_DIED	0x40000000
+
+/*
+ * The rest of the robust-futex field is for the TID:
+ */
+#define FUTEX_TID_MASK		0x3fffffff
+
+/*
+ * This limit protects against a deliberately circular list.
+ * (Not worth introducing an rlimit for it)
+ */
+#define ROBUST_LIST_LIMIT	2048
+
+/*
+ * bitset with all bits set for the FUTEX_xxx_BITSET OPs to request a
+ * match of any bit.
+ */
+#define FUTEX_BITSET_MATCH_ANY	0xffffffff
+
+
+#define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
+#define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
+#define FUTEX_OP_OR		2	/* *(int *)UADDR2 |= OPARG; */
+#define FUTEX_OP_ANDN		3	/* *(int *)UADDR2 &= ~OPARG; */
+#define FUTEX_OP_XOR		4	/* *(int *)UADDR2 ^= OPARG; */
+
+#define FUTEX_OP_OPARG_SHIFT	8	/* Use (1 << OPARG) instead of OPARG.  */
+
+#define FUTEX_OP_CMP_EQ		0	/* if (oldval == CMPARG) wake */
+#define FUTEX_OP_CMP_NE		1	/* if (oldval != CMPARG) wake */
+#define FUTEX_OP_CMP_LT		2	/* if (oldval < CMPARG) wake */
+#define FUTEX_OP_CMP_LE		3	/* if (oldval <= CMPARG) wake */
+#define FUTEX_OP_CMP_GT		4	/* if (oldval > CMPARG) wake */
+#define FUTEX_OP_CMP_GE		5	/* if (oldval >= CMPARG) wake */
+
+/* FUTEX_WAKE_OP will perform atomically
+   int oldval = *(int *)UADDR2;
+   *(int *)UADDR2 = oldval OP OPARG;
+   if (oldval CMP CMPARG)
+     wake UADDR2;  */
+
+#define FUTEX_OP(op, oparg, cmp, cmparg) \
+  (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
+   | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
+
+#endif /* _UAPI_LINUX_FUTEX_H */
-- 
2.54.0.746.g67dd491aae-goog

