Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8C3164BB
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553586; cv=none; b=tjgwaC+tj9woKQFRlJ7Rqyos9dRjVzPyuuyYQiTas2jyPsKKAAoKdq3kvNXiQ+g2t9smP0RRDQ73FyZGWPOIju5+E8FpGUxBIppVd2028QIlW6N8eqSXLbPESE7LTSv+iLPy4ZWZ1fuvSy0b6BGz9mU7iUKtKlXykxJr/MRqM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553586; c=relaxed/simple;
	bh=CnG0U9L2o0XGUE2E9XPt0sxgf+zgqbEhTP9i+gzCgnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY9asAhjF03uo/2/3ZTtFTGLj5X3A8BaDix5Dmu8UPxQjd5xoLLIpw7lYYbE8/O6twRGybGZXobyRHawrCfhj7UcWSGkmw/ttauQuqCzCJtJSw/rqVqxODFK0CWTRw8PTFlEFHEtkSvVBCmoyhyinhy1/VeTFNMWH2O5NwGbXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ro0A0d//; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ro0A0d//"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so2040989a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553582; x=1766158382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIyylrKuVnmfqhBbx84gIScsHXdr4noRfgmns9UOCBc=;
        b=Ro0A0d//Lb61kONtE/ao7WV4yefPMrlMnNuZL6WrJtlx02MCnpxCRX2OcBy+vWiBzW
         gQio1NBk2goVVz2zPsNJ8E9b/nkZp75jxbUXrZqMm1KfMA3TvOZExN7qwFeatUH4hQBM
         4eRvA4zQK9O4pa8pXNTl34Y8Je1Eju8dBJXKO31Y4zsFvwRwU0vzaWEModQaLzIgZ3Pf
         7NABhCaR0emphM1+3EbXjTXsaLXt8mk4JIvQEMIxVUPsnG9FWuYPJkBoAAfheg7Ss4Sm
         o7olm6TG7GTdN0vFw4ETWvpAoLz8J/dbl3V6T8mBuAUkvBmBVNwnkXisEbCC3viTNxbb
         0j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553582; x=1766158382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIyylrKuVnmfqhBbx84gIScsHXdr4noRfgmns9UOCBc=;
        b=UwnN+iwX/JyWS1xUNxocDPsxiIUwrK0vvMAAZCNAhxkIYpFjzERCooNW3Gqk5qL1Dp
         lP8RddUvT349T8M+81KXecBWB2HeRb14Ud/qzQWpArtS7660iLsS46WbG6xh0OUyfP4V
         KOn1xeuzZaXco8/0R9wQkNoueUEBcd/URT1BoLdkXSWDbWXYx0plePK7TbNwatEU9C/o
         fjtx3pTTjuHsZnyneZv2jnHeeIcDCiwnKFsff5/3la33LN5OSC64I+5ztE+piuodhI8C
         N8fkJBcBoMwYnNDFlVqMCK+XwIqrURx0dRPBgM+3F6CURtwGawYtl0GKs4e8xPDhr0M3
         9Okg==
X-Gm-Message-State: AOJu0YyQcngBrkTNX1Q+hD+TNYaztFqArLVJ7SXvT2g0oWh3RU2YSPO0
	9yME1Is0fVeNIG1cx/2gogvpYyDxu4xwOSnr6pPsSOzGAz/+WqvwCVb5X9qIsU3HsYc=
X-Gm-Gg: AY/fxX4SDkyk38l3N2gr3N2gzn3PmHS51ZYyI4xxPbrPGiJuBDAiAajyTKMgv6J6kvN
	XhXQMYxD3SwShOuVjzDjkLcQF2XCfes2iGrGQaERf7QXqsO4ZuckW97eRIbESpKcyZvSqT5HkKg
	bEn9phqbfiMs4+8Dwf/HEb9p3UX4FX3nrBaJwS3vqbZB/RpBdy9L0MzKi5ingbvikWkdweRhOVf
	UTTICw5gRdSpzhpAVq3VV0aC305YPZu1kqK9B3PV89S1Xi6JPNWyBD07p1mPe0DsJC0sip5Ed4Q
	W2jFg0A3GSK8VJ/hHHy/Yzh9LYkJXjOCOotB5/nurHy+mKFoDjgMzh1KdjepRbuIopZhKr71TrS
	g7vXTdUQC5jcGlq35+E8gzYk1Ea/pLtPmmY73pM127qcSvtmtF0k2krT/f2WOazXR6KkGbqAPTY
	ongmNPDxoAkwlPeSQPIdyj
X-Google-Smtp-Source: AGHT+IGnR0gQMQNB1+wHObkuQkoO/WDhs9GeM7GP+ll44IR076qgwRjFu3Xp62OThbWfaYmyOQtqjA==
X-Received: by 2002:a05:6402:518b:b0:63c:690d:6a46 with SMTP id 4fb4d7f45d1cf-6499b190338mr2329332a12.13.1765553582073;
        Fri, 12 Dec 2025 07:33:02 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:33:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:27 +0200
