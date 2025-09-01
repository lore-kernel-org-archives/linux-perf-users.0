Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133F3375BA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730525; cv=none; b=lsZW/OUNVl4r8NmBA3VUmHuch2WZkMF8ddWmfMwZPv8j20R2cvcK6Eb43CCQAaY1U23YVPrzbFUKHTXq5FI+QRQ7olqfzayeuolVLMJ3iquHp6UXhOWAoLSCNfEldlwTTM9dXOihw04qNYTE1mVG3MyA/AoGI6CXJZ+xh7yp+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730525; c=relaxed/simple;
	bh=RVZayCp5OixCPVRZdJVQFNOqw4c7KtixASsd5Xntv6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBqJHWmjHHenh4r4rru/1we+NR5Ppv1gEvZ2xEtoGsnVk1Yz/pW01Ukb7S2Pk9Neew1X0HRXsUx9BLr0LLH+bqXJ01ybR5EHkw7ku2VHNgsEG6tRFh5LR0dKDAvn+6CEXFsVDjiFJYDCO7e8R3GW+xqRx1RZLfICKD9VpFPjsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGg6Dgzr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGg6Dgzr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b7d497ab9so37221375e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730521; x=1757335321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gYBkgwI12gbrT5fDRBP0jl2MaqA4H2/njWa7gROlbw=;
        b=JGg6Dgzr8QenlZQaXSCa3yYHRp2AaPCAzXqBuifGfnEnjcwuxnzCH2wtdJnGwRxMbT
         Jy/i0Qwc3wGpMuGnWpBIRbOblBHLie4crYsxwEotQEvryGXDMWmhzF/jJtUD+2k2d/RH
         tESdSYU6XNs5TJTMnmsVKT8pvQAiqXrXHqfnmrNAj8AlEzovL3/k1oS0tTuEJfJnMv4l
         cdB0FkV9XQcT+ngfFE93TWbyQcU1Srgcu7u0Cqgq5qnUzVLQkotc9EHrhmKiQW6Ea0k4
         n7rvAbzM1oDqDZvE1j5UomXp8/hl/xULe53bRlLy07rePqAvhJZLbS2yvTUob3ackGlC
         CEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730521; x=1757335321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gYBkgwI12gbrT5fDRBP0jl2MaqA4H2/njWa7gROlbw=;
        b=ObichYH3qFTU2CGWdRxAxQED+muLJ7xwSxhUev9ogFsyzTZ4ox2bskFLsVwg+Wdp9E
         4DfrDqRTfeSJ4l/rpHl52r4CARKVRw9222vwfMUpTX62fq4MkSF0rZSEX1YolvNEIvN0
         25XeGn5AEJA7Goena609eTSzZ66oDkjBbmCD1jRq/kgsx9116UfQ0+rkxxG1fKkQ3GUr
         Wihog9yJ+71IZNcOGMiP6zmRmxDZ9ckvS4z8xBzgFibv1pt4LF7a1BFC4O31lQ3HIp/C
         mzhm0ZO5ndKKyKosdIWK960qx6x6+tqtKFST9RI9pnB1b0iOV7O+rwRZNGXoxjk3loyW
         Ip3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhVo3eXAg8Kl4vNrR0qfOnSSpnXH/PttIX/cOGE7LQuG6BX1wH5jqbscWLK09yBU5vhkP5fUghZR7x2ZeayD9W@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnjXY0X5XLErSnam2L6DVLMpXkga5e13w2Y3vNLe0WxdjapDy
	rgWI7wLSXllrimFYemjdfKxa5KlMxJvWjzwpz/KCq5MC4LOcm/3Q6Vbf/0xCuywqGmI=
