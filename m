Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529834B190
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328772; cv=none; b=Jnp1WFIr6E8iC4+cZcmwt/KltcNVvlTPIBM+WmthmLxZgsJJEEnirhTylMSG7M/qkHTi42FFsjbAEMuf65ES5lrcPZHSQ7k8eEuVQRslxBEuS5+ns79pPSIonSJ50hZ6GkDZEWmxoBEu2bclQWYvpwwjuYrli+2fUyTgTIovucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328772; c=relaxed/simple;
	bh=0dW3EhwozZJdK9GyY7uSSqkQ3MrxnQx4/U/UjD7W3x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HibfsCwcEcd/6dwMXxPWijFVyfa9SaRAzHWyh3o+aVUjJiY+UGNDeJrl6Pom6xE61ClzH0CgrACtoreOph6TyFZV20WHDMl/LEEtb7rxrEbHJCoQiA+DTCv4wEZ6w97tx47NTraeW6k95YpAYuTPTyK1/GBegIkUrIUDBqCMLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4uaIg2w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4uaIg2w"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33d75897745so4822628a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328769; x=1761933569; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmup4BIbkScoJHl2u6fwJbLlsa89q7qgBXlzEQqW1es=;
        b=T4uaIg2wrLxeRGdGaZp6X07cXDZHdzSqP/0sxkL3VBRIwD6gmgjQ7NTEis+KHeijI4
         OaJebFqgQh1ln6IBRUrJwlm7TBtDk11sjPx11ohjL73aOFLnjHcQak9RzFdy1LUSY7rG
         42r4jg50rFBODbx8zdgcfP2W2z5rnEOYs6whfT3XmRoJynQw+X3DDEMP9dHaZOCVRIyd
         Gv/lOErMOcczeyA1zG51j+s+tEYlc4aBrf65MX84bnE8i2mpG1+cDOtAVYI5BVmEnUWS
         I3PuCWiScx9gzNne+fxRCbfhpT5AHAqJjTPI7C51OAa8mM4kgQ1iDCBn6yRnvRYxbFNO
         nPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328769; x=1761933569;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmup4BIbkScoJHl2u6fwJbLlsa89q7qgBXlzEQqW1es=;
        b=pLw31hOhsADxtEqLozO0BdbUsjPhQQ+7pTrEG1BZBma3eQULF4FcnJP2g8kPtbmMB5
         WrlRsjlR/IBT4bedIkj9nLvHa8XQtoq+8niGOV7/peZfnDym8SQyaEs2Kq2OVi9hrJjO
         sCs8cTP7SBJ3Ib/ZjjON1Ny9diPbo5eaFjLwmLYvikFsOZ2xZBgG35HQVep5v+jb2T5F
         TaJxzF660V/aAWI2yHTAlAmdtUT2wbGVeI6PL55FttpY4kKO6rxfZJ0uduAKHcc9NPBM
         B1rYy2siNNkHYliwNbaIGBM85ss+wVbFjuDD9FyJJTeMd5Q/NIU9JYl4kR5mXQbx6CUS
         592g==
X-Forwarded-Encrypted: i=1; AJvYcCWr9L8Hi/1fRpa4Pf/dq97F44pmIDv0QoEKUlsc9h9Pr2NeJbsAOYVeL5C5KAbxkdTHxa76CO3+N/EqFOoEqqSY@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCgp9XCfG8GpKqcPoMEOGC1d4bEZqOQnxlFJiOiZ8z01HLtiB
	vcquhe1BLaVdbstAbVo3G5FD6wSNgDRrfAATg8En1vM+XGNpVyeV/kB1hFUo2v5iThEmFIoNbeW
	Ibxq9qP3glg==
X-Google-Smtp-Source: AGHT+IF8VrmJgUHc+N22FHVZeIKm9/dVMTRLTdCjZgNklBkTzpwDuzOlB+B1PvJ5QqZTPRwuwT2BrDja295a
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3852:b0:33b:8ac4:1ac4
 with SMTP id 98e67ed59e1d1-33bcf91c61dmr41786364a91.35.1761328769046; Fri, 24
 Oct 2025 10:59:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:48 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-14-irogers@google.com>
Subject: [PATCH v1 13/22] perf stat: Fix default metricgroup display on hybrid
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog

