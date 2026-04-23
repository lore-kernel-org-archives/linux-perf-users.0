Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A563B6349
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916547; cv=none; b=h95a6gGwAd3YSx9AlGRVmLUxIXLPabAVoZ1bc2a3s5DORGOQlUlwaulHyB7CE3oC/wUStdpxbrGuOm9Pvt5q/2Dc7zDuXxP1AEX/7Z2tGANVe75cB5lwz9cewOYEUTnTxDlE/QdeHynhPW/GjodV+lvm87fOLvHao+x6uuCkjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916547; c=relaxed/simple;
	bh=M/SgY4TmTdT8HmpVVkMbcJi0ypWYF+pu5pz0BxOFTos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJuk3RHvTROAI5/+6Vfur/wxWjDAwt7LD9kYCyTJduu/Hb0hf3BdKk1+d/LNZKBZXPj3HWtp0CMzOtNl3aqv8PrkfiM54LvAXv9CBrl1os8ZJOSCGnd+YP9O8uNJpXbIirSV1jiJsbyUtJZYIVvEELKkRjrenmUTlbCt79vg+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQuWSWVF; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQuWSWVF"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso3653055c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916545; x=1777521345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=XQuWSWVFQzM5pb6T1/Xqj2NqTuCdlSkDvQg13ODgMXqeh90VLaodH7nNu0NaNaE7pC
         cYIdhGPdFEvmF6FGKrLSRh25M2639UsOSksS4TcMWLIv5AlKaqcGPJvo3GL0lOgMaoeI
         jMktNBJLGWyqjlIh3RFW9WZBB4TyF1aSphhiqaPuMttQomBAB3zILwKtTL1vMsl9/m7A
         osfHXtenZGQfaMTESWiU5NTgbvSgZ59DRyPO7WU+kl04blS5dFNcc6W6eb4a07ytis5Z
         Dl7P+afh7DN7wNOyV+tYUSQHcWq9Q7gfvE1YkJ2+eT9Kr/kLpCub0O0ElVrmKKe8KSRp
         tWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916545; x=1777521345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7fikRSJHslpAM9iLqBnszWLRLEJVtED/Rk+CBk76vc=;
        b=bRIOl0aviVZ7vr+FPhxarkCJv4m16GBtGWw4onPLq8VqY+McJjTM+Cj6sAgAeig93X
         JlsFS6ZhitFLbmBioTEWXJT22Ig7eHWT7CQqGagWrDgpWElMVFUzVQmXSZFoX9xygmUJ
         hrrxONanF7LFhvZnqlbNdcaWptN5kuuwfLNsZmqhI3VXRp956uAUX1pc53F3QyOv3sIK
         lkBmYh3tFLnnq6EG5pulLeG7w57AJ+hAZ62juwauMXMWiZOmN2wSVb/1dP77mTb3+9Ln
         aCJgU2joJAQW4vr7dQp8aygA8F6JEmc51cxgudRweGnktAPudUU/GACveHLT4+/wgsSq
         TT/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Tfs+LigOlb7gnu/ZRfLvHXC2BknDiMtW/UH2f0KOSn0taW0KGl946691Nh20O8cq4lz7NXWRE9CZx5xN2Opaq@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVzgkaXz4hCZmgsH9pbwCfWvvLCRezl5OUD4TAie36zEj3xl3
	oqecsq9zrqAc3zNuVwv67Mkvg07M/O3LPRya+i1coISrwS4EIPm/dZW8/uSF5FOL0dtMyMTinb2
	IfekYHjV48g==
X-Received: from dlam20-n1.prod.google.com ([2002:a05:701b:2094:10b0:12d:bd4b:5b09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:239b:b0:12a:6ab7:3f73
 with SMTP id a92af1059eb24-12c73e2dde7mr15189412c88.0.1776916545106; Wed, 22
 Apr 2026 20:55:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:31 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-5-irogers@google.com>
Subject: [PATCH v2 04/58] perf tests: Sort includes and add missed explicit dependencies
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

