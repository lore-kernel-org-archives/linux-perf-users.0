Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B82D949A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103117; cv=none; b=g9SWjn1vLAVoLKmVKfW014tp9GRCOFiG6SFsPcY8UZe1Gt4Y4PBMbIKUu/+fABQmRyfE0AQbhnP8RSmNL3s4WqSYbCLRZHQXwbx/1+HrMAyTRymzwLg/+sCJRU0BcoLMpVUvQn+CiX+K0ROOxdHRvBZCA+aMmz2nPtiMwWKezJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103117; c=relaxed/simple;
	bh=ioJvhXZDfjEQt2ziDmXFW0nCeOZA32fi0+BXFuZXXMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tp9IoU4K9I0Yo6xXgwFB9wWipoiMrMO+7MciX4zmOnU+gArz2WJfBDQQMql4K60OeM1qq98p0hPBYYKGUYz1YJb3iKgrmDWzKOBbAMr5uvLnF72NhucrOoMWisl1QokTY4Bp9jGieQ/y3kn6SF8aebhF7ex7yEwOvH+Ne/avRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVB3k91v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVB3k91v"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2368366f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103113; x=1753707913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=QVB3k91vAt5X0x7iRt0ayPZUdtpHxi0kEISpq/TzDOoOAMe+qcBLAG6yGOdgvD9yfn
         wcpOik/5tVXd0S4lvue/vLRP5qqN/+NIhGZAGXjGKpat28krTj757muLMq/r4jSPcz59
         Qr/KicDF7glSrvUMZCZqAg9ivxuQbX1CZ3sizCZ0VaKQ+dlQkzFIN+qG4XGQ6povyN6+
         DTGAq2JJlMcOkeq9RCm9sHJK1a5SIIO7r3pbL/BqWNyYPaOR2TbWmlr9x1UObbtkPvH5
         HO7d01/+uS6Sb81tf2fPduyA5SHlJAVuNcdgRkHrWCcqZzofYHpxz2GXHMpRJIRUm6DW
         qrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103113; x=1753707913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=mFj2bSTqLssjYmSjW0Ud/T4KGPS4FWKAX/lN1yq8gQL1cA8XnnvpcNud4sE4drTqL5
         w8NeQib5QeIsRc39C2+pipzuBUH7YMzco4eKI80xnkv0aGz6Lc882Gl8e6SFmhIlQn46
         kLasZH/bojwaU963wI9BTyuSOugm7OzelcTVeR0Y/4Avsmxbf1gJo+RpqDw0J6G85ZZa
         e0yeZ3P7mPEaHOdCnErl8qIp/CQicsw5LZql2hru7dXA/WhVkA7ay36zlBk9kLOHP8I9
         FaBNrnbi74yr49GjixaAsqDYnvPYvNbpu+n+ySqVNFVp9ZCawuEuAOarXVLB01LL87T5
         viaA==
X-Forwarded-Encrypted: i=1; AJvYcCUDcu1vsPY77+pe58c+WJOEJE2tlbdFTWC/s8Ht8CTZ57gcI7HaJGn5Lvph4dvY07h2W61hdZH1d4lWcJJAp6XB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Jxhz3szp+7rEyohqOXpjvdnQAKiOMsWaw0oQlwIpm8lfn4Ep
	AI8VhaUxyrtmby+eYusKHmcwBekkhgxJeXWmsY03eltKnv7AUU1/ms50pkjiwuzCzVM=
X-Gm-Gg: ASbGnct9NwXkTlhdS0ns3zKGVN6YukcRYk3HNEsj5cE/aEBz7+9/IWPpWMA5ziQF/0r
	qHXaUJLfLLHODFsAHYk9H1TowYNLGucmfrh0anmwpxzzL4TDhidBPk281QJ8cX9CABqh44ecqrv
	ilA+tKObA/DjjJXxOuA7GnSthvYf9xAzDnPK8t9Wdgd6ewJiYaz1u4lJv4ONaxWZ4p0WpwMZE38
	SbGxBjqAwrFrpH3KgQjGN/0uWEK1HDK/a9fDmQmtqkGiIOJ315zjsBOilwQBTyOPV4yo4eebLZo
	RFHOEyHbLlGsj2og4EGSXno8LY3k7g8BQ7DYv6LlQ7UlrBIzsf6TsqDpq5RYn0AMr+6pxWixh+C
	JSrT9eK4gpV6nM/tkRmOmBezK+1YPMyg=
X-Google-Smtp-Source: AGHT+IGWq4jzpIhEdv6123LGkJS3kcsTALE6uCDdvRzPU6u7cW14a0/tv2JQi8/2wxRmO1WYzyv6ew==
X-Received: by 2002:a05:6000:430c:b0:3a4:d939:62f8 with SMTP id ffacd0b85a97d-3b613e984ccmr12134458f8f.32.1753103112960;
        Mon, 21 Jul 2025 06:05:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:04:57 +0100
Subject: [PATCH v5 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-3-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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

