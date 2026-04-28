Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF763D0939
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360769; cv=none; b=P1hXIhHIK2SaZ0APx9ET5Ieeu71WQWc4usaCrS3EZyoMN4IaJDsiDrAW1L++cqeQnWn+0pkW887pFFAtpudL3T36e/KwwONpUrOO64gTT4rOzzr2iauedFZrFjcTHxLe01H/vfCZ/KKZTLfE6wO2kt03lRzhDRZ09HdLtR/LiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360769; c=relaxed/simple;
	bh=QHTZx5MPgaaZQHiX00rro2INAj+zmier+jw6hcgWdKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sg6BIoIZIgqcHP28GNFLaklsub31csE7cVcZ6cdhxuYyTlNN3Ma7teiQKKwMW56BayTvXphLHxfnbUXBQ8yJ5Ov27Es44pXfGSwcmi5iBBoao4op2OrQcMXiN2WdnY4L5NbVazxIAYPX7FHx28sCzLY6FHx0PFiEvtVFohdNUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRpkS+hN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRpkS+hN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f058973fso13242266a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360767; x=1777965567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=VRpkS+hNHa80YUWY4FYklC5rOUf6FEvNSzQyApdyPZBY4brkKgGIOnKMrIb4KdIOdf
         5H70m1fEPlbPieJNSEwPZtuShRTTV6LxRVT+2k796dd+32VHFNhy6m1riIKWBSsFmJxX
         Ha9J8MDLVDrGp6uQeTfaekAc3J3w8LIPIQ7csXs23syeIgb+3vUjyufUms9vXHlhXAfl
         BxzBv8jhYEA5qsBAbr2bMSEoxIBxfmimWsV0pupHG1R9g0Uoka7XVl6RP3g+5OLXqQEW
         rYe5h8aJsYBo73rdmXG+//Mvfh6ovx5YyAyfrFVENLUKrxYoqxoDsyCkvPY3PegZMbTo
         t1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360767; x=1777965567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=bREnZ0pxNVOa3Xo+gsP/o1744fz49SNhpROxsx9rgvj+lAnru0QPmdv+xw3QTTylai
         Eg8vLcxcDFfmg52WGo2vH5vnbveyJtliCyiRS6qxjkP/w4Dnvyms0N3OG4m65gxkOiw3
         IaABlZcPB86Eze42D34Z2w61UV6a8BxuZwCebs0HvrDMv+UVahl3khJDRP/jBmB94vIM
         +6Nf4bey7Jxc5LISa7mQ6qahLvPsr5RRUR7ylR1t3Z8bBlhhiEnNWp7ZFZ/tZ2EHOiYE
         WzSAzysyJBQolp4dvD7qQqXfHuLvk7ogGHEMSFyq/xNoF9eR8aj6XG42pSj12ccw6I6+
         ac3g==
X-Forwarded-Encrypted: i=1; AFNElJ8xbD15rNmTnz+sp+IduB5L7YXsv858741IPJ6+uKG+qINEyuxzGi/JyJ21amTEJjrkQiV1iREwHVuwtPFqqYGd@vger.kernel.org
X-Gm-Message-State: AOJu0YytDCZvN1f/N+KSHOfqDrBZ0g669D3gn6BJx1KBKa6EabuTfnWz
	t5KS6tjAdbip9k9Cu4HdSuojm6x7kNmMybuSwHBFE9C1lKX7VMZCqqbkvrUwnf+4skLxkZdn6MN
	fUOrqATG1iQ==
X-Received: from pgjf17.prod.google.com ([2002:a63:dc51:0:b0:c76:651e:6d72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7351:b0:3a2:cc5f:2187
 with SMTP id adf61e73a8af0-3a39c24c919mr2365748637.28.1777360767081; Tue, 28
 Apr 2026 00:19:27 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:09 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-5-irogers@google.com>
Subject: [PATCH v8 04/58] perf script: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmu.h found while cleaning the evsel/evlist
header files. Sort the remaining header files for consistency with the
rest of the code. Doing this exposed a missing forward declaration of
addr_location in print_insn.h, add this and sort the forward
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c  | 111 ++++++++++++++++++-----------------
 tools/perf/util/print_insn.h |   5 +-
 2 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..853b141a0d50 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,74 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "builtin.h"
+#include <errno.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <stdio.h>
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <linux/bitmap.h>
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/stringify.h>
+#include <linux/time64.h>
+#include <linux/unaligned.h>
+#include <linux/zalloc.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/utsname.h>
+#include <unistd.h>
 
+#include <perf/evlist.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+
+#include "asm/bug.h"
+#include "builtin.h"
+#include "perf.h"
+#include "print_binary.h"
+#include "print_insn.h"
+#include "ui/ui.h"
+#include "util/annotate.h"
+#include "util/auxtrace.h"
+#include "util/cgroup.h"
+#include "util/color.h"
 #include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/data.h"
 #include "util/debug.h"
+#include "util/dlfilter.h"
 #include "util/dso.h"
-#include <subcmd/exec-cmd.h>
-#include "util/header.h"
-#include <subcmd/parse-options.h>
-#include "util/perf_regs.h"
-#include "util/session.h"
-#include "util/tool.h"
-#include "util/map.h"
-#include "util/srcline.h"
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/trace-event.h"
+#include "util/dump-insn.h"
 #include "util/env.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/evswitch.h"
+#include "util/header.h"
+#include "util/map.h"
+#include "util/mem-events.h"
+#include "util/mem-info.h"
+#include "util/metricgroup.h"
+#include "util/path.h"
+#include "util/perf_regs.h"
+#include "util/pmu.h"
+#include "util/record.h"
+#include "util/session.h"
 #include "util/sort.h"
-#include "util/data.h"
-#include "util/auxtrace.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
+#include "util/srcline.h"
 #include "util/stat.h"
-#include "util/color.h"
 #include "util/string2.h"
+#include "util/symbol.h"
 #include "util/thread-stack.h"
+#include "util/thread.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
-#include "util/path.h"
-#include "util/event.h"
-#include "util/mem-info.h"
-#include "util/metricgroup.h"
-#include "ui/ui.h"
-#include "print_binary.h"
-#include "print_insn.h"
-#include <linux/bitmap.h>
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/stringify.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include <linux/unaligned.h>
-#include <sys/utsname.h>
-#include "asm/bug.h"
-#include "util/mem-events.h"
-#include "util/dump-insn.h"
-#include <dirent.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <signal.h>
-#include <stdio.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <subcmd/pager.h>
-#include <perf/evlist.h>
-#include <linux/err.h>
-#include "util/dlfilter.h"
-#include "util/record.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/util.h"
-#include "util/cgroup.h"
-#include "util/annotate.h"
-#include "perf.h"
 
-#include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
 #endif
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..a54f7e858e49 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,10 +5,11 @@
 #include <stddef.h>
 #include <stdio.h>
 
-struct perf_sample;
-struct thread;
+struct addr_location;
 struct machine;
 struct perf_insn;
+struct perf_sample;
+struct thread;
 
 #define PRINT_INSN_IMM_HEX		(1<<0)
 
-- 
2.54.0.545.g6539524ca2-goog

