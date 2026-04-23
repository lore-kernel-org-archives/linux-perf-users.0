Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF33387371
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962066; cv=none; b=F+8osTYDAAcHM5ezuF+7fuRqtRo2vXnDLV4T5bRtTIGGlj6VBYT5c2AH/HvNffoyOegh0Up0IA4/b8LNOVDhoUUvN/q0n68OyI7eX/iDxeu/6aGQYEQ9Io6h8TQlagDZcfiDS7Nwye0PXoxLn59VnFjMiK57nOixHFoUTcKRdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962066; c=relaxed/simple;
	bh=8Caaa8+D1m+Z0a08ENYym3dZ4OBVwGKMFLXJOgq0Icc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vo5CklQP3mUltWyHUMtWrOheC2JwfvpKtTbu5qjsSIvbZ1acyjl7PNeCy5yRVRq75Lywl/Zx6u70lZrBco9MAaVVAOhUispgoRktZTfYj2K4xfHOtmsc5zqD4M3a2JuqtZ8B/c9sXWW/l+Hw34gw7cJSMU5zwYzdGx+J2Xb1i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwnEnqVZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwnEnqVZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c726f4055so6048396c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962063; x=1777566863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=uwnEnqVZWL94ESypaPWYFvABxiuslWyUz+r9nhXh/6tCtAbpBeiyjz+pEmN0q/PNZE
         +iMO1v3le4TeXO0JvBSMbBRIdTERvBpPT64PAg6/7ojm8NIz0PzPYOmS5had8lmebIzf
         MFaw9K+yDRpxObnvUCrvUFnLn7zOvAwHDVrbrcXvZ+ezUZcOpz/R9cJx8BzDUKPl3rXR
         6FOfDXeQg+zRxf2tjkV9cyccM1Wqh52z0lraAjK5p6xNWcFlChffX1E1VsTuPZ7f4o7y
         X7Uj60tidWC52WfYC2EyrBM/znZiwUOce8L+iVa9RDZX+xK3nwS3j/j0TZlMEGYw5eb7
         hD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962063; x=1777566863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=hBcXIh/jiaPj1K2WCiwuA4Zd0bsCi+7ZPpoe9VQ6fPJ6rTU/Iq8OYIGaRuFVJ+rl/w
         acXY08r8cAhlpY78q3nliII7a893SqEcWkjft9adJUv6Eg6IzRzlIQNwpgsDu7rktcSa
         ZqbwOnl57/XJRBoPUfaUf3/LJCnqZrYuB7M3qh7wS2dwNiDhdydCWMJZCZotygwPVprq
         Px55dEL3n0fJFkpbPWBfVnpLJAczMo2t2+KVGRSGHVPnYkhciSUyjHgFwjUmwjPSQ6+K
         f/LayayJDVbwd+vG1Jjivcbv91Nhmke3HAhx0rhzJIH+scKCHX+P8KJrVhfyLYXkr/nt
         TZ8g==
X-Forwarded-Encrypted: i=1; AFNElJ9e3WzE40qGTQlEL46nmIxZiKADX135rKmN6nN7lWcFL5N5pGzN+S07YLQHTw4sRs+5Jiz2wA7Q8BnqS9nBkHJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiOiMNDtsnBI9xUPim65+/aWzBbCgkrZONemBnos2d4ngWgDh
	wxgWH1mBY0Snyo61nhxwb9uKFyILthOS6wrCkJgBL0CGGpYOTIw6DWFq9G0BIT5SO2JNIvqAme8
	UjKhdBYgG8Q==
X-Received: from dled14-n2.prod.google.com ([2002:a05:701b:42ce:20b0:12c:4dad:95bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6606:b0:12d:ba61:2518
 with SMTP id a92af1059eb24-12dba61277amr4312089c88.18.1776962062439; Thu, 23
 Apr 2026 09:34:22 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:11 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-4-irogers@google.com>
Subject: [PATCH v4 03/58] perf arch x86: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

