Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98915278E
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743137624; cv=none; b=SAbcIpsjBx16FilbzPE8LmoIG2oYt2VOBHREyp4ZbsU7JV6Av3uzj34e1onmGjMgUQcs7QO62n6IHpZP1t4iwgTCWy+0rDUOSAdWPrywOBt/DnEI2Z7IwscTtFBhEaiJHpwE5fBRC/JusQwoBV2dLP2UC2bbi8APAgRIDZ0Ca8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743137624; c=relaxed/simple;
	bh=eaC90ricQrnC8xqsISs4vqoaWZJHbKwrppXGxE0i4ow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=IDKnnfOGe2+FK2piLfgGvBq6F5tn67pf6jMdrcdnNHKXwY2EnbACy8opmIJnWciqzTlQSdKJyrhmAHrCqVNBI/85j11448tk9gDcN2e7hQ4nTBTjyEfSeuLOgrGz8vFEIvzJr1LA9wJ5DFgpYqyZcxRwUZyHAqg98KK7megLlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4SmWqlO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4SmWqlO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011bee1751so2812363a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743137622; x=1743742422; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ns2ed/rm3QAGcQCA8lKTg6jzHlri2MGJNkjL6fFkVaM=;
        b=B4SmWqlORG29KXFYcqNyEdhIzcz/nC/LBjj3J/c16f+fzFutG0OcyzhtEIU9afe+fE
         LENXy1vQD35cx4/+x1co8mjHoTkP4ixIrUENM4z3q9A/xvVQXILPKFTq7hxD44IZlIlf
         4Jijm46tQuZl89Yckmi+zSrOIqLcVrcR1El8WZWqOx1yVvXoi+SxugCsOAe42ZgozEOW
         m//L9zHWcxv+Nd7Qju7ImF9R/MqdRz+BylH9xaTt/uojLUwUQmGMKPTVno0QsB5Xr/xC
         J2OiKZvPjZYMJDqLraA6Bs0/zTN65fXkXLFA/55qBg/xznuGpGWi6FUmfXQoRz1lQIMO
         +p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743137622; x=1743742422;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ns2ed/rm3QAGcQCA8lKTg6jzHlri2MGJNkjL6fFkVaM=;
        b=xD5UT8iE2/9Up1n14hgSoa1/Xx3lkfEbDmVUeeEkwqhSc5PdbwvCwoKClMgDGSIxrT
         a01DLf5fPk2FhaqAgeh8+zbL4FxXnJIMQQyxobehaqXHAIm03UonZ7iW0BVLpRC0febL
         RerDC8CZ8cOXowtoFeF8arSUCjt8Vxp+5liLHXnuJO9A4wRRtJN5SOXNG0rOq+ywnSfe
         KL/UZM4xaqizDEkeDBFsjz0qSFl2sKtdGUI/Nj8jbhuDxWrIuSisWjfR6qeSjjRdr1Qo
         xtFVXDn2l6zCvrifwRKnuuuZa0qsIUiXV0DaT4Zwj9CdTGg+O2pYVNcRjTMIapS1CO5+
         qFyg==
X-Forwarded-Encrypted: i=1; AJvYcCVPjCifwyrjjrJGklDaJQCAsKzLi1NVyvADfkVwxclE/gfrIfiBBO+L2zzk/cZBx/xPjIgGqTw3FjLxZSNxzKDe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90MWji3GgbP5oUXpp5sKHGTgn22HYO80/c0oogx5XqFlyDMwt
	VPTF8YTh41RZ1f/7/y+eCV2/J7QM4KUQUCSMuTKwBsKmymSG65B5UuarJax+dIM0oNqr6HCMYam
	fxVWn/g==
X-Google-Smtp-Source: AGHT+IEktYI2lIl/Mcy1bHu5kSEPUp3+gs9nYax0SkoWPCqnfzMRLy2pjGSEJKNFDYHGzS2EhW2X3ixPUo0l
X-Received: from pjbss16.prod.google.com ([2002:a17:90b:2ed0:b0:2fa:15aa:4d1e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c888:b0:2f9:9ddd:689b
 with SMTP id 98e67ed59e1d1-303a8d81f5amr7490974a91.22.1743137622475; Thu, 27
 Mar 2025 21:53:42 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:53:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328045337.229354-1-irogers@google.com>
Subject: [PATCH v1] perf stat: Don't print uncounted hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Aggregation is different for core events compared to uncore. For
uncore we don't want the counts for events not in the aggregation
id. Switch the !counter->pmu->is_uncore test to a
counter->pmu->is_core as the hwmon PMU doesn't set the uncore
boolean. There are 2 booleans as some PMUs forget to set either
cpumask or cpus that are used to determine whether a PMU is uncore or
core. Also check config->aggr_get_id is present as the non-core
'software' PMU doesn't have it set.

Before:
```
$ perf stat --per-core -e temp_cpu -a true

 Performance counter stats for 'system wide':

S0-D0-C0              1              63.00 'C   temp_cpu
S0-D0-C1              0      <not counted> 'C   temp_cpu
S0-D0-C2              0      <not counted> 'C   temp_cpu
S0-D0-C3              0      <not counted> 'C   temp_cpu
S0-D0-C4              0      <not counted> 'C   temp_cpu
S0-D0-C5              0      <not counted> 'C   temp_cpu
S0-D0-C6              0      <not counted> 'C   temp_cpu
S0-D0-C7              0      <not counted> 'C   temp_cpu

       0.001375790 seconds time elapsed
```

After:
```
$ perf stat --per-core -e temp_cpu -a true

 Performance counter stats for 'system wide':

S0-D0-C0              1              38.00 'C   temp_cpu

       0.001260575 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 91386429115d..ed3270ab2557 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -981,7 +981,7 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	 * Skip value 0 when it's an uncore event and the given aggr id
 	 * does not belong to the PMU cpumask.
 	 */
-	if (!counter->pmu || !counter->pmu->is_uncore)
+	if (!counter->pmu || counter->pmu->is_core || !config->aggr_get_id)
 		return false;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
-- 
2.49.0.472.ge94155a9ec-goog

