Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743F40FDAF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542220; cv=none; b=Q7/a69+FYH8lBWB36BSSG/EWEvCRtE1qJinNeH5durPc8m0mw0Sl5FXlKGJ9wbzkVAC0oQAzASsSr0Q9LhohVW75/2S6TxEabUKvtL3TGCazhROvWuri9uVW315z7UA8khHPsMpSxDr6RIIV1+BslLsm7nmhngr2XtXktI0dDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542220; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk0kvP8WVZDOL3/gAk/kQCp81LiMv0CCNF+S6qnaGnyM0s2/ffmMH5RZvxH4oKVskYpLrJI+vfiyijWBBBEa/Efp1XhhSEv8n88jGNIMFtBsAez+y6CtnNDYZwZqvj1fgB9wy59Q4adpt+w3vBVnhDiH/v6dMbl3/Ei3B9Hl8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phAIOqN+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phAIOqN+"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso2474493c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542219; x=1782147019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=phAIOqN+SV85mhtKT07iyI/uEHb43y78y5L2DJL5B4quf82o63N39aqTuHYoGTrdD+
         GLMSmCeVICi1dcorQTTF3WAzPQE6uZ7QWLa2r3Lofd+lgDo5lG51LWG8mj7ZK7St3m7f
         w8JcptoHvWJuNBPLOkUo68RxKy92dJfCCJtHS4n7IgYGJQe+Tu6KMt9Qo/gqDN6X1nf4
         h63qLFOP8jpp+zsy/RSYr8uuKRMogQow4nLy7t3NItte9z76QodlYvruoQXMnk22OPLy
         XRGHihKb7pP1sA0Y+dJunKOqDNy5K0tN3XZ6yncdJ6AKM140tbUcuv1mXcaiQq96qME4
         qMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542219; x=1782147019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=O9fhtTc6FcJMLGA/lX9opEI6fya69V9/gjSz+1XSrITV0IJhxqPv6GOrgOVYnOdwa5
         jRmkD/6a4DxzYwVJ12f7+x5X30ayfNFaNlB8oBgBrXAkQzax3b8iwrdO9O0bn+w6nHeN
         11NdN9k21PFrso8Nw0ERNQEp+fKj2BJYF6WFCvXrlSpgTvt2zrDHpfDkVCR2Q1VCniFI
         O9D9qaIfENOneWwp3VvWCJBOs8Y0BX39M7iMPvdDegHytb7+waOjM3nCNw6R2xFG/UN2
         NN78bzknbjFY9I0S7h4N7lGsYZJF7emzqHVyLUCCwrsxkyq78vr5mrDjVx7e7hocGxBq
         RFyg==
X-Forwarded-Encrypted: i=1; AFNElJ+XLyIDKca+jdm5iPFL+EXFLa+GnnHY8D3mwSZYwWu0JVVcf2PvarCndNzdyrYzVCoVqZdOxkK0KTTZLewmAulY@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWusKrPPqAofQmQLHeERy8LZBUsDBoviyazo3G9roKNJUu7op
	t+LEDqnzjsdMaTBk3Xn7mowo3tFt2nx4uJC0preeNPQA9solEayigIugOSopvyQmJtvikUUQtEU
	p1a0q5UGXew==
X-Received: from dyctz8.prod.google.com ([2002:a05:7301:9f08:b0:304:e34e:e1e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4190:b0:138:43a4:925b
 with SMTP id a92af1059eb24-1398581a0a2mr130840c88.20.1781542218447; Mon, 15
 Jun 2026 09:50:18 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:49:52 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-3-irogers@google.com>
Subject: [PATCH v19 02/20] perf python: Add missed explicit dependencies
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

