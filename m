Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2D19DF62
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198301; cv=none; b=Yvh2wtS3Od8/URL+byCf9QJ2VGR7EnMj2EJ+zNW/0C3AQmM+RK2KSJRkLOp3Ih+0ZX4ODGoT/CqNb0EaWTNncOA8eW2tsypakq4t0TzyX2vMGS9of4t/6hskesbxUYWpmy49kDjKbL9n39T49Vu96l3PTbBqxKbowo1/3L/Apxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198301; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMGvjmfbPNa2t6tMGDBg30zq7pX6FJBTlbvO9pUydK5J6bvAI63Tx3D8CMwfxHbn5X03iGi/iZX+VzDSWTS0YfCf3I9he6NiZmPLaNnMPms5grx826tcv86NkEe8zqKNfsQ0OsoqHY+t7Q0RrDAFWja+4sWKML6/U+lBi3VI510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnWeqW6V; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnWeqW6V"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so310819eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198292; x=1781803092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=QnWeqW6Vg0ID251XQ9Ila44zaygx+WNzxVu6qFUbEOE0fpiDOVdEt+0x8rGXfRm7iO
         0WwXG+VYSWm1RJQPU5MlKO5dsSMBr1CeDuQ9VvLhdE3dTr2YWUUdcI4IX7Tk5LxpYXdM
         cYvtjqJgPkGeoqy8Vnmu2qIh/lWumDWoECCNA+VVSWtXq2Q0UlrcuE3xwMl5V/+koGPc
         CujdkSHsDDNS2gMxGzB2mHTmhKirwMursp1axWeNxiZN/r5I1vcD9l0IQ4D+He+Wip7D
         hK7zfCvC4fSVR3uCn7+xMwG/Q+iFCUW5y9PZkM7Bg91p+9AAhGqbLhPQhHnY7cdaMPIk
         aSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198292; x=1781803092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=Hv9guAzIIprQj8ePjAcEcXciG3vMZ1mbAj23SzrUPxTMTkdEES64SXMcCMGao1HdV9
         /wL4NkBJfKHYADG7HAh47rF6hITQd6ygP7Y80h3vHOfGXA3S//AFqRPGe9M0rlfxSJpT
         5AS00/aes51UsPEMI8UkOq2/Lt9RLgQIBwyXrnsSWA8u7Hf7KSGN/ZDmiemZo4lUZl+l
         6lSuEcelx96ME3+WTfeNc2ONz4SQsBI7OPTQo5j5/n0kzGmyNrthdzJItpz4/qy1ipM2
         OIe0ietizjlvz2F4gcS2zp9McahyWZ6ljQrZ9HQWNoTqpDCwXbmYL3Mbx0ZMh0TZBM3k
         MhNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dxerRUporpIpGkkWrmOsFTDkK5h7J3s/34K3T5ZSnGZ2upBoFbp6CqalcskgFYmjhzIge/UOLaVak2fPo6lzP@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDx08X3LWjtnGV2MUGLFP+xYmzlObE9Tu4ULp+xi65LAaaydY
	vV5bA2yNPO9z3NMzLdGqm/2PoP8TMCS0aR4yZ+jyNt/r4HoUi2RxuAc37aMuSlM08gDTwsytT9y
	LPKXL1+LA5Q==
X-Received: from dlaf26.prod.google.com ([2002:a05:701b:241a:b0:12d:bc1d:8783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:113:b0:137:e391:1acf
 with SMTP id a92af1059eb24-1384250354cmr2059009c88.36.1781198291245; Thu, 11
 Jun 2026 10:18:11 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:39 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-3-irogers@google.com>
Subject: [PATCH v12 02/19] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
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

