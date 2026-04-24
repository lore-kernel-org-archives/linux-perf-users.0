Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633633B97D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049274; cv=none; b=AJ/9rfCnBcWnPq+P10lpQZ6K2jbha+k5szxYs+xbNMJ4LtQnSVLmJf8TZNMmoLFI0JxGn5vqxCnLqNWAv0ZiONc+sPWcgmPZMm+ufAPitcuE6CGegFo8pCmCaRWQbBtHQZRAs+xpVPhM+qzNR2cZm1fNKY8pM24De+BEVMnWXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049274; c=relaxed/simple;
	bh=IzGtiew6lV3UoAkWJeECtCMku/bwu3+F3qCjyvwzJ3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3QFeET/5P96f/dhRqab1dyOPc68VsxWxqjsFJNeOMSQ+dAlzvEuJjrX0cDOJrdPt8zzHyA0Z4PzrqZwDmYksh5byMFH3GrhBofGLtIVR8HBqUvs50F8uBJAu/askdFZNgoYVzL0MI3pQOOTGGPPre0k6q4RNxOXaOMITewJzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jncUDAh9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jncUDAh9"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd1c74508cso12952461eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049271; x=1777654071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=jncUDAh9+NmqQe5u7hwLhU2F1Se793H2HXlQ6CV4KNuZLUPFjmK/Bb0FRW3ybRNyNa
         +snVOIgAwcUauk+CGxzIVssYlidQJM2IWrEH01jinZNX4OImLHEJqMsw4B/rTGYXpfem
         haB0kLMc6MvsPOXHyBGFsWW7ja2uLvc0MNEiQ6EIYWAd8V2sVRQWm4fkmTOzTCYnKGuf
         PTiBsMstgjJLdfgLKSGvqMbX8MO6MS/oQZeNGvMtJOyyeCURamcvu07UUsi1pNGHh2Ao
         6mmz27nB4iqgFdv/x+2dVxaa68DjGJQk9rRzl5MyWddEkhOAKu+w0FRTa6IrOLFFW8+9
         ywiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049271; x=1777654071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=ns1pcXoYdZ2pHbjgJUqnWJiVe7CvR4uR5WiCZrklvdSXk6oE5riEyx4RIdVCYfE8C5
         62OhX0Dht0BBWyfI00iAYilTWfPejEvwBL6vkknccecmbwGQ8q0XOHP7bciNPhmnhyEK
         +oKM9GNcmSNHWt1zA956V2rNiWGJlMvXTqtnQGBUQtRti07Z4cIYajulTNmbAqsXKQ2Z
         OgGKZeZhrOrgorDcjNLqPg+bPT/FkHAadV7F6fqS8wTT6vINzezXRP38KA/wM0XWGX7O
         E9nS3o/4GcfD3r+ch7UfWZELMQFcFSzIsjQDbRPNUV1vKI5rfZggw4MXGZwIwcYaCg5K
         d/ww==
X-Forwarded-Encrypted: i=1; AFNElJ82QeN0drGeunW1cLLAcgdqdnjZmvNPZTp1LXh7N+AG0WsG+BJlsaDcEruln6YbrHjNnLn9vCtL4LWfzbgKvfqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjUhx8Zd1QXgQRaFYAKaiJZjZZuZSgy1NeJPhG8dZaImJ6W34
	pOZsKaxSeV6xxB19H2KtzLrw+YE4l5XWjycrwgr+8Y4fev0YYlANIaYxDOdw5bMONwTrncaTton
	R863E8ABGFA==
X-Received: from dyjh29.prod.google.com ([2002:a05:7300:561d:b0:2e0:f299:f616])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2d15:b0:2c9:ee15:a0d6
 with SMTP id 5a478bee46e88-2e47901662fmr20345135eec.29.1777049251118; Fri, 24
 Apr 2026 09:47:31 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:25 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-4-irogers@google.com>
Subject: [PATCH v5 03/58] perf arch x86: Sort includes and add missed explicit dependencies
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
 tools/perf/arch/x86/util/intel-bts.c | 20 +++++++++++--------
 tools/perf/arch/x86/util/intel-pt.c  | 29 +++++++++++++++-------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 85c8186300c8..100a23d27998 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -4,26 +4,30 @@
  * Copyright (c) 2013-2015, Intel Corporation.
  */
 
+#include "../../../util/intel-bts.h"
+
 #include <errno.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
+
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/types.h>
 #include <linux/zalloc.h>
 
+#include <internal/lib.h> // page_size
+
+#include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
-#include "../../../util/evsel.h"
 #include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
 #include "../../../util/mmap.h"
-#include "../../../util/session.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/debug.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/tsc.h"
-#include "../../../util/auxtrace.h"
-#include "../../../util/intel-bts.h"
-#include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index c131a727774f..0307ff15d9fc 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -3,36 +3,39 @@
  * intel_pt.c: Intel Processor Trace support
  * Copyright (c) 2013-2015, Intel Corporation.
  */
+#include "../../../util/intel-pt.h"
 
 #include <errno.h>
 #include <stdbool.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
+
 #include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/types.h>
 #include <linux/zalloc.h>
-#include <linux/err.h>
 
-#include "../../../util/session.h"
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
+#include <subcmd/parse-options.h>
+
+#include "../../../util/auxtrace.h"
+#include "../../../util/config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evsel_config.h"
-#include "../../../util/config.h"
-#include "../../../util/cpumap.h"
 #include "../../../util/mmap.h"
-#include <subcmd/parse-options.h>
 #include "../../../util/parse-events.h"
-#include "../../../util/pmus.h"
-#include "../../../util/debug.h"
-#include "../../../util/auxtrace.h"
 #include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/pmus.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/target.h"
 #include "../../../util/tsc.h"
-#include <internal/lib.h> // page_size
-#include "../../../util/intel-pt.h"
-#include <api/fs/fs.h>
 #include "cpuid.h"
 
 #define KiB(x) ((x) * 1024)
-- 
2.54.0.545.g6539524ca2-goog

