Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFD2D5C95
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102457; cv=none; b=onVn14lUMRx2AXNki0bfTAn0xyvqhBMEFOBI1f+CubnYNFrh9VuavwPYkTAYDiBipZwHFrnTKjNpVBaYr/yHjYJ08z+vBgygrawa4cSQQkUk53234UfOe7esoKb6eLbswzVOHCbftlpNl5yhteItk+lR1mYPa7ZJuN23YdFZ45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102457; c=relaxed/simple;
	bh=ioJvhXZDfjEQt2ziDmXFW0nCeOZA32fi0+BXFuZXXMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bovUPvlcn2yMZDD+/I3tSuWa5qArnDFFOXQfl/hw0sIzLsXPSZ9it8ICO/IkJc4IBUuq+cPxg3GVZl2auEIpbCvsczunb1hNCXwDD3XOt3cb0yE1uex4VbxVHruJo5SOUQUSDEdouNTzflZoU2nBHgBAkbq2kUdh+DBO5kfepaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z1cgsCi0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1cgsCi0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3474482f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102454; x=1753707254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=z1cgsCi0s6WiCo3cL702Oe6ZP+35NGH4GeLe+w9fvprnljAXgta7Uq4hutaJlBhu+K
         7iU3k4I7YUAvhvEDYHEvvQll++jZxtGDuiCbPEq5hFMTltnMFVuEky7CqcLSCRpz6wse
         w2Kvg1SWGSizxvhDgaCCX0ZCo/q3xfw96VojBgcoxlLg50EbRgTnhrVmEQlpDepjLyZP
         iCdQ8Ki3bCPlZoNNxnw8PSkxW+GV9jzzKq0NBsXtc0ul53jtFptcwtiSXjg5+2TvKGoO
         /z1I+yE2Cv0dKglgyBt8MNcADVPg54KgzukROjlWJS+ZYXPUME6Y8RJqbK54XHdpUZek
         8rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102454; x=1753707254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=JZ+8HEbxnPXsB75QyaTRnJAvaKpFPw6o38mzEYXO0E/3d4k7jJe+O/suXimpYwWQ6V
         oujzRL+a4uXZpR0Jr9G9vix34m3kAw2dSxsja8diLxuy+cpi5cjGhkDmUpWLUy2HOk6R
         Jvm2suiX3gdrzmB4mwC7wgMX8nT5stRTU4VqaB2JQmRPhIWmYOp9UrfrhUjiK8HYFIUL
         ZfRTrR8UzGbcy24ir8VcUW+YgntzoNKn2GFU8XnXPERgQCgUF++ZfrSWh9L1Mw5zN4E8
         m6qDgFisHvf3Zan241yK7OcGRQBSxnkAFSQLJd+HgdMFL3LGLVLO5Rv1F63a1B7KJ1Og
         wluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb8jo7chNR16tCgxr0MLLLzZyzIxyKMz+yQNGElEaBKERZ6FUvaCm4nW70/iVg3/hEiKZMkmpHk54OeePq9Hy6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EsZJ5r3CBpM8Mk8NIR8Kdl6U/rYcy8DMI0PWPyU0v5mY4BYR
	m91ovhqEaKdOPY/iopM96N9xiHZAybXchhgllHOvEvMpKxQRylyES/ebIvOHg0K7vNA=
X-Gm-Gg: ASbGncuctTSVBFfTGyoMG9dz+CDJBwEAaxoaU5r2FJRW55A5nYwOwkOpeAoxgcXJkRk
	sh2EUDctei8I17mcLXiyj/CiY9AKcSjCO+OOc/KEXvQV1+x2i2oADQHCGvY4MtnOXPAWx50rRTO
	G0H3020EfY3LNaqeAP0eVl1kC+m/OPZgj6u8MCnb1Qj1m5y6E4vUEbQifq+273eZlWJsuoR6CE1
	0lg1++GjZwZcLQWzBn0IWAgFLnRGdMFiVnGWZNfZsdjIiUjjsccvcBBkAqnRjSDJWskb9/IckwM
	x+70pM5dNeSaShyB9XA2fp2eThF+sqfWkBM4fDHOao2WLVuVsU2rcdhPU1sHbDt8achYxjl2D1C
	U4l2i92AK8QWbSTzdskNFOyukHCoTnr4=
X-Google-Smtp-Source: AGHT+IEL8PHgJ4SopjgITysCZQMBksfX7qBSxWXMtzthfbfPyv1+5wLWmZAb1M4QE19p4pJCh7/Zmg==
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3b60e50ff6amr16938260f8f.48.1753102453767;
        Mon, 21 Jul 2025 05:54:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:34 +0100
Subject: [PATCH v4 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-3-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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

From: Leo Yan <leo.yan@arm.com>

Expose an "event_filter" entry in the caps folder to inform user space
about which events can be filtered.

Change the return type of arm_spe_pmu_cap_get() from u32 to u64 to
accommodate the added event filter entry.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 051ec885318d..3e9221a22a61 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -116,6 +116,7 @@ enum arm_spe_pmu_capabilities {
 	SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_MIN_IVAL,
+	SPE_PMU_CAP_EVENT_FILTER,
 };
 
 static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
@@ -123,7 +124,7 @@ static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
 	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
 };
 
-static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
+static u64 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 {
 	if (cap < SPE_PMU_CAP_FEAT_MAX)
 		return !!(spe_pmu->features & arm_spe_pmu_feat_caps[cap]);
@@ -133,6 +134,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 		return spe_pmu->counter_sz;
 	case SPE_PMU_CAP_MIN_IVAL:
 		return spe_pmu->min_period;
+	case SPE_PMU_CAP_EVENT_FILTER:
+		return ~spe_pmu->pmsevfr_res0;
 	default:
 		WARN(1, "unknown cap %d\n", cap);
 	}
@@ -149,7 +152,19 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
 
-	return sysfs_emit(buf, "%u\n", arm_spe_pmu_cap_get(spe_pmu, cap));
+	return sysfs_emit(buf, "%llu\n", arm_spe_pmu_cap_get(spe_pmu, cap));
+}
+
+static ssize_t arm_spe_pmu_cap_show_hex(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+	struct dev_ext_attribute *ea =
+		container_of(attr, struct dev_ext_attribute, attr);
+	int cap = (long)ea->var;
+
+	return sysfs_emit(buf, "0x%llx\n", arm_spe_pmu_cap_get(spe_pmu, cap));
 }
 
 #define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
@@ -159,12 +174,15 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 
 #define SPE_CAP_EXT_ATTR_ENTRY(_name, _var)				\
 	SPE_EXT_ATTR_ENTRY(_name, arm_spe_pmu_cap_show, _var)
+#define SPE_CAP_EXT_ATTR_ENTRY_HEX(_name, _var)				\
+	SPE_EXT_ATTR_ENTRY(_name, arm_spe_pmu_cap_show_hex, _var)
 
 static struct attribute *arm_spe_pmu_cap_attr[] = {
 	SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
 	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
 	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
 	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
+	SPE_CAP_EXT_ATTR_ENTRY_HEX(event_filter, SPE_PMU_CAP_EVENT_FILTER),
 	NULL,
 };
 

-- 
2.34.1

