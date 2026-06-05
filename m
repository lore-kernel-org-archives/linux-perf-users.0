Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2040F8F4
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686921; cv=none; b=SJiKBJKQoxSnlR1rPw8AVfLGnKQyC2Uhj2bOZ7DwOZpCHbhBpvu6ptLTXprLEI4IKAUWfxzs+EuDyB1lUx8K7JmTwjhzaQ1SH2i+55gnv0IVjASInGFGvYCkvoWUb+Xv3KfwndUm88sblH3JSwBUyMUW0sTpa8UdQfrYj9OO6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686921; c=relaxed/simple;
	bh=tCSJcYB4NhRgV0EoN+2Mj7s7Z6/xFGuh/NFlr3KWR5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GyuZpLxBWQY6+sMN9477OgdR9LLkv5oCdCZOe4gB346YZEE/0JykPx/7sP5pvpqtjADEnUrv++XPMA3rIWn8MdlZFx47fmqjrcrEOju63XU0oT1PXIBinm/QxG/vZyDp1ga52gvcXgdvEfV1AfmEA/QcMaV7k3Xe/9+fPAt2sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0yo9NpN; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0yo9NpN"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so5594084c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686914; x=1781291714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3HTbZlk8r1o2shhD5prIkIUfpXfAm47iIMKJ9+pRt0=;
        b=N0yo9NpN6jtICPqQZefVhi+OWgzTEmpGIrozTR6frgz7fW6Hlj30QJAmN+DbP1qkXt
         vSLCjqZrpiSYbb6YHB4BLfJBP0KaM7DBXW2ZzarBmEApqnrPNGby2OQ15jLpoMwQQAr7
         IADmkqR5zkoyVPERQWkwboo+MIt5ReSVOop45ArR9vZTfDP5oURmAk3iwAZzDv3Zut6H
         LPR0tslky5VV3e9eRcZ0ybPRKpLAJzqKziwlQIL+dZp7Nr89ziyN0UvHwb2eG+G0fRzA
         /+NKBTGhZgRtmILbI5pFfwviC0+AtISoC7MiGDtCm8D1St6xcpp+dFlCtlzjdX8XbQbg
         70HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686914; x=1781291714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3HTbZlk8r1o2shhD5prIkIUfpXfAm47iIMKJ9+pRt0=;
        b=LWTtpXuNs+2tT+NyUgaBC6iw+rVdU9pc5fodIt//D8h9og5VpfyByDL0GkJnaVzE9F
         RisUjF6aoArsOeC4xxm85SlkMNjjGEn0ZJpLdouOy12J8F6A41jZH+OUpC8vXc/EibTX
         JbMpCYtx5gulgl5OUHcBYoy2Kvug00ruCz3IODc2dc1qd+7mbMOEopAAIn3jAnEqB5YY
         WKUzPlWsQ94FVjByfq/ccxcwB3zqaFNKPpAFlPgsnbHqmHMcH9lCIBEwNkd+buxGkIpJ
         2L9Q2InK5Ea0PJkR0pILmqXzT07A6eMLimRITE6L/wEdhZgq7mQa7pdPfG9Y0Z5DSrC0
         m3NA==
X-Forwarded-Encrypted: i=1; AFNElJ+q0Ox25QUgEFF9ho9yD8wgdz9uUWdBIQ1ooJBNXEketA65CqwJuDvw8yZ22Th//tpPsBlPs68LSyzHxkcXFoKu@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpjAxdBcbS/EE3Q1Xc+hvL2W1dDNnd5nCiImO2D6xIeLHhkeC
	7Jyr8sJ0/P5PlCaBPWhl9eDZbpBosJnz6MT7kR+jXFfmtc26aD6+rqE9dWafV93mF2PvRFmaVp/
	zNpJLMackaA==
X-Received: from dlaj10.prod.google.com ([2002:a05:701b:280a:b0:135:e6d6:d140])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef18:b0:137:1ae1:bc19
 with SMTP id a92af1059eb24-1380666a380mr2376008c88.5.1780686913509; Fri, 05
 Jun 2026 12:15:13 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:43 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-3-irogers@google.com>
Subject: [PATCH v11 02/19] perf python: Add missed explicit dependencies
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
2.54.0.1032.g2f8565e1d1-goog

