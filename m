Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20227549382
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061857; cv=none; b=ueU8xTIRXUwEQ4nB+7zEwW0oodqsY2QrXW0vrxTS1jW0B0ra0gof8lPi2dXaQabg9saTBM558/L3zQNNG4i9kpOuaofaxntqyec1pmsKhNXQFrQU2nzr+kMjf6JCcfZttImB2MbRBfzsltXSL9atmWoQ1Avtok11c+A2ysJbo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061857; c=relaxed/simple;
	bh=EaXpGARBBS5UY6+5xSkisv2AXW0aUbBwnhgcfujXjbA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=i0xnqu/g4WmiOD/dgtx0JjjtVmn+FWKhRm3Z0kGb3tTRdbPCqS+72zwEl2maSiPXknCTfxaytrp0JhnTkqcUjUf+wvSVjxl80iI7dF1PvtQwt9SBBNkbv8wXJagejAthu7YGW+KxERIGbhrv55mBNSUvlHDUknsZCyhx5Wr4kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONCqDkLb; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONCqDkLb"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so85004a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061847; x=1789666647; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DhOY7FUWuuOuty23dXeNbRVWoUfkVepaF5Bi7tmSR+0=;
        b=ONCqDkLbsB4DggW+eEq+7ozuA+AyyC0WfjqgAZMxr98kLOmV98D8jmTzY2KEUeyS4r
         XvKjmB/K14YlnmU/TEX6bGcsGlvb5WK+YdE4j0H8JpewhY7qwJ21JFB9kYJsF8bOxjFx
         i81dda30QUhsfyFLypwMp62dUooF9hDUEbz/ExRd5HJTl2i1QDjSZeHN28vsOAtGVB5U
         2Zjex10n0oO2xErQ0nX0Vz0HMnLGvT6q3s2qezGDpjYoylpGosOfHVgwdWGI/7KD6ZxF
         xV/uBvFZlm9nTjLsnT3XtCe+1SWlOwQpvhP2jevp37QYuqG2oAYQ8x+J2U0303C7D6/g
         lxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061847; x=1789666647;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhOY7FUWuuOuty23dXeNbRVWoUfkVepaF5Bi7tmSR+0=;
        b=KVNbdCtaNp6cBtgmZNykTreBUF1IfScqmDRHH3AmL0GiykEO3ETk8beQDKHNj4FvOu
         cQrYcYbnIJJnjbUxy/0PdoHxM+509wtshHZE2atuko0C1n6XsVBqXrI24T2GP+3eD3/J
         tgzatlvAWNvBEm9CoblMAL4vtGx4dwj8xOHax2WGfVHQcBzu4046HrSNRxuAnmijKXEI
         dHo20n4+KhfqrhO1KNVca8y/BIzucYF2wCjaVia0EJ/+POK/5lKUHomvzYZTld17kcJK
         YaL0kiWacH3uhzLWHtyWEtByDR5A+4SIS7YXxx8AE1LtJkvyMFmeA8aDc+7AyNiS8nHY
         5muA==
X-Forwarded-Encrypted: i=1; AKwUvBxQP94zXiHkGrxrJdh9RwLzJyJzv83py5NXpWz8gLaLNmSjtUgM4s8CukCleNinH233xlm4W1vbES5Z9MMVU+1c@vger.kernel.org
X-Gm-Message-State: AFuF++mJVfLFozonSgzeK1voGQuKYQp7opiNelHF7rA8VS/buYQQk3s9
	UVWK+AEbFwVRRku1WzAd+Dkpgkyq0lYmOy+4FkQHtZU4w+t9m9ZqEIE6DCYDI50Yfbg5blrUxh3
	0TW8zMiZlTw==
X-Received: from dybrc18.prod.google.com ([2002:a05:7300:d812:b0:336:ceb8:a920])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e881:b0:2db:39dc:48af
 with SMTP id d9443c01a7336-2dd2a352722mr7855885ad.17.1789061846962; Thu, 10
 Sep 2026 10:37:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910173715.2996571-1-irogers@google.com>
Subject: [PATCH v1 1/3] perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit updates process_compressed() to ignore comp_mmap_len == 0
when validating the compressed header. A zero size is valid and may
occur during testing.

Sashiko review flagged string.h was missing (preexisting problem) and
so I opportunistically fixed this and sorted the header files.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/header.c | 78 +++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7db7da090a1e..bdd79d7542ef 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1,65 +1,68 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "header.h"
+
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
-#include "string2.h"
-#include <sys/param.h>
-#include <sys/types.h>
-#include <byteswap.h>
-#include <unistd.h>
-#include <regex.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+
+#include <asm/bug.h>
+#include <byteswap.h>
+#include <dirent.h>
+#include <linux/bitops.h>
 #include <linux/compiler.h>
-#include <linux/list.h>
+#include <linux/ctype.h>
 #include <linux/kernel.h>
-#include <linux/bitops.h>
+#include <linux/list.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
+#include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <regex.h>
+#include <sys/param.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <sys/utsname.h>
-#include <linux/time64.h>
-#include <dirent.h>
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/libbpf.h>
-#endif
+#include <unistd.h>
+
+#include <api/fs/fs.h>
+#include <api/io_dir.h>
+#include <internal/lib.h>
 #include <perf/cpumap.h>
 #include <tools/libc_compat.h> // reallocarray
 
+#include "bpf-event.h"
+#include "bpf-utils.h"
+#include "build-id.h"
+#include "cacheline.h"
+#include "clockid.h"
+#include "cpumap.h"
+#include "cputopo.h"
+#include "data.h"
+#include "debug.h"
 #include "dso.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "util/evsel_fprintf.h"
-#include "header.h"
+#include "evsel_fprintf.h"
 #include "memswap.h"
-#include "trace-event.h"
-#include "session.h"
-#include "symbol.h"
-#include "debug.h"
-#include "cpumap.h"
 #include "pmu.h"
 #include "pmus.h"
-#include "vdso.h"
+#include "session.h"
 #include "strbuf.h"
-#include "build-id.h"
-#include "data.h"
-#include <api/fs/fs.h>
-#include <api/io_dir.h>
-#include "asm/bug.h"
-#include "tool.h"
-#include "../perf.h"
+#include "string2.h"
+#include "symbol.h"
 #include "time-utils.h"
+#include "tool.h"
+#include "trace-event.h"
 #include "units.h"
-#include "util/util.h" // perf_exe()
-#include "cputopo.h"
-#include "bpf-event.h"
-#include "bpf-utils.h"
-#include "clockid.h"
-#include "cacheline.h"
+#include "util.h" // perf_exe()
+#include "vdso.h"
 
-#include <linux/ctype.h>
-#include <internal/lib.h>
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/libbpf.h>
+#endif
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -3903,7 +3906,8 @@ static int process_compressed(struct feat_fd *ff,
 	 * checks decomp_len + sizeof(struct decomp) against SIZE_MAX
 	 * before allocating, which handles 32-bit safety.
 	 */
-	if (env->comp_mmap_len < 4096 || env->comp_mmap_len % 4096) {
+	if (env->comp_mmap_len &&
+	    (env->comp_mmap_len < 4096 || env->comp_mmap_len % 4096)) {
 		pr_err("Invalid HEADER_COMPRESSED: comp_mmap_len (%u) must be a 4K-aligned value >= 4096\n",
 		       env->comp_mmap_len);
 		return -1;
-- 
2.55.0.1007.g17ff1f9808-goog

