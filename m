Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211833AD82
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049276; cv=none; b=Ge3ogmG+I/4l4OO6/E5cYjxYLsZw3d4/SJv7sJmx5zTlvhvXaKfoFNE/NkwFmxzHHL1wr1J6XMfbXh1QLqoEdr2HbUzcXBLJBfPURG4ADwwJIx7eboFb6bLh034WmP6wdC/Ah4958CzBk+pxbunE/R08BZA4MlXPzcVAyk2LGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049276; c=relaxed/simple;
	bh=/h8ESLHe5S0bbxRN9MN7l0JrDETJedf6AiFuXhBylRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bD9h+0dTwwuLt0tU7m0uvn8vr4JWB+NW/+BUPJ/owC+FK3NS1X1CU0UYWXVqqW8/fMTE66QNfq5+gdnClhJu69K0NbJAkqfkcL4Qu2uugqgVwxuzsF0LUHsnFxww/T1//1fQJcKYYunZFXIpS6UDonv7QTDjpNm42KA43OoOSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKRrwGyj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKRrwGyj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso8555815eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049274; x=1777654074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=iKRrwGyjBareufwZhFxVJEPyhGtiy8wLIHD44ROSPLfx+ZaFjPPQTLo7HxKSmoRb7T
         VJAYr3p32B5GRJW/nQv5VUu5e8FfLzmzcfRmLPAyO8OEm0zxXbwJhkfXfSwKxThqeGw4
         KD+CbWTEOpV+eqb9snLmZmHcoP6L7sUX4KZElG1hMDeCsLxrS0Bjes4+JwYk+5lYKDuB
         hpS8lyd2riY9DhpXU+8GfJX/AIzccCStzKrdmcxdNffCyIs1yshvJxGPx3CJ32G7cfxu
         KgbZzqcbHm3yOnxqyIonqS6RxPsOcd7vqJUlAEbXdQ6O0Y3CYjdcW+bW2TMaWVfyLATJ
         hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049274; x=1777654074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqXJIn8r4IA9Gva4etcbzr/XlHSVW6Lm8pY9GKRmyzg=;
        b=BqIZBPLsu8I5AzZBkZfoMckGUsmWzIhkCAJubYXcWyBWKMYrqWs1/AN0kN23cvHtCp
         QJy1m/HGNjq24baWHeo34A2RzlnGWb6JRU4hRf+MJxwl9mZMNwJlRDcRSxFQfxOrhZbH
         1qC69B9xAZ/fE10Y5kQQETyNRvetp0iBIZoGvj6gCEErlNHv/XMnne3NwKamOYPVu3J7
         fWsr4gd1rvevnMGwP+WQMg9uPfkMNGOHL8xvuVhOOmvoidxJZkI4crANVXnpRm+KiXYP
         0TEyjhyIwsfzO/mjBcgJEkLlQMRHNdDEF3B67t2mjO9GqS4jOVbvA4miRJFZPFdcuJ2s
         SvKg==
X-Forwarded-Encrypted: i=1; AFNElJ+McRPKoexfVnVwoXARMnLMQJnAbL0XUFhsI5EN3bNMMJrLw/4Eieoucrz5wtvCq9RVn5i4vkl4lSqcOrZ4n4YJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSlERXB0GWRuNF/jvRKM6ibyXxIDyesr4m3w7VUHpn49mBOEh
	UvONfA7P7CaoouB/8gEyvThd4KCwJ40CfLp2qsCtOTTLDyHbLUpKhohgmjCKawOn/L6dxeuVfXa
	Abe2hQQ+YZA==
X-Received: from dycrm24.prod.google.com ([2002:a05:693c:2a18:b0:2d9:8328:8324])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3723:b0:2e2:27bb:a48c
 with SMTP id 5a478bee46e88-2e47883b6f3mr15670318eec.14.1777049273554; Fri, 24
 Apr 2026 09:47:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:26 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-5-irogers@google.com>
Subject: [PATCH v5 04/58] perf tests: Sort includes and add missed explicit dependencies
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

