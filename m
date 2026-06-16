Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7668373BF2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572557; cv=none; b=oaHhKIBasgBaxXYLZ/PvRopWJVlg0zYFXM0l6oyN4O1Koanfusn87/Kc77rt2y/AM28m2UR6mSU412dssufUw3vYnd02YhvCQABHJsSz70ABRg/Dx+ctVA4/c5RoQ2KkKYr3+Izqbs1I4f74USXiszCjMdneS8FkpFX0vPtdmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572557; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lMJqZvk6M5bmcaLeOJugfjSZHNosxJAJEvH7BvvegxwX5o3rSZ48MxWb+XxzEGZei8zQKCWa6Zpv6gCxhwbMMbN5qvknLnsC/tX2K0KhkM65MBCRXhzejJgXUyjxEGoz/6jaggtSBtt8mp0ODXz5JZcx+zZCSRaPCOjO2kGBTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3rSOfik; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3rSOfik"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1383723dfddso4997443c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572555; x=1782177355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=O3rSOfiknz717YHMoERxDmhtmzdxlQUxejiW/7GdWJ01mKYijIt3MG3Mhi8V92MpEZ
         4NVGfMknxXHdAwT7ZK5TlNhxHUGKUlzEsVNRrvYtAAaoEvypdAKeZL8xlIgr5czHoROI
         T8BvE8Pn/skm9mpogfXR0wCfs82gDBLVFrjJ+547MfaxK2r6yGRH7vGBsyVRpqJ2uTcV
         +O0eNPsLlBcDPvvBn80gZD6PjxyLV6Kh5V0MyATv0qiEnut5AC4wyFYd86opeA6ZYrLk
         RHBOIgN5W0SQOqzdP0p734d+sERjNxqL0iOQyrWbkf78L68rN/uYv82vH8ty4RHjtXkC
         d14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572555; x=1782177355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=mJ3EepnyzHzXeBaT2jL6K7wyCKeYqxOX8IN9t3nL7DeY4ZWdkY6ZokM6jZ5Ks/l917
         y/tleiCJ6SWE4rJ0J7n/YRjy/Xel2OwCYFo4WxczzZM0j+SJPCJFXVlWXMX9P1ByOgNz
         BbTVxB9ijsU/K4G8jgEJqT+p9On0Kz3AnTHT+GGU+9pd4q1Ie3Hat5u/5oz6Pk1rmw+V
         6xLutvz5n/9UmAbpdW9JXa59I8fvvCr81QDU7WWp7bKi3+RIWdBR4oDFY2OP7QhOEppS
         bg3RFDWe+0NvmjNGIcPHTyGER3HyqD/F1+kY2RFhu8rp88Dz/D33iwh+cutEaQnKQ6UZ
         2Jeg==
X-Forwarded-Encrypted: i=1; AFNElJ+QM6WWWQqYz4Yt7WAqiUs6UKYncy7431o7hqtifcVOW35BAwWUxJCqHT5/PjCH9aA/P6a94E74xMd/WhXDjuTP@vger.kernel.org
X-Gm-Message-State: AOJu0YwY24+yvacygj+ZVnkyPdwCj4UQrUsy39JBOUQ55r0AOmtTsnuJ
	f7dSxy/FFLx+P3ELCVHhqpKIA/oZCAEwlfYQxCuCRd/RsbqyxXR/jSah4uzzoX2tCGJ/pv1gln7
	0QbIXCDiOTw==
X-Received: from dly15-n2.prod.google.com ([2002:a05:701b:204f:20b0:138:7d2:f099])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2390:b0:136:c443:80e5
 with SMTP id a92af1059eb24-13985e9ec50mr795068c88.6.1781572554256; Mon, 15
 Jun 2026 18:15:54 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:24 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-3-irogers@google.com>
Subject: [PATCH v21 02/21] perf python: Add missed explicit dependencies
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

