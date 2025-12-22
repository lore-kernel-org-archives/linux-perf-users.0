Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BEE3218A6
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416492; cv=none; b=YvRS47t9uogGS51jxVLOIgRiSChrdMFpZVbAbvYxhMtxTtxDLXyYpfCn5xl9XU0pMFep4XmIsuwd4OarEB9vlvP2VzVN2mdIdE6UAtZp+bb26RDjK4BGwqeBvslaf2Y51awCNG4eFHPAIujYP7NEPfZ+SQLvTy6GL+VBGxbHCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416492; c=relaxed/simple;
	bh=mrtxJ5M6SR3xdP9wSMg81zPVwvCfE9H+mEz/8/aLW+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEI1WTwg+EF2qO2Hk636+mweRPadqR7exDSXVRum3xq4rlMf3waapVmkSx07ZPzZfy0/TpaDMx37tsl7nAWRISyo94XRILAj7qn6PvqbJsVmO7gOt5YsW8HEjaKbMRAUenYiNTj62T8ZfQAF7jdgEG4z+6at20uLI9vncO61Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j4Xx/x55; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4Xx/x55"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so1827405f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416489; x=1767021289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iYsj2HXEXbwN0vBYKJUN3Lkbk015SqHZecYgVjo6J0=;
        b=j4Xx/x55/BCGEAiIjgKWJjZKjvfTFs4AaQakNAKFt5S73kTI1UYeQ/nH7Bx2QrMxaK
         I7/UJ2BpclkWP0gTGuTTbLhTQ8CvxdJT8KJq98zPvPBNmJ5knRgxevUshmLqHWXG7/wT
         ylhLzavGu2DDe40gqmgXJEw6SlP1U/oC5Gzm3/7n4rcl6G5wgixAJit83/lxnToM9DuJ
         advtI0D9PfcG3fzAfZ1/+Oj82Zey9DgC1m1POGd9UJCNJ3nGyGSbaEkb0zYyiK8QkIoL
         U45cijVpdcO84vl1N6xTaFWDd99rXqc2S72smXi/1vglaQenQAPWTyjYGm60j/NekEcp
         Q3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416489; x=1767021289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2iYsj2HXEXbwN0vBYKJUN3Lkbk015SqHZecYgVjo6J0=;
        b=TZYQRmIYjYfR9tlFvMr/rrsT8X6qriXVWPZ/lLfoAKkoj8p+PRfZyS8CeeVNHC+cXI
         w5mB+2lEHRO3Kszjg3SyMnmf7GzwC6B4Dk6pkVF59Z+sSJabBSLk7AJw6n/TPOv3/fwH
         g6kcPAg95knn40QZetPIfn3vGVHGFA+ulXt32YmmpBy5g0RtPsKqg4HRsUFXT5be1zIT
         2fO3iFGYCGIAGdzx609jQ8jEhn//yXS5uc2I8t/Ey04K8AQT+uHiIx9+YxmG6vrmQa5o
         XTVo63aEWoGtB459tswSTrpkqqc//n5C1MvpOGoy9yAJ++w9WsbzIoavW+VQla6SHT8a
         9p+A==
X-Gm-Message-State: AOJu0Ywhg9Xfys/R6IFkYdIoSugWB08tyvoSbsTFQV3LQJcLZqedW10m
	DpP13Kqenkjy9cEgSKAKoYmJCfXfAfK7fZM0yhk71px/BDbMfV5ELXj3ma7lX9Qi6Mc=
X-Gm-Gg: AY/fxX7Yb9ok6AfZpe9zqocsN3b5Si0k72OXiclG7ZoKPdEepj/bI17NJLtgDcktQzR
	traCef1qUTZ25fWJ243+mrG/bRpO1fT8nH8n7/806rftAe3VL28IqwYcHYkaH4Lf5Z3F97hEpHX
	R0BoNZAYfZBUToz1VM7Hmlz3WpYbxkWPo/xaxdaNTsNQPRr8z5eV5M+bqum9iEcVoQ+YxEF//K3
	QUjrz7geeEfJPK8kldM22kBOzp7/fzLaxF8tMDkICC9J2zZjJwquedECqamXCdZE7AduhN08CRy
	BN83kondIM60EJWT8EcHEDhIDsuq5fmgevuLx3HPRUewFfsvhluogARPPpP5rZ0v43KG53+mCf1
	JDLu4ZkeW5Ir3I+q2YBIZiCI87R8O0jIMPr+ujMpqsljMirwnasZl/MXvD0jSGlazwRHSt3AzhA
	u1LZJs8awBXwZx7U5Kfbn872/pnPlcJRk=
X-Google-Smtp-Source: AGHT+IGLZG6rDLL8DZTvheHrtZ8wcdGMWVbVjIluTaogXPZPgmpF6avXPlRYPjqEHI5VM9k96uhutw==
X-Received: by 2002:a05:6000:26cb:b0:430:fcbb:2e6b with SMTP id ffacd0b85a97d-4324e4d2d51mr14009093f8f.27.1766416488996;
        Mon, 22 Dec 2025 07:14:48 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:27 +0000
Subject: [PATCH v4 02/14] perf evsel: Refactor evsel__set_config_if_unset()
 arguments
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
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

