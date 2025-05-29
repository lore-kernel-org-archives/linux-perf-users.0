Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3928FFCA
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518404; cv=none; b=a99sZajIewAU7Die5Iio6SPgNGWqv+pJhIhOWfIq2CfbF3msdV5m7HitQzIjyy1wq6Tx4ceNBZjTrypwW6dmjzGf0/OWcI4e5X33ashzer3O5BRppFDoKJqUd9baO+ziMUb3QcYYGaeKeu1OqWDFGHFE0y71usfYOjZoeB7HCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518404; c=relaxed/simple;
	bh=HnsvEDgYCsBo5G8yWPXIzHJBnobLrqsoKSo90S0gH00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzuxfUAWiUbfNe3/PwqqrGcfiWj0mQy/70bMwGQJJscRG6KYGhKVxkCCAGWf7U+5G480lNGwKT16aacKcCBiHlXCJpvzZiFLS6vNgPHxyWHOhVSKle+A9XkPc9S9AxUgAWv/tgT1lSRQS5y9xsDbv6Akt0RZywC1QjyMzWiqLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rdp28b7H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rdp28b7H"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441c99459e9so5694625e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518400; x=1749123200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFtizqLb9AdbPIP2xG9Ud/C06SCBb70bCrr/xyknRBQ=;
        b=Rdp28b7HcAkvssTGXgXyzf2eVf1cL9h7/Wmq32rf10JmrnUd2ZaD5Sue3+jLYhTIA/
         FNbWUUrmlZ+OYVqVZbuiHK/5Wmcn+iefL5iJT8mbFkIRvkQn2cgIRYceYTkHRPpyLR9l
         MUrbpPtv4Spkfxv5uGyoC6x9qsilvpDMwstogmfTehKI62Eyqovr8JAnYbRDxk/SSuQT
         hBwcqNdNkCQkolxjekFjutKn34jZ2PHcWROZBNN+K+TEl+fVFYBwTex7ZlsrM/h5Nm1F
         Ya/ulLIaHWfEiZqpepY7U6MeBWuWuZRWGbOQMG8eyYPRujwJNcP8We+8G+s+hcqMIqnU
         83YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518400; x=1749123200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFtizqLb9AdbPIP2xG9Ud/C06SCBb70bCrr/xyknRBQ=;
        b=DIrGP8INTJaYo5OTQjwKkclBCi4GYCAgMJB2/WuEvfMz3vFAv03KmVoTbs7ifcIlra
         ZH1EtSwxXs3kxn9KlqLcOVkzpFx6SgAnVCoSNOFIbxigNWd5IkA8VyXgmr3xRjTBNXMu
         Dbz8958dAMs5SCKx4ZjLc7zssO0PpEnZrUK+3fb//PrIfbv6fOgExiAFBvfS885PjYJG
         vhBcmV0/AL35r6M8jz1R24ZRuNx1avR6SG8trvrFqZ/s55O8D76x8VwJX2x/sJjLAlHD
         D9Tr3w5iW1SKu/ACLXJhbBU5eU7Swv18n6b49C6hZ812xkXzlhnhpkR41AEuX79e/Arx
         4RBA==
X-Forwarded-Encrypted: i=1; AJvYcCXw0vxviVvXLS/PeBX8gHq77H1nRyXFTb8tMI9eVv6Gh2wOPz5UbnAXwna5psS1WCddKUdadahtmQOssxysQTIc@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBrFg8mZ65nxDdCQVCszHeawbQqLYiBkcztR7vxbU7p1P0DZg
	tshTDjhNhTR1lFgGMRKs8nrgamMckuXbCWbO+tstFrFBzoADIu7F8VMIBegLrIktKoGxTH+8M9r
	V5wxLYrIDsQ==
X-Gm-Gg: ASbGnctDzitTl+Wmc+5JWP7tH8tsaBBtbXLIBInHmmqOrBXqIcBL9EIeyJNRs5HHlDi
	w6x6soNV7jjxwozGL1b4Vf/WGOuq7skaGcwMl0pCkp1DukhN3MVWEAigu32z8q8ebTy13EykRjg
	3w8fwJgsmZvJvFFFReRKjSZJ7qVeZcKRP5sdGXKspgMVFqvn5YiqOe8+biixmjanE3luMxHrvdD
	n4omrLVvz6hbz+sTRY3fnI7DNfg9JvkVl/jS7Q0MVY2YRa0lMPFU5nwzLWwPwRXNhYVlOXVqw6L
	nGfs6VFFe5fW7hUCMvVSv4kR/hN4czeuLer/Ep7//4MgtDE724/c+lApaOzh
X-Google-Smtp-Source: AGHT+IGimy6ZJ9K4F4atDZc7N5EcbAuC+37QDbioDnIXH/PmwoUz6QxTIrXaAGlqmLwxYEe63f5+gQ==
X-Received: by 2002:a05:600c:810e:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-45072545a3emr53537625e9.5.1748518399707;
        Thu, 29 May 2025 04:33:19 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:29 +0100
Subject: [PATCH v2 08/11] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-8-a01a9baad06a@linaro.org>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE_FEAT_FDS adds the ability to filter on the data source of packets.
Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
when any of the filter bits are set.

Each bit maps to data sources 0-63 described by bits[0:5] in the data
source packet (although the full range of data source is 16 bits so
higher value data sources can't be filtered on). The filter is an OR of
all the bits, so for example setting bits 0 and 3 filters packets from
data sources 0 OR 3.

Reviewed-by: Leo Yan <leo.yan@arm.com>
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

