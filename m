Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5D359A66
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139349; cv=none; b=kQH/8DybYTcFagRDvGxd86CAXPBdyvqtDspUj4YVxHQFwc/nTWlSKRkkeY0RogEgAg/bhhVbvf+igjP4GtWog5wswIVgp61XL8Z7aHQAwBIeIaEERSmiDJDXW3lHd1pSGVQ9r2dZraGHF6x3eTWyxjG5r6QInr9epKHiN89fb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139349; c=relaxed/simple;
	bh=IzGtiew6lV3UoAkWJeECtCMku/bwu3+F3qCjyvwzJ3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVYHpdSWk7nxW36CZvNUDecJRBcodpYSRsTA6Eefv0dQv45ckWszoiV10zJr5kk6bWM49AL9EnoOBZNx5JitKy0+DRRjCmeJiNbkvX9URRZJ9gFZcFX0eT+YvhakFkVdDnA6LFw6D3O5EC2i1gRcUag4Ru3QeRnuosh1aR1qsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e39d9EBr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e39d9EBr"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d9da2559aeso24385545eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139347; x=1777744147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=e39d9EBr0p42YjOJkjeylmH/EvRWyrbK1eBPXbtozfVXmYLHjgyIuNxsOeM6NeRAa3
         ejysYi9C/d5yelyuOy86VUctci9Q1X/OlUetS4cgDLx84jjchEDQ8IXQyXXy1Qd1JSi0
         Fzd/ogmkFYWCJVghYorbgt7QlyzYp9UkfW//3/6GIDLvriuixvLusFAj9LT6oP+WR07f
         K7axcqTZxDNmAYgXmzhxFLeCf22gFLAFaVP89dtANAVnLn/zJrcBqmrqSfB7Afmb38KY
         6zW6QtTnET189DihjXlbeA067GUP8zv/26vQYwl+kzP8ppl2rlQPSI/MsCXt9gY10nzi
         yA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139347; x=1777744147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL6gbA3yHwRjF7ykSQ2dEvMc7Axg6yuH3FzRoVTsCT0=;
        b=T4HOxr/X0mKxLBDLzs+wu2QP5y2qWLAgWTYQ7Npy6Z370i1Cxf7hFp3uBlSr2sSVJR
         PKwLhfMJFlTG71Dt8/d60s4iGNgD4LWCaDnL4B2v1XE3ipWfeSekZvdFbsB48mu7b7wQ
         hda7h2nGZrVjMSEBFmCFLE4HheybZ3TgIQ4HZTgxmG9wVMkfUr6sqLe4GiklFxmtTTwD
         kNZCrZ7QeIYQ7viZ8AsGARmpIhe0e92GM5oWPp7OjRMUdKITSBE9nqjDLTENzO9aAUpv
         wZkkK1w6IesakODoibGTsyt4TFXTk0CVpnKnky7+9OaSMMqduNzatTmrebKsnFv3WLVp
         JTIg==
X-Forwarded-Encrypted: i=1; AFNElJ8FWC9xBhxzLoLXRG29zSGVasgdwDUjxJb9nHlSWIcIY1ficHtF6A31R+52iurbM1HsIKq/Dg8fSO+lAoIR+ro3@vger.kernel.org
X-Gm-Message-State: AOJu0YyqPpwugBqbNMXyPlkCIY0OzS0ifvugjKck2usLIBCJGnDTDL4r
	VBzSAOdeOlOxSm1SU6H6D2uVupab3fallvnIbQ+uhD0aZ+4qChdnhYlipbyU5y8oRrcwh9hkVYB
	vUpUsS45Ofw==
X-Received: from dybb21.prod.google.com ([2002:a05:693c:6095:b0:2d9:61d4:4d0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1295:b0:2be:a2d8:e9e3
 with SMTP id 5a478bee46e88-2e47981c631mr20925841eec.29.1777139347076; Sat, 25
 Apr 2026 10:49:07 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:01 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-4-irogers@google.com>
Subject: [PATCH v6 03/59] perf arch x86: Sort includes and add missed explicit dependencies
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

