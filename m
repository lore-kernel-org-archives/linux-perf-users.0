Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A205346E78
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139351; cv=none; b=Kb44Lh+mlj746r8hH25e+t3TnJCOwQZc+KEeVa+DzIvqv+81AgBWLJasEsMxe/q+qUf0OZxbtw7DTVlc+PU5yvKvZ8ZEqfQBi8Ce0R7RNCajEkglXlPEpuNU9FgZjEIgMXIPqGaBBeW5CfcrEFztVZbR/dVOOggNnYvlvlwm1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139351; c=relaxed/simple;
	bh=/h8ESLHe5S0bbxRN9MN7l0JrDETJedf6AiFuXhBylRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UNCjcj6lXxB+DLgcITtm+7iasH7cp/KJPuLJUmre+7+jCpa2LSlub3w643xuVKDGt4wrLAOkkLhOTOTNXGST7gYUEgGW+1v8pn8LsnsaR4EbuJ8Ol8SegTV0Su2HNg3QglcFu2srR1cLkKM/dN9gZ9zckt9d25EhSCn2mtGev08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLcMByGc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLcMByGc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dba1e866dso3321407c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139349; x=1777744149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=hLcMByGcD4stv9k3HDwL6eCoHYvF7qhwN89zBiy+Y7MGwsD3a8b7RrrTJCgA56uFih
         R6Ekb6W2bODve/1LASsJKZXPIibiCCF1gYuJgkhzu3i4AZSegBg9rHhJkz/xx70+GfXs
         rYnRmL4eGiJEhC6mXyKSXUhr1CH16oQyal+aQUq1EzOVUNLJZGY2CEiiPEqsEQO8CHKp
         WzxfxUUEBrrcWR3ysxZ4NHPNr7BZ0L/BLK78eB8lixAU4MF0/zUwQl+DyhcZnmXSZ/cW
         pcMrVuzkrZgdOoec2HquKlBd7Ifkc5Z01/FfSPLO88LgzV7dPWkmFnF5txeYqCtdBf9G
         xvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139349; x=1777744149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=Sb1JTvo6HeUsc17OgLHITgb+VrDJfLxkhaPjNYF74bC+3cV36jD7xv2ObRoEAjZS3L
         iRMY7thddKMZbEaJruIJx1kDZU05fPCzEXxx0O3ZuaztBOVggp37rk3WYz5CTmmaqxBg
         sB0XgJMOJbOlDSb2DOab5mfMJHdKCPRuGenCwAubsev9TySXbdbJKoP0mDAyX5av78k1
         7D+3fQsxniMWgU4qTYXn/F8iRboNAj7da+h70PG72Wk3lREiAYrihvDfzOPkeg0nrIF5
         1ikdlSBm2QzAioMvhnMnLyU19eVQeKis9DxZvAgWOdmTZXiW/NVFkC9RvZxEmSuxs1wS
         7MEA==
X-Forwarded-Encrypted: i=1; AFNElJ82dTZCroezsPq8gkz4hrug7XtxFqhSELIYZHx+Nynw87AtUkXfE+s8moOj4vvDXnLBVjgHdXkdB9wrk7/B2nzj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9DETsH80Fy4THNDDhezkS6NSq6ZnQhA0bnqz9rA87a5N2bL4
	klIVNFKJVzhgS3seCZnOVrKaXjjIpS+hUzqmxYAe0eXzZJuMR+PPw3jFuYMlN8TD4sMU7NE8H6X
	X3VbG+WI6KA==
X-Received: from dlbrh4.prod.google.com ([2002:a05:7022:f304:b0:12b:eb91:8863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1283:b0:128:d5bd:3557
 with SMTP id a92af1059eb24-12c73ae5574mr15608343c88.4.1777139349253; Sat, 25
 Apr 2026 10:49:09 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:02 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-5-irogers@google.com>
Subject: [PATCH v6 04/59] perf tests: Sort includes and add missed explicit dependencies
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

