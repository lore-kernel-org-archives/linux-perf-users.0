Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8A194080
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858314; cv=none; b=qZzlxRldOGD7NV+e3jC+UQY32Ye/TI++De0/hUJc0rZmSzf8ky8wJBkQAb2IjQequDoksdy2U28vRVr302QaKPf7PRs8kHMRedt3K09e1FsPDlhA4Y73m8RAjANW5463Sxqd3eeMLWLBXluYYIcqgjRArXLULPG2De5dPgau4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858314; c=relaxed/simple;
	bh=zLjyeZbn2azddPUqtc4Ge4NSb+lnbUk5aXLsXnEjA4s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JLIvKRrUJyR+W6fZDTVLtZJxTMz6VUzpHQQ5HUU7W/W0hM2E9MC+aCk86/MTSm0ddEWhEao6m3nKvJXfTCdPbWbk2CGgjXOLMHpHD4vJz+lrujoOWSwzg0ZmgwlmQAlQPX+Yfd5E57+i1ZDnRQwxQzDz9Aawj/BWAbXXMfi6a1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3FDuwFS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3FDuwFS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6efed40a5bcso54829877b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733858311; x=1734463111; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IGQhz6dYA9gvKzv6B9FYPbGo1YaUBKUFUvBFQDWzx3g=;
        b=z3FDuwFSvdr1acp1QSmL119mNoX+3jwru5OZdpC2uB2I8IWxzP20UgMC500urqphAl
         QjheibNUhA/GGIKt7n5iNSwPysSA2WdxlLVTkPAbHiJsl1qnwlGc6lK3XcAMKl13NcdT
         2KtRr8mg+M+tCP/qbpDnB/8FC+BSU1NWiCn9TOr09aQfHIHbWhVFsTVKqc1QDkHKqJ3W
         etRflSRGVVjM7V9sAzD+yTOitV051IxPy574DddKKrrhLAWRi+ny/pYcLgJ9+nzP6JP0
         gnm/EwFbAFtXm9eW7NEgjrBOS8234D6ykcPbaaDlKR1+E0Dp40DUw7zZVm0Hu1sD3ijq
         QAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858311; x=1734463111;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGQhz6dYA9gvKzv6B9FYPbGo1YaUBKUFUvBFQDWzx3g=;
        b=OGjDc8x3ef0xKtAaM8KwtVwOFXP5I3fOfJUj6Xf8rw3NdaOdeyCRvIR1+08QePBSg3
         J4DnOqA5ELkSUPaNiZIyV/eScw5gi4h246xEqQ/zlTqc67WQEZHfr3Ao93isg8anL15T
         ptp/SKqQMWkBqXYD6ZTdwUFm9Df/F0Xz/5zCvTcrJBi5O5EmGtqr0I9bcL6x9JSEJsaC
         A2NlWhvzPCY5glyjcm8CvgV2ZMcPSIA+hvXvcpmrx3C5IYl6hoZ4olnU7koy3sbxRhe/
         621s88uzQRP1sJbJB9ygavlfpHlkGm/AzFWz4H7cnr59S5rn+aE3d4gO6mEqxIrNrONh
         b9lg==
X-Forwarded-Encrypted: i=1; AJvYcCWkAtlBIRDRTSw2TT/MzpIkhR9vJoR+52hlCDwJaSQJnays4SqPjAUhSEm68Fz+cI8J7pBdI3ckv5HqPFrIWERh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4OjHpOugeCDzUjzN752T1UnZDTAMHPgTvQazJ4jhDuq9Cb75
	qRrLTaQraAP6hj3JOlxUn00Tz0WWhunt644r5OagKZ25YE4gTdzPTiIYYX9SOiqIbgeRi3rlIVB
	kIdFqiw==
X-Google-Smtp-Source: AGHT+IHT0UvC956VGrh7hk00zt7MvxiV5tXr9zu7jDzJJbYPWSguxL3QtROQgK7WdmBsBkSrxuiEiDPtdP9b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:cd0f:933b:4048:cd14])
 (user=irogers job=sendgmr) by 2002:a25:b281:0:b0:e39:78c0:3dd with SMTP id
 3f1490d57ef6-e3c8e70147dmr159276.5.1733858311366; Tue, 10 Dec 2024 11:18:31
 -0800 (PST)
Date: Tue, 10 Dec 2024 11:18:23 -0800
Message-Id: <20241210191823.612631-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf intel-tpebs: Cleanup header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build         |  2 +-
 tools/perf/util/intel-tpebs.h | 30 ++++++------------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9eb8b1c3df94..c0ccd8ef08e0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -158,7 +158,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-$(CONFIG_X86_64) += intel-tpebs.o
+perf-util-y += intel-tpebs.o
 
 perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..63c16e759a71 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -2,34 +2,16 @@
 /*
  * intel_tpebs.h: Intel TEPBS support
  */
-#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
-#define INCLUDE__PERF_INTEL_TPEBS_H__
+#ifndef __INTEL_TPEBS_H
+#define __INTEL_TPEBS_H
 
-#include "stat.h"
-#include "evsel.h"
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
+struct evlist;
+struct evsel;
 
 extern bool tpebs_recording;
+
 int tpebs_start(struct evlist *evsel_list);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-#else
-
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
-{
-	return 0;
-}
-
-static inline void tpebs_delete(void) {};
-
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
-{
-	return 0;
-}
-
-#endif
-#endif
+#endif /* __INTEL_TPEBS_H */
-- 
2.47.1.613.gc27f4b7a9f-goog

