Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DB37DE80
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960617; cv=none; b=K+569KSussZpdYQtsEYRlzu3H22b/m+3amO5RQxiW/I5SbV7zx3rMuTxYY/sjbeXSAYwFkIFYIYCHYL4c2UBPmzGreE8RCGDbntUXXku+tixh7NwIDWho0wGpye2pZA7+Ra3NN3pjFba0mPmXcxF1j4Xd1eCX3z2PkgELo6E1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960617; c=relaxed/simple;
	bh=M/SgY4TmTdT8HmpVVkMbcJi0ypWYF+pu5pz0BxOFTos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KarLSzmG19AZqT5cRLPi9yvBQYZixYvaVin6wqgfM+hCUDIH1yEMKuhgw6G3MSWLThDelOPdxwOUmS1vYEynb/eIX55WrJpwyWE65OdNOrL2rRnvG3XYYCxUpsaW3WG0MgMlq8EBi17iFBCTkh8KFt9kRLONaxacGKEdcOpjBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGzO/3pL; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGzO/3pL"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so19207898c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960615; x=1777565415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=EGzO/3pLqtRRAKK8S7TkRUq/mYrC4pajhw0oFEgtM/yQoMekmkmnOPnQWbx7U8q+3u
         EKLMskbY0tBZXfeMcZFeOvlWISXTxm+wSkXkSBD2M/0KYOt4gCgySGG20Wy37I8xA++d
         BMW2KirvgZXfz3HC6PG6iZrVsmLiH6XEfZg5J4W12u53WJGdBlqTgpjfzBQXv4KUtx58
         tHHsqVSxTmVSObrfAUEEjW1wYiI9jlzmT2gym7P4maZ44g8vcOzllLx9tCdpVIvRpzUA
         y2cDAqGd+w5iTAO0K8wkG5W8Ewx6hf5XsmYwx1fREnm+6z60SSqC/+3I5d5gmMFhLTT+
         Kw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960615; x=1777565415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=i12W5stwjv47ETEY8CPWhQjzgoLDmtedqq67IYMJwPZa9RFl0k+RyJdehSAR1apHOn
         4feM2FKB63yWXpeTcwff1skLuJza8yA0p25ZxLInkKasb/7VxfCgAhpF4n8lR3iASmKU
         vBI8FcQDgEr8s/PtmNQKBqGfULQchtegvdSbTb+JMckqCkQOdIYrET2iOUAxo7GZ3WNL
         /0WYJC9NRLcY3gifgaLXufDpaMD0xXx2Ry5w1t30ZQF/qkA/vLfopikwFKqKLoE9CpK5
         oZfN6xDz3lJ1yA5Juaj/dmWPU2mJVm1VcXQ4zLZSDDtt5FAsshDJ3k0kJQAxc3yjiYsz
         6rIw==
X-Forwarded-Encrypted: i=1; AFNElJ+89CrJ1L7TpZa9BB092jrnlc/hv1e74ZJznohSusbWsN9mimpGMjih4AaIRGV+9LwheChks8OL7Ye8teK3O1iN@vger.kernel.org
X-Gm-Message-State: AOJu0YzFejz/fDDliDHaawGamx9xIZKyQ/fx9nB8PbZYNnIANITH0rR7
	AHECxJ36bP2tKQXG7YN0DuSn+APVm2EELBp/pLiVAGw8j7e7lwCR2FcdDlw0I4fME+jQkWlcNdn
	yT5pGZznQBQ==
X-Received: from dlec7-n2.prod.google.com ([2002:a05:701b:4287:20b0:12c:5db:d6d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:383:b0:12a:6fb7:87e3
 with SMTP id a92af1059eb24-12c73fac0cbmr16298823c88.31.1776960615207; Thu, 23
 Apr 2026 09:10:15 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:10 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-4-irogers@google.com>
Subject: [PATCH v3 03/58] perf tests: Sort includes and add missed explicit dependencies
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
 tools/perf/tests/hwmon_pmu.c  | 14 +++++++++-----
 tools/perf/tests/mmap-basic.c | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 4aa4aac94f09..ada6e445c4c4 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,15 +1,19 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#include "debug.h"
-#include "evlist.h"
 #include "hwmon_pmu.h"
-#include "parse-events.h"
-#include "tests.h"
+
 #include <errno.h>
+
 #include <fcntl.h>
-#include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <sys/stat.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
 
 static const struct test_event {
 	const char *name;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..8d04f6edb004 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,25 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include <fcntl.h>
 #include <inttypes.h>
 #include <stdlib.h>
+
+#include <fcntl.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "thread_map.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "util/affinity.h"
 #include "util/mmap.h"
 #include "util/sample.h"
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
-- 
2.54.0.rc2.533.g4f5dca5207-goog

