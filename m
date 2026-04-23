Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEE86329
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962063; cv=none; b=b3ws9Bi+RXiUW9kF0MbNUlu6KXLnyXLpbNfXyXKG8abyhNpT7e4JT+1enKJXZSDoWpR54WCGymL7jAB8BWz9ftfcGef4Ns0pM82DM9XXpgCip5d6gCkb/dZ3awJnTJ12pAPMdt4xiJSgFeS62Moyvx8UvcmnCyHBIDefmSeeSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962063; c=relaxed/simple;
	bh=vjwXPrK/aWCZIYb+Y5em9fWKaBvg2BNyqo7V2KlIWQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miLOb/yhBTapiOl+zU8w3hr4d0QSc1a5DPcnwgvxevsrGMfl3fp86quHLJ2jhYZdeDEFFOLe79XnlGp7rV/cBRnjpkfxa01JVpOpHFaMu4eiZ5oSzfzLIRr4FmW9glb1leXon5HuarNJkAb39GRojABN5vDGpaYUB49RTgZT+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRcP3Z5x; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRcP3Z5x"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12734af2ca4so4249552c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962061; x=1777566861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=QRcP3Z5xhU5AlJ/hMKTCql7bA8r4YvnnImvZ9nMeDAw773Nm2hcBO/yKQH38QbCqmz
         vEQpqwslTBBZo2O8dL89zQMDbRx42jhJb9QSTLlRnajzH50X8g2Q3196siojQCS9OrSA
         osUL4mtVjdBEk6sv2hQs6qmPHjjXTH5+909LD7/wxtkUMZhNBFAPzjMtJrL3ItkBvw5Q
         K8NxiB/cpCcrdA/LC9TfefWDwQSeFnIMp4+mIIjBKyRVgvaJArKMrvp8nlbUUwJNVggO
         g6NP4S9Xn56H20pO2iYLlkmNciDRT5heAMT+2s6//2MFzyZg+uH4cks7ubTJUD3EJViq
         9A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962061; x=1777566861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5thVpDWRzKYsrSGws/UFerEKLK2wSScuqDLwrALvYA=;
        b=q5E150zvhV84Az7rdGgc2ex7c7iZqvdkLUdYx1FBXVR82jiO35Wr2c/axu7Tu+ewgo
         JFyhEo+5yNrZQbGDNfoy9wmIUR+aOt7M54qL6iTXcsWbJGM1TxI31H4Y3rD2rR5/noMa
         JSp4iphMem7AqRptFegZZ++s3g8gB475Ll12EMBSLiXbKAcTW0y0jLlDAEzH+DQJjOZu
         qAAYU9/iX9cryfJtIPcegqYW5R3Bw5LOjf7ijygrSpRlcPZCTzCLkMRkk4TMn0NUJv9a
         9WxxiZoU5BGJsVta1Z4cWq1NVlobFx4LbeYZpbfplBLLXbn+gm+KrM6p5oeWI8E4bgfy
         D7Cw==
X-Forwarded-Encrypted: i=1; AFNElJ+ieQPDQ0P6hevAFrOtSRg69+QDHBtBQXI4+z49Rh/T+N1jOiuZI+OIcs3e3qic1Oyjhdcv1DX5nFKnIqp09eiz@vger.kernel.org
X-Gm-Message-State: AOJu0YySi66D/uG8hxg4P2FCAKT1iDm5omW6ymdMawHudvxcWVeCagGH
	tY8bbMFXYLDOk03nTqfcp+gjiJ66BXlwcsLWRZv1eIry5JozaQNjF8iUBu9A/7o5KHGpovlQuVu
	8rgaa3JytuQ==
X-Received: from dldoa8.prod.google.com ([2002:a05:701a:ca88:b0:12a:77b3:9893])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1283:b0:128:d5bd:3557
 with SMTP id a92af1059eb24-12c73ae5574mr11910242c88.4.1776962060271; Thu, 23
 Apr 2026 09:34:20 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:10 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-3-irogers@google.com>
Subject: [PATCH v4 02/58] perf arch arm: Sort includes and add missed explicit dependencies
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

