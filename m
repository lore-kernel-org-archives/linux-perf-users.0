Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1F357A3F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470956; cv=none; b=IAZaOQQKDaQoDqTJazaT03MAADbvXC1bBgNadvfMA3mwrMFgImE0kMA3XBYj4ACwL9NbWeMigCO2SjdEgc2Hu34RfS5Xtq/mpeEPylMBTqDqnY56rthG77fym6LM983k36LmzEN/R9X9daXY39GRtVDMnngZx7GMM38zIRbb4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470956; c=relaxed/simple;
	bh=cZF5rXK0ot4f5Ll54hzIMYMkIxY+GXfM/HIllfqaohs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nnTpvNAb/OwXceYOaHxo/DMsNkMpzj0fPyhYJg7sGYKPosYCJrlN/bq2TBO4VGIhnxF717Qiu7ztJbf5mFM/Tn6UWS/90xEiT8gI7kSNuSjrWxd2JAfvzua+7MjpkoXhtf8c1muVa4BlRRSHwDS6487hgOMEAVRiXNc7+E3ulYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNjDytRv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNjDytRv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27c62320f16so2202875ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470954; x=1763075754; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=XNjDytRvdIKQ2VhEU4fJnQwqaJJY68nxei2eOgGweRFnFVTvjfIAsp0Z47m0GEEB1Q
         qch9Evp0eNOsDjraG27QTG4RxYLz9Z8TED7sNJS4gSXM1syq3FiRvlUn1bpcL482wKJC
         nXp/DZSldUBFxh+us4j4cqqnH62jf0ykIskTSG6K3jnb9yMiKEzcAg7h7MEvTc3tJlMA
         vKNk6tJdlsLP5fHrQ9CIHZ+sKsyIEKTAsGowLbdyxvxu5buJsnfqUuZwjQiqSJUV/039
         C9eG9HmXwmlru9lt9pN6WquTjVGlawCj2yNUUIOBRBUonkdiTI9xpnA2W0eZNum1FJN1
         jwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470954; x=1763075754;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=UVbZ5gS51rF8RBGmiQX/3/2TVBZd5+INHBStI1Pgc/KtZGbNeyhEKCbNwRvmE5qO5G
         UvA0wYkOMkjUq+u7KhiwT4xrDfwUcXkDAcjLjoRlizcdEypJOzUbNGCfYASOjuiTIFpO
         2O1zAZTsM1miOm7LpT/uEtzTCdrxL7H+2WFS0sJm1T7nIO3VVeeLLIDr5wSe+DNpm7In
         FOAKUHbXuJutqxyiRHSc+LLlH5jAA8OBGwcUSVTqwAWxOHZ7DEyMbqFLz9pRhE53GeZX
         /Onp2Yp4ug6dSESzOwR5FCLPUzc7HRda6xypJqyrwZmlJ6aaPro7w4A0y490A3BgJ0Tn
         cRmA==
X-Forwarded-Encrypted: i=1; AJvYcCVi8l/Ng7zIHhfSsjwPatOhFhX2w3wk+lUP4aHoqCqFPSm2xDBjfAlHvTI+Cn6Ox6iXt/7Ol/wNlngDz8OvASad@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0M/UQbxNDjr0mZb7cVj1NI5hoPYlXwpFT4NFy11cvyLpIECD3
	fAKvYJC+ygtJBxmBKMRcE/x3jPsDOAtoYBh4W1wi0MguC6sL/ENSJvEM/DMDOEU66AHuT71yNtP
	5ttFBiEx/6w==
X-Google-Smtp-Source: AGHT+IHjH/Lc/zZixsXrrpT72ayLrbkOIrsLtdVoMrbt/bO0u2fvW5pbTn9CqdlIJUS6Wb5uI4ddoJtrc/nT
X-Received: from dlbcf37.prod.google.com ([2002:a05:7022:45a5:b0:119:b185:ea6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8e:b0:272:c95c:866
 with SMTP id d9443c01a7336-297c03ab3f3mr17315715ad.20.1762470954099; Thu, 06
 Nov 2025 15:15:54 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:58 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-9-irogers@google.com>
Subject: [PATCH v2 08/18] perf stat: Fix default metricgroup display on hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The logic to skip output of a default metric line was firing on
Alderlake and not displaying 'TopdownL1 (cpu_atom)'. Remove the
need_full_name check as it is equivalent to the different PMU test in
the cases we care about, merge the 'if's and flip the evsel of the PMU
test. The 'if' is now basically saying, if the output matches the last
printed output then skip the output.

Before:
```
             TopdownL1 (cpu_core)                 #     11.3 %  tma_bad_speculation
                                                  #     24.3 %  tma_frontend_bound
             TopdownL1 (cpu_core)                 #     33.9 %  tma_backend_bound
                                                  #     30.6 %  tma_retiring
                                                  #     42.2 %  tma_backend_bound
                                                  #     25.0 %  tma_frontend_bound       (49.81%)
                                                  #     12.8 %  tma_bad_speculation
                                                  #     20.0 %  tma_retiring             (59.46%)
```
After:
```
             TopdownL1 (cpu_core)                 #      8.3 %  tma_bad_speculation
                                                  #     43.7 %  tma_frontend_bound
                                                  #     30.7 %  tma_backend_bound
                                                  #     17.2 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     31.9 %  tma_backend_bound
                                                  #     37.6 %  tma_frontend_bound       (49.66%)
                                                  #     18.0 %  tma_bad_speculation
                                                  #     12.6 %  tma_retiring             (59.58%)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index afbc49e8cb31..c1547128c396 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -256,11 +256,9 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 	 * event. Only align with other metics from
 	 * different metric events.
 	 */
-	if (last_name && !strcmp(last_name, name)) {
-		if (!need_full_name || last_pmu != evsel->pmu) {
-			out->print_metricgroup_header(config, ctxp, NULL);
-			return;
-		}
+	if (last_name && !strcmp(last_name, name) && last_pmu == evsel->pmu) {
+		out->print_metricgroup_header(config, ctxp, NULL);
+		return;
 	}
 
 	if (need_full_name && evsel->pmu)
-- 
2.51.2.1041.gc1ab5b90ca-goog

