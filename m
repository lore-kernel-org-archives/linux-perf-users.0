Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896B321445
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553584; cv=none; b=eYUdXwILoT+54s2MVZTfQgIuOD1JtbtGQLDST/uKoiD2nYsyntdmk/HQGqdL7UWaJFYvLQsC/Pri6KrZmToqgYmcmD3R6oS4vq5aV1r5aj3DZP+b8ej3bkLevrGTqusEsssLssREuzKAOoJrR/v56RVSPk4Ycxrv/NNjsLQCHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553584; c=relaxed/simple;
	bh=2fTL8UEB9CZOHe2mxY7U8rV3O2XcV9Rl69OFhNOOOs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS6qf/ZZrSrDMp4wwuVj/xA4cwKlXiMFJYC3ST58cT8nfir+XsZJju+O9AXW4wBEdmgjEPfrzwS+BxjcEJzjOnb/g5Ve4oLXDDrM+dQs9MmHJCiOHAllU8IYdy6Z4dAS05k6aaoSbJIgED5huuyp5t0fWh7daKGg96BnEIRqwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ua8WsznG; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ua8WsznG"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so2687411a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553580; x=1766158380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzt6Jr/+wkfmociJhlECu3e99FFKHyiFhWTKLOnLQI0=;
        b=ua8WsznGsxFEBawqlauw/cL92YaKPZvSDKmI1pMQQ9CIkFn0CJhDDGJ8+lqGMMJMp3
         OEYVUMyHDWCgQziA7mex+4av6dLQmA15JZh5HUnQk0umEc1N6Fylfa5X7L+b2sn5jIRv
         mrx7x3SiojFqH2APwtW2+FRXVRjByGTYxwW+VvTWPjQBot4QoophzROU6qGARmYLP9Tj
         u77q16qA1czu6WqVvHnjoMxvgkuyAkSws5zDStxH2G6SUYvIDiL6OoVI9PHqKQaW1Ub/
         V0UHv6v0hC95225HyEmcAJLIoUVsKQFpIv8U8J3XlWbe6kuN2INbumrWgtuVpdClrh3u
         Nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553580; x=1766158380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pzt6Jr/+wkfmociJhlECu3e99FFKHyiFhWTKLOnLQI0=;
        b=ada6dAeoCfk7DtMFUVLsNu+xeqPET31oqd+ID4bX0yGZYPDszpoi13Re4IHu3dU7WF
         Cs1XErNAlTkAt3A8gYohsyiOfTNMn17fj5iY6LddXjvg4k8TNzvqpo4JuprOZGq7W/YC
         FnN79Oa00BdlQ7NRe5mz5geBf0dbbBvxcoN+Ksi+CtpNylP+TnpX+XzmOvS1BKYC5528
         VCHH82PSVLyt3FQGFNGfVw45ipdOOhOcfbsuoTnxA7qBWNUezXc+Gq9cS6yXEy76NQ9H
         UOIGgV9ljJ+eUsGdeEoWuYxLwyIObe4nbO7k3VEfevgQIVISzxZcJj4wDQ5FgHg6shcT
         VU4A==
X-Gm-Message-State: AOJu0YxNZW52T6ZxZeHcVmVbYmB7musjMbjnY31VssDP/8YpGGwKF+y+
	jTwj6o+iTTAzbU+AwokB6891RdBuwqnpXlrWn4KYfSjKxmkkeIGXAHFlg35/SJLqofc=
X-Gm-Gg: AY/fxX5MTz1vjByAuo7+hF6hvDLZd+xS0Tum2LRBUX0+fkoQQyY533BgM3QG+FKrgbE
	sbCaqiUIUPaaJKFeE92XwRBT6cXI9TLGR/6AAS8rA6WXfBMIuIq4+qSuJbVKe9JpTPmjXbVcy7N
	bVQM87FtL4YeEBDujMjR6s14Nucx+xSvFXsEl/FBqDIs0v+5NSz1rkZvSFRt79xicFoaHay9R9v
	KVtcCk6DUQUp8ESQDU3ewkDVpqIUIquRG5P/vdP6jU7Q0ebnuRA3RPZs7s4fIdvzjBqAqEWu7FE
	wDGtF3EmGGZSzMJydbsKP+Eh8LrCUDzxo+3hRqV4DwWd1/kAjeqzfvElXg0NVXW5bBuj1olndqk
	ihjm1yLJN6pH9PtkRpnXX8OoYskq4bFiyBChJR/KMut+4Y+KdDj5Xf1Thv6y53xaN8aH20X9G2I
	X64rlONIKSilzouVOSfyNw
X-Google-Smtp-Source: AGHT+IHuJrYzbGSy3G76dO6PcCNRHA+ZNmNldDx24ULUjiT5Wo9EMki68zi3Oygn9G+PH2eBroytyA==
X-Received: by 2002:a05:6402:35ca:b0:640:9993:3cb8 with SMTP id 4fb4d7f45d1cf-6499b16e779mr2529095a12.5.1765553580465;
        Fri, 12 Dec 2025 07:33:00 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:33:00 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:26 +0200
Subject: [PATCH v3 09/12] perf cs-etm: Don't use hard coded config bits
 when setting up ETMCR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-9-aa36a4846776@linaro.org>
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
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Perf only looks at attr.config when determining what was programmed into
ETMCR. These bits could theoretically be in any of the config fields.
Add a generic helper to find the value of any named format field in any
config field and then use it to get the attributes relevant to ETMCR.

The kernel will also stop publishing the ETMCR register bits in a header
[1] so preempt that by defining them here.

Move field_prep() to util.h so we can define it along side field_get().
Unfortunately FIELD_PREP() and FIELD_GET() from the kernel can't be used
as they require the mask to be a compile time constant.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 22c6272e8c367e5671809771b841c5babe2d5282..a5135b743e6f18789026323ea75b2a78d6495d73 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,12 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+
+/* ETMv3 ETMCR register bits */
+#define ETMCR_CYC_ACC		BIT(12)
+#define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
@@ -487,6 +493,33 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	return err;
 }
 
+static u64 cs_etm_synth_etmcr(struct auxtrace_record *itr)
+{
+	struct cs_etm_recording *ptr =
+		container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 etmcr = 0;
+	u64 val;
+
+	if (!evsel)
+		return 0;
+
+	/*
+	 * Synthesize what the kernel programmed into ETMCR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
+	 */
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "cycacc", &val) && val)
+		etmcr |= ETMCR_CYC_ACC;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val) && val)
+		etmcr |= ETMCR_TIMESTAMP_EN;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "retstack", &val) && val)
+		etmcr |= ETMCR_RETURN_STACK;
+
+	return etmcr;
+}
+
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 	case CS_ETMV3:
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
-		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
+		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_synth_etmcr(itr);
 		/* traceID set to legacy value in case new perf running on old system */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 		/* Get read-only information from sysFS */

-- 
2.34.1

