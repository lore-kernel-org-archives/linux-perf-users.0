Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91873524AE9
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063002; cv=none; b=JnToe8470IiQZLKQ2uCv65vZByBcPQQb73fv5aPy6hihm+5HZZHcllJUGwu2EsvlsPP8ED0o6W1PiIsdbouatrgWURBr1OaCTWyEDDcWmpB+jPW7Yc8ZdlZLDNnuTNCJzT2wjz/xNckOCCAG49XrbzJIzPod0UVkyCT9SUqTvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063002; c=relaxed/simple;
	bh=EaXpGARBBS5UY6+5xSkisv2AXW0aUbBwnhgcfujXjbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UecS0lZwCBWZ8gDeWAd1q+Wvf/MzLy+TzPbH3JivN5MGcEkDUaAOaGsNhMKPqMmNcLkvD/GLyGU8fPdCr/geu4lXuqwLhy5L6plr1MhaLV2UhO3ljieou1rHegQBQZbHx/dlucqY9W5C8APZKcCvBc9u6ZD+/XAzFpKbK0AePo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxZAUdBm; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxZAUdBm"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d7e0f3b4so3364625a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789063000; x=1789667800; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhOY7FUWuuOuty23dXeNbRVWoUfkVepaF5Bi7tmSR+0=;
        b=LxZAUdBm8nqQT/Zc7cy8I37BqbBkoeikGKIE9oIevANx/FxqCH4BH7uh8oJhha7FEe
         BpUZ9Q0FLQ5gESHS5/jCxelF7AWw9zMH0nFCVkN0hfcT2/FVvUK/+8+yvXvPphr5iIPh
         X8hJ6LsKXMMG/iHQW/Jq3H5FLTYAOs1pAtlr7WUOCnJR1/dqsYOMx5ZPJVaK7pdu0MBs
         TGjyHFkjzKlJKsJFFy+0vJgs5Io8Vln5aldGujN96cRMdeizYpU5nsUKwDJRuiEYDS7E
         UFswOTfUubwbOXgGp47xPxL9NfqMXazbriqHML+rOoYoBd2RHtZPJgxtgNO/KbJKLh2J
         FjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063000; x=1789667800;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhOY7FUWuuOuty23dXeNbRVWoUfkVepaF5Bi7tmSR+0=;
        b=COOlV5ycEJB59j1kX/wfXknsAbEBqtyr0JVLQQLln+Vwzc+gBjFrtIRrpEdzOzxHLg
         n3Gz3PN5VkxyZrlvk11d/30njxFda24xShi5PijtbHgSRmlGNVuMl79v0EbwkCH9c73i
         iBQDW4oI4jP0sDZfQWChFvc6d+OrM4vu2BJW3Rn0x1MlmJJYQ0gXz0OKbUneRn6+tsNp
         H2YClp9HhrxcLvhyatq+KGM+WPywVwJMXRZ6dFlbOjGaXf1hnzGMP6uFjl3CzYfUN4HH
         2tl87rbv4HwbFM3jUsgYnIEpVfq8jq8f0kNE2epEnD6nuuaX9M0c37JZpDuGlm917xMi
         attg==
X-Forwarded-Encrypted: i=1; AKwUvBzTW1KV7g07oPy608UZ6i6T9HHe7vgaO5Cwi+ufac0mORP8kaHOE08RY+PEzC3R30XWIAH3K1bM83MCCLYvgPOn@vger.kernel.org
X-Gm-Message-State: AFuF++lWk4zNpDgi6TXVeWKpUx6vGnrG+sAHRda8tLuW10nMzyAyhihS
	131T28nfPXH/cT7AJxNySv8I9Oxssbt80UGuwuZ57GkPir3vd6cfuI205GWdlc/5beUulM21poE
	6EgkW0j059g==
X-Received: from dlnn26.prod.google.com ([2002:a05:7022:619a:b0:13d:2447:768c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4a:b0:39d:6f12:fd47
 with SMTP id 98e67ed59e1d1-39d70bb2226mr14538059a91.20.1789062999526; Thu, 10
 Sep 2026 10:56:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:56:33 -0700
In-Reply-To: <20260910175634.3014018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910173715.2996571-1-irogers@google.com> <20260910175634.3014018-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910175634.3014018-2-irogers@google.com>
Subject: [PATCH v2 2/3] perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len
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

