Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9683783B0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960614; cv=none; b=ur9pv+9LTEKemOr8I20EYtcP48jGVpFLp7kp33w9UEeyg/UDUF45nKYvBVhPv/g24/u8DmAkgGAC2SnmVD01Q3sxtSAZXmpll35MwLK0iP8180R3tQnMVRFaRR9jolqzkqrIcTlJYbXL+Pa5qaCYPlTQLUGzybxaSbSwyCBZRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960614; c=relaxed/simple;
	bh=vjwXPrK/aWCZIYb+Y5em9fWKaBvg2BNyqo7V2KlIWQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OezepeRKkOBA7OpHyn2pRDW/yYfkZp5iQwhlhFW0Kv4Avmq3IAx9hmSDi2RIQ7D+onmvwnaVgvTjuaT9AtxhPHgfXuP90VXX87lMCXXAZR9mAO/sYjcFqU4oZASP5vBp07zjtFK+5mRn7KEsXmMvMpPKr14u7OAuA3M7KgaEvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A578XrKv; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A578XrKv"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so2316575c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960612; x=1777565412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=A578XrKv9pS3Nqw4nVG21lTAc1bb1D37aIgdJ9pTzvlTEDWtmYxoUrorPb8Gsm5U1a
         FPTnYuwE6CVE2qBqDzizjsPe4vpCS/onJaf5C426K1HdgnO7dPh9FzKGHDwF8p9ubClj
         hggPrIi8kqDsD/5ZWuulGzCqPum485mWNtU/DSSHcw926A4sEuUFtVHbEjUG4bOoFAJY
         spl+kAGj9YEBJz3UisdzOSU4Y+5PB05zJVy/OLBvorLESUSmz4B8Lobuv7UM4JniYJYh
         e3ZdiwUC7G7R1B3qqug6KUysj8amrQb33BXL7Zp/IpXwpAqzc6R1ycV3ydjptiuRV2Bs
         EltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960612; x=1777565412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=k5A1+XiabGcNh7Dx3F+5ANszk467X8Xc+FsPYLL+8eKd9dp8aB6/rHS2WNaYMgghNM
         IOGHhW22qaNllT5/I30ty7q52thFgZbHNbDKD+W046MLP7y0nKV5rUCScVn44vd6HYzu
         JZy5C8QYt5cHZwIyWXnrof0A4XQ+0zHi84vEKM30Q60AT63kvpq7ZDwn/0S06gr76ypn
         3f2zxaqhG3n000Qm9a7iiSJU0m8Kn3YPWEb6iWgJfWGPzDZowusuolRScCYT30vNstIl
         38Jf/YM9L/zOixOQnikVCd4tqXuL0DCs99VUpC4Om3DzHmRYI6x537h5iskhYvkZ5ZJf
         Cd0g==
X-Forwarded-Encrypted: i=1; AFNElJ83r6DeVEDoWQrjFPfcSaoPVWj97WzxxQJRSQGFlZ/KsdsXdYG8g8kZI7/paHNXI2rAxjKbewsry+WLLzb6UVWd@vger.kernel.org
X-Gm-Message-State: AOJu0YzekX55y0sWsulRbT+Y8cZo2ZG1MFhhlS5kqRDuHYKv6rSGNC5s
	1X8PcW1aEJ9I3uODD4LDKO+IP4CUVwXu0V7Qm71nIyxstMtP+KC9f3YVMg+GWQsq2wkFpMOdawA
	9uTdNgTX6JA==
X-Received: from dlbpv3.prod.google.com ([2002:a05:7023:903:b0:12c:9097:2891])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6728:b0:12a:6902:ddce
 with SMTP id a92af1059eb24-12c73f75d0cmr15717268c88.10.1776960611403; Thu, 23
 Apr 2026 09:10:11 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:08 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-2-irogers@google.com>
Subject: [PATCH v3 01/58] perf arch arm: Sort includes and add missed explicit dependencies
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
 tools/perf/arch/arm/util/cs-etm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b7a839de8707..cdf8e3e60606 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,13 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include "../../../util/cs-etm.h"
+
+#include <errno.h>
+#include <stdlib.h>
 
-#include <api/fs/fs.h>
-#include <linux/bits.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -14,25 +17,24 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
+#include <sys/stat.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
-#include "../../../util/perf_api_probe.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/cs-etm.h"
-#include <internal/lib.h> // page_size
+#include "../../../util/record.h"
 #include "../../../util/session.h"
-
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/stat.h>
+#include "cs-etm.h"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
-- 
2.54.0.rc2.533.g4f5dca5207-goog

