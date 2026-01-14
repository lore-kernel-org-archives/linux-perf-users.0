Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014A3A1A28
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406276; cv=none; b=uMjHxxom2oWL68C8Vs7TXbZQ/4UkMPsol5pxSCL28LBX3LMhOnHEvIhIWcmQdl2tPUbesg0ZHOQQNVTRvWWovN1RJRxeCYuESXD3svTFidb6b+bIRur5FyAmcSOEY6tNFJyATbP95ZFECxFeVWnwBxWW8TkMKbM9IlqjWWrbgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406276; c=relaxed/simple;
	bh=IlGWCJT2qBGC3XXCJRsXxYfQz51Y104FxCfSOx1WSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRo23yFqDyocFXBSFLndrCjUAHvQRWIUEwi0S2hoc291RiufWgmwpu+9/ilQt/0Uj2t9C3agc2gBWhBnYyDUFHNxMssJPx6flsLSUsJArj9lW83FvLMWYwQn+fzyQHJ6JyCjb/Tucgzb1wm9cPcNnGPwogGUWhudhlJdIGw9TRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YaJezoi+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaJezoi+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so51040035e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406271; x=1769011071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIFLeU/rZDWgQfxqeduMgDTr6BnNNm0nr5ZzvbheRLg=;
        b=YaJezoi+mYDGJT4Jjlh3we/6zaOCxjJteM5f28YqUA65x8UARrqND6BHh7zBWM/Jdd
         TfAOkrYHk3sFCsCVJfr554K7Or0WzTxb5mYNjSSRSzsprX6swNMC0IVWePf9vuxO4ek7
         NBtiHQc92Y3E4WGeuGJUhL+MCEDV6dzzUEq3agNMMl8CB2zCtP99X9YxIC6IBSDgvYQm
         L4GO1bjxTuJS+aUOb+sqvAeU3w4I2Nb4bVQ/l27uqd05NKCLgbxhsKBvFbpyorYFn1WV
         VUziWSE/q2b1cyQi/cFzPSQ8XbXUKE6lx2h7xcFlTdy7Mt7azEPAgmgDB5/HLwWNFSEi
         YXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406271; x=1769011071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIFLeU/rZDWgQfxqeduMgDTr6BnNNm0nr5ZzvbheRLg=;
        b=uekrc4zz4aVParGifMarOiR2BQWSEWOBUAoibyGsXKGzTJlzdvzWlJ4MktHha4eJeP
         h2+8SgN65QzCeDWcp6O0MoMkKaHHSgfPSmmSBjdLI+OeUgOsa+xq29nkFKTGhJ2zgCEy
         D7Y63RBINOO7j0sVfR7cqS06T7haDpdONECG82KFWYbUjU/4JkTc/oosnRh8yI2rlLMV
         9ZU0e/ilV28azfthAoI4Dc2fetX3L5ljUFKk5ajI82yEXLI17fFlzX011cjDGtgvLKxU
         ZDqTXDTuPVhuxyTNDCb0LsXAHY3TTW9bQvRudl85K3Lx1lg57gMgyIQUv/DAQiGKQ3Sw
         2tbQ==
X-Gm-Message-State: AOJu0YyYt8s9Fc74BeJ/GqS9Qh7L3NlNlpNc5iTj1Yo0r9xWbAZb7I/L
	l1NhPpBPOVs572iaB5Nx2A05IE0ruQvbf/SbgTN0bl7uI5jnbnXbPkkQ4syFLSatXx0=
X-Gm-Gg: AY/fxX4ACB57LWcFD1H99zs7NrdorjTIqWjeI8LJiog8Apy8uUMmtqjKHcP1lnaDY9C
	f9Tux+WfU5I6vOROs4+dn2mVwKGJ8MZMLwnwfffG83MrXMk20H6+Jo9a4I+F3RYtM2tpPG2nliE
	ZhKs9V81fk6Iwi5OusIfWEjSFWXjdIMmHL9RByi7UpZewTs6u4Ib2BbhZ32E/Ua59mcNyxaqS3/
	TeDHXJuf9VfmSr75WmscDFOb7+m9NT1TXq2SF3s5L+zFL5l3XGtcqBrfYLqP77tjBBpzS6uGsDG
	e2fL+mf8suYULW/HKktBkcSOCla+qh6JHK4qbarklLu9yse4Dsaxv0Vbk4lnAhpPeowHuGm+CMS
	L9a89B1SP0eG9FTCO6RX+Y+7yDMDd4HCOspxruNN1ICECQ2KOKmU1Mk53ORh6P2UKh+T2OMFetF
	EIqGJ80e10jLVB2cjqxnAg
X-Received: by 2002:a05:600c:35c6:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-47ee3323ccbmr41291455e9.4.1768406271314;
        Wed, 14 Jan 2026 07:57:51 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:23 +0000
Subject: [PATCH v5 11/14] perf cs-etm: Don't use hard coded config bits
 when setting up ETMCR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-11-0ef97aaf1ac0@linaro.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index a49753f0d20f..f535027ce862 100644
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
@@ -484,6 +490,33 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
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
+	if (!evsel__get_config_val(evsel, "cycacc", &val) && val)
+		etmcr |= ETMCR_CYC_ACC;
+	if (!evsel__get_config_val(evsel, "timestamp", &val) && val)
+		etmcr |= ETMCR_TIMESTAMP_EN;
+	if (!evsel__get_config_val(evsel, "retstack", &val) && val)
+		etmcr |= ETMCR_RETURN_STACK;
+
+	return etmcr;
+}
+
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -743,7 +776,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
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

