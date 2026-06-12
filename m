Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8C3D170B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302363; cv=none; b=hsWJUHqV99bKPS3oCtGUvOz1bMMf9X5hCILdL78RPDb4zv8838hHB0j+wpVKlUXeJ74RkRGa7Q3SSWB0SQ4uANxI7omM/52+dOYGwS3eOX0e8QYcu1l1fWWTb/EIYCy6WGDV4gwby9V5fzltizgLufnXdFvwBXa+0ScBMBotmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302363; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cXNfstSezAvrNn9bFh+UBhvtgu1BnQLyH8hKujGoq/XRqpue0LGbDTvn7GcUISEjIWSuOKRZwkjfodR1VXizfjTCYnNXghbgIOeSYRtDdtV/80/5cuA++OdR7o21PSKJG3pHH5VDKm7Ie/5R2HhkcYLBP+lbP4YL3O9ZhJ9Qpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyW3xGKl; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyW3xGKl"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so2044174eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302360; x=1781907160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=DyW3xGKlf6ELyNdDO7uHfufrA0sPI+aa9Xh3rFJiYS5j0AuV52BZJ8Ttzlee8InN6C
         HCYWe8xwRpl2FPZ1iCZnk031BWG88otuHYlrT9vTGFp+3uUba3Pd/X6iBgFeSh2QYrRN
         ViSjDFDTpI4A44J8ebkU7MkqJs0YR3ZQXUROj0rjhP8b7GBNTO8dZpL8K1oEyTGqqUHb
         kF2m1NWiZO552OOg9M+mdYc1h5DzEoTm8EvafyQc+jNpTQTtC8nYVz8k1DqZDqUkOMZl
         lDtRhVyGQR6FK0NnWKZiJFUf6ADmrJpygd5hjVZR2O67yY2QSJeqtdURjJXTe+74SJTA
         a0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302360; x=1781907160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=WPiJQnqSExTbqwGdW/NHN19QZ2xHEo5EVWCkhpBEM5cfEngFIb+eFfLWnilyq2imSO
         P43r89DZM9D/CM9gBXzIFB63//4CtLOdV5dj13x03MwaF7878Wvhla+3fuUNnzh89rzP
         WAMBJdpMsHvwrpg8iVekWvKPgNHYflNqDgWXKr5VJ96fX+sSIt5UaCDsfpY+ehbrK007
         I6lsItvsDUe9WMLHGUrXIsFI6ak4uvFhcGKr4IrBS5U6P7y8yk5vQzKC3aA7pzWh+7fN
         +ZcPAr50MLy1yxcegdybuFkYYePE1nxBuqocKAfl3soKI1QFtu/olxTCdkgqiQb+tG8p
         Xyww==
X-Forwarded-Encrypted: i=1; AFNElJ/mP6ZxTqHQkAkmd9sWp58k62Qh/KL53ie0ZJgL/7XxfDW5FeLZtmaj5HFStR83u/OXr9XpLyKlncdA2xOCQVyy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+W1Shb4LirGh/FL3TqPcFI+1AkBFuj6yr1CN8bs/2mlgzx0YI
	Q9TMIOgPcBy/rVOCnTJOCtQc4n4V77dAuzPvi/5y9YEew8kmWDnXfo5/Nk7ifjyLpcEMVWl2oJn
	4aVYaIMCpZA==
X-Received: from dybmc34.prod.google.com ([2002:a05:7301:19a2:b0:307:d71d:34a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2293:b0:304:5db8:da95
 with SMTP id 5a478bee46e88-30820093b4bmr2675697eec.23.1781302359769; Fri, 12
 Jun 2026 15:12:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:11:54 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-3-irogers@google.com>
Subject: [PATCH v15 02/19] perf python: Add missed explicit dependencies
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

