Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341F342C95
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752806; cv=none; b=J1l1UTPtnfsX8PUmS8cK1MrKSk+/T5++f2x8uQCR10xySH8gTvs2D8/RbP0/F8JENi/Uw9jRwIgPSC+BHPYCQxqc1Zc1sD2UN4aFCTxcRNCSnL8bwXZKj4U2fgwp9CU1DLpeNqu9aHwL0ki8tOeS3C0kfoGIE9B/vdoSVUksl1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752806; c=relaxed/simple;
	bh=SadB828C5dPf0BWbY6PbKBHvcUIXDrqbiyTpXZ3dCN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTp1vH8HI2qWKhlfQMcBJZ9j1HkL+wNEVJvNyYAusbp3NpJvfI1sVIJpS8nZ9bcVVroKrHkga2tl5XUekCqu1XegO2LjKTa1EunfbMs/tVmenJZ69625uCb0hpwKVaHzFDPWr2mod+ck7Q/23pcj1U+r1UP1c18o/xX5H6MX1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RSPCrRHB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSPCrRHB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475de184058so20355155e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752801; x=1762357601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ib/m0uUPLSkVp1ZlpwY6PmfsEKy79muQ35cF6NAqDLw=;
        b=RSPCrRHB5/U5OvDCqgLLusHzhCIX7f79XBMi0I7sn+3K7R33FdGHFy3SblVdMzxenC
         E+/EmwIrSF9MLIHJa8ydWdlzZpw5TlPzaDbfHNiD3LC4wE8TCyHBEBVpMIOIQbqPRoMs
         QXvBYbpwuf3s/n0ORLyMsfn4TorSTzOpVi67nP7rtxLGfOh/ruF6V6Lbmr++mvW41YRd
         Vkd4FRGJXYuQ1wrTnW/P0sHr2bVD+J/WjjhbGGpGN3kf6S1+Wa9yozE9XcIZY0VRifgP
         5pXCnb0/OT4FjcmOJ9NaATgnEdOn7dB/N6uHxrbpBHoaaR8gf988b4vd06fhnVRsLyMb
         hEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752801; x=1762357601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib/m0uUPLSkVp1ZlpwY6PmfsEKy79muQ35cF6NAqDLw=;
        b=n/ESGSSUv8F21E84Gvs8UuOsRXtRuS1qoh98Oj3vimshNAuibGuM3fvILjo6IrqQa+
         HXGMfQnDvOorPo2mW9ubd/6DEaGY8xd67/oXy64dwZFyt+qmiglkpF5MeJPZaSibUGVq
         wH50S8iyLuwevUCku8X3PqePO+enySlZO1AAI4Z51cuThbM2t1vkIdAQ/IEqfNEkNTYE
         FIRz7DgannxDpvVepQTTEJHutkcuQqp+SsM2WO5KECeB0AhBmtj0Wvmp2OvVSgC3dshx
         VLiZh2wVTTFtDUPROVpVyOWwD1xBtMTFhuE0Tbzhb8OHMVxaGniu5K74SChfpt8zBFUD
         RGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpoDzkONpFgaNlMc6TudlQEhWWw22/2qJz1F8BE5XWonbjaCz9mTYEKnTOuGP7rjNRYJMEhJFHFsVhW8yOSfw6@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8Yd7pXJs0vRKfITrxKmFv204rO3DY6m5Hmm4MBjLYwgd1S0f
	rbkl9PE/imVT2vfNTpkBye5vTBpzhuYN9JzmBCxXPibXK0cSmoYQJej+SLfA/LqnyMs=
X-Gm-Gg: ASbGncukwDfkFyfizqiW3jPSle/DKUPohN/8IwUUNhogtT8a0LXV2Q38S3p6LrESo6q
	ZoQBODkXMxxOgc+I70ZqvIBClg6BXHk+65sh34a6xunKzAEAopQgd7vOhSUF1bJFjna3a90k8Rt
	JP7rDdarZAWo9LHiKYLdZyAlpTZX3uDEY8P00xlz/ZGkoopoFpWjbJ3V7hl8QHBfVQ0IMew9ciG
	/hT7K6r6yPsJt7ppfdIoypqt/N3tVORh7xU/g6dX1uI/eiH7DibsZunies+1R2DdVn7ngKPacOL
	Rym4vkSKK1hOUfqluzr35+zLQ8o2Ab9y+h1aHYl5tKVm3I+/+t9C8xjVcqxlvnOmTVWRuIKFtju
	X8pg6qo4Io35gbhzVtvOFXCvphpZFHzhAxTRz6pTN4zQnrhXp8Ty6xfG4bDp5Kb21crr54xpWeZ
	yO5xfuIhs0SQ==
X-Google-Smtp-Source: AGHT+IHpC4zA9rHyOq1xNedwh/vBadqHyptjOa8+6vrhjj8123XYNoSFYmp8q1PCWiMuh3tVBr2dqQ==
X-Received: by 2002:a05:600c:190d:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-4771e1ccb50mr30318945e9.22.1761752801364;
        Wed, 29 Oct 2025 08:46:41 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b9994sm53745535e9.16.2025.10.29.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:46:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 29 Oct 2025 15:46:02 +0000
Subject: [PATCH v9 2/5] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-james-perf-feat_spe_eft-v9-2-d22536b9cf94@linaro.org>
References: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
In-Reply-To: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
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
index fa50645fedda..617f8a98dd63 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -87,6 +87,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
+#define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -252,6 +253,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
+#define ATTR_CFG_FLD_inv_data_src_filter_CFG	config4	/* inverse of PMSDSFR_EL1 */
+#define ATTR_CFG_FLD_inv_data_src_filter_LO	0
+#define ATTR_CFG_FLD_inv_data_src_filter_HI	63
+
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
@@ -268,6 +273,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
 GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
+GEN_PMU_FORMAT_ATTR(inv_data_src_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 GEN_PMU_FORMAT_ATTR(discard);
 
@@ -288,6 +294,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
+	&format_attr_inv_data_src_filter.attr,
 	&format_attr_min_latency.attr,
 	&format_attr_discard.attr,
 	NULL,
@@ -306,6 +313,10 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if (attr == &format_attr_inv_data_src_filter.attr &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return 0;
+
 	if ((attr == &format_attr_branch_filter_mask.attr ||
 	     attr == &format_attr_load_filter_mask.attr ||
 	     attr == &format_attr_store_filter_mask.attr ||
@@ -430,6 +441,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
 		reg |= PMSFCR_EL1_FnE;
 
+	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter))
+		reg |= PMSFCR_EL1_FDS;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -454,6 +468,17 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
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
@@ -791,6 +816,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -866,6 +895,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
 	}
 
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		reg = arm_spe_event_to_pmsdsfr(event);
+		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -1125,6 +1159,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
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