X-Gm-Gg: ASbGnctQuBwmU4498hfIe8fK37DleltVJA+pEmoJIg7MWo9i8ViN/qfC7wrjjtpwNHx
	q9GMS6JwJSsqEH/HCYDnuFjbPzRi9aFzG/upppznbJ4tX6Me/SXhyQ81FLH8fnDlv9F5Nu+A3WN
	YYqBdRSOp4019SbIa7908GEbZSozXLi7ODRdvbwMtTl+VQmEBaDSqHnSPyTZhmsMqlUV54Oh8rk
	eXqIgsd/YW2TjIVfjSc98LmhV0rojn7jsG2sjJOa1bm8tmzQ9AbucfxOYDenP+Xgn4MgFAKTFFv
	97QjRUgWCxDXBxfUdYgRMO2S/N45iWJeJAo9OPm5p90y9szATvGx2DFfVn1Eltyv2BPZBMsy81r
	jhMwDJLC0XBje1OHukNi4kCRHLz1hvJKzsuLSwMg9XQ==
X-Google-Smtp-Source: AGHT+IGtybtA43LzaX+nZGwbXW5Im33x1sTdapVn9uZpGYduxlJ52+DycNYLVsJKQ1mPUhW2aRJdHA==
X-Received: by 2002:a05:600c:1d24:b0:45b:581c:ad0d with SMTP id 5b1f17b1804b1-45b85550679mr68872005e9.8.1756730521322;
        Mon, 01 Sep 2025 05:42:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:42:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:38 +0100
Subject: [PATCH v8 09/12] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-9-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE_FEAT_FDS adds the ability to filter on the data source of packets.
Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
when any of the filter bits are set.

Each bit maps to data sources 0-63 described by bits[0:5] in the data
source packet (although the full range of data source is 16 bits so
higher value data sources can't be filtered on). The filter is an OR of
all the bits, so for example clearing bits 0 and 3 only includes packets
from data sources 0 OR 3.

Invert the filter given by userspace so that the default value of 0 is
equivalent to including all values (no filtering). This allows us to
skip adding a new format bit to enable filtering and still support
excluding all data sources which would have been a filter value of 0 if
not for the inversion.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 591f72fa0327..e5b36ab90786 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -87,6 +87,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
+#define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -251,6 +252,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
+#define ATTR_CFG_FLD_inv_data_src_filter_CFG	config4	/* inverse of PMSDSFR_EL1 */
+#define ATTR_CFG_FLD_inv_data_src_filter_LO	0
+#define ATTR_CFG_FLD_inv_data_src_filter_HI	63
+
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
@@ -267,6 +272,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
 GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
+GEN_PMU_FORMAT_ATTR(inv_data_src_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 GEN_PMU_FORMAT_ATTR(discard);
 
@@ -287,6 +293,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
+	&format_attr_inv_data_src_filter.attr,
 	&format_attr_min_latency.attr,
 	&format_attr_discard.attr,
 	NULL,
@@ -305,6 +312,10 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if (attr == &format_attr_inv_data_src_filter.attr &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return 0;
+
 	if ((attr == &format_attr_branch_filter_mask.attr ||
 	     attr == &format_attr_load_filter_mask.attr ||
 	     attr == &format_attr_store_filter_mask.attr ||
@@ -429,6 +440,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
 		reg |= PMSFCR_EL1_FnE;
 
+	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter))
+		reg |= PMSFCR_EL1_FDS;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -453,6 +467,17 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 	return FIELD_PREP(PMSLATFR_EL1_MINLAT, ATTR_CFG_GET_FLD(attr, min_latency));
 }
 
+static u64 arm_spe_event_to_pmsdsfr(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	/*
+	 * Data src filter is inverted so that the default value of 0 is
+	 * equivalent to no filtering.
+	 */
+	return ~ATTR_CFG_GET_FLD(attr, inv_data_src_filter);
+}
+
 static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
 {
 	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
@@ -790,6 +815,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -865,6 +894,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
 	}
 
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		reg = arm_spe_event_to_pmsdsfr(event);
+		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -1124,6 +1158,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (FIELD_GET(PMSIDR_EL1_EFT, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_EFT;
 
+	if (FIELD_GET(PMSIDR_EL1_FDS, reg))
+		spe_pmu->features |= SPE_PMU_FEAT_FDS;
+
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {

-- 
2.34.1

