Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E53A0EB8
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406264; cv=none; b=noHjXRHVwYGMn2yDDjSwDnmWsa9Hbyb9oulShqsrswFsbCqZCKxHsWWgsXaJgyf6nJ7ZYn1vaG8t2xHXfnLsJvsv2JsMpJrQXoM1LfGUO61Xym+GOCGGi7OWQHO5S6bnAhknMs/6FF4iEAh32D68Cku9nzLhOZzBK5kXSnE6jgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406264; c=relaxed/simple;
	bh=mrtxJ5M6SR3xdP9wSMg81zPVwvCfE9H+mEz/8/aLW+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoT6k8HvSZzpBkJiKPIbPAANxovE+A+IM60vMbcokpsVpqR1NxhkxsTOFrEBPdWv8d0gWH7PsDcCRxtqlFEN4KOQ2a/x8XAdjF6zYP6zp9CjDk1Vt0lk5GmABN8iHQz/XV6HiXThCworNeLGVL+x36Z87S48qOjVEUbdstClbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2f3DJFE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2f3DJFE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso81985875e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406259; x=1769011059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iYsj2HXEXbwN0vBYKJUN3Lkbk015SqHZecYgVjo6J0=;
        b=w2f3DJFEBI31GHDJs9sGnwj219odQX4qDF8CzY3uvxFKPnmH/ldtWkPZcV6G9Q0I5W
         A/mVL2Mc1ix8mu979wFh1Vn+y0zIbicmA5BzxNBzmvA+rLz+MaBdAn7vPBZpUtIrsj4y
         bTvR5TAaBlyMXGC5a6qexvu/qTFFJoi/56+8p8jNz+tXAtWJeQS0UIe6nCKHsHSFw2ld
         1CthWAga7WruZhu58jDBqOAtQ10FqFh1VAhiCK9i2FCrMKdBz32qirFeA7L951WxJZf6
         f6i48GBxnMXaQeY3jwv8RhSkOziSTPUfBKQI5HTZwWMYfzkksUccx2AJlrHCkvt5LDia
         zXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406259; x=1769011059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2iYsj2HXEXbwN0vBYKJUN3Lkbk015SqHZecYgVjo6J0=;
        b=DRS+Ff3xOl+9kcWUr41WjbMdYYtw8jYjc0/7GxHLGbrxVJcqd/e5aeVk2AKX5DuIm4
         ZqS598TsgaBtI1eQ3ok1/vAsn7iCTFtXPlyiivNkXvgxDoaAx5IswcVX80LGsLo84y46
         ABjPX/6HKmWS82QV+ABnoBvFGFngHeoMTtLP+Y8YVjcuVXvCsNct7sYv2go6fxC8vIwZ
         ELLVcUahJ5/f1LnbnGscDI9aw2BCQZhEpHRMNT39XmfMbUIxyKcPSxVqL33Q0th+CEh+
         WeUUOsEofjy6vd8Fb/0VSwUnJbEr64/EBgAQ4Ap+FnfbWouEj1MxKByEppPrxwyYWCfR
         MYwQ==
X-Gm-Message-State: AOJu0YyCKyrQUGqO2rD6wFEJR65+YryQYB8IF44a2TEOaNd3xZgDMPsY
	Oo8J8/6mR4Wv0G39wl+4Ji9+3f+1UQcAiR3oSgAgf/W3mvtmvYiHwjuAcBIzgWTpjiA=
X-Gm-Gg: AY/fxX5hoUIHnq76fb8r0UVlKOo1SjOPyt6u+xc0mVAR34oFCVjOWEHVoHGHy0dDWJY
	byS3qIB/TQtHzpQG9QA8AKDsvEftmgX7CuLPFAQ/rOoI5GZGgz7Mej+WZr53EE8ztAAD2Z+YWXA
	P9p0mv7aX3s4L/oMKHrESboJhPtuQG68+Z+xOBaIw608O9yaSYfurzxcb/txki1T19Nmd++7+jV
	+UMhAiQ9wHbJVO2QdmnvAJZ/4d2QdPuQpIsbTIgdv1RiqlAiZMsHADnfLQsWXmQhpM7jMECElbe
	Kozoage5ve0jiWEYrsigIDmqmC3uv8sZe8gHf3dHikFi70s/ZQZIO29gKTSwkrmrD8yK5hnYnYu
	pU+ksLUGGLkKxmIczNCnRCegd9wLgemXRTTURmKp+lQaZ1U826twoU2Mww6D3d6M66hn+9i50tA
	Rdz+Lr2DsOyvMKdTw5fmLfSomz0gGZAak=
X-Received: by 2002:a05:600c:a46:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-47ee3371a0amr41542255e9.18.1768406259151;
        Wed, 14 Jan 2026 07:57:39 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:38 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:14 +0000
Subject: [PATCH v5 02/14] perf evsel: Refactor evsel__set_config_if_unset()
 arguments
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-2-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Make the evsel argument first to match the other evsel__* functions
and remove the redundant pmu argument, which can be accessed via evsel.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c    | 9 +++------
 tools/perf/arch/arm64/util/arm-spe.c | 2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 3 +--
 tools/perf/util/evsel.h              | 4 ++--
 tools/perf/util/pmu.c                | 6 +++---
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f4..c28208361d91 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -441,10 +441,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
-		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
-					   "timestamp", 1);
-		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
-					   "contextid", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
 	}
 
 	/*
@@ -453,8 +451,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * timestamp tracing.
 	 */
 	if (opts->sample_time_set)
-		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
-					   "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d5ec1408d0ae..51014f8bff97 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,7 +274,7 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 	 */
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_sample_bit(evsel, CPU);
-		evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable", 1);
+		evsel__set_config_if_unset(evsel, "ts_enable", 1);
 	}
 
 	/*
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index b394ad9cc635..c131a727774f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -664,8 +664,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	if (opts->auxtrace_sample_mode)
-		evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
-					   "psb_period", 0);
+		evsel__set_config_if_unset(intel_pt_evsel, "psb_period", 0);
 
 	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
 	if (err)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a08130ff2e47..2cf87bc67df7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -575,8 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
-void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
-				const char *config_name, u64 val);
+void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
+				u64 val);
 
 bool evsel__is_offcpu_event(struct evsel *evsel);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 956ea273c2c7..e87c12946d71 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1382,8 +1382,8 @@ bool evsel__is_aux_event(const struct evsel *evsel)
  * something to true, pass 1 for val rather than a pre shifted value.
  */
 #define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
-void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
-				const char *config_name, u64 val)
+void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
+				u64 val)
 {
 	u64 user_bits = 0, bits;
 	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
@@ -1391,7 +1391,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 	if (term)
 		user_bits = term->val.cfg_chg;
 
-	bits = perf_pmu__format_bits(pmu, config_name);
+	bits = perf_pmu__format_bits(evsel->pmu, config_name);
 
 	/* Do nothing if the user changed the value */
 	if (bits & user_bits)

-- 
2.34.1

