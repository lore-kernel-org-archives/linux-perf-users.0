Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132435F5FB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139359; cv=none; b=PTALlaPazj/gLXkbofL1WJcAHlG9/tlCWi/TjTFjHHLlrsddtwlhkzUDbRm7nb7IQfrsO7nIJX776mk62vqmeYdypinEp0Lbo8Uz/ccJX5+mEFGvQbIEjW43Zh+mGFeRWyDg//lvwBnaDUAe9ftbLkS4LUTqHxOIrQGs6aKppiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139359; c=relaxed/simple;
	bh=E1A9rOUkigl47RQgwxPU7BZg+a2AkxhYpc7Hpry26ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=noeuu0IJWxzaa8awoEIBC/shyE5ujXJdGY0mM/L2l3jz9XqrPra7YMT7QkxBb7eiNMXMYLhEzyq1RoneU1Z8mlLmmI1E2+iQBKzedHX9CKBhyLOlRXj6zJOQ20IlPkdN2XwCh4pIpd4x7xJFlrkz9lnXoJY5PUU+QaSqM+XpmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkKv2yF+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkKv2yF+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc75e79b97so24050506eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139355; x=1777744155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=rkKv2yF+7VBnQCtfvLoXdcdoewD6RZmFDNFh6lJkleMJb0StWzEHJrELHbAy0EScGA
         AhOuAgUEs+umB4z5ORuh4K3rZIhrXyvcFpyhELnQr1JCuCstAGD8CMGvU4m5NkBLWi0W
         Om77vBDGupqUlV64YUe5OFih4JlIUTTdwBzEOIZKK+IGcSW0REVWYz8YyaDkYHAhtfiX
         X0bCUIMj5SEjsCjnWEmoCACWPoRA7EYT9s27JxPrJ8emBRlxZ5nCpkY/pdi9Y8ekA9d9
         cHZoMPslygbpjpV+RsfjR+2uiGJHOC8AuSogJat/qCe3wXa10V2p9JW7NhgMPm6l99Ug
         B/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139355; x=1777744155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=NrCZBwFtC+zwVy+VsyXe9B467bMRBGf2T9Okv54W4Npofbm52fnduRfXAr2U3pETwO
         /ubq1DNkK0A54aAaZ9ViG+GdEym+/EvLOestD2xQM1XrvrB/LM4mj9mZOnyOCGwVX2sB
         IdVPejHIaMnPAD8wnUOLCc0Bk41khNw1/D8hmH7N/Q/iO1fJqE8bZ1yXCPS7qBbDa/Yr
         iX5Cygrkmbub8JKxtRm5RDJnjB3Lg6aa24WjGx3smPODGsjzBTnowcnkyQxdT6KZzTAX
         Hn+AB+zIaqk+H22LBKP9+/LvQn4C1NYUfvL/LTbUrXP7w3TA5wQWPfDvzfaYpu6LXo3X
         LrRw==
X-Forwarded-Encrypted: i=1; AFNElJ88mCtuJZN+gukhWx9A/jsvH0hWAl7JCoXEW4L+sLk1RjKsjlgZ1kLF0U0GkPZkfLetZ6qBft4/fW5JyP2Zhe8y@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvryepBE9ncyuxpgGzrkl46U+96LSVUHRv2vEojTFuxd4nPUm
	WgBmb/4XfBLS1i7PySW7s/FbK99DeMKXYIAmUa4AEw8Ih0rLLTkxXrrUYpAmrH5mou3cbJmCpmR
	pHHon67WuBA==
X-Received: from dycnr28-n1.prod.google.com ([2002:a05:7300:e9dc:10b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:230c:b0:2da:7e33:9261
 with SMTP id 5a478bee46e88-2e47951dedfmr21517858eec.27.1777139355126; Sat, 25
 Apr 2026 10:49:15 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:05 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-8-irogers@google.com>
Subject: [PATCH v6 07/59] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..1e6c99efff90 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,26 +5,29 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
+#include <internal/lib.h>
 #include <perf/mmap.h>
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
 
-- 
2.54.0.545.g6539524ca2-goog

