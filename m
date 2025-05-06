Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869C27C872
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531766; cv=none; b=ocl0LNz8qA2GYrPPXTXk6MyrbhmgTEWWNa7SpwmKWkfCK8kX79cSCo6a9z0Im935IeUVftUsos7HYwMViOIrq4WTMLg+z1t7xj3mGF7GIxzY7S0OJzYCeIwVSVfisa7nG9HTYLp2nfS7a1T+GaFcqDP7EeV3TtgpeTpPAhcWqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531766; c=relaxed/simple;
	bh=65WNjh5z2WnExcihMO64dr2NcDoeIVLE/pLpYlBMNhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXc1rAG0arNTlvTY9JLFt3O+NVZxhY2k9/y2cunFKeiAkeEmHZsls2sbYUnTHZfuBJKVA5AVlQOlk/dGLpCXVyKTi+cwWZN+NO78u547dzf/MWRAn23TTyKRT+70dEjVPiE4a/UzhUQUmuMG8rZ4nny3FrzCN9KbIohRu2ZFZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GM1lZc31; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GM1lZc31"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so269890f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531762; x=1747136562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjL0Hshoir2IbDDqSPKjm3LlUhn+PZo2xvFHRbzRL1w=;
        b=GM1lZc31ZldLKnf8QrBtn4EPGJBtvDX8LkWFhR5/aaj8jZ1fsSEaKn55r09liZk+Yu
         RHVJjSVgYwtYeYD1DQiqc7xv5huqIv6CjFjcVAhbQmKhVMJ6If59cex7LXcdLFUj3A6e
         GflzNS9aiUofraGIV9hMByPF/JHUHEcM7AWi1GprnU6VVd4nt0s7Ej3y9OXdpT/qf7gY
         Dia6yIwm1ES6lfzNuc+QNQ6XyjUwvzaOk1NNyliGI7eyt0F6AlvxgmzLXE1utMemoTB9
         84701KPT3AEsZeQrrVr6ajtSPg5+CG+7/7wy1/KqH1cVTucSIDqaQM6/7Td+uXgjhTjH
         qLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531762; x=1747136562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjL0Hshoir2IbDDqSPKjm3LlUhn+PZo2xvFHRbzRL1w=;
        b=uSBz0JWR3otX9W95s4uzFBMOW/BLOGC+2OTTGSuBL5rBUaWpMeuM88Z7a24k+w3fbX
         unHCtuWG1m+vbXzrCoCXZGOImhMkgqc+CZ/VKBLjq20ryDDIu4QPrYcTbI1Bu/KycS7M
         Gmf0mqrZaVMSJtjjqGmcHNf81ctpLyzEJo40aSDTKOsNi9FPrhWuzCZPPjptj7wD+mB8
         VaLA0ujjk1GzX4dJHtWeTEpdnI5fmJyG9PLbzdp8aFuA65+RAiA51EMmd5mO0ihH/8wg
         dph9hcO1+QX5ov/TVT6G6dVWQqfuwfdfQLNxpkdmqSLFkkIKDhfW9fTLs3kJ5BlbB3zD
         Yu3A==
X-Forwarded-Encrypted: i=1; AJvYcCWi6bAdWfZcA3HzQUwXEUUwoRaBwFEiHL0ysun/injNoxKb1hjsIE4CdhLdU/1Bwr0YyPacXr7eVuz+h6HHWDi/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80o8s80o4T0VmVP9BjeuD7UYMqCk3MdNes4IX2qpTvX2hwPyL
	ONLLvdvEKuaQOhcu542RbTMB/EJogiHnOZXjAt/VA5LXFzSgY2GX6jzCbH2ENds=
X-Gm-Gg: ASbGnct5ENcYscwmppkliECehgEtc+r+OPxZXtYNBIZWphgqErYXGLFRSqJMrD+qATG
	XtPt+OPN3F0o32PULD+fVnVR/rFEsbMPXLnwnnHmSsSu6cwAZEa9NZDdiAyvnuDac5noptMf0dk
	QEogkYfMFmyEehhNOJq00bdHIrPoZ4JK13tx2MHIvTzXeYDhj7vsYQxRdnqLHxbRKw28qy5cKmy
	RYum0G/12dD3LQhJedVKe9Ifzuu7rGuXEZLFO3jyTSg++As8kyk5QyXTpvAjp/1pDzfb/txdY1V
	j8Fc8aE8kt/BhyIgv413ju1U35Jrlj2aK4CbVUH5g27zUiY=
X-Google-Smtp-Source: AGHT+IHpWiyRrtD8sJFVaNpdcW4rw8HMIdjnVXkaf7syZm/CG55NgxTsXPzAr1wt+ksksXMoEAx3GA==
X-Received: by 2002:a05:6000:1869:b0:3a0:9f24:7748 with SMTP id ffacd0b85a97d-3a09fd7a70fmr7363837f8f.23.1746531761933;
        Tue, 06 May 2025 04:42:41 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:39 +0100
Subject: [PATCH 07/10] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-7-dd480e8e4851@linaro.org>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

SPE_FEAT_FDS adds the ability to filter on the data source of packets.
Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
when any of the filter bits are set.

Each bit maps to data sources 0-63 described by bits[0:5] in the data
source packet (although the full range of data source is 16 bits so
higher value data sources can't be filtered on). The filter is an OR of
all the bits, so for example setting bits 0 and 3 filters packets from
data sources 0 OR 3.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9309b846f642..d04318411f77 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -87,6 +87,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
+#define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -232,6 +233,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
+#define ATTR_CFG_FLD_data_src_filter_CFG	config4	/* PMSDSFR_EL1 */
+#define ATTR_CFG_FLD_data_src_filter_LO	0
+#define ATTR_CFG_FLD_data_src_filter_HI	63
+
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
@@ -248,6 +253,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
 GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
+GEN_PMU_FORMAT_ATTR(data_src_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 GEN_PMU_FORMAT_ATTR(discard);
 
@@ -268,6 +274,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
+	&format_attr_data_src_filter.attr,
 	&format_attr_min_latency.attr,
 	&format_attr_discard.attr,
 	NULL,
@@ -286,6 +293,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if (attr == &format_attr_data_src_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return 0;
+
 	if ((attr == &format_attr_branch_filter_mask.attr ||
 	     attr == &format_attr_load_filter_mask.attr ||
 	     attr == &format_attr_store_filter_mask.attr ||
@@ -406,6 +416,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
 		reg |= PMSFCR_EL1_FnE;
 
+	if (ATTR_CFG_GET_FLD(attr, data_src_filter))
+		reg |= PMSFCR_EL1_FDS;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -430,6 +443,12 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 	return FIELD_PREP(PMSLATFR_EL1_MINLAT, ATTR_CFG_GET_FLD(attr, min_latency));
 }
 
+static u64 arm_spe_event_to_pmsdsfr(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	return ATTR_CFG_GET_FLD(attr, data_src_filter);
+}
+
 static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
 {
 	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
@@ -788,6 +807,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsdsfr(event) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -857,6 +880,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
 	}
 
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		reg = arm_spe_event_to_pmsdsfr(event);
+		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -1116,6 +1144,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
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

