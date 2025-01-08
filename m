Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EC1FCFDB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346616; cv=none; b=jXjKWnw66gJ/SxorTSlkUdtKRwdOHQxXwW27ZgnHAScioX/OPnKxSSxDIlWK/cEwVy8CG1n+Djdy5wg71VBD/0SHf1fmYs1gspRQAi6tEe66v/P8x8HOvuYRJvEXi7FeIDXEFryYwbmR7oTeR6Wg4WSJr4mNlExAvkOfnPuZfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346616; c=relaxed/simple;
	bh=kPHLZrDNKrarvsG+2cdGymsw5D7aOVxFWnWlmvzi7lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxT7CImNYP0+2JvQyTRTjZJ+2iyP6lPlcJbMjtNK8zYav6YHIkG02dD5zXJzzHzbakC55hiGrcBH2tQyyvYQ+sutzZEhq55QAX0mRa2v4OD5Wq2asibFMwzPc1KW+4w19wnSHVHpeFxa3cRGs3jBUsqZ48bK9Fy121pvhYsH67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoJQsvAS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoJQsvAS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361c705434so122045015e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346613; x=1736951413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGOb+QzXOCupJHbixt2wd4hm1wKT1vTFMOcKSfrV7BU=;
        b=DoJQsvASnWMFRujCq682Nv1wS1DakpBs+XLeZBVzZIOnO11iahneuNuz+LQQ0all5a
         M4vf1PCPhIk5gPA6rw/HxnK7qAWOSDHlAYzMWLPGqOmUIIM8u6DxMk+XBjInJVrfWeNp
         +OD/2BXrX2GLaCXfnE5DkCjgbF1ClEFMvwVhNR+gRlI+srrIYi3/s8ihFlHFbcq8h0Nx
         V7e9DGmSCQdEJ/XNJXH0AretZ2ExgW43MB8+cjduufxRbDB0LRFQs/PrvcU9YXY4WS5F
         yonCY01IskrQrOMH/2Sf5rf0XgWfQ6PHY/OiHoVleDIwF8jOOlvGgc1Qhj7mtcG38XuV
         p/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346613; x=1736951413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGOb+QzXOCupJHbixt2wd4hm1wKT1vTFMOcKSfrV7BU=;
        b=UZozstJzQCJZTZ4OyIkCQ6iRAh5e4BTAzSJgInrshGKDqt2jYll4Zro9jFijHH1iNJ
         iWiaL54fvMwEMO2Emj7D/gm7jOWz5O9fiJJpbPXNKbZntATN0YWdmxGqQaE3DibP0G05
         dApDW1beguTBT0v2oGoEpQ68Q7VMma/9+tHOw9pgyolTlIx5zDWFq4dfx2TCNq2LBzxy
         ADhVC2wryhfkGMHISXhhQBFlm1TBxUMeo8HbPE+GbnyQ6jezaFhA6eLkoqnI8LQI+CAe
         BGTQH7A5zHa9zzEeSwNAlNVv2YxZI9oTWdw5hMD3O26E4POA4MN9dI9l3kWYWBxXFhFK
         K6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW6z+6aw6vhmNka5KK2sTp8Uk6pibrT6odsdEe6xmTXGncArXZOM9krI+ms2b5Pnrf3PDecrMWhUwiuRX3J9HOp@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbAPTg+5S7yVr5xYgI3AGrCboNYZh/G5oW1z+MDzpfdNr/xyW
	PpQ8eoinv/RehSu6gD0/ZSJqSnUkpUr0M45aQQltoAMyDTiANxZFzpVGRFS6iFQ=
X-Gm-Gg: ASbGncvXehCoRJvhLR/KAh2wiFPpvzUJPJWQMJm/XeA9wm6XbxUtxV/mo38AoZdDFDD
	SoS6T5fllXNt6rB30U65tlFW7OyssfRKpIULXEt8K/15FM7PwIkJ3rO+j1EUTq9sHwBQXqoKzJ9
	ziRkbJwoqMrrrY2SfoVKcDsl0iMGNnrezVXvzF8SsGvs9b4VYMMXa9SyxGzhznnKMxaCkNIIIus
	p2tpvbH35RDG3RDbVMaIv/FBpM25lm+d+k1HOaCRUH+dCC4HnjeLDNT
X-Google-Smtp-Source: AGHT+IHN1A9cX6z/xhhtgrQjHkaDM0PpDq23z/ArfmpMTg/+JIa+MQk4qZUtvdK5AFfi/widPNwZ7g==
X-Received: by 2002:a05:600c:1d07:b0:434:9934:575 with SMTP id 5b1f17b1804b1-436e26a8f4dmr28940535e9.16.1736346612923;
        Wed, 08 Jan 2025 06:30:12 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:12 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 1/5] perf: arm_spe: Add format option for discard mode
Date: Wed,  8 Jan 2025 14:28:56 +0000
Message-Id: <20250108142904.401139-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
SPE data to be discarded rather than written to memory. Add a format
bit for this mode.

If the mode isn't supported, the format bit isn't published and attempts
to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
allowed even though it won't be written to so that old tools continue to
work, but updated tools can choose to skip this step.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..f5e6878db9d6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -85,6 +85,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_LDS			(1UL << 4)
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
+#define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -193,6 +194,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
+#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+#define ATTR_CFG_FLD_discard_LO			35
+#define ATTR_CFG_FLD_discard_HI			35
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -216,6 +220,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_ts_enable.attr,
@@ -228,6 +233,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
+	&format_attr_discard.attr,
 	NULL,
 };
 
@@ -238,6 +244,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
+	if (attr == &format_attr_discard.attr && !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
+		return 0;
+
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -502,6 +511,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard)) {
+		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
+		limit |= PMBLIMITR_EL1_E;
+		goto out_write_limit;
+	}
+
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
@@ -743,6 +758,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
+		return -EOPNOTSUPP;
+
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
@@ -1027,6 +1046,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (FIELD_GET(PMSIDR_EL1_ERND, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_ERND;
 
+	if (spe_pmu->pmsver >= ID_AA64DFR0_EL1_PMSVer_V1P2)
+		spe_pmu->features |= SPE_PMU_FEAT_DISCARD;
+
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {
-- 
2.34.1

