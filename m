Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694593358B6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217904; cv=none; b=VlIQ5whu513r+WpBOf3q3ysJxndiVjIO+d60Hkp6vUjFRnOHkqAZs3LFcewwLcK2U43/rjDyH6yrFbBTxnP7hW2Eh8nc5jc0HtrCJfrBZ/I7uVegxoAJ7kCJrQLgX4iNMw3Qdg9th0XgvkEnmIiMOwsbeMRVUX3U2NVylEKB46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217904; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+2VLta4Z9pNTyUPYrpFRGxz+Yo4i0HSECf0IU3QkCpSe0Nz9b+XOwcfBBGM/+uTWKsx5uqWiMdgmvesBt3tPiWQT4/6NiZ26O+vuPzVrHGShtOA74e5P3XhJzJWN9LptpC+wYamK5/uE7kVdpFSzo6Raq8d2ZmFltIhM1I7UK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJBEugDN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJBEugDN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so781662eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217903; x=1781822703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=HJBEugDNDg8YbUF5e0iD5Cspo2DQS2Gx+xAhnbsNrFxYm0DQwF/OOUSFbTUfopXL0y
         GF7m/ovs6r+4UWEqAnjRlt6iGEEasxvZ+JMZ8Yqdpd0i0SEUMhFQI2k3bf4BW2kKHX+i
         pNTrG6YMnfX5uFWu15/YNsYZZZiGm/IkL/PujVDktzTiPIiPYI1ZgjufergIHxT/ZCP3
         KIEtV+QsWDmwxsaBegpv72lQa/Gfdvq8qyIi4ae0Ud+hO10IxhLYwx7Yv0GrwCIALQY5
         X8xBsmZd+jCYn2dSs4oFerilRWQIJTVwpp9fYDh6OLEsOsPucifb5k+E0ekZUhdpfkc+
         f/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217903; x=1781822703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=gcZ7KwXsrngIY9GyIeSW9YWMYZwDGLZ6le/1NOSdFHM4m/JpvCVq+UdId7g920gTLO
         0ULoZQSTlwEr5aCOJ7qCasr7mN1AXn0qgSlbnGgDRxtY+LQQSok/Lr55gBvy5jRqOSp0
         kV1S1tZhOsUm9bHmgbFyiW+NgN56e0SWPUzrhLy0mxW/tZQFMLIyXv/C7xDi9JYsaOY2
         exF504lDXw407Uj2NsF92rzNNkNrHH78P40Gu3sKLjuRsGqS3bCqzLTW1/3sIk0tI1nt
         NKOdyfkwTVNrOCBR3M3BiJlvVvTriHWsNSIU1A+F0gASnQPYzUCr4nSuHBth2aArn1Qk
         Zkfw==
X-Forwarded-Encrypted: i=1; AFNElJ8TJZM2thAWNH+xZY4E+cN1323V2Zkhl+BQ0lvKX/3qsL3R2xHI6cCp1pB9EWnoiNIn+/yKoadnQlmGz/yPU/QW@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnWP8dCn20fx5ZZNittvl+xTM47VMp54/ro5Uj+MgR+yoS6Qc
	3MKzgKV1FVT9lXZ7qNYNB1nXkslK2Dx/4BMLL+YQfHBdUZJI2N1XFj8LsX9oPN5aay1W858pxwM
	2WugNQ8AfaQ==
X-Received: from dlbtu17.prod.google.com ([2002:a05:7022:3c11:b0:137:e4cf:f531])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6088:b0:136:d237:b426
 with SMTP id a92af1059eb24-1384baef20dmr138873c88.4.1781217902353; Thu, 11
 Jun 2026 15:45:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:38 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-3-irogers@google.com>
Subject: [PATCH v13 02/19] perf python: Add missed explicit dependencies
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

