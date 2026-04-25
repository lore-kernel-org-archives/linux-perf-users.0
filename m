Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153A389454
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156896; cv=none; b=Qute67+13uL6/UHFn8ZRid/dZHBiUUnZa/JdePIdv77dgTneSzXf4ShAvPSlYF6OdlVSsFAu4j532xl3GnBruAaMFvj1Vt1/GLnaRQ3LDdG8C+IGt8eBb/VtMLZx7gu4WqLznNQPDMBR+lM8gKCetRmcWhskfS0dG4qfEQB0LwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156896; c=relaxed/simple;
	bh=bITPVK77ksbOupCd8yIPNfKlXiQAinH05MI73w7M+5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ajfcbE47KyaidXtYsUsrXgh/qukQQ/TEj1yg5kTKE2hV8OUJvsZ0q76hKHNOKsd7VlG+d0HQE2GXM4XguCYqP5M1aTcVbm68xLFEEvbeCU9BFoZ0dX9MnZcTkcaRgMgiM2iqbqqxF7YqhKMMC4qUlbdcLA3YzjjxCMOUkgG0Fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhqNZ5eW; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhqNZ5eW"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so33836207c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156895; x=1777761695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=qhqNZ5eWaKq+HqY0I3d31O2GR5yxjTcRqQFWIjL+ejZurVVhgut2mgKJjkf74Uardi
         cOiqzgLzzPAEuzBBOOylfmK5CmxjSESZFIIvMEqIjfm/kLpS9mWwLtQ8iTaPL5jAGJC2
         9DBNm0qi0Sbfm/W5c7x6sZlO/LgvSQgPt7eFgZCrvUx+gZ2j6TxcmfDD8iIHdV+j/HW6
         3L2h21o9E90gQEJ01Z4lhqvmxHijSka8qNL4kSJ87qZrTa4Af2sJDK8Qk0siBOj+NDEd
         A5uDrFKTjTJyNPpjt4du9qptANQWnCGDid+ydYbg1vn06Ls0PycPs3KffqDQBRCAkYql
         Hkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156895; x=1777761695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/xS7q5C5QGMJMPDSriSnCglCHYvD9rGLYFUY/AUodE=;
        b=NMDsJKN7yv52r3/WBw6Xvco5nGHJO1tl7ZLcxlxI0xR9BQcQ0YeGqdsYZ1trfjN6Ow
         g8JVnJZ4q1ZRzjaiudDRQ2vp8wSZBIDvu+rdiwijp4ex/rnVZS8vaYI965iyhr5EOPY1
         lUdc0SGICgRdJzAsJPIrNgDJ1jC7Zl9T0vKOVCJRlD72qM88MDHz5nEFnAWyX2LSKsJu
         vbVmoN61IVuaAbwVn4fLnWHkCH/ViWKIEBMrmFA79FBwwYhQGbLEQ/31oXXRU1gx4anI
         oYv88gOCYnyZzb5nRGGgHDZ6aX4SiYIwYGOOtC/iYNrQyR0q4nXgQQ9Tut3sR/epzSIu
         vm6w==
X-Forwarded-Encrypted: i=1; AFNElJ8+3t2PxL0xYyL2Zcgg9AQDCF3qVr2oUoeMnlf7wEYQWH1nss9/BQ8HqeZYI1oFJ+MkoCe1cIqbI8i9O+Nb85gk@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrA0lN6B8kcguOTRcfnD55jqFoV1bBgf0EkYpVK0aRCd6K4Vb
	lS0M+GQzduhNa7WXad5gymp64UAuZSSGgwi4SGuvSfqpsf6rNWLAFJPQrAjOW1dZYzH0pXkqRLm
	Ow/H5l5LC1w==
X-Received: from dlbrx24.prod.google.com ([2002:a05:7022:1718:b0:12d:b591:4bc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:383:b0:12b:ebb9:1c18
 with SMTP id a92af1059eb24-12c73fa739fmr21474492c88.31.1777156894496; Sat, 25
 Apr 2026 15:41:34 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:27 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-3-irogers@google.com>
Subject: [PATCH v7 02/59] perf arch arm: Sort includes and add missed explicit dependencies
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
2.54.0.545.g6539524ca2-goog

