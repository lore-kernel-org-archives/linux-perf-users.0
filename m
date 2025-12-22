Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF6327C1C
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416502; cv=none; b=K52ce99/1DgsqZ1GIAcGHVemuRDVJb3MKy1Urg62/d+Rj6eMTsxjIn20CcQSABzoWAwGjKoR3rh1/LvCvhL2096iMfuY1EYs943vLquJFTuwmumoNplzNge4bkxI2ZTZXpqobqPhWTSCONUo8J0CnQEAW22ZCkuMDp71wx/600w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416502; c=relaxed/simple;
	bh=IlGWCJT2qBGC3XXCJRsXxYfQz51Y104FxCfSOx1WSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJXVRYtFg6Px/JE47kBdEZdym68PiOghNOskUBDTYLtfzn0AwPiMgRPeWy1hVlZb02VoHybQkCm36V/G3Q8qM6nv3rRLiav/wPYP08KgP8B0fiM6Zl6rSH8dmjM83qt6xE4jaUoAQ4n8zIetCGMn8EtxKFf/yTHuiKAUXjP202Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DlAIWigB; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlAIWigB"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2143497f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416499; x=1767021299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIFLeU/rZDWgQfxqeduMgDTr6BnNNm0nr5ZzvbheRLg=;
        b=DlAIWigBu9MPEJJzMjgN3e6gqAd4lY1P6/Xa+Upt8slPh7i1T6wCBq/JtYsEOqypSA
         5soyxmWwxJxmErHxmpsYJwhNobvMDa3jdWK3vz/mpeNtF/PjIStpJoyBTQAvqOo0vlji
         rBCw4au6TQswZPcxVmnhDaOXAH50eoJEX99W6GSBcSD13MmITs5Bamd670yvSjSAow6G
         hqYVLzATB/+jPMtuF2588OFaGkcvRggGb8MfVeDpbX+vyIQEoaLdg3RQU0y6Eclx3sLw
         mBKk2Vr7s+rUcdHhIvYEfm7Arf9Vnis/rOafmPYs5EaIrhqex6pfDI3PHA3TdWuSL/fk
         6pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416499; x=1767021299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIFLeU/rZDWgQfxqeduMgDTr6BnNNm0nr5ZzvbheRLg=;
        b=piylU72UBDl06vkJmcYo+Uq78wTF+CTZZsadQUjmKE0Hmml6+ybQDqLgmOT7THLG6L
         1MMsBXCZ6id+lPJOVG6ZCqQhdBogOiHmhrEsmjx5wu208z+9CsfqWZbkBN8257owoRys
         7uKOCSuEMEwXkpRZqMZWk8BFxPNAlnFSX00jrhHK9fSDnWz6aBjXdzY6inNUCLkwimI2
         Ucr7L06MmKf7cKtCvgEY8MGKjnWBvDKAk4CDsawCBVMZ2OrF6MlyKYRpmzOFbiGMFuxx
         HHYLTCySpQSsaa0BR3SlYJRd7OrvYz7gI8N9pu87cJ3Lr27fARJmbCfY5tVEp2Qh75bs
         tFlw==
X-Gm-Message-State: AOJu0YzJhmKFq+y0GB33ocH0R9tFqxANBOrN8ZjOFsz+TMqsuL1ByxbJ
	NckrLGbr9a7xJtz+A0fzi2sK8Hxg4hL7ARuq+VNjHXPOSBk6JEa0zXogyFFjoWEo0is=
X-Gm-Gg: AY/fxX7xVlEgbGJTzlOwGNp/MOtq4Cw1QzG7N9zZHPTRe+T5joqLHMiXaI8kBPDHOte
	S2FlrcQW8JdXkRxFg0dUpoaafW9TmLeFQW1d1LI4riXsGgCTlsvr2JBbghJWXlEAHGaistIc6Yf
	dd8AW9WD3L6SsiBl6+4b6gvPvfo0hXK+3NkRESf5J5wjO4F/+gauobGUlvj/LcglDWpS765R1tp
	Mzv8dcFo8vKyLVZ0A8CQhUA2NFrQ8N+Kj5wACDheu9TjHBkGcgEHcLFyaQzkfrS+BA9ou+ZUzHS
	JIQO2Knwx2gez6VPOiTvDg5BtvYZPld9VS5ItLtZHQXa0ie+kvMRxjGurtqigRasf1pGzEWA0LD
	PZtkmIyp6MolmNQ9nm7LdVkIqhpPZU8ls2xm9DmY3761sYUPKtVVMJxdgSHQv0nkhhJAANQU3+/
	uOP3aITN8/MzpTeYQ63eXM
X-Google-Smtp-Source: AGHT+IFsoNIU0EBEL2Gy8nEZDRr2zOvkFn21BezY9JDZ5LUC88dlX4X1p9ulUl+LSAp548pvzltUbQ==
X-Received: by 2002:a05:6000:2387:b0:430:fdfc:7dde with SMTP id ffacd0b85a97d-4324e4fabe8mr11530837f8f.36.1766416498814;
        Mon, 22 Dec 2025 07:14:58 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:36 +0000
Subject: [PATCH v4 11/14] perf cs-etm: Don't use hard coded config bits
 when setting up ETMCR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-11-0608438186fc@linaro.org>
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

