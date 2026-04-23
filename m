Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244A38BF97
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962068; cv=none; b=HHSHZKIuVkd946VTJ66N2Z/g5bovCBCLvnJ1w+82P9rV0o+SjWnySvftVJCW7m3dzcfgL7MTLjyAHOpXgNLKptM7ImcXrvpSgkHM6cZ2P7eT9AzSYBpLbkmjtZPXAYdzAnCtxu6xzk3Qtbwj+An3N6HB/wmavj7Mw9rQf36p6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962068; c=relaxed/simple;
	bh=M/SgY4TmTdT8HmpVVkMbcJi0ypWYF+pu5pz0BxOFTos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fija3KmeEXI/cncU78J7Vih7FRlvw47zjeo7C43DxSNSpwAFKBexTndJ+djCg7jt8+Zs/KHU20fY2Xtc3XTP7YrhozTstVhvpDTxUldR5v3HzJokAM4R5x5TIkva8K+WYjhO/MrT60iIgxDyuemjD/rZeGbUVhFPyVhnNfN/1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NX8vwTbo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NX8vwTbo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so10754046eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962065; x=1777566865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=NX8vwTboOGVfmmMinn7IKKEBIIGQgnPpl56CVvtiyMSL4OvpTNXKT5Fr65mvn28hL+
         /X7ScVJ9BVc6Ak7w1fY+RzkM7GdZmiidBJh1XwR3+27YFs0F7qaykNcIMMlsLl2ShmWH
         bMe/ivVz3ApQi0cWGUQ/JMiNUHsEqkwjggky4iD1p0yFJ5xnkFrGU6912vnnaevy3zEO
         zXrm2NFSv6Az4EJAX2M4GwH9TNuYUDO9wc872iPSp2gr6r5lhfWa4+bi6rCrrAWd/ckb
         rj4KF32OhJqfVkZ2b91UMrzXYwDNtes05bzwtLcbZ9nDLGoO4kmqfrCntfkcIPAYtUK4
         F0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962065; x=1777566865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=hBeObHdNJZ3f6hYD8bFp5l4MKd2HxJbH6bC0Y6Xgk1GsdOFUJnmi9qlXQgiczhN0VF
         rGNgQLYnM9Z+CqisCBSZbzqB1pNXU8RghV4JXpevsk24oO07I48QkoK+Df9VsbG1ydco
         URJMchvLg6m2LLQYKjR45tPRBuM6nGP5qzLUZ8QcCdzTYLjlyh8k3zWTcOJLwAm8MLyF
         8JTbJfnt5/gGfELii7ioXoC9+42K0/99+kZTy7S27X+u6XLdp/cPLPdnOg7sXcJnoLtO
         2qFY+YQgvPNh8zU4WghVsioKpFo/pNpAsSt5G25FKII5aHOQ1AKGoq7qafqEaPfEGQmN
         jb5w==
X-Forwarded-Encrypted: i=1; AFNElJ+t7LJdnIi7OyLq7OFMaLkQU4os27iYL19DlCXdeEvmIDBbwpIBec6S5tfJaPEOOhBMzQd6YdCbVoNJAUUcLDL0@vger.kernel.org
X-Gm-Message-State: AOJu0YzuESczMXE9FBHgcCDZudpu9aJKRJyJGIpjVvb4/Zjj+OYdmT1y
	XeKbVqrAesP8HcKcgQaRBXAoL4n2lz8JXgCdWsiH0XHOl4zXZG+IKeDFTsvNu3tJDceGvq3deyt
	xqwNSZ8IRdg==
X-Received: from dycnm22.prod.google.com ([2002:a05:7300:d196:b0:2e2:2088:dca7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2393:b0:2d9:6f2f:9f6f
 with SMTP id 5a478bee46e88-2e483d82ddbmr16346812eec.24.1776962064201; Thu, 23
 Apr 2026 09:34:24 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:12 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-5-irogers@google.com>
Subject: [PATCH v4 04/58] perf tests: Sort includes and add missed explicit dependencies
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

