Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7532F764
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916556; cv=none; b=A8u0aD7Ntd+1BkWY9IsRZbJ6YAmrdkxsDOIyekdl5QK0vciUFH/ObiFoFj8Y1p7BkJJ1MW93jnM0VcJJzmW0nUDiPLQ9f2ywNF3SEJNpT4pebnFYxomo0y4KtrRV/YeAi7Mh8FSBKZrzPtyajK3/PbEpJTC/5RROhCY1DMnVMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916556; c=relaxed/simple;
	bh=RAd4pOeIf8vJj9brxXdaHiiQU+q1Ls8PaYIy1lzUB6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7gLQni+6kfjdfALPRW1sEbrb69f/txtqyC7ELzDOyuUr79ATr9dk6FOFi4uT0F2R/t/oT0yQk/yyhfC35NchontWHoif888Ylui4ynfYeaBJrFrtEMhf5jEx1WatMmvP6/6WZixJVjPxX7YEJ/dPjllOXW5D+rXkduYditMTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0IYqTHD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0IYqTHD"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7540935eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916552; x=1777521352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=A0IYqTHD243XLajRbcdAPY53pVXcqgD3JbPSxLhb6o8k5c4mBvNltDQAORTKfTls4y
         R2RAERsW3O76Ygwg1cnQMcuYhEMNJErrVMFeyqiBf5cazXCkdL7qGwwyvI6r9gYUwBwQ
         /5DaoKiJvpgqWKL7SlWDzUtupwyZCFaxS/3SFSOiLvnWoNeDRd/NsP3bmZ5N+ul0+5Bx
         rlsyogjppJxbufGmLsUv/btTvajTW5QvYohWHA/yZVglzFc05wQfwJMuSTpcE0WNLfAl
         BL2NgZf4itagB1vT6w3sW/Z48fvA097GbcucnQWjJVML7Vt/zE4vUGk+LfiI3BUxQN/g
         e5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916552; x=1777521352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApYkK6SNEDGkVYkt2/XrVj4KhnXqn/c40lp08GmSsQs=;
        b=gSsitVFpOqzQD8NFmpqXe8OhRjq9HCI9QE9q21vEZMx+FVEPelGYAVAcU9jZwfryMw
         O3ha1TqH7dHC07XDKioSQyPiesmvOqKM7jxVYtT3IiK8/ysKb0MXthjgx0W2ZgHwhDny
         XgSJH4od4oYbctI43N9mXpc4O42a6lUzB8zMTSGTZzwNb4F/mfylJY3jRZ1n2tHrAnSI
         B8k7jMZ4n6C6OV95M3esJytxCD+MxEaKSRgkjCgsP08AKdOuec4Wp9OEVSU2tgB70uTP
         UhO2QdptXRO3u2TA2isOd83cfdsA/oH3CLuubmCoHc/3pTWuH4/xgMehtFqDIiWSJYh0
         ArJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+02h9bhEHnMq4wnDAQQugNDtvExVk5wQj/HRrOpVVkwqi1y8DcqJNciIc0AI+GgSXjCW9pogVHQCQxXNTJjBiu@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSpfd+RNfaAnnlCBN3dqugrPG4zxWsylcRyW6xtjhVuTdfVwr
	nBGWnMDIKKABJ+zdqOadWkdf9NvcY15xmfFhza/vLQxPJEbUNOtHnpiwFAlYkLZU/4WTgavhofd
	kV2G0svrhkQ==
X-Received: from dyer22.prod.google.com ([2002:a05:7300:2316:b0:2d9:e328:e0db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:168a:b0:2d1:815f:19c1
 with SMTP id 5a478bee46e88-2e479c0427dmr12202468eec.15.1776916551580; Wed, 22
 Apr 2026 20:55:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:34 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-8-irogers@google.com>
Subject: [PATCH v2 07/58] perf python: Add missed explicit dependencies
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

