Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3438C407
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156898; cv=none; b=c3q6OL/n2TnYyo5iUeJcnn7eRIIlgucKZBe3Y0xn3kCxQ26E++JWaeppHVGqKvc1+9O9IT91XC5F69UsAXMACa2aQ4Z5Dd2RV7bupTNA/J8kklPgi8Vx8EJmIGDG2zCfiKwy9+4pkPRwALMFcEnc8eJtxInVvjX+WjymUHpprao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156898; c=relaxed/simple;
	bh=IzGtiew6lV3UoAkWJeECtCMku/bwu3+F3qCjyvwzJ3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sigyWIAWLNVNKgK8ekTbsaVTCzrB1ABaT/3iLNUeQND9GJyLjfT7qHzU2UaSad2GPGfneaAyc4eiSfUTvZX6AYLCld3ADTULUuEU+0S2I2TGLYyjRu9pZQxG8xJgwQi+bPVK5hDgjVpzslicMnPlVMXKGwkZ4VdTpD1xqLdLi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhuw8c1j; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhuw8c1j"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2107527c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156897; x=1777761697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=lhuw8c1j1t6lKFBkBzPSY41DjGYXZwpPlEyLYWd4ZFwBWEYap3lkozDt2nysQgejZb
         9CzoDwY8e5AqX7P093GyvFInfPIXXg9zj1jJ/6M5E82r90HRaYjqAF1vz750gd4dZzkT
         B4S4n7ILAF5vk1RuJ9no4zK8GVV7kaiuBQk5kpMWzjxfAhoJTN2A4rVEoE/MIvhgUhFc
         TtCZu/K4GGt9IldyrqlajA4X+r3fI9QKwo0QUNICnmnP3ooWmUt0+yYOnpk3G/qeur8R
         smdFRwJsXbI1NT5ukZBN2lPTkKhQ4aG3G7B2aiU4DOeEZoFHEJ0/2StyUB+/7xRlLYs0
         wTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156897; x=1777761697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=Zze+JjUODFXK1MfrHHcU9VXLHdBAXx9uyzckmqCwoshQFnthsTHosxqZ6H68yxGVpN
         tDoOPXjg97V4WSemBRp8VD6PWLQMRXwV5TUVs2nvWZ7jWzd4iBJBSjLgq8r7QiE5l/f6
         BmW9IVOkk3jtYTW58ufDA1oKa+gtyotAQIfJ1qE7Pk8GCXJuoBXm/G2qi68KbxZp59oD
         WpY3Gxsk5ciuAGomBu2yvOYElk8lIC0aQRFGt9o6/7ZVOSL/7Z2GV6klgDJ/yPIoXHjX
         O0+Fj0bqa9PdWbygmS3deO7nIIhXFSvZyDz2g2YdRu9j92GqMKkqJu8rWEiNspq3pLNJ
         1How==
X-Forwarded-Encrypted: i=1; AFNElJ8EAANLyivgbO2zyYxoHn4W2Ar4yHTW9SYGsJv3YnYt9iJR6eKiCQLL3Qp0sIxhOc4xe0HWXqOEWx0+/bYfY8y8@vger.kernel.org
X-Gm-Message-State: AOJu0YxXw4+BN34cGVJSobHW2CnTZ9Bb/KYkuQrZzjArMAZ3J6oD9Jqa
	qXPLkEU5BCD6RQkbEZYuEksWpCL5s3BSSHs+dB7bA+09kpyoRwDNTaD9MpLtekUm2FXcTsP+QZl
	Vr+iRchG8zw==
X-Received: from dlbpu6.prod.google.com ([2002:a05:7022:e886:b0:12c:8eb0:61d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2385:b0:12c:aae:7b43
 with SMTP id a92af1059eb24-12c73b5af08mr15016774c88.24.1777156896516; Sat, 25
 Apr 2026 15:41:36 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:28 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-4-irogers@google.com>
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

