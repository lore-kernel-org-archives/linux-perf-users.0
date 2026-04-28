Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31B3C7E0B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360766; cv=none; b=eiVgxmNrCvoD8EjfzTDlKK6bB2CPsAsb0yCUJmbfi8ZtA5CkEWNjq/VtwoZpLa9zpHMtPmLwfSsAF+0m50RYcyGG2b9JiFy/JxZotQw0VrlKGoQAJPk57IGU4d0rWe+KWHYNzhOfboohrHvA4R4kyKclxV9aL2Q1ZOP7lXU8JmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360766; c=relaxed/simple;
	bh=IzGtiew6lV3UoAkWJeECtCMku/bwu3+F3qCjyvwzJ3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnfC3HvtIqiPC7ayRpLvtAT8PIdwLNdDOdiCO68g9RHgj6A6wsft456kGOs1UDes4lAk3ocL2EiKItin09E0bcxLdW8iiFsJMekAUGnZqwdpOGSBh3UYjJlo+dpGxxGcTpWMZP7Q947OBaHUtbq1ZYAKpR31Rgy1EIqUDSZCWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXl67G0i; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXl67G0i"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so14537638eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360763; x=1777965563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=YXl67G0iPVbIeSj5dFIuiT3zaQ4EgF9r38uZncBIowaVBL5biygbUDJFj2UW53HTvo
         9mKsGr5hrkeYFKy82g0limkNzMQz6NJCgaMLmljYBCLsHAgYDk+vsACAbcC1DFmm1wG5
         dpe+BBTYNBTvtOCVsG2Xr72UoZTpRrwLwVRrMLPVHc2FDYq/5p7eO+mrNwV3aLgacYsD
         z7FjXm2jCdnDniT9CfWDamHTYjk+ghWaxBwpzSLjujnqzo64/MRgj9NLA9dzU3sZYJAk
         32mc2w3xqdFkzyaN4cgqpSqONpvPUE5JuonJcvI2vU3MAlOitJD1BKwsHvaM7dhv73LY
         BCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360763; x=1777965563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=gTEQb1NvhyFCiB/TYXC0pvC4E+1579gesOZE2lFWiZ1piDPICElsncJLb+Yn9yQ9/5
         GTFKqWKYo1OjK+kXufJEcfI2pOxruopfsEwlnGm9M/idDxo5+5ZtqnoWmRMWIIfTNXJz
         kmBLhLzsywXcg217wLHV4PLI6W9t4J/fpFnUFPy+qwRHvU/6DtNLpbc3LSCbPyYdcppS
         0RLa4I/4MB2sNeI8rD3MNYPWcLTr7IOrD0YkgJNHgGYkd18FgNUy/0EaKZzrhrdWgYhj
         DhZN5csGxec/+LekE60oUQrWOk9FdwwGT0cynDpj2cQkMWFKTjvwZv41EWlX3TmaHRvu
         q1xw==
X-Forwarded-Encrypted: i=1; AFNElJ+FE1GFR08Y0+Y2EMOsAmzkokEGW0ik1rdQYJRZTMGI0USKo3TjYi/YVH4AQftySszqIq0m8oj4dkqGkEcT/AcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/PO+5lIyYJYlCZBztBqGgnZ7F8pWH4vFU2+fl2NHW92+4pNq
	a7egfvdOLOSeFcnRB0OJsZloHwjrW8HGFRidZIq+2XU5177W+zOESjxpyPgGRbqGTMKqQHfNX/Y
	pYkoOTz1oqw==
X-Received: from dycnr11-n1.prod.google.com ([2002:a05:7300:e9cb:10b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fa10:b0:2da:2ec2:64e5
 with SMTP id 5a478bee46e88-2ed0a084a58mr1036731eec.18.1777360763065; Tue, 28
 Apr 2026 00:19:23 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:07 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-3-irogers@google.com>
Subject: [PATCH v8 02/58] perf arch x86: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

