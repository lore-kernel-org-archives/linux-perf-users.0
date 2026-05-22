Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DB390614
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487486; cv=none; b=Ns80AoeFqnqroOMmuWgoJAaVIcK36WQVKVZ6OYfel4Mtc7Yz+bOmtAB3BdXVEq/IjHuiDNFnQ9nPhmNPTPPJO/Es7O77TEZ6rTULXbgO99Pg7h70E+yFZn+BHC2JcFEG0YipltojO1jt+mxQNmyeen5ANIyaAfaz6qgGZrYhlEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487486; c=relaxed/simple;
	bh=Z9EfuPTzMJXZQXnYTrZ4ffha0yrd3iGXR/sJfpw92rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7hV9+bjy0FAa8Os/C/X9MhC3se/GCVPG/gXcfk+dzXP8+H/JkILIUW/9cMfvt4LE29Cmj2kyoy8rypccrqS62Np5EX2rbttlM+fLL1Eiq/9TffzLI/Nvm3fIFjeKwmd2IqRoqWHXo9VxFiOZsD1mD0g8Sv19aW9GeslZ7KJZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ha51a3pe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ha51a3pe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so6831520eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487484; x=1780092284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qK9dSpPcv6wOfbSQzn8e4LYSN0aiyiQIegu2xzHPiXg=;
        b=Ha51a3pefej7+mpOSWSD9ZfJTi5FCrZWXpqpLPwUlm3TzvfyhJyY3wbcr+6NXvMGex
         S1Dya7eNHoxtMt8KjrGkTc2KBQUZ1aoNgbQr32t7t4wrUaFVYpCyGMVr8LO0OsRousQZ
         Y5HHsPLuq9kcm43wFJAcvj9dHo8iaE2PqRPSV0zAbzIPf6qcBA74arzSZ5mvkeGO3c/+
         +8aQ/Mfxu1o8pZffWONUeWAkhsdZRaiSJpwJ41LBJbjxjfwi4IBYY02eEySGmUEzn3Vl
         illSwr+TyxxTEa8ZmZ1PyUAp2eC9cGb3nO1Rz991m99H71LmtzOghvH6zFt1CLvfLo93
         FYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487484; x=1780092284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qK9dSpPcv6wOfbSQzn8e4LYSN0aiyiQIegu2xzHPiXg=;
        b=H1h25Wm1dQZaxRbthukendFyy2tq4Jv6DnO9zGworGNC8ewv46TvLyNMwCX7F8Wv1o
         keTKFUjuRQodiq5mNSn/BmaCd5ec8VKG+RhB08v9JWtC0x2m51TyuOEj9JTdSdJmR/Sn
         PQyZV3sbiLcFUfF/t8rhKP2QXJf/nvY6yeGewN745jsjjDzC8DJme/7leQqgDs7bp7PB
         v1vluSD1DBUxIeqLWqfStGSRIgPI/DGZDqmKs+ubPtwwPRWnCjbuJr3XOA8L4R0yr2Dj
         JsMhF7LyDv5mDEqufcxCSltfctIlJlvM6h9zjwnGmOjuqSS+1NSYhXyIId1/RLS2ljU/
         EIuw==
X-Forwarded-Encrypted: i=1; AFNElJ9/a8GY5wAV9bmPuGmSzXl5Kdd8u/HDo+ZXy/kSdYIg1J+fixfMpQBWvZr/gQdmCxVHwyIexj7xwoyaJeFuTaCD@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJY3XfC4BUA/wy2M6evWvPKaRPa9x8b2syucRz5BAWuOmxaU7
	L6WoXgmJAR00KD641W9LKDY/gR9I/opYL/2Fsu2kB+tHvNMFGFzi81PJinacyd1iz9VMDL7rL9H
	53dt1/j8gMw==
X-Received: from dyblz48.prod.google.com ([2002:a05:7301:1630:b0:304:59b1:e122])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7483:b0:2ee:7b2e:8a3e
 with SMTP id 5a478bee46e88-304304fbfa4mr4638762eec.1.1779487483670; Fri, 22
 May 2026 15:04:43 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:13 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-3-irogers@google.com>
Subject: [PATCH v9 02/23] perf arch x86: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
2.54.0.794.g4f17f83d09-goog

