Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B385C47
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339009; cv=none; b=qYyT0/Ov8GoLvSKY+QG/3jOhmgzv5DLyw3zJ48kYbUMvMGGJCL4qy6KWGRNnuy/Um+E15BWWfwkY9V9ibz+MU9HViRPDR5sepGsJGNL1BoiYtCV8lN1VOjWJpAwCRXnLCA6cdVrt+fQjqHrDuzuJddHuHTeaJmWdX6Fj5mdZKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339009; c=relaxed/simple;
	bh=GYxmpcXArXMONJWsRe5WPl7DZqsyI1iL6F7x/lVFYsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CBRCWQYuLFsGbDsd89VmX/tRDnFnZb/9SvWGhhQOLk+8eqE0oQcoj5BKkiSQIU9MnGRq7XFsHLiFuUCmgBvSggQGzbJcIUHGMNxFZYkt5c3dFNivaeAIwW//8/BhCN1LhUbkG7SC+8imFDR+FcFFYH5kjhISlbT6oTRet3qDH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8dSVfJL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8dSVfJL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e59dc7df64so6562527b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339005; x=1730943805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=i8dSVfJLwAEC3Yc3iBSmdXJa2a1NKEQl0pe29oKpmV9UfR2G3iEHDnHTEfkiXW+Gp1
         xECSB6NxeLVsNj1m4TG8XoSpFduYKvxNk0EvpSCSjAqWARTSRL2tV3IMCgN1NVa2duBc
         Th18HNhxGQhsehqllG+QCBu91ckdXLkxD8PgTpdARw6M/0svOHOyPTF+U+dLyzJbA/vr
         misp0UXr5z3s8qTBFS7lFf9xupKLKIlcBE4sEzS2DV+OACoBKJRae8V8VoF64Uxqz0wB
         R86ql7ANYS7OvRNNJK+HtSCFUJ3TqjkeB8SgDizXLBLhSkPJmVOI+p9y/PnxGDF2tUfv
         s4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339005; x=1730943805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=PaYjJ5k4jOc54tgkH86FHl+Zz65GHKKw0fqx+GwlqYpB4Zq+Xd2YcF5Z0iZaWZMfmR
         m/uO1o88Z2u5o+qcSljEA2nzUtMgvkNMrk2LlSA+E/ir6U41mYJk/zWtpM2qJVsI1Q4R
         yPLmuMJ2jeHDlVRcIXDckLOJUg3Gec3VJdcwor8vRonLWXJNtgAfjoGwyfy3N3sRP4Ea
         M+DqIgE6H/8hPt7cfZqXQcT1OuEukGXn5jrdrWtBSlLDR/ydVdpsZ6Qj6M3pA89KPCQl
         c1F7zHLxEF+i+oox6EXWlmT2FFALBowuHwGXro1UQbryEZtvtl+hN+TPwnezpr1juMLV
         98Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWl9VBb0yYqR8rMA8b1bOy8Wl3FBCnkoWBBrjSUzWQWuQJgd0t9xT/Proa8GTl/ch0v1bRVQjd2hgETlOpuDEeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gSbsHYpICRgLbYVUYLJAWPPIi0ylFUoNlkyVs0W/N7TQf/nJ
	pfisgJLbfBD5zE3Hv7s4WKNWsh6h12pTc8cIyiFNBe4wAx3kn6kmBxLrbwoujeT/7mjP6JAyQn+
	yq+HNow==
X-Google-Smtp-Source: AGHT+IFR9rK/aQ9amJdpd1t/y1Cad1qqJ3/zdCMOUezpWk9aRtk00B9mU2U04VpxVeYw1eEz90LsxD3W/WdV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:7004:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6ea554802ffmr68657b3.0.1730339005014; Wed, 30 Oct 2024
 18:43:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:34 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 03/21] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.163.g1226f6d8fa-goog

