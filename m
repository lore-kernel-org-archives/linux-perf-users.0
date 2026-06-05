Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A147A0DF
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645236; cv=none; b=B74EV95VpBJhL3gtB7o5togJ7JUqx4vjqdxhHOcMB0M1wfzdi3whCnLbLk8P8joyLibrCpnvkVXd1imXfeGpM0Gd9LtdJ7soGkKpPHT5kbC1N/zEMXGdEKs+kLeVwm09VPx+IozReqhVh/tAkPA2Peq/jO475JpQDSfWHTDJkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645236; c=relaxed/simple;
	bh=tCSJcYB4NhRgV0EoN+2Mj7s7Z6/xFGuh/NFlr3KWR5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Le8HGWYitCTUTWxsadAARPBwFhJ4UZGyyqww7ar7RoySvcYMN9hkrkIgrOXpsUxc3LtY5WdT/3RMLBohw1QH7dglNdppaCa/1f1165704qAtJ0vg7LJea7hcVQ92OKwbWm1GEaYfiyDcbVytO5W9B76LTqO5gebhRfhXVGtD8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRPffI0U; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRPffI0U"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so1450405eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645233; x=1781250033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3HTbZlk8r1o2shhD5prIkIUfpXfAm47iIMKJ9+pRt0=;
        b=sRPffI0U/GJe0Ys5r/MwRCyOKLTrfXBfbSGYCzdOA+g0QUxNnFbIONTPLPF7VJ96Kn
         XivEmwoInmGsstuG2xEM+fNmzJthuPk6jZtZVedvrAt+z5iTjIFERl/ZtTqNh9EJHubs
         D6T7X51l8Vbgs7TzAXGT8K3n4bnIy0KDafp5WRn/PM0siPeRoa5Da9ZxODJvMKevw5Pb
         XM2xe7G5QuOkxcubAPo41bLWdMsxEF8yPF6rIbISltyHnBhcQaNIMtfl0HE2MvwN/rI/
         fUaiLyeegZEHOaijsaHMFjEBxEZ9vqRvxoK0X2ldiprAI0NhD1QMPLRk5Ypa5mga3nuX
         BYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645233; x=1781250033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3HTbZlk8r1o2shhD5prIkIUfpXfAm47iIMKJ9+pRt0=;
        b=jppnAFH9ptY1x5r9doBFNMKVQbHavN26sDRApD/7Hee9LEI9O6P1YkNowdj9YJTbpv
         tG06Let011AWtFzB0PM56+pYEtGEFfgRs6Y30PwnNAXDeooBrfMYg7MFNTbzGDMiicHA
         D0r5N5V0dICapaUyGMUNSWkng47KEfvIup/4ejFAstawammGxlYgyiSTDHQGJS3uNXCq
         7rSCTEl9Egwm+mKvexso7XuBW/497rrVFy+Jdkdnv77nDuMko4fJEBQoKuYKkGHuVvN7
         6KzspRMl7Sm4Tn69O/WpSiBws3Sk6ccJl16waKf/U1rwu3OHVvSkfx8h9yyyEXf2YWg8
         G7Yw==
X-Forwarded-Encrypted: i=1; AFNElJ96xDGdTba1xAP9cg+tl3sHUgkHq0lMwyIdDgvsGx874S/PmBr27ybcfKGC7DlxMzZADRfWNoJIZd3O4nPRnbl4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vMEC4Mps87oQXOFPgnAYD5UpgU88Of1KrZlNEJSD9ZKHxWJg
	voJdxTEaFn8AgTp4j2OnINjTzPAhFlsbDF+mYW+iVApUmpM3/1icrkCckkdetQ483rnY4Kaa21G
	9lP73OzhyPw==
X-Received: from dycmz17.prod.google.com ([2002:a05:7300:ea11:b0:304:d169:68d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b88:b0:304:9b48:53d8
 with SMTP id 5a478bee46e88-3077b0689demr1167288eec.10.1780645233070; Fri, 05
 Jun 2026 00:40:33 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:46 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-3-irogers@google.com>
Subject: [PATCH v10 02/19] perf python: Add missed explicit dependencies
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

