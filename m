Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05F34388A
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487489; cv=none; b=VYi5bg0KNBnONIBVHeSkX4FdQaTF2CE2wmrJrwTDCEet8CjPPIgbCJzzA7LUSjd8jJsrahU9n2pGoXlhVD1gYWQ/qbRgCe8WEdg+EQh8ONcLdEDw+l5Y25CKXZglXMQxwVQgTTsP69VWuHrWyxjuDo0JIVfd7K3/9u0WkACDGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487489; c=relaxed/simple;
	bh=oYp56yQ9c3HTPir1o13TAxUrIQnMwxiHstNvNMPJJn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9x8J2aAe7HeQEuzZG9mUeIPnbtmAOjsk3oGtDsnQ33Z4OGRALAT6lDsRL+Y+FOgDB+QcfBpiln4O6nXuxT7hHDOBoGgcQbZBsg4qi0nPSwywtTaU6yHIScXvHVJaekue8QPgRSnsrIwsrulBpEUBITEzJLLx2kujgd5DC+Kn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHBIakqU; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHBIakqU"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f5943ca81aso28733279eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487486; x=1780092286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLgxoRHXv6qZ3ND3G4At5I30r6SxZQ/gRRHwp7gOY3U=;
        b=eHBIakqUopjqjdgr6tBj3f9dQAjKt8xrghSgK6J/fsvvTTiy30qg3J+Y+g3nR3kPaI
         GoNECEqNdHgn3iHoNJJQDOkpJpBrVvBnkD1FVWYgp8I8L4v4HjYcq3wOObp27ievp8sZ
         t/SewWfHvrIqx6U1h9eENuupN2Dlkw8nsHgweT+mX5a1fW55/rEoeLWsHniTqjsF01tP
         6iAtRaSmsBTIOc2jvWDMqr88CJkHIUQRjU8piEMxuQ+gJ8tzinYoJ1tj2dMbBhdcrAPY
         wTHtq0qujn4/R6SUlZA2QiRECiEYzz7bLqc44E0cGzp8Gdq3NfEAjP55gC3twtk0QEwl
         BIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487486; x=1780092286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLgxoRHXv6qZ3ND3G4At5I30r6SxZQ/gRRHwp7gOY3U=;
        b=XgUG+/dA2ey71WxWYD4K/lVbxo+JwCDYBpbGfWLKepyMJUPCiCFt4txdDp0pwFpJwq
         oXu+a6zs8LgTXzKnZpBMxox3R/S1q4MYT96HY8g82ua+BglwDAaxH0o6L3SkhpxBel6r
         StFpifVCp3mhfLKgtfFSH4d7eYPL8ocO2CYMVGR5yneCZHfjEfJb+3tsXGLIgy2WIAPS
         9Mm9tnrt4OOPx7kakQCgzFuNHafODMb1jcOr4Q0MsXMuklKNtmZZGHFpb0kZnlIEm7sh
         /b9GTE88hZ4DYALPbSHJuSeo9Y895cf2EpF/BCYJaGsUBRBOyo+jr0A0NrB6m/DbZosK
         tagA==
X-Forwarded-Encrypted: i=1; AFNElJ/KE85SgxoUCKYamWpOiuJc8RdNqCwT/yoy30hF58l6ykn6+j/CBM60ZRpEzTawgQ4giHqFw7jnVa0zHChhKdpF@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ++A1PqPjsDLr09gKnTmBHpmnFHrRVfc26/QCQcAANaBmQwu
	Y0pPO4ryz/XKMB+Q3hqiHf9tcHsschDv+y+hmbY1HJWcxOIl4Xbnp1O+wk7tcTGPfDMvvPK4brV
	CveYcViM3JQ==
X-Received: from dycok22.prod.google.com ([2002:a05:7301:db16:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8b1f:b0:302:e560:afb5
 with SMTP id 5a478bee46e88-3044915659dmr2907607eec.18.1779487485728; Fri, 22
 May 2026 15:04:45 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:14 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-4-irogers@google.com>
Subject: [PATCH v9 03/23] perf tests: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index a18d84d858aa..a69cd1046e9a 100644
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
2.54.0.794.g4f17f83d09-goog

