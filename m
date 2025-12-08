Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0031B825
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203817; cv=none; b=llrgEdcuy4ViZh1cI5ITkEmsRWirfx9Vejb3gNkQi2iaFYVWvutg14uhgB0oT/NFznMrx8sQwYXoVDmckcgwadRy74d0cFFS4VSkDZa+5UJ545tfDGfok+NkJvtyVHvrT0leb2dM5x5WKi9u/3AP4l+HaWCEegWFSfoDT5FK8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203817; c=relaxed/simple;
	bh=YbyRkpwdLOqRyIj5AYCI+eJu5FRAqfw/ugAvNg9Iz3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8UuRHFx6FfElmO3jxyGBWMfmySgKxGWzqgHXiKfd7c3xkMV2SUjstPjccKTddnbemFfbtV7NX0Edb0yxNXnKNFHkUZ1Zker/HG/ekAvEtceKd9DI1IgY1ScFsw4NEtL25UfgOE7i0FA7TYViOwxgEBlBEWHsaGMrxuhK9C8C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BPRH5P3F; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPRH5P3F"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477b91680f8so50579575e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203812; x=1765808612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3MJH/lNPT8DNNCsCKfxfekwOJGt2219jutaHJgnIdQ=;
        b=BPRH5P3FwsRlsXjwIYzb7vlAjYdaXEVAhUrBWkhAKV8RttjHoA0W5EJUkHEFryAxSp
         wmDwN9nug5MR7k8s9eeqFCVVYwN3ZhGkMnSu1PLD2oy5SkgbLJzJcsbS/f4nVOLzaveS
         N8B1SSoqSGzEBrgWlfDTS0lYPrR2Pxbp+H1QW7a6mVT94RHt155l0x/zEjgPqxAzElIb
         HqQ/Y0ISurufBXnelMYBgZDQdmlq7GE2y1KDKzjwvdVrppWCidK6S/5d4ggVjkgNfR0T
         heBH6tTSM3NqHN9ZsurNf8OiKri9wyzpVAuagfz4dYQvJLjWA9YyqjP2RwnNDdfMG7/B
         6x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203812; x=1765808612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h3MJH/lNPT8DNNCsCKfxfekwOJGt2219jutaHJgnIdQ=;
        b=teBAAogJmM7vG6drAvdk8SkZ81+wV2ZS/zUdurQOmO8QLSmvnykxNrxym13k+qPX8n
         o57K4t8GiACYP5BQAFjtLdTygMxM9bk2uM0KRjHDbu4PAIl32h5vrUsKaJb2izY65uEx
         gR+WWIqXiIOSY1RGNZh+aY3LXbs2tbyFCB4Pnwv5FWLlPNSyukdOtPUt412Ru2Xa0hjA
         y40Ckjh9SqlsVKdCQU84M8fBo2Ofi15m7b8U+nPlRTO+oqDzF5AX6FpIivemOZtW0ja8
         Vo7/KJyj4dMmqGJi2FfMtFIMNQPECwh2GXMGA2Uy0B0HEM1gVHSUB74YvB5yId9ue+lO
         PINw==
X-Gm-Message-State: AOJu0YxCOg4t0V5zcn2ZAP1N8rzKLXm/X6WYlTKrhRcYbIAM1RosBaqw
	seqnx/GVOlwLESaxfzkhtiLsiHOhMryyYRrDfP9PYV1l4yKAR2JnSsGE/rfxRxFyyms=
X-Gm-Gg: ASbGncthpcBUFrevgGJO8TG4ARhv4FhKpNMr247pcIjTeYU7IkFFCpViAkPxcVN3j0a
	DX1Zq5zmKvQcgzIdGf9vf7F+ZmPYYTRiC4aUamUD+wXZOichGkOcYEay+7qA827LSdzII2ukJTz
	dDPiwODOKc5nFWZKFCUGf+GzEJzlRwvvbMEGnmZliYxMeGUahXlEh8Ol7NjhJsxCUlOs+Ud8fc2
	z752G4tYCRa2HgvGX4GZx/6Y0UryzbTSNVm23sOWWEsXrf//HyYH35uhTowm26Pn/Sp8dH385kc
	uSxAPWd1XuFQRIPzCFrsQtqTeiT/gosUy8uB8Kq7wM9iM+Snm5MncooNyYt3fq0BinZSP4OIWbT
	HXCOtK5oJBt3RpxJdszyrfXQRy/ws+Fmvj/Od2ws221z/ZCnew6UlXNy+6dlkgf6hugJrTOSBVQ
	7hKnt8abprLsdQL447uAun
X-Google-Smtp-Source: AGHT+IFyQ2glgXqpcjiC8KcvlMBIRf60rQxQ/nkTZCnm7ai0E3dGboO5ydFiCpMyFkFY0AjK7zhV/Q==
X-Received: by 2002:a05:600c:4ed3:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-47939df12f6mr84356285e9.7.1765203812098;
        Mon, 08 Dec 2025 06:23:32 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:30 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:13 +0000
Subject: [PATCH v2 10/12] perf cs-etm: Don't use hard coded config bits
 when setting up TRCCONFIGR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-10-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

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
index a5135b743e6f..4a606b1e90f2 100644
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

