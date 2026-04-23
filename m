Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1138423F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960624; cv=none; b=nUfmuctj964RiwgTqYdPcIVKJ45Q7xpnH9Gxc/d4ASi0qaO8+wicBFWQhNrBobLW63V1H9J2DZAc+o17z4Wyw+y4na5yM0NdApZD0dhJySDnu96A02UUrHGc7KcYX6BKoxWwUcMO4P69t4uU3N4EV9kxGZJV5aF01zIy74vRb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960624; c=relaxed/simple;
	bh=RAd4pOeIf8vJj9brxXdaHiiQU+q1Ls8PaYIy1lzUB6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=toIJAnjtMGqheqAHmWBvmlUG2Ju15lbHpR6kbj/5PpuGvvZbB3TlnjOQY5i927mkLVsidMI0sF9FSm7jmbhqwownfYbwHn1N8nY4U5abmt+mPioz3zbbmd0xbNN7H4trpFFOv1e6223Y1SfaVdDbjfOsx0SxByUfoEzLn/JxHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMZOMe3N; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMZOMe3N"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2da19227bc1so12482875eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960622; x=1777565422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=nMZOMe3NXZSam5qiJMK4Cyh3GGu0LKNit7b78hx4NthDEDoulr2FGDah30yNE7t38A
         OJFLgmTCIdC/Q4M9TozldiBZZq9glnECS6cycqdA1rJzFJSZmK9R1P9Pe7XHjRR5Bt/D
         FIHpUmAFn3uzptqF5vhw9t0e9EEPAtf5+2ibbViWvYSrK/lXPwBH5e9j3bex2CLNII16
         liDhxW+8ScH4RQ4jWnwmitT1V8Fhiv4EUTF55CdEN7qsVX+FqqV6v7VHL9cASqjJKWUI
         q0lMU6a0TxZbYvjmjip9non8VX+ii5BzPGQEtoWB713bmcL/22cjuFZVZnmBqMWUgUYD
         qEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960622; x=1777565422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=GPceIZvADSWNBBG6qMocA4LE7xpaVYivP2KwC3hU0hYA2+G0E+wRJqf4mTHQAN0qZh
         At5jgtO8Pr85QKEc7hLN+1gijtiX2lXmIHd/W8+YxqhIBysHctxPFgTsZdYrhnHqnw02
         mJxOZ3XQvFiH8XwjsCAhVyOcdr7uIrW8532ibOSmFwuzSrTV78qYixG7XwDZzJWnPNhy
         HBWSpan1dZWhvWuLX921b/rEJD6ec7Qubj8FiQRORPd4dGB42RsJ64HO6VpffQzpZ/E6
         tMg6Oof2otsXt7PJqgv7EliTa/T4dFxTiNU+1kN5ff2n0bCQSAKjvG53Iyq6dNmbPQnq
         av2g==
X-Forwarded-Encrypted: i=1; AFNElJ8Q10ds5k7ronOZYdPXdNRBhQuwGkH/Y289dlsbmWZgBpEE7GBlgmyE6OgrjO1wx3fEZuCkd4WrEz5kqRLqYPYV@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLtFQiiIsAr4BO8+M2lTvPrDl9zvj7kNBzlKKFVvNsEyuVH6v
	YMTagwuGVcpO81Tw8f+QHEgZB0Szas4cO8XCm28l3Sq466PhUuKiZ3Tha5ZVIsRoaK/AXlm0/VW
	UEc5whhWoYw==
X-Received: from dycnl14.prod.google.com ([2002:a05:7300:d10e:b0:2da:b59f:1e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a49a:b0:2c5:b23e:48a6
 with SMTP id 5a478bee46e88-2e478e0c684mr15646168eec.23.1776960621391; Thu, 23
 Apr 2026 09:10:21 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:13 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-7-irogers@google.com>
Subject: [PATCH v3 06/58] perf python: Add missed explicit dependencies
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

Fix missing #include of pmus.h found while cleaning the evsel/evlist
header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..1e6c99efff90 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5,26 +5,29 @@
 #include <poll.h>
 #include <linux/err.h>
 #include <perf/cpumap.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
+#include <internal/lib.h>
 #include <perf/mmap.h>
+
 #include "callchain.h"
 #include "counts.h"
+#include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "event.h"
 #include "expr.h"
+#include "metricgroup.h"
+#include "mmap.h"
+#include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
-#include "metricgroup.h"
-#include "mmap.h"
 #include "util/sample.h"
-#include <internal/lib.h>
+
+#ifdef HAVE_LIBTRACEEVENT
+#include <event-parse.h>
+#endif
 
 PyMODINIT_FUNC PyInit_perf(void);
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog

