Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652A27602F
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652240; cv=none; b=JbocxGPhJBdIeY3jMLuOe/71AO8SO7nNo3UU86vSVzJTIl5f7VnKxmpTiP15Eo6xdsF8tjgHhPV6eD+7ZqiYn/Kr+lfWQVsSan8lFh/RbbvY1mynvUaHmjG78lgyZNMephAW1XYSfyE/218BKjULO+RB/cpJHROJ9tV3DoYeNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652240; c=relaxed/simple;
	bh=d51etX9Wtlt64/Vo/esdCKX1y9gVFH3rYLjiUdWOlVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAnDk9oY0jgRkP+TaG5HEZ5T/OaXK64Z2SqfPdkG/MU2a3UHarRuwfKuYcgIX2RuBvDpBDq13XOfhEV81MBXxLkMcHJBb++U06AuHJznqlkIKtzTZAOIEVqv5DxPT5/9CrgmdPxov0EB9mUz/WJ8VX6LNnwdAnBuBB2Q529Sbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jj6g5t8v; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj6g5t8v"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00339c8so12893355e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652237; x=1755257037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3kTEULZc8sJ7phkXJvTPn2PvqxIKdhSpNCE5Vha7IE=;
        b=jj6g5t8vWQRhb9y/CDxG9qtD2+rEDGFtaJjVJtaf+iMEUh/8gCgBMeSNak3eONjmAb
         eg4IZFj8DSRp3yIxxzwlLko6hV7ecWscvxWa/fJtP0GtKOuHi6G8MkNBks6dCCme/L53
         IMZWGgz9Fsp50I/WsIlOLExF7QZ31gY/q0Lk9blwuazaLLK87E+prvjgv0xAyA+scRtQ
         nAFkUF917208xjt9+JHQ23LJiYH1ewVeVQCrvgqoimKdBeu74bo7dbW0hAawqrbrRPrQ
         X8TDwqtJK77hZF7sYQSlC6/qSjXVGjRKXwRN1ZQaIqkKENX6xsgBmqQXxDBieFWzUfn8
         EXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652237; x=1755257037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3kTEULZc8sJ7phkXJvTPn2PvqxIKdhSpNCE5Vha7IE=;
        b=t5352xu2k0y+nBRZQIZWP56YyFeg9QqaYkIEn6rdKFmFplmfQ0t+n6KiV7TtS3av4f
         jU0Eo1vcAlqTDomzoEoQbgHaltxn5AMknFXFgxpB4xjfHJYvcO3mTyM2DeC6BObveUtK
         kAuO4H8pO3yXmojzmmiVs4cU8GPqRXOtrJr/23d6RkIXPrb9A3EASzmv5ttZrCyFGEXJ
         kdW7QN3nZbGEpFTigq5vZ4yhjSBPnV20A7eu+tF4H4svTHdXPup/NXOTClb3lyW9wu3Z
         TrlOZKmLZc4ynJxOSLEydiB6aMNm1L51qxAOycHJIoQuFbTK1xzcufAthtxsWLKsTv8S
         Y3mw==
X-Forwarded-Encrypted: i=1; AJvYcCVw4ySs8NHIRJHvkNprAJ+xnuPN7dCt9EFTJ2Z4Xxe2Cx06gjWu73d3rMk1XG1hh3zbgT5GvdJlOl/+CxRkuo5H@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmTMIVukj2/zzVuqPIS+TyC8Us8AQwHzbZad0Qv11U2Hxv5to
	nSgU6IGRi8ugxn9JBxSuoDMyIrv6+VE8uJs2KGTo0WGGNb+BsyZzdgSMPOVBm1dvCFc=
X-Gm-Gg: ASbGncvrUbNm3S/pzvOdB9I+S87Kp5PeJ2OWtqauaQmthy0Z92H7YHVAaH9adm53e3B
	0zP4hGzTXN+VhK0tc4M0sUXJtr1MAP4wpgU09zoW12Fp72zVZhlVnn9zkZV4/NPjHs23LOEk1s1
	o8ES6oxWx+2srLf3GfIcyJ31dFsTCa6NRerg813sNTP9jiBM/9QC1bneyXtzRVg2DVrqbk9tY9/
	R2yITOFmtnE5yJMJJGIwhBYt6zp2xA5pW+Lo05cGOuMX5zLFaFBV+oSfeyaU8vqp2TGC282Nsrv
	7gB7zjZvgIk4UNPczoxUbFqyCZPwdW/L5Vwo0kfZX8BIoaHLPgZoUnM6OLzMQEQr4wRfPHDZTHG
	YFUVBoGAdnqPkCkgpNxBblG+qSZ74Ot36JpUPRjW5Vg==
X-Google-Smtp-Source: AGHT+IHGDlpxTqvU8x6CY6HSrShTz3PSFbXeB0d760uYkAX/1NVAzKqdZtpMjiV1FNq3jgKsDT7ssg==
X-Received: by 2002:a05:600c:468d:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-459f4f98174mr23233005e9.19.1754652236850;
        Fri, 08 Aug 2025 04:23:56 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:56 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:06 +0100
Subject: [PATCH v6 09/12] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-9-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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

