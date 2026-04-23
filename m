Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5C396B99
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962073; cv=none; b=rLcznljOstRflHfhIUyZ//nvrdmJNvsrHJ0fAl1AmT3zj4adni1a9+/2l3tgbd3fkHLCmRVKBOMvddnn4TDueD3p1QDtOFOLMXN8p1rsRn8JxmsandbtklcG+lcR0vAAwfNF6NTIdDCQesdfb+s4PRM7GMnrH5WHh2F1mDSnSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962073; c=relaxed/simple;
	bh=RAd4pOeIf8vJj9brxXdaHiiQU+q1Ls8PaYIy1lzUB6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qwt/IO39X508zQbWR1gDdC5GlEctmjYK1CfO8OjLJdgUgqLHHrL1Kl6z/Mo19y+USV6lK0T4eKwck2E7ajq9D+hP8jZuCksqkU6OMfTdCs+gn8KaChLT7el/pZkQU9Lq9LonjoEeUIWi334ED9E07NXokK3EYC2oR9wjxFxWp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4Pq7yWf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4Pq7yWf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8ccc7593so7356139c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962072; x=1777566872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=t4Pq7yWf8IvgTIl/uIthrSSUuN/dMbwwt8FoL2rf9BtQbA6ITkxaYnF5ZbV+wOl0j3
         FfcpaHFvRP2bdTkB6p9taZVeXk4hyxQYEk/WYk+YaaUii/obOmW6rtlpC5TZIKnVQd+n
         nV78tWz0qW7DpMhxtBwfsdFUtZ8ZthkdTAv7HQbfZtSNNwHHM4lb3saVAteEKLCkuXmy
         WmrRpGHM3u4BBR8jYe7LeDA9K+cFDcJzAA+HuoueiRsYXCYvH22G4NA9+lXA/wmJdDSu
         tchex/eI0/CmKudOLDE2DutJK91f3HWZuaMjvvaLfIRZgIpQzqMSnMjrV2giZTaZ35RG
         o1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962072; x=1777566872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=Qlj6iqVqEC1Zq0F/CWEvoxJ5cfXCFGU+l+56NSGzxXGYJF72mJBz7A6GkrBRDdVv3P
         m3gWoKR/mPgr17C5so6NCDCzI0t3VcWil1O+jFugiyvLxwiNZAWDug6KyuG0oRQllrIK
         4Fc3lGpSuS9ouUUVNvocitDa3e4zTw7mO3RUoQu8K2FB9gcU3Us105JTtYKZEqVH4/nT
         kroLt85wQgeDhnY7TWl7DBMkQT9K8WD+mC82RU4P1w3P2y3B4g5FcLrE+dZWH0TTUVUL
         3hsAM0aJvFYMPmhN6qUTBmGxfaH4XP+Wz2oVCrUlFNskNkZg4t2x0miDc/y+6VQmpckW
         lpPw==
X-Forwarded-Encrypted: i=1; AFNElJ85+og6E02v/hDP7IziYpyiFlYbZD9cdiKqjCKdCitgyld7bIjrqDDXvqvosvM8dV0PTIDNQWv+Y/2viD3uRbeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/Xvah/htCGNpCM2g4nZhzN/olUyHrGCtXfSzJMLHnvmaEQD5
	/W7Pu60MGBWIoU6Zr5nCmA0fTCtplz73MJw8KwuHJxBIiqs+BxvaLrGM3ZT5ewQyQDy+7CShCgt
	erKLuq5VaWQ==
X-Received: from dlbsw6.prod.google.com ([2002:a05:7022:3a86:b0:12a:7b92:3d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6627:b0:128:dcbd:e27c
 with SMTP id a92af1059eb24-12c73f95191mr14366495c88.20.1776962071264; Thu, 23
 Apr 2026 09:34:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:15 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-8-irogers@google.com>
Subject: [PATCH v4 07/58] perf python: Add missed explicit dependencies
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

