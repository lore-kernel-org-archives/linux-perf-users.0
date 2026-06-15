Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846211DE3DC
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483304; cv=none; b=F33Fi8xC7EfYyINEDG/nEesHEhCezJ/s1kEl0j9MLduUv+qKfOL2/EDnMOJ+AcrG/gbDkIRjrrDWiLOMt19xcWJbwO56iU//bayaImMMWoQYNbW3INShVseWnvEpvur5/0EM3gzgz8C/d6qQJQkgXBi5Gw7jnJ3KooP/7IR/P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483304; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjtfqjVBLv6GBCHRLDLGj+afITUadBeruKlL32j4DMlDG+iwx877D8j/G0tjHJLnQWMpGPdtVhpg8mKrQ1P8U3sjFc19/YAjUdZGv4bPU4mXRzlcC4f7Uuvgh61ckaXBCv1jbYUoEAcdiLHC2ALlY3OP1+VDLWZz2JZUquRWMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1ySdmgO; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1ySdmgO"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1394c3ee7f2so4636165c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483303; x=1782088103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=V1ySdmgO40tqgc37XYbifuIUl+E2FWAlGwRouAPP9EWHaHMM8MRRkHI82nbtOAWW3w
         +ztFi8Pn/m6Ue9N4BWNMHBzBLtdU7zlVoV1y1x5xp56lfZj0O65qAMHnmqagvAERizx+
         fktmMW809WtwlvQISaCS7vvG68mJy9T8wJ7WioCBSEviSQPpuiP2mFk31CXWBSuZmChI
         dr8KBRLqpIAgrWraJQS5eWtT8RZlLqCmkij2F4Qk2X/AEAIzpbCwP1xXsx18UVaGkGzo
         ROQDJMJlhHDFNTB4SqS/dDtOlI9jl7wV/ezlEY4AG5YlEsOpAPwIygWtunED+0eD6He5
         /Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483303; x=1782088103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=nloumXmBABRMbbFyZQdIoMa7tt+B/Xp/UvwQZu2lOJqqO9TCvImUxoSyomzzFEgBEC
         504YChjM2PmHjWKrWSwvWYbyLYf71nC53OCB8kHDnTvm2+68UTiKSA02aj5RXrcE0ONR
         p8YVNNhyRSNPn86rvFkRciG/iBOJI84ru/913SayruQmbmZDEi8EngUbOynObFPD4Wfm
         ePTAEOD7hDda3QlfMuhK86hfqeC/e72OVY306nRYOlUFcxqHsrC+mvnxqWuXL8ir+Fla
         8fL6eIepqo3XdZ6h41SSxZ5ubweQxc8L8cn3f6Gy8v14VCB6HJi8dtZtr5zv1CxoVV2t
         JA+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ennbcSJhK58FLWu7Sro41B25Z+VyUB2TwclLmf4ip1eSc77dodxf36gXtq93+DO3rUUyTbEKR/NNoFPJnNNcC@vger.kernel.org
X-Gm-Message-State: AOJu0YyD70RQiwBNT3HOeutJHn8of+I+cwvNQe/rbeOCbP+LBhRdMRKj
	N1fcD9rSLLG8402CCbPp7rWCi8I0SftySKr9S+Ecm9kl4wnFpIiNgHiZwDKzTC7Jtth59eT5ycY
	T1c/KKymcAw==
X-Received: from dlbcj30.prod.google.com ([2002:a05:7022:699e:b0:135:b432:37dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:250a:b0:137:d08e:e5b1
 with SMTP id a92af1059eb24-1386f34a1femr4089185c88.16.1781483302288; Sun, 14
 Jun 2026 17:28:22 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:27:54 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-3-irogers@google.com>
Subject: [PATCH v18 02/20] perf python: Add missed explicit dependencies
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

