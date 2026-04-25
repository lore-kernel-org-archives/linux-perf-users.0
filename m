Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744C38D018
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156900; cv=none; b=VyfB33cPvNNW8O16mvveQp6lMPhmuu9yrZiC4Geeg26rSRJ5FDUqtbw+x/puVm8wNGcp8fbssm1mkqfPUuI65FnnrDPApMf8VfG3fRpx1owuEMgYetrtikRUuirj2UAcw5pxYyQ7yXlI1JlT3of3W2sGbQiw3HMrITDrKCX/9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156900; c=relaxed/simple;
	bh=/h8ESLHe5S0bbxRN9MN7l0JrDETJedf6AiFuXhBylRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAk+9SIsl3G2u/mwasog4mJJhWv1/SQyCpzD8GWDT2cMidvhaLQBh/W19kqkAtlPAAwhmNabVMIDgub9o4moo+5lDQVUFgSEnpXbZ+uGIS88bODnijnJ827r0L4fm5sd+RhuVjpGrcFYv4k/kXfnAW25CYVIXaxQhoT2S1Y1sbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRWz78k5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRWz78k5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso89328805ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156899; x=1777761699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=pRWz78k5qCc+WKgmpN8yhIFRSjXWcUI3YmpyHDYsrQGxEf0A6KcXi4ZzvNuxLcWSjk
         rNEhmvyhP0zm7DgGyB08UBAWAAfGI22yOjAwRwAhFyQ7BabwJGlmcqBfZa+OuZi8FlHK
         Os7/7K+g7umXR26ey+jwq6JpmHJx2/f7G8Z7ddFUxq7v0n7ideyruK+a+Ppv+9MLaVwA
         ak8srLWQe1QMipcijY4Ps4838GPASKoj+d9nI75Yaf7wHjrdTZMZBhWIFNG7BMN07OEe
         DtBBA8S5peAMJLiUtAX73Ailea3byBGxO5VA7WGmlsZsSqw8AT1R+Y5xEozB4BA2BKaB
         84sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156899; x=1777761699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=bB+tL7ZVaYNcO2jYK4AebZ89SQskSvUgQAbxNfPqXkLPn/7l4dOiLHhJZs9m42sRhn
         UZbXkJT+vnMST/996RisV+tqYDPkLt1uP/I/6pgHz/XneG7YHAHPlNvnSsYswbEfO+9g
         ZTMbsqwvjnGL6J25tzlAH3MD14emtUrlGkNAw96J5DwshJ+YuBO17L2Eouh5nQM+GbPQ
         yGWYRrOghI0J8nZH/B743/ZtEhtDr5yLpy0MpUABiNkPyXt3V8yFqevPGMzxXhuKx/1O
         frUrjEEgeBmGm77dVIxCVyACs6i3Y6zr3AP+hMn3x+F4ZHeH0xQaIAuxNEKhB4mq5pWI
         Di8w==
X-Forwarded-Encrypted: i=1; AFNElJ85qnvMClkwfRFqnboCcFghnibZfCFaqyqOFDkI09/DStQJi6ci4Hl+dV0ckeUn1IjsT0/QImYm55tISCtGk4RE@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzAbTFn9zFXcp0g5MxLm3p2auP1qX11rt/cuEUIKKwHmHht8l
	BlmBWI1/YJ/B3X2sTPw+g1HYhAyUhEh+jgMzqBUz+6CqXQjMzs/YXWT4ijX0HKhKXuAwZgXMIoA
	//jzbwlJiJw==
X-Received: from plbmt13.prod.google.com ([2002:a17:903:b0d:b0:2b2:5092:b66e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ca85:b0:2b2:5491:e32f
 with SMTP id d9443c01a7336-2b5f9ebd9fcmr260384085ad.16.1777156898574; Sat, 25
 Apr 2026 15:41:38 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:29 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-5-irogers@google.com>
Subject: [PATCH v7 04/59] perf tests: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c  | 14 +++++++++-----
 tools/perf/tests/mmap-basic.c | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 4aa4aac94f09..ada6e445c4c4 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,15 +1,19 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#include "debug.h"
-#include "evlist.h"
 #include "hwmon_pmu.h"
-#include "parse-events.h"
-#include "tests.h"
+
 #include <errno.h>
+
 #include <fcntl.h>
-#include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <sys/stat.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
 
 static const struct test_event {
 	const char *name;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..8d04f6edb004 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,25 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include <fcntl.h>
 #include <inttypes.h>
 #include <stdlib.h>
+
+#include <fcntl.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "thread_map.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "util/affinity.h"
 #include "util/mmap.h"
 #include "util/sample.h"
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
-- 
2.54.0.545.g6539524ca2-goog

