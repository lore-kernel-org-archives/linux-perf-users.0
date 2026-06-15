Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A723B0AFC
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504203; cv=none; b=eRMFSzkpBEV9legFoBzRDEji18Ag0LHT9MyDQQ8wNBTOLSgKwvS70C42uviHwqpNoWRrT4DNhpQD0wZvztVkRY4xl4//aCUJK6W0Qoz2o3ZOkJHu7qxxrcZmKyD/qDct2wBMF6m037SAGFtYdLPdGXT0ss4ipErd2BNB/YCVL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504203; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D93C6XyAg0g+4cvD0AKz+Vl6UFISXVKo1QQ8HMNpoN6ZFIoojJ0mBpNFkks55ZBeqCpNX/+O/4ij2aK0PnqdrgCAlwRQ+ohvvO0crdR0WyZGq+A7CwnvmxYI9qqvtb+Se6iTj10P916W8zRNKynolzxv9qqEkLLCIKYTGF33rI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKNnZdhN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKNnZdhN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307fe856724so837145eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504201; x=1782109001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=kKNnZdhNRbHu6wX8HK2JsyZnsZNNyxilRW6+onvqxaeQsRci9gGmwngzSNT+k09SCP
         5oOUtlxm8H/DrrBzvPPg2Cpz4DMwlO8c+tKwJvdt0F2gqtrDMm6ZrY6ZnwUQYOPtzJbG
         unblFyVZ4jCZXN2BjNo+cxJk60udSEtaJ+3hW5qYwKrWWPtb4vgMqykPS3MCbYXyQXaH
         v1PxtzCNWNyGeZ+6otsawpkitKaXm/RhII0tmKdXV7M7cyUu72+373NuWI7Eyjt5WK7j
         5XbQr2AdBDlORaSkXan13+zKd4dYAwX/JdDjozxarAqqSSB6PP8/WwJM+5FnZ83iwsra
         58GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504201; x=1782109001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=aShOSKNlDkygL/T7PSoNDcfqTPRwG+W79pUbaeqF7g4BMepPS1CZQPBZxRg3I8JE7q
         42bgQEBn0n3PuiczsoUJfuvr+wBa5pTb4xo97v1tRhp/00zC2+d14YA5jnoN4vI6ulAn
         QITmg0PFYuIBoaLLCcWe5hncdKO6OjKL8hJw/m7PXQmbek6IFTWcDRTv1La/C8zdnSD2
         bMCHH7/qsObiqEIwi9cwIcwbpi/4K96LO9LKPhG5YRYSsFfl9vFjYFQok3vrX8GfSw9x
         AMAoHPAaXJfZpA1BRXriaiROb+8hCSrvEqOfCiWE/NYSyhFaw740v+YDOw23/WMG2zpG
         0LAw==
X-Forwarded-Encrypted: i=1; AFNElJ+3W1CAnJ1gSr4lmaryfnmc7sXj2wwmtIOx/4h24Uubkwh5wknS+env++y5fxr2pWjKmb4hwLlfxsRfeDKn5jUb@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKZIJZSR9siRzOxbyWhRtziK1azo/UZMvrefuWe/z+5dptg7n
	8lEdVXrdYCUMdnC1bo1Jfy+WB/wHWyx+ocom+6tZ8wRIfR6631ZDhXMKj7jybFnOqN3ZkBF/XGf
	rw1hsY3ho3g==
X-Received: from dybii50.prod.google.com ([2002:a05:7301:2f32:b0:304:15d:7342])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b83:b0:2de:c5ca:c1f3
 with SMTP id 5a478bee46e88-3081ff55ceemr7453364eec.4.1781504201170; Sun, 14
 Jun 2026 23:16:41 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:12 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-3-irogers@google.com>
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

