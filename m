Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA333986F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049284; cv=none; b=cY6hyK5RXXlo7T+8oQKd28EYcPrBGF7e8yHQ2KX9aDLUoiYfSDNZZXeEaUNdl9sklp4/gcPVkiEucJ/3JSeiVjT0d+geE11shzFPJbATCxPStejpRVtDIeYP+hTCcCXr+F0/B24HBwxO+msnxiOSYsd1Noxk0h2h1gaEHChutiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049284; c=relaxed/simple;
	bh=E1A9rOUkigl47RQgwxPU7BZg+a2AkxhYpc7Hpry26ZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+W53Oa24qRpuipZlcyeZUXBAvkqaY7k50NUj5uzcF4Qq3IAfTeVAwoNx3CesZMZmyAAxiUey3HwcQRYriCbtmBrSt9czLDL02R7M0wTNMHfkMa7XpGLGPKUZtjWoBweUzJ6c1/s+4A7JG8bC79m86vMI2VZ5gYDghqn/5kPNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr6/CXvS; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr6/CXvS"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so12541094eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049280; x=1777654080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=Rr6/CXvSwG62bGZIv1KeRZoGwGjDFuptIJTtW9Tg1c0UW1HMnLmf980/9lbuEFYqci
         +q8kuHYj4wyAhtNq5Ab/xEWQ4icXHULg4uuoJV4G5L0epPeRBU9FtvFopct76YpMCRe1
         rjfUqvyEOyvtcTiYGUTr48YTBvzPlnY6ptXFlxxD/1PGPFdSKIdIfibF7RBy+F9NZvfE
         4D/kPsHRq/nazbhledOOXLjrzKEDb0SMg8/lZ2pTvCmxWzkPoaoRIn2JdruG0zxT8FzW
         Hfj6Hs2g9glx1nloyQnfPj8V9r/+vtxXX3T6vpPXPsVmod73JEKtYijPWbwnk+vOmqca
         xJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049280; x=1777654080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pih4PvjlzSX23VUBfhxJgrdaziaLdcdiDaL3PE08L8Q=;
        b=tCimCsXWEz/TmIVszbORSi39GXr5C0aBPBPGn8FDmGYFB50iq3Sm1HDqhNKDmVuJPs
         /MTX1lMEgRzuvso1NzcFoJSza+AaBwUf1TX+G+RBsM/WtIoOPXuxMqcNiePUzEBQRCPj
         fX3V9i7CbPk7f5Fi0KunuOFriZU2qwDEunwZCdjgrb076vzU3/kmQUJs3V5/HsVvM48b
         QEot5hAQbS8/ABcQkaKdTcEGw6ioT8x8Jed8JpLRCvkPteP6+jKZiUNtSCS90rcUikTa
         w+hGKUU8qkUnjeW+rbiO+dbw6IXxAK6rPESOnh/uFBKbegITtp3uaSa2JLtX9xKREFi4
         f1xg==
X-Forwarded-Encrypted: i=1; AFNElJ9WamV8B6qOJX6vZpC2ICaLraJds+QKeX/uAm258wYjNzVJjPzcAv5PKzLZOFPSZcNEi+zxpB0i3umlAkx1Dmg/@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5f40yIrmrTQhWtRomma8w6tkMikJCoWIRj/qNi1wvIfh3FSg
	ROqBA75XxxWUfkgGLkzGbAGqHDMrkSo0cVyYf/WmDNRSnBbcprx57xOhveKYFLYZ6su1ze0Jd3f
	8Dx2e3DIZCg==
X-Received: from dybmf1.prod.google.com ([2002:a05:7301:901:b0:2d8:f479:9a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d19:b0:2c1:7793:7bbb
 with SMTP id 5a478bee46e88-2e4873f3103mr19715418eec.27.1777049279688; Fri, 24
 Apr 2026 09:47:59 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:29 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-8-irogers@google.com>
Subject: [PATCH v5 07/58] perf python: Add missed explicit dependencies
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

