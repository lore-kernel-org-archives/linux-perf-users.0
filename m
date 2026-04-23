Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C537BE78
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960616; cv=none; b=cDnIFoEusXM4SfoZ4TCXu84fTQrraa1n4AjgjvZDjAf9l9HqqY+qlh3UVnMBb6GiUeHYwJTBs+CN/fx62Rl5Ubs4CdmXk+0poptgXbZLpMfyLh5M3CrK4RUW9OH0GDgB1DMGagJ5LQRn7gjfE3AJNuuGe6zf9RHEtmOUQIonROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960616; c=relaxed/simple;
	bh=8Caaa8+D1m+Z0a08ENYym3dZ4OBVwGKMFLXJOgq0Icc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tb9NVW0mtNA4ZLlBBZAzjrEbB7xIVENCSDkI8wD2ie/qTwpbQEKigNNrul6DXTTCDsJYy4N8vGiVyVXkFmp/r2nZYpEjUedPpV3PeNvNPj+fbZT9hc5kVyaTa0qOjwF9pWiZWW6ZO5y08gT0mQqsSiXXWrwGoqvRj5difslQnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyYRmaP5; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyYRmaP5"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so6133914eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960614; x=1777565414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=RyYRmaP5f6Z5ISG5frZHiVIZ+aPIRBnuDuzK4JDONKV4S7Ok/TDay61u1812HpQehU
         pqkqzx+vLJ+jxVVH86jO/9LnVMJNrTj7AurUdqIRcSFygy3YonstEG+2Skwz+2F/dIaP
         AjaEU2Yc/mJyrBwwUm7A1rYxRrOwCnK88vpXuP5AJA26m6d2Y2jEV4QNzTntvb1ipUl5
         N+HB9u5qCMp/fhsgHePHulEz8hGXOqEBYy6GLnOwuoFHYTXZU5p2tXX07qXOwzc+YBTh
         w9wwdX/RQYedSFQFdNM4VIdHDkl4SyUqL3Ze49UdJq7nqVaIDqmwFAI/pFVp5eBmXpsq
         Bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960614; x=1777565414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1F1igX/6jdSGVHTL3KHvA/0GI8l26ow3xB+IoYb+34=;
        b=qZRMfzflt57G7oq/X8o4hEVoQFP3yeXd6AZXor1Q1KS/37IA9xNqqtnWcKiXmdwf+d
         QQQFwEAQSwqXADOYEEONa8ecYlaPMptwQMzfEroC5+ZuF+5qbxkYZ66S5NBS7VnjlVQw
         Yc9RmqaMNOVyriJKRXg09w033BNW3M/oaXhC/WRQmvCIPwpgO4pFttrE1xiuVXKYQp7d
         wTOAlO/Ybt2zbm4cNR/miIehaid0TuitWeH3LSEDIL5IboACYdNTBu2OP3kV3U8MQznI
         Mksz+eRUHn0OtirfcQdiwdndb2JAKqwSpF6ngrPGuN+PE/z1bwOQV7TFNINuckrJ+/jR
         0exQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Brhkq4w6uzjDKrvvCvvPyIPBH4sZYjD9+aT2IRMfheGjUTZdwYTOVWAX24k0jCXVj4Z69UruZFoeCoFZ/oBEu@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrHZVf0zl6q/zfznvOYd53JxKdf3ZcBR2977QpNL2+meQA0LA
	NkVUPSZDfdPxhkNFxXw3Q86KiCNvQO0JeooqrIVR9Nx35zZ4tlzf5yd+sxM9L3dP2iGnI6e3CK1
	0ZXUiP4LTug==
X-Received: from dyoy21.prod.google.com ([2002:a05:7300:3715:b0:2d7:dc51:72ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7493:b0:2de:e194:5fb1
 with SMTP id 5a478bee46e88-2e42ce4214bmr12858095eec.7.1776960613279; Thu, 23
 Apr 2026 09:10:13 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:09 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-3-irogers@google.com>
Subject: [PATCH v3 02/58] perf arch x86: Sort includes and add missed explicit dependencies
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

