Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1F1BE251
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037081; cv=none; b=Q3ZWp5bk6bpdwfnJCG6HDS5pDLPEDGOe5lU9c2pywi6q6tY3hwXcfC0FiecDl8eiwfP+2UO4c5vG9LRvYMs9bkOeKE7vRak1UUNaNIhNRKGF/Ee5OxxcjlmpA/Ab8rMeMZPNGVnsPod4gmAvmdA465Z81BAi7IV8Nz1qkRGD0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037081; c=relaxed/simple;
	bh=yePtXUNb/r1DdBXxhuOfkHvg5tUlHsFB+j5qY2RIjQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/dcKJTl1ZiXlbOBrhlQ/A90fc1t0SC4uy7FjDV7m3g2jHDyh42JNFpN0DYRawkkTIPodLpBQ8jaLmwGk/Lvi2wHG1DgtQAEBPTuHmE+mU3MORcbS+d0oSXS5mUYJrv+9mXtlfqV6DtXD9K5NT45uhyxutXSB+PSg809HvPJL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxuGCt3D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxuGCt3D"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so49401425e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037077; x=1735641877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHAl/iVdRpFZ4l6Mby+FrJoyVvI8kLZuzTqR3xsa9gY=;
        b=IxuGCt3Dft/VHOLVlwvTCINTchX00rrdcGBrraTBOfGlRKdSlaSWRh5wFq4rd07AuZ
         VYr6Nh7j9XPRcy3908huWVbY1T60dNzv9CcB/uU0DCfeNClGKUmOdpDcY9XfgcPajNPp
         fpLrci69bvlmeaNTE8BusNeLBMm50I0LMqxT0NH4TvK74S8eolRIuVhZ7k/3YdRhxHwm
         l7H2JnjrL59I4sooz+7AOQUuTODecDO9VbeIhahhBVETfcE5ikDmu9UDYIBvAG1OflqE
         wr4ULejftyyXi7p5GbT3KxViGuLmXLaYeu1ToVuHzDExiLKq8Y9mJhAXHNX+EmGWmyiw
         qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037077; x=1735641877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHAl/iVdRpFZ4l6Mby+FrJoyVvI8kLZuzTqR3xsa9gY=;
        b=I0ac7FpF6dcqFrYRJLqvCJTjKk18Fg0+Qnv0vwZoywre9eDlO1TRisjYwRzdfhX9Qh
         Fx3nLByeTj6UKvaDjhRpJHHhQODGbstBB5LraQFmYQwOsJe3UacPXUtyODUNQa3bVNqR
         /dOLVevid0qmWhm9TZNekLtWqYyZEqd603sFOBgACurYhheCLEv4IFCnK11ILykLKcHl
         3GXRw5KJFYvR63Xwdftp7s7UHdcL8aKfX4LsGZNa7jgicJPzTDz0Xh2rqves05zWOu48
         yLKkcqu25459oSa0lX+SnNyfpfpAsNFfRfotrYZrcTJGnuAomZz7lZI15nam2EJFZ4Pw
         0ZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU8wMp2YhqMHMteV1x62sSy2RdnflOUNq9Ye81uREA3zj0IoHWJDXFDYa7N9MFOr9IUZHzKSpgVY1zfytzAifM@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJ4kELtfdn71UHHHWOyjF0xYM2fPqaj8WJ3dUMSDUote1FeiB
	4gfmiLqDMSvKVRnF/CO8N9pQofi9h8E3ZkByUXAwc5AhFJ/GvEojRrt/P2qkW5I=
X-Gm-Gg: ASbGncvy57YNGldn6VOdOMSTo8FHNNxZmL4Xk3KtlKf0eJ+I0+6Bkgzc7MteyL93EkZ
	T97ruVuJgBEs36Dri2DUhk0S36O4V39+pQdD+STazPGhc8r/ta8U0I0OUhdKQIJSiSzXLFwjfvh
	FWbj0RlBM1YOT+nyuE/5HFmul8FetUEpj5Q5bmo7YObewsWJhJWGPfLlScwgLBHA0/msY92ljzR
	j6qPRkVqkF05+OZ1fkq82Jw22PenhpU8tVSKIa31+iVGaXXgwURVUM=
X-Google-Smtp-Source: AGHT+IH7n+am9veH0sjuso0VQt6cOhLb48Ywipt9+tQpA2guKm2WC+9l0VoxKlK8wBiZB7S6GwshiQ==
X-Received: by 2002:a05:6000:154f:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a221f698amr13901717f8f.17.1735037077544;
        Tue, 24 Dec 2024 02:44:37 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 1/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 24 Dec 2024 10:44:08 +0000
Message-Id: <20241224104414.179365-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
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

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..9aaf3f98e6f5 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -193,6 +193,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
+#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+#define ATTR_CFG_FLD_discard_LO			35
+#define ATTR_CFG_FLD_discard_HI			35
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -216,6 +219,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_ts_enable.attr,
@@ -228,9 +232,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
+	&format_attr_discard.attr,
 	NULL,
 };
 
+static bool discard_unsupported(struct arm_spe_pmu *spe_pmu)
+{
+	return spe_pmu->pmsver < ID_AA64DFR0_EL1_PMSVer_V1P2;
+}
+
 static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 						  struct attribute *attr,
 						  int unused)
@@ -238,6 +248,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
+	if (attr == &format_attr_discard.attr && discard_unsupported(spe_pmu))
+		return 0;
+
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -502,6 +515,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
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
@@ -743,6 +762,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	    discard_unsupported(spe_pmu))
+		return -EOPNOTSUPP;
+
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
-- 
2.34.1