Subject: [PATCH v3 10/12] perf cs-etm: Don't use hard coded config bits
 when setting up TRCCONFIGR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-10-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
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
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

Perf only looks at attr.config when determining what was programmed into
TRCCONFIGR. These bits could theoretically be in any of the config
fields. Use the evsel__get_config_val() helper so it's agnostic to
which config field they are in.

The kernel will also stop publishing the TRCCONFIGR register bits in a
header [1] so preempt that by defining them here.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 79 +++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index a5135b743e6f18789026323ea75b2a78d6495d73..4a606b1e90f227aef9915e90439b2a024eeabcfe 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,14 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+/* ETMv4 CONFIGR register bits */
+#define TRCCONFIGR_BB		BIT(3)
+#define TRCCONFIGR_CCI		BIT(4)
+#define TRCCONFIGR_CID		BIT(6)
+#define TRCCONFIGR_VMID		BIT(7)
+#define TRCCONFIGR_TS		BIT(11)
+#define TRCCONFIGR_RS		BIT(12)
+#define TRCCONFIGR_VMIDOPT	BIT(15)
 
 /* ETMv3 ETMCR register bits */
 #define ETMCR_CYC_ACC		BIT(12)
@@ -520,56 +528,37 @@ static u64 cs_etm_synth_etmcr(struct auxtrace_record *itr)
 	return etmcr;
 }
 
-static u64 cs_etm_get_config(struct auxtrace_record *itr)
+static u64 cs_etmv4_synth_trcconfigr(struct auxtrace_record *itr)
 {
+	u64 trcconfigr = 0;
 	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
+		container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	struct evlist *evlist = ptr->evlist;
-	struct evsel *evsel = cs_etm_get_evsel(evlist, cs_etm_pmu);
-
-	/*
-	 * Variable perf_event_attr::config is assigned to
-	 * ETMv3/PTM.  The bit fields have been made to match
-	 * the ETMv3.5 ETRMCR register specification.  See the
-	 * PMU_FORMAT_ATTR() declarations in
-	 * drivers/hwtracing/coresight/coresight-perf.c for
-	 * details.
-	 */
-	return evsel ? evsel->core.attr.config : 0;
-}
-
-#ifndef BIT
-#define BIT(N) (1UL << (N))
-#endif
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 val;
 
-static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
-{
-	u64 config = 0;
-	u64 config_opts = 0;
+	if (!evsel)
+		return 0;
 
 	/*
-	 * The perf event variable config bits represent both
-	 * the command line options and register programming
-	 * bits in ETMv3/PTM. For ETMv4 we must remap options
-	 * to real bits
+	 * Synthesize what the kernel programmed into TRCCONFIGR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
 	 */
-	config_opts = cs_etm_get_config(itr);
-	if (config_opts & BIT(ETM_OPT_CYCACC))
-		config |= BIT(ETM4_CFG_BIT_CYCACC);
-	if (config_opts & BIT(ETM_OPT_CTXTID))
-		config |= BIT(ETM4_CFG_BIT_CTXTID);
-	if (config_opts & BIT(ETM_OPT_TS))
-		config |= BIT(ETM4_CFG_BIT_TS);
-	if (config_opts & BIT(ETM_OPT_RETSTK))
-		config |= BIT(ETM4_CFG_BIT_RETSTK);
-	if (config_opts & BIT(ETM_OPT_CTXTID2))
-		config |= BIT(ETM4_CFG_BIT_VMID) |
-			  BIT(ETM4_CFG_BIT_VMID_OPT);
-	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
-		config |= BIT(ETM4_CFG_BIT_BB);
-
-	return config;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "cycacc", &val) && val)
+		trcconfigr |= TRCCONFIGR_CCI;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &val) && val)
+		trcconfigr |= TRCCONFIGR_CID;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val) && val)
+		trcconfigr |= TRCCONFIGR_TS;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "retstack", &val) && val)
+		trcconfigr |= TRCCONFIGR_RS;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &val) && val)
+		trcconfigr |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "branch_broadcast", &val) && val)
+		trcconfigr |= TRCCONFIGR_BB;
+
+	return trcconfigr;
 }
 
 static size_t
@@ -691,7 +680,7 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_synth_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 
@@ -723,7 +712,7 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, st
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 
 	/* Get trace configuration register */
-	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	data[CS_ETE_TRCCONFIGR] = cs_etmv4_synth_trcconfigr(itr);
 	/* traceID set to legacy version, in case new perf running on older system */
 	data[CS_ETE_TRCTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 

-- 
2.34.1

