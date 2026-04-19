Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205E32B9A1
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643179; cv=none; b=XKEDmshRFi83+2v5MQ0j53clVpN8YYKJpC/K0dn9GbsYKKb/lhuGqEmBzP/4EZFJSOwiIqLzWWliXAu8PTepu7bhtvntIE11buJuVbkcSNFxhpKjUEPrP2M4+dSacTiuDwEpUgFGwWqtxD3f1ePGxg0op0fzNdzCexKNNF7koXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643179; c=relaxed/simple;
	bh=yfzX/kWkUPo6HuiNEcCplA3nJDWvyQ11Dbn+i6lcXrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOVsONtY+xJ8dcL2lfCTgrAP9EUFCO7lGy8FNxLINQwysy4Q6KDp98pgZjq2Ps8mvtiFH435g8Reb6Qb+BTxTtOLYVuvMYKl24fJJsfFAGqC9iYX8LEgOTyDzzHy03+L1+bUM6MfbpFjMZrwEqLomhrPdNWy7eMoqBbCkmLtTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRuLtTP/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRuLtTP/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c7169f3a9so3196429c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643177; x=1777247977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nd7TgaO7qPS5M+WvEEPw2th6XOdhm3UID2XKbTPTAo=;
        b=TRuLtTP/JiqTftT9Uuu0eJSZqHPbSP16aEVeNRUAEWnBFCTtE91HWsJSfp3MpgnA13
         XcYPv/bkXDUXmdpnA+Op3mogCnLPkksqZEXW36CKlXzVRA1LY6oO56Zt+YwDdoVIhA4z
         mtDZH8b5xncTK3SOoTCn8xz8shu8vaBhZIqn4NrjJGx4oFUOZlsaAPGgmb4XPfhBJx/j
         Cp0uevHLrZZWGieIQ7Yp5E4QOPEmA0yfEBUfivHbxHe2LEceG3ygkOnvqpyAB8O4jYqm
         imHnsUHrRdo4Jv6ip0RU+ac5UNYAsS507V9s9ICkjikY4yHJZcQyTo1qqrI1JOKOMS2w
         qO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643177; x=1777247977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nd7TgaO7qPS5M+WvEEPw2th6XOdhm3UID2XKbTPTAo=;
        b=CB0wro4BZz6IkJk07jt6c094H3PqWmFtAkYBn243Zg527CBikuw9Qmr+sByCNhWVud
         NzOdyShzULYwh6PRiN58wkorPHvohiWhW/QTXsiVRUsSxLDxG7yDBrWTEc6pTlvcS/Ld
         eDp/VGpCJAVK6wrFTKjxuaHkjMrXLBWDfgbAmlnXUzPj2aJzl0qb60BTFLiVI1AGTTV4
         9YAmUGR/X7OmtApYLWbun9yP2aCxqAlDsq28VXhDk1eMcMlVv69rZmx/6qX5qiQz1nIq
         xfjQvLekvTMh7Y6JHC52/qzZgpH94onTlYFwQqgaFB1muZdlmAgkwKXdCifhQtz0xEDU
         l5Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9BvRuD+Q6KMTZsgZKVLupJ6yoM9pn+N1ikO0mwjOc6WUDDaw6KErJVvE0jrJ7n/MH6fNmZAgJi4DU2xHo9+MXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxMzkCIqVRcSlL1elRZRENqAUlyW97qRR5uIZxvbtIK2Rntxu
	AKbrksFKoAD080aJb2g6wpN+Y+X9rubGzfQFobn0K8ChodDJ84H2zks+RkfFDkU6q+piR4Y+AVR
	dzKlpVg4/NA==
X-Received: from dycqa5.prod.google.com ([2002:a05:7300:fe45:b0:2d8:36c2:7c59])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6289:b0:12c:6a24:a24f
 with SMTP id a92af1059eb24-12c73fb05b7mr6083529c88.33.1776643176530; Sun, 19
 Apr 2026 16:59:36 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:19 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-8-irogers@google.com>
Subject: [PATCH v1 07/58] perf python: Add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
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
2.54.0.rc1.513.gad8abe7a5a-goog

