Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77736AB4B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287811; cv=none; b=AwlOngTWDduHuwfliUuwuce2dWWaLk420ly0Cs8uCke/K0Yss5tA6m7XN98NIWqoiXjZvNqZvRCaREfLlRPSlxzoqh3CV1QupfmHTFgGO0qQuyVYHThHp0RCbsN7oFRZzgC14seVkG1qB2fjeLidzMoF4fuBlrOzY99nsMCD36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287811; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EyZSxDgA99QNMurripai2Srb1ye5Tpy4SDTVVUpI5kVvxOu82CighPKG9C0gMgAlKnfphlyDwh7f7ZWd3KLGUGtds1vYu5ANYvBjI2h4DreouQfrtqImjob+b4jj/LCnl0ruMtD3cNV5oDlD0wRLNQG3rq3A0OWCZrtHj4gS/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3RpJcQd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3RpJcQd"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f3465368so1749304c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287809; x=1781892609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=Z3RpJcQdNgAvxL9lkk0GFasEDi9P+z7HrftyJ/KTIAITNj4XBcTLwN26+nCoGEon99
         ovp+Z9ykexMYT9/YtlihfBoNA7g9k1pXlFvM7OA6oVRWSuB0GCshyP14M0F1kaX/XlMk
         erno/k6mRHt4dY3Il9P5dzgZNP3vOgTx4ZCDXGv2HKgFl7XFKiSXWjY4uSMh1DJlwTHt
         UAojnHN1OTbdR0y6+WhQ6acOkGvDfusa4Ozlr6fpisU0LCMEmL/H0a9hvn/9HNI3oKt0
         PotMPeDYc7dZr14ypFDQd/BH3y0GqB0qmOlYOmnqycMADvbIYVeq9W2YW9Z5+MTgA3jS
         yvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287809; x=1781892609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=Qvvwi17I0dm673AyqEVH78bFyteVJxj4hStkm7FuHNYrnvKxvsQSk4AJN+4HF1CZxW
         zf9S1rIZw3zug2j/j/elT1vWlvqA6HxvR/eQ2HQtEbiiryapxE6pQ7dAc/mJOd2Cgzuu
         wo7WBeSU7RnwuQG688ogk/vCSTFSgaAtfi1NgQWj5JhK7MjocwWqWfpWAlk0kkItlptI
         fVYyRxax7fRbylBV0+4eCIWaGJSAuFyTyXnuWvQfotlhZjMaCISW+YrPashz1ux+WDuR
         IaSFYiRTTDgqeVyUiWIZNsoedu7sL7EuIjbTVZVpbUmIFQq9uoKqXYU8/wftxQmZAi7b
         rmng==
X-Forwarded-Encrypted: i=1; AFNElJ+w2KO8WCzP6U3TjwoyxtmtHqvCOKPsl15U1eKWPDrgvL6yQob28/WDKPcl5ZXHwJ3aQCrOQjMRu7qYz+Ks38ND@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkpQpn7G9e0A5RL0vmocClnsqle3DS1GjKCSB+UxAwRadi4KA
	N77hZGRxJecHubT8fP2a3IC3ZkaM4ygij3RKIAtnMMwAmim681RJc+FwU9FS/ksltlLAGXFPJDE
	QEcBLPyJJ3A==
X-Received: from dlbur28.prod.google.com ([2002:a05:7022:ea5c:b0:137:f3fd:df45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60e:b0:136:e639:9c22
 with SMTP id a92af1059eb24-1386f39567dmr314687c88.21.1781287808581; Fri, 12
 Jun 2026 11:10:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:39 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-3-irogers@google.com>
Subject: [PATCH v14 02/19] perf python: Add missed explicit dependencies
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

