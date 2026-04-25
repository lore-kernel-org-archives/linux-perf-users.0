Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4938E100
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157416; cv=none; b=h6ebm7nOzp7QKNxlfsoTir2X4DdYXNVSCjpY8Oa4hSHPS++Jkwk6LMfGwGZqJTv5BvPJIPmBjXVsGhO+UDNJug49CMeL5iT+mUGen5aGjdm2+kQvNpDW7WwKRxi84HZWUEgTuoBvEj5+xk621F7sDVe0VpwD3Q2Rerj0N+casqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157416; c=relaxed/simple;
	bh=IzGtiew6lV3UoAkWJeECtCMku/bwu3+F3qCjyvwzJ3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4/r8N6nO0hZU7/x+yN41I4n27M0iTv86eQTBEuchjRABPIkuJonfwzcn+mYCknCyGOD458VTEcjO5PZhs2odfAEH9egwsUhG91NTuBwQqDqCZjEtrPjgBpvG5wtCYEtVezSBwf7zd8vKC6TBvLTD6fFMPBONiqK5nuuYVjcU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nd8Irtt5; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd8Irtt5"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so5627235c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157413; x=1777762213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=nd8Irtt5IbjVgL8cHI5c5u9VhATuQC+UEbGDKKg6rKK4NJvlZz9STnOhD4kmVtYCM5
         JmDkViZEDQjl4OduCr8pAKwORxD1+sF400dRxN64EfD8gJf7Kza3WFGWARIOfES++UQ0
         b1G1UKLHVFH8prZrImmoR7FZk1RdDmMS3SjlldIduhrlw1oWbOFY+fsDcnRjs8CRMh8W
         JlvS6fYCMUwUVpD7NvnHThn1L4FdjXIo4AxLP6P7dcSTJ27Fu1KWq73qUZqhvmKbfbHT
         0ebr5ktr7TCjD4Ao3XPQODbw2DPPkM2LYre7YYS+vDZY2Bnz87DoivJDxs87FacjfTsp
         Iljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157413; x=1777762213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=YHn7MG1qTGXHrexLVgfTtNS+RUgLqU2c/VypOTc3eElOJMleiFII4KAQ2k6m3qhu8L
         aSovMH1ULuu+2/6uREqcTlVXqUU6KAAW9nwP706FvUsF+466BA/rrjSJ8VJ7o99xz7sb
         HXMRJJjmMykDDoBTdJ0ojtVbf12RU+Cvoz1qrVRhLQkpVx6Qzhe8ueDx89z8mwZ+mCTM
         w+amFcXHDA8nW8B9H62AJLz61kRO6CqdRA2o9sopHqpg6nfNycZ6xsnEvnarIn+dK+ME
         eU1EyVD1dUPzTk1G/W/zwqQjvLjqkikWa9YwNt5u5HZfV01md4rF4798VZJ+GJ5CLYLA
         hJMA==
X-Forwarded-Encrypted: i=1; AFNElJ9n20UEDVz/ajYUyZ0Yj/Bx4Mm/USSjqqIpwtVGFSx8sVntgn6zXCz4vF2XgosXjIJbPzyrsdrgqZ2wVVWeBwFk@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXck8n9aAJwPvwHGLTLFJidG3zpP39zD68afd3DnC0hf/Kyxs
	UtAjeA4X7ImAkA9Z8oJ0xg7J5HwJtTzeEcsFfkhq5DL7I6iUnQorgj5nVhGkuJWa6t5pd3lmEW5
	iLspJe0jaow==
X-Received: from dldnz4.prod.google.com ([2002:a05:701a:ca04:b0:12c:91ef:91f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6981:b0:12c:856:ddcc
 with SMTP id a92af1059eb24-12c73fa3c9amr19853823c88.27.1777157413166; Sat, 25
 Apr 2026 15:50:13 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:48:55 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-4-irogers@google.com>
Subject: [PATCH v7 03/59] perf arch x86: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 20 +++++++++++--------
 tools/perf/arch/x86/util/intel-pt.c  | 29 +++++++++++++++-------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 85c8186300c8..100a23d27998 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -4,26 +4,30 @@
  * Copyright (c) 2013-2015, Intel Corporation.
  */
 
+#include "../../../util/intel-bts.h"
+
 #include <errno.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
+
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/types.h>
 #include <linux/zalloc.h>
 
+#include <internal/lib.h> // page_size
+
+#include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
-#include "../../../util/evsel.h"
 #include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
 #include "../../../util/mmap.h"
-#include "../../../util/session.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/debug.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/tsc.h"
-#include "../../../util/auxtrace.h"
-#include "../../../util/intel-bts.h"
-#include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index c131a727774f..0307ff15d9fc 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -3,36 +3,39 @@
  * intel_pt.c: Intel Processor Trace support
  * Copyright (c) 2013-2015, Intel Corporation.
  */
+#include "../../../util/intel-pt.h"
 
 #include <errno.h>
 #include <stdbool.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
+
 #include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/types.h>
 #include <linux/zalloc.h>
-#include <linux/err.h>
 
-#include "../../../util/session.h"
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
+#include <subcmd/parse-options.h>
+
+#include "../../../util/auxtrace.h"
+#include "../../../util/config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evsel_config.h"
-#include "../../../util/config.h"
-#include "../../../util/cpumap.h"
 #include "../../../util/mmap.h"
-#include <subcmd/parse-options.h>
 #include "../../../util/parse-events.h"
-#include "../../../util/pmus.h"
-#include "../../../util/debug.h"
-#include "../../../util/auxtrace.h"
 #include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/pmus.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/target.h"
 #include "../../../util/tsc.h"
-#include <internal/lib.h> // page_size
-#include "../../../util/intel-pt.h"
-#include <api/fs/fs.h>
 #include "cpuid.h"
 
 #define KiB(x) ((x) * 1024)
-- 
2.54.0.545.g6539524ca2-goog

