Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB73314AE
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916546; cv=none; b=BF8fxdUpbF+qk5yOgEl3DJdB+h0NSIy7+h6IE9NOG9xrfeXwRlo2QbInBAYWi/u3MEwJHHziehad247VIIbAwEL8tLAlIdt4oOK33W9HA4dLu27tU7877iU1+C7WENZLsn4lKLUImUn46BdeqyIPdKJHmenWZeEzaCW0aNrlm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916546; c=relaxed/simple;
	bh=8Caaa8+D1m+Z0a08ENYym3dZ4OBVwGKMFLXJOgq0Icc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QAFns/ruePAQdbmbtOB8a40n3AIQjgrcN/7WbCiLMgdlNDp/E+7XAcoUhdf6K2ZXmyfnKz+8/08pDMAPPQvisdMUFaNm1eU2YkjWGYUY+n9jqcRZYAmQw3UHnXtLb4XrDSUyUpqeBHWj7sdEcUnzszfgKvzAg/lcyUkR6mSw3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1iyz7fS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1iyz7fS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2da19227bc1so10390571eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916543; x=1777521343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=R1iyz7fSpXRePrBFoqhNr4oP/MpXT7wbr2xrrdv/qdYm+4VLPW6AQ6IS8RdDjx5sLz
         UAfTUOD91y1vNxYk1nFuH1A9Lu2/L8clCPjLAKHRIMkBajvPtEfB34CzTKUgTJK723sj
         vxX/5M77sqIBjwUIdulcwbPiNFT/QeRsedX85FEdDSV63QgsTgRiZweBJdJLdhXlQ/b/
         H3St3BSLOLPLvp5q5C78jU2ekgTV3Dojmeosm0iLbVcc7A82QZ+2p/PzpYdthqo7u+8H
         OSWF8zVOLGc4wKEAm4OznskqX2U3KOcW1j7iErYzsj2tAeATcTKEWPX6QY4SyZtbNHJ9
         fV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916543; x=1777521343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=W7aL8hyXIX3mjoIOaCLUwxtH0zhsXdbA8yJbm51zaqEuOJG1SSXSGX85au0LvYOB1S
         Bzgn8eD7qRwe604nVCvFt+kO4hPGaOfqM442cf532Cl9zIpGVWnmIrkirBtx6HQBmVaJ
         4yewLONCXF3tVIPfH70BNwi1BMGX36mKQKcS3kP9bshSXZlSlIKVeNbAECGldshoDSd/
         pOYg/XqJR1JeuQWv3FfBjr3Q1ZIH1ofN6mu07x2M9C22wlAagkkk1XCXn1IpjsOoUaNM
         b8ucsaDBEBZygewKAKABUUZN0gHjYrifF+coJeuUjF7xOq856xQGdenEF6vkzaQ0U72b
         OI/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/vnD8dufZvohTqufsHnGxf2wSAgpmVqs+2ik643/urou4AYdzAvi8KQ3wAJXKWjfcB4xkI187bPYsc5RZpvy/o@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuGTmIvusX0IXjOK8i6s69BvT9PCuENzwFgII79pspJ9VOr0X
	x5yVJLnLg7H0cPQBcAhMsuoVcYMoZKcYtaFTc/V1aHuFKuzMKlzxjFXEv1Hz59Cdh8ozI1g089b
	H84ihkgnX4A==
X-Received: from dyclw17.prod.google.com ([2002:a05:693c:2111:b0:2d9:472c:9184])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6096:b0:2e1:f72:3f18
 with SMTP id 5a478bee46e88-2e4648c5f75mr15922502eec.1.1776916543294; Wed, 22
 Apr 2026 20:55:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:30 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-4-irogers@google.com>
Subject: [PATCH v2 03/58] perf arch x86: Sort includes and add missed explicit dependencies
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

