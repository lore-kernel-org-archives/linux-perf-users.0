Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F43B8BD9
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562627; cv=none; b=tlWN6kKIsw0MLj/tMnO0w6bBITPqZNCclcj3IrIGU56y/9zT0sepbphKAGuQ5+uJLs+4kX7ToSeV9xeeITWmlgPdtqxpZw5zXjjFOws1qfmY41YtQJCZlcvZKB/+3KZDlBEgaiNEnnWQlDPH126T/dfnzmS5BZqXn0lkqRMjcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562627; c=relaxed/simple;
	bh=BmN+uIK2KozJ/CmJ6jybIyW1ngHuqgsLL5Q2oJs/n+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAlITmPz92dzEI/A7xieARID3OuyeHIkMNce0tbnsDXh13LGHfmAEJGfG02spEmvrihzeoPDCAOVonIu0/P2Ml+tfswHl02v5Z4QRWucX0ceoSMzdhsGDRONT2CDK9pcL/xQ1RDXVbRcVOFopCzOXGkMFxzjo72wXUXxsUSJDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSvzhhTj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSvzhhTj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307625ee07fso13471225eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562626; x=1782167426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=aSvzhhTjSkY8PNfKG5RVyAMrl9lVeG4FdrYcW0dTNiTzoYs/39avhJ0zptszyJs8c8
         QIQSaJNQ1UW1hFGwICVawQkPtb5EqZszUdQp0sKbSDkg7IRAnQoa/LimpTHqp97mpv3n
         tDZd4yCQIGZ9Pcvr3HXH9eZLc2OwYHRkZeaW7mKDVLC79EbWrB8p0Hfgpy5vldpuqF3d
         PFoNRz4I52nz9Pn8SdEnBQzttn2ZYkJPlabfqV+b/yNv9Kdh+ZG9YtAU3by4eKsXbPq6
         QlJu2Qw6T1Bff6g5aYRLcC376MZO5okkwgqHDRsQWuq76HrEV4EH/fRB6HgibK6yrAxU
         Y9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562626; x=1782167426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvL9FN3niBRwopfeT8jFF2/cj8/ZhVUpeFaQcjlgPs4=;
        b=fCiCHXOGDV3Zt5VrSZBbC4VWjOyu17txjeM4MuFISh9+y9dJ/5gNivC7HHHfCT80j6
         rG8rjm9LdbFMkv6H28aKhHfzFApIXxduuVO91Z0EWEZRSoaE4fo2Sp2UO3fJ308sBpIJ
         aM1r7PnUHBusIA1F0PRZZOSDFRp7ymf2Xp0P0cwbQc8WyUSTmYDVFmK2CXAhnXW8W2DR
         8i2f2WrhUYNMEP6LZG+khAbOv/ceBKruO4roEIrO34vAhnWOHU8wHiwjjZdNGOdN6RmF
         zuHXRULR0Uipnq2U7/6chsOdAWR9NdZyp765bzZCfsNzTwmwVQN3lfvYfyr45nIhj1F1
         lcXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aEiufBjym+VMrxScULW3fZJCeP3prnc0ea2S62iWw7gwXb3+tgkvF4R5escwOJz/LO8VyZF41eBG6Sf74HdZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Z1iWZ3yoEbUyjufArqQNbVGP8mo0/FJ+9A2Uy3SCGfkOa3+M
	xDT4HEJQ5HLtY5PizJl3CJiPb6N07tNyNX6FE4Sutz8xxMpMPI9E43vLlyujtasEKaaz1BbQg5w
	Pz3OW5pdukw==
X-Received: from dyeq5.prod.google.com ([2002:a05:7300:42c5:b0:2f9:af7:504e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320f:b0:304:5644:f97a
 with SMTP id 5a478bee46e88-3082009bf0fmr9165146eec.21.1781562625265; Mon, 15
 Jun 2026 15:30:25 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:29:52 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-3-irogers@google.com>
Subject: [PATCH v20 02/21] perf python: Add missed explicit dependencies
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

