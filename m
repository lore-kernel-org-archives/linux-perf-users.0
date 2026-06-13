Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F93612EC
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334675; cv=none; b=nFyZI1WOqYj6j8KnzrlzR9MBJ+eqp371tPCu7hlXA4U5XUVY14jUB/Ad7fddB8aumxdaOlpt79zjMORyVADdj+cJhFNp7aAedK9BidUDnll1Yl4lGaVIJ2xheMJms1s3dbxO4V2FCAyeSsqlI8HNhsnMO3fPwLGjy+0PMCwrbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334675; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxKPY0kDPrS7BxIwk4neE0K4WXHL3MSqdlGcm84clxWh63TKTQbsDUQUkU9sxPIQgYB4mxmRualAGNeLFyY2cFDSijrFJaOigB0Omeh6/1NMzMW9WWqATyyrP0GC4jJLPQKFz/ujfOu8+rZIBClT5UPiRS/x/013/qr1Id7PGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMAhQVdG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMAhQVdG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so2864859eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334671; x=1781939471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=eMAhQVdGNHBBpv52H6FfXfOAnXQHqxSu3bgI/DmJAMHHGADsYEHkK4PQN4llhc+XIg
         qdw7aCSD6UglrttD1x6vWR7h9Lc3CDNtxDUs9zX1+0gslSHzomeKRh/8zZ5Ghmn4qjVZ
         DB2nd13NCkkcSDwQBc+Bm0aJr27HaFDQ95q2wlwQfzXx9jPyVrcE7KY8P+YVnaxOEq6Q
         M/VOBHXaJb3pCjRRU9kIU2U1nWd76HTSsYlUfIqnLO/uUenyKVFnWuTIV//g2fl7bW4l
         tcgi4cUpQoKct0khInCkbEyEQlVLTEp9CIfOUwc04bvCWoQ8RvxJs0BLJDmRIXeTuXro
         qU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334671; x=1781939471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=ZkhFQX0wSUHXVRy9j6ZsjzdTIsRUbysI8dYGpE59bjJLsJJ5+/MGg22PaewRO1JDcy
         chfQP9C9Zh+TcUPKZvk5JH40VohQWu8c2ribT+lSlhufmmqtkIkpZqp7y5gqF2YDE5JW
         h387DF+B3Ep82YLLQAbSPuw4qtMKh51jCTuRV2VWcQ3+xhCDzWNSnXRMB1/9izsbfzVX
         LNe9dL2tGe+jaQ0Gw8SM+9Eec83c5PBbhlabkxqCYRSTYmk3WElBWHinzZ6pb9qE5Wda
         QLW+Atrc9CZw56qSnPg4B5BJPDKg3c8VdspNWn7bLC38M/i3fnyQV9+ZHMZ9LGjUgr+U
         NgBw==
X-Forwarded-Encrypted: i=1; AFNElJ87WGk2FyU+wLNNZWOZ9MZmBcwPcsowbjvRh4SnBmg2noBEZsEpHWGuoIl7YShZSWR+9UzA6/3ACLA4OCTR052O@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXChNL1oOg6hW5bjcpF33Mz//NciieS6p98KRQZFcyLP+N97H
	R9NscEgowY1az9kZF/34+0EvSm+VfREGBjpojI/RcFjh4cCGUlDsu0S9qt18NT2n75rst1pOc1D
	S2Pmv1TExGA==
X-Received: from dyke30.prod.google.com ([2002:a05:7300:471e:b0:30b:6191:7635])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:511:b0:304:de94:1c55
 with SMTP id 5a478bee46e88-30940542b00mr1654196eec.35.1781334670288; Sat, 13
 Jun 2026 00:11:10 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:42 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-3-irogers@google.com>
Subject: [PATCH v17 02/20] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Also define PY_SSIZE_T_CLEAN before including Python.h to comply with
modern Python 3 C-API requirements, and introduce CHECK_INITIALIZED
and CHECK_INITIALIZED_INT safety macros to be used by subsequent patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 41 +++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..98a8dd9b673d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1,30 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
+#define PY_SSIZE_T_CLEAN
 #include <Python.h>
-#include <structmember.h>
+
 #include <inttypes.h>
-#include <poll.h>
+
 #include <linux/err.h>
+#include <poll.h>
+
+#include <internal/lib.h>
 #include <perf/cpumap.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
 #include <perf/mmap.h>
+#include <structmember.h>
+
 #include "callchain.h"
 #include "counts.h"
+#include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "event.h"
 #include "expr.h"
+#include "metricgroup.h"
+#include "mmap.h"
+#include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
-#include "metricgroup.h"
-#include "mmap.h"
 #include "util/sample.h"
-#include <internal/lib.h>
+
+#ifdef HAVE_LIBTRACEEVENT
+#include <event-parse.h>
+#endif
 
 PyMODINIT_FUNC PyInit_perf(void);
 
@@ -38,6 +45,22 @@ PyMODINIT_FUNC PyInit_perf(void);
 	  offsetof(struct pyrf_event, sample) + offsetof(struct perf_sample, member), \
 	  0, help }
 
+#define CHECK_INITIALIZED(ptr, msg) \
+	do { \
+		if (!(ptr)) { \
+			PyErr_SetString(PyExc_ValueError, msg " not initialized"); \
+			return NULL; \
+		} \
+	} while (0)
+
+#define CHECK_INITIALIZED_INT(ptr, msg) \
+	do { \
+		if (!(ptr)) { \
+			PyErr_SetString(PyExc_ValueError, msg " not initialized"); \
+			return -1; \
+		} \
+	} while (0)
+
 struct pyrf_event {
 	PyObject_HEAD
 	struct evsel *evsel;
-- 
2.54.0.1136.gdb2ca164c4-goog

