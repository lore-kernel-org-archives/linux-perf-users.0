Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12B23C4FA;
	Mon, 25 May 2026 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671497; cv=none; b=HChcr8jbKvTSjfiWwbll1tq/dkp5qJK0vrOLpv/FnFVjE6vFwBXIVq50XnNi8+vD757Seng5pYbZNk/O6MBtNEZS+kxpMpBHVQISkXQGtJrD0ePrcKcm1bMQ9qBuUfzlxYvYbNFm+4MTh6wOsdHO9KRnmmfu+PZ1G/f39/MsMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671497; c=relaxed/simple;
	bh=mx7O24zXZmQNCg353wEAm5Sag7/cT1nTpPdb9A91VcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BF6HcOe/u90nDBUxs9fh920phIeyXYF1IDSFZZFP4zmf1Sh97D0XFu+zDwBQ5UqzTIyAa/eDFTIKXDLV4ETHizNUkIXHjlOSI9QgK2oiP2EvUZptfVMQZMicd9DSYT+Vhw957YU0pORsbBwWXQIsOJ1bvnLw1QizX+tyLKgqK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXGde3Ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXGde3Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967741F000E9;
	Mon, 25 May 2026 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671495;
	bh=ivmB7oM7GE9cyMv7hCB+867uEi/xgXVlnI1JDNZo6SE=;
	h=From:To:Cc:Subject:Date;
	b=lXGde3EzDts1DAgmIlNhHunRmQ5j8UK/WonfMFt/jjRVUaH0H3+KnovQZrgY6YZrh
	 vbxMGdqTmcz4h+cCwFkbFHUtBQT2ppk7F8CgakI9CcGGaPaRJviO8Z7605dfQk31XP
	 WK8K9A3VvM4eNoVssV1c/Xm5+eqwzq/N6vmOC2kWzvu/OSHAQ0vCHtdpQh05/7ZeJO
	 cQGZIF6RA6iqNzzVT5hvio/0l1V6vgqmU8q854RHUTSfcu7nrrNR/JmcfV8nqufHZP
	 BF9FcAj+Xv9PkgRI27TxVUBbIeBTg/57pNUNOvLzuFnvvCFj4Zz+Mp2g5mGgDxt0o0
	 HStwDOPw3i6fA==
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
Subject: [PATCH 1/3] perf trace: Include copied headers in the beauty directory
Date: Sun, 24 May 2026 18:11:31 -0700
Message-ID: <20260525011133.179130-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep uptodate copied of the kernel headers, let's use it directly and
don't worry about missing definitions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/clone.c           |  7 ++++---
 tools/perf/trace/beauty/fcntl.c           | 19 ++-----------------
 tools/perf/trace/beauty/fs_at_flags.c     | 12 ++----------
 tools/perf/trace/beauty/fsmount.c         | 11 ++---------
 tools/perf/trace/beauty/sched_policy.c    | 10 +---------
 tools/perf/trace/beauty/sync_file_range.c | 12 ++----------
 6 files changed, 13 insertions(+), 58 deletions(-)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index c9fa8f7e82b909fb..c80f800a45d04793 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -1,15 +1,16 @@
 // SPDX-License-Identifier: LGPL-2.1
 /*
- * trace/beauty/cone.c
+ * trace/beauty/clone.c
  *
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <sys/types.h>
-#include <sched.h>
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/sched.h"
+
 
 static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index e1b99b8f55eb0d7c..10fd6a2b75c353c4 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -5,25 +5,10 @@
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "trace/beauty/beauty.h"
 #include <linux/kernel.h>
-#include <linux/fcntl.h>
-
-#ifndef F_GET_RW_HINT
-#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
-#endif
-
-#ifndef F_SET_RW_HINT
-#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
-#endif
-
-#ifndef F_GET_FILE_RW_HINT
-#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
-#endif
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/fcntl.h"
 
-#ifndef F_SET_FILE_RW_HINT
-#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
-#endif
 
 static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size, bool show_prefix)
 {
diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
index c200669cb944a417..085a3ba399a41dd4 100644
--- a/tools/perf/trace/beauty/fs_at_flags.c
+++ b/tools/perf/trace/beauty/fs_at_flags.c
@@ -5,18 +5,10 @@
  *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "trace/beauty/beauty.h"
 #include <sys/types.h>
-#include <linux/fcntl.h>
 #include <linux/log2.h>
-
-/*
- * uapi/linux/fcntl.h does not keep a copy in tools headers directory,
- * for system with kernel versions before v5.8, need to sync AT_EACCESS macro.
- */
-#ifndef AT_EACCESS
-#define AT_EACCESS 0x200
-#endif
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/fcntl.h"
 
 #include "trace/beauty/generated/fs_at_flags_array.c"
 static DEFINE_STRARRAY(fs_at_flags, "AT_");
diff --git a/tools/perf/trace/beauty/fsmount.c b/tools/perf/trace/beauty/fsmount.c
index 179e649fc72a4724..a84e3f9749ca97fc 100644
--- a/tools/perf/trace/beauty/fsmount.c
+++ b/tools/perf/trace/beauty/fsmount.c
@@ -5,16 +5,9 @@
  *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "trace/beauty/beauty.h"
 #include <linux/log2.h>
-#include <sys/mount.h>
-
-#ifndef MOUNT_ATTR__ATIME
-#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
-#endif
-#ifndef MOUNT_ATTR_RELATIME
-#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
-#endif
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/mount.h"
 
 
 static size_t fsmount__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
diff --git a/tools/perf/trace/beauty/sched_policy.c b/tools/perf/trace/beauty/sched_policy.c
index 3fb6d9e0fae9b4e6..f8c8d297c95fbdd1 100644
--- a/tools/perf/trace/beauty/sched_policy.c
+++ b/tools/perf/trace/beauty/sched_policy.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include "trace/beauty/beauty.h"
-
-#include <sched.h>
+#include "trace/beauty/include/uapi/linux/sched.h"
 
 /*
  * Not defined anywhere else, probably, just to make sure we
@@ -9,13 +8,6 @@
  */
 #define SCHED_POLICY_MASK 0xff
 
-#ifndef SCHED_DEADLINE
-#define SCHED_DEADLINE 6
-#endif
-#ifndef SCHED_RESET_ON_FORK
-#define SCHED_RESET_ON_FORK 0x40000000
-#endif
-
 size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size,
 					   struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/sync_file_range.c b/tools/perf/trace/beauty/sync_file_range.c
index 3e8f50ff4fc701f9..50a6c458dff704fa 100644
--- a/tools/perf/trace/beauty/sync_file_range.c
+++ b/tools/perf/trace/beauty/sync_file_range.c
@@ -5,18 +5,10 @@
  *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 
-#include "trace/beauty/beauty.h"
 #include <linux/log2.h>
-#include <linux/fs.h>
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/fs.h"
 
-#ifndef SYNC_FILE_RANGE_WRITE_AND_WAIT
-#define SYNC_FILE_RANGE_WAIT_BEFORE     1
-#define SYNC_FILE_RANGE_WRITE           2
-#define SYNC_FILE_RANGE_WAIT_AFTER      4
-#define SYNC_FILE_RANGE_WRITE_AND_WAIT  (SYNC_FILE_RANGE_WRITE | \
-                                         SYNC_FILE_RANGE_WAIT_BEFORE | \
-                                         SYNC_FILE_RANGE_WAIT_AFTER)
-#endif
 
 static size_t sync_file_range__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-- 
2.54.0.746.g67dd491aae-goog

