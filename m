Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F932B9A8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916543; cv=none; b=s2QkGqJ6AZtl9Lct/ZXfoKNPYATNsEuL9C53mTD6aHEUaOPcF33BfIj+Py8NWAnRCDzHw+zi8Gee46vS8Rc1CC129FK+w0mir1F3rTnVzoa8BCIOEQ/3yYpucMLgbayaI4hPxXUDLMgEHKSogg2Ys79qPxYXgW36V98cFTZbLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916543; c=relaxed/simple;
	bh=vjwXPrK/aWCZIYb+Y5em9fWKaBvg2BNyqo7V2KlIWQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rEHwrnGlceqLVP0RNUXHfF+Myt0DKDgAl3wkNNMgjAtPiC3wTsvbMvB6rOA38SELYRoxmLdzokpVN9lprIkMpeGr2hn0OxeXxo/Tjpfz6rhv4VIHDix7vLgNbZO7xONkMQyDp+c4iW/PuChoMvt+Jrl3XiquMcDxSafkHAufk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l73Cyj8p; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l73Cyj8p"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70dd30025fso7825488a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916542; x=1777521342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=l73Cyj8pMXsGGOVIv1Pu4zQWFONCZwjCZ0SlJGqXXmAQdMrADIY7FMJgRZwV2U43W2
         dhJduUqXr0hkzt6sRD77+SSzFzx8pyq1LUa5sVpcxJvkv2KyPj0dNhGrxnpPMFkhjFYL
         Xa8ub5Gemrh95GEBjTb2zx0pW/qMqb2IBpIyVoSS1EKzZ/yEXOgNgfrfnN3Lo2uMk4ex
         lgslx4vgxIVdBc6v6r76XyDUofA8LjC1wyJmIAjzaiq92gp9n765SbYMxK8MBDoznuiD
         9ayceUQZCKsjj6GBY50nsECdOAwoXpdGbph4BN5bPy2uBxCZS9elseZPn71UPv818GQ+
         uo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916542; x=1777521342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=GLQFnsZ1bd2QhCZOG1v86CQgD5xXpW8SPMqk69pM/7MSf2FkYrX70Vesl1+C31Dot4
         KHfORLC8V3aw8Loybq/Mo0XvJdihZ1ZnsWb6TWquRPBWLx5P09U3XoRGW4S4MNPecKym
         OjQ5HkmD+mXTVwVpfSRQBu0hkcPCPawQAHGFl6XSVxLNNzDnGiwVJb7C34BVFgufwreU
         y+tuLSZ+tbEVfN6MsCp2asYXZgq4caKngl4gjdf0EUGDcENdWOS9LhFqOyfq4r8QvrMZ
         dBDg2teBFPXuYLG53KGWrO34zBWIl+faUU69bI8F82p8PHaA4/TkHUj9rpaCeBjxkm/A
         Wm9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9FGVjAoJd5Z3achj1Ycj2drXcI4jUDJpKTQhcHRO2/UwdDH3idGF1DqDbcP5Y3DTRzyzJhcETENBvwd2c8lG/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeLFs8yTj9a9ggF6XOCCkZIAgbhJ/+0euQ4jXnuNXgL67/gew
	DvwqPVISnamETMe0KI+lA8GHfE6P/3sAXlTlVhmyDS6mHrgrp1xcJgc3gQ3T+CoeZZZDtbq270/
	o+3Z5AdWHiw==
X-Received: from pgiz3.prod.google.com ([2002:a63:c043:0:b0:c79:65cb:1f76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:398:9820:f6ed
 with SMTP id adf61e73a8af0-3a08d940335mr30856204637.56.1776916541527; Wed, 22
 Apr 2026 20:55:41 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:29 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-3-irogers@google.com>
Subject: [PATCH v2 02/58] perf arch arm: Sort includes and add missed explicit dependencies
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

