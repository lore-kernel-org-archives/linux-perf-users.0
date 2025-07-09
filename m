Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F09244665
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097241; cv=none; b=WnodEExo44sXk+5RWqvfUro8YJKST1lc5y68IE657GtaB47ad94U3rVJFDUDqPP9XxhcEpQ7v/SbqBchnvVyR6iWN61dDKeQ8cUZojmsqVlSYfx3EtQ4W7Z4UB9iDd+ugAjaZdXXjqIWgmwia4/snCegPrNHhLH6USt2ftPCkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097241; c=relaxed/simple;
	bh=4RhnUIdDBTq0pKyjxJeOi7qIuV8UBI3E2+4jD3YcP7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LhOT0LP33NYETJxN04Ymcjz30odt9EmyoQWpyp2GpR8ga5jf5YOmpGfY0XAbEFO9xLSKCqx/wXndwheYKHgP/9XZwnwwBBFVnfhQAc8M5tWPJw5n9p4ZvFKwHQMpJ6NjQLoDiCdpe8dSVvG099filp3XbEFnurZxEP3LEcdaAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8lTCzpa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8lTCzpa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e3f93687so4281705ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097239; x=1752702039; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=o8lTCzpankEju9ZY/zHFZ2grfNnZExQK88ExddhOE0vAVt4O990tGW8znkvBQdODO+
         iVZgoJ6s/+K+jWeDumaFDeKYZv0F/4uTW0pQV7wUlf7+WIDdAL2boUGWSxJzeFKQYHL9
         c3cktyT1loomwDkTbCHCNSaYnwd5H+lzpSn/gXjXYatd3eBriK3OEs0Aeu2H15EX1vVa
         gwB9MFSJMQvHc8P5RnEmhreBsEewfQF15FctnDPo7qnTdicOWNlqhamVBBuIGaZn0tD4
         N+e2YVltPwOrIMEHvxdiOhnPtLnx+dc7uLY9Zk68jBIKVv89K2EI/SlPsV7YneV50kIe
         N3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097239; x=1752702039;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=wFwYpRa6vE2GSvs6w/XYjUFbZkZOlDx96/oGhMycvY64zEpdcxHvo2zFscYDI/Cy8h
         Jffs3UDoYYLQ3ralH4I71gtpHsKuqjrm03MHEe4+JBXZ3ndH9o7FrYarsJppCpKDKHp8
         0uMxlEMN6Q2GLLXyFqGtfY+Ii17uyGZp6JN+YgGLxeSpNHHuggf72V77/dU2ovjErE6J
         r3pumCifty5t8BG2VhOwKknqceCN3aAFdC4vulk257tlF6GSIjSA1DUSTe8bn/cr8hgi
         BXw5kgsBMa47Ns6V9hZPFyx8reEBNSq54G1aqUOGC7YSQB/dmajksvZgke5BOJE/bDsq
         DEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb/MhXqGiz6RauwyixvIzHDFGkkjKdeYPsz7VEV8r6WfAu4is+vvVc6M4ePX/i4Dni8DvkzqPdsoEgqptqzGq5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8r/pjwtrcGItDCIY/5lqgQkqS3pI4QrukQ03nx7zWklym6Ei
	Gj/okv8sJGu/7/uvTqgdC40US1Ijbc91w+Ai2ZKUcVaj9n4LQDaafShBzNzM0OR5fEgJSateZba
	SOd5vFfOkcw==
X-Google-Smtp-Source: AGHT+IGZ5grGeIuw5glQVkklBxNEKKxomcSYAQGiwSohPNNQHUy7vJojGsm5h6sCDpZq0PO+bkWJuZ69hg1F
X-Received: from pgar20.prod.google.com ([2002:a05:6a02:2e94:b0:b2e:c00e:65ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240a:b0:236:9402:a622
 with SMTP id d9443c01a7336-23de4872c01mr289295ad.34.1752097239690; Wed, 09
 Jul 2025 14:40:39 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:20 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-4-irogers@google.com>
Subject: [PATCH v1 03/12] perf spark: Fix includes and add SPDX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scnprintf is declared in linux/kernel.h, directly depend upon it.
Add missing SPDX comments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/spark.c | 8 +++-----
 tools/perf/util/spark.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
index 70272a8b81a6..65ca253cc22e 100644
--- a/tools/perf/util/spark.c
+++ b/tools/perf/util/spark.c
@@ -1,9 +1,7 @@
-#include <stdio.h>
-#include <limits.h>
-#include <string.h>
-#include <stdlib.h>
+// SPDX-License-Identifier: GPL-2.0
 #include "spark.h"
-#include "stat.h"
+#include <limits.h>
+#include <linux/kernel.h>
 
 #define SPARK_SHIFT 8
 
diff --git a/tools/perf/util/spark.h b/tools/perf/util/spark.h
index 25402d7d7a64..78597c38ef35 100644
--- a/tools/perf/util/spark.h
+++ b/tools/perf/util/spark.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef SPARK_H
 #define SPARK_H 1
 
-- 
2.50.0.727.gbf7dc18ff4-goog

