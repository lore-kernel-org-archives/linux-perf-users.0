Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F32EDD40
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328454; cv=none; b=OX1cXj8eP0I5O1cXiq0gERUVeMUTcm00gmciCCY+X2sIavGSDjxAUZt/cpeghx2X4kziGBr7bGVKm/gJNK4Pauc75s9JGJE6RECQxoBBB5K0bNViaqK1QER0IevkvU0C1949ngeki3KwrzYk4a4e76eFkK8MaesX4t2/zRI3x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328454; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN5hk/+2rYcNYawScTtU39tP3rjxxO4il2xCSGZaFt9yB1quQfyBgowcensASz0dcWFAYqaZrBOTsknUYZ1OjXPELNlICrzXVAtfQBB5MIDV/iWcs2DgKQ9npuzgqumwOFEgLihVB2flzMzwBVWi4vo+1PPVijqkOGPKD0Egw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMejpi3+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMejpi3+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3080bb0267dso3617672eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328451; x=1781933251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=wMejpi3+TGD8q2iPy2GL9fhn75/476+f13MM5mdkejD6+XE4SjsN1ajQe2PMrXehxK
         4CcvXzVC4ddiIkV8vPqyt5M7pzsyKreuKqP/+wjnOhZD3SO/gjzbLm0+wDkods/jxqUk
         QAOyOfszTcnYlyDhRJhbvmjj/9gaMUfA9cXukMaKC1RtLNvytPiP8xvjfD7VKxsnHD0Z
         HeqbyADZ39mmhoeVYnGIf4kY480Xl6NBaC97lVSsi3caMzBqre1+fCQm0CYms62jTmFy
         Uh95kuJ/7o+gsFRchz0xC09QEKkBGE70w8UMTqVn8ok/1U5sc49QmBZfVkaEG/62YZ8z
         nZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328451; x=1781933251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=rOq6ruLll5x9sTHD8VdvRnxMdLFZ1wmM0ecnGnMxJo/3PTgSKUB6iVTDQ6JPMiCsrB
         MX8a0+kpEXmWgWOWz6agAl8pRPCOlriQtBi56bQIpkh790CJj7KdmtMq5SVu3o4JDInk
         R/bBw3aMn85K/UU9zykOBg+NospbmtoUGeTPxjMF0DgomnDZhYjzVPpY76B9YSt5yLEr
         886pmeQIUyPlN1LScglHH18CtGenOroK0Rdxg3ifE/6j6G4lDhC0hN5Lf4YiF43GPB79
         p0H0+Eybmt3gFz2/jj9hMzmGCMsDeuGaBU7KfT9Df9sgT1Q1dwn54cAe00vqJUZGZ2Wq
         IPaw==
X-Forwarded-Encrypted: i=1; AFNElJ8ukX+ObMDX3Wx/nnI0T3rR5l/Lzk7efMvlVv/xf39cCWMw9KoQCM2Rdq0/3r8FUwvmWihPkXHDaPf0uh7FkGOq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XV04eprEjMfyKC5YeIKDUCuw/N/+U6M5gyIkLkOkNqw4vD6D
	J4xKPU8cIrmipYuoBQjr03HoPBYq7KwC8HyV2/rNO5YAhmmDt0qLHll2Jpdvg603czGNvIWNOWf
	G20C6q+V7hw==
X-Received: from dyjh11.prod.google.com ([2002:a05:7300:560b:b0:303:9118:b1ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:214f:b0:304:d388:c33e
 with SMTP id 5a478bee46e88-3093551a637mr1437544eec.1.1781328450334; Fri, 12
 Jun 2026 22:27:30 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:03 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-3-irogers@google.com>
Subject: [PATCH v16 02/20] perf python: Add missed explicit dependencies
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

