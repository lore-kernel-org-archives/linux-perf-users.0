Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE861FDE31;
	Mon, 25 May 2026 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671497; cv=none; b=ODNWZE5CpEEeZj2U05FbUnKJYuNZo2ualj2MVVBzc+lsqRNF07nTdFvLmttaa272211YM/Rm9rSs4fF9ExAWEQaAXEkSCu2vsCqIvx9sfL0W3ie+SLUj63NeqIf42yGmWGeP0+IQ+zUY3nCjg9gLxlyBS+8PxIvqUpvtxRjJqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671497; c=relaxed/simple;
	bh=d9WK1CSuAcIwrSciSsTwEoUvp82kNc2SWZsWJtyNkVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyyD7hRgoyNoEhtE3EAQ7uHIAOqWT3IVR17xV7J6wzep3nOCE0RuK+oVstFS3PgAdJuBLQw8AoHaDyBPLqypa/jIHWZRX86SI3F/zvMT/034f6+4QMFMtW9ntRcxjT//mDOv4JvLh8XfC3GTEIUQBpm6mdL7GXM4aopZ44yxCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2hKUQLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2hKUQLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D51F00A3D;
	Mon, 25 May 2026 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671496;
	bh=FdHycpyCx7L/gVk29vWX/fLoTn8EJsG5yIaRcyMb/nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2hKUQLITvcVmOC4looDfaJIt5rgw9CfqwZKnU1dfVoqS6rcsdNuqoVwscHz39DlP
	 Ofpkqx1/h9IqzErIr1HlwWhqGcVNwI1XRafbHXl5NR1qz2mswSfhmTC/G9W5WSxhTU
	 5i9IHBlSbpoyFcZxc8qdYI/Od87rLH2Y5wXJxwpR0RaJq+j/1Svm77W3zjgPrs8FBb
	 Wqwk1zHo/99IwxbD6ecMnzzxWJ1Vj9eZrnHtigFlzI1vLhucBbGLRph0sB5EDpglZe
	 Wi8b1AmJ24JZv8Jen89GYg+Kt6XmEdVGjTFR+o1GMvT0OwbUZ1n/hRTLiANxFgIWql
	 RRj+ajVyxSwMg==
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
Subject: [PATCH 2/3] perf trace: Copy uapi/linux/eventfd.h for beautifier
Date: Sun, 24 May 2026 18:11:32 -0700
Message-ID: <20260525011133.179130-2-namhyung@kernel.org>
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
 tools/perf/check-headers.sh                          |  1 +
 tools/perf/trace/beauty/eventfd.c                    | 12 +-----------
 tools/perf/trace/beauty/include/uapi/linux/eventfd.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/eventfd.h

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84dfa101..24660b2bd45e971f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -90,6 +90,7 @@ declare -a BEAUTY_FILES=(
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
   "include/linux/socket.h"
+  "include/uapi/linux/eventfd.h"
   "include/uapi/linux/fadvise.h"
   "include/uapi/linux/fcntl.h"
   "include/uapi/linux/fs.h"
diff --git a/tools/perf/trace/beauty/eventfd.c b/tools/perf/trace/beauty/eventfd.c
index 18b661282834b7d9..830a5b7ae455f157 100644
--- a/tools/perf/trace/beauty/eventfd.c
+++ b/tools/perf/trace/beauty/eventfd.c
@@ -1,17 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include "trace/beauty/beauty.h"
+#include "trace/beauty/include/uapi/linux/eventfd.h"
 
-#ifndef EFD_SEMAPHORE
-#define EFD_SEMAPHORE		1
-#endif
-
-#ifndef EFD_NONBLOCK
-#define EFD_NONBLOCK		00004000
-#endif
-
-#ifndef EFD_CLOEXEC
-#define EFD_CLOEXEC		02000000
-#endif
 
 size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/include/uapi/linux/eventfd.h b/tools/perf/trace/beauty/include/uapi/linux/eventfd.h
new file mode 100644
index 0000000000000000..2eb9ab6c32f30502
--- /dev/null
+++ b/tools/perf/trace/beauty/include/uapi/linux/eventfd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EVENTFD_H
+#define _UAPI_LINUX_EVENTFD_H
+
+#include <linux/fcntl.h>
+
+#define EFD_SEMAPHORE (1 << 0)
+#define EFD_CLOEXEC O_CLOEXEC
+#define EFD_NONBLOCK O_NONBLOCK
+
+#endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.54.0.746.g67dd491aae-goog

