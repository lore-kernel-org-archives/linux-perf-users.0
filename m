Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37301F91E3;
	Mon, 11 Aug 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920570; cv=none; b=TyL9YWQmvaKaQvIzraK+UI/MNhfjih8X2Gy/n4NWp1RCWEprM6jXnCdNrxp7ZCnaOGkXtZfPG4s/Ltu8SiNfSJ/uw3ydISEEVq1NhNBnPLTiENjZmK3psu2K4o3K3AfgBmTdmzMYjj0bZe86shwvzJ84WR+Ryn/HQbxAr7UC6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920570; c=relaxed/simple;
	bh=WuH8YXRWTDJpsqx0u6Hpuz6usLUPET5IKer40y1frRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO/5hoe9lH8FTor0jJRpZbsv4wplQnaCaOiEVoMGyo6gDLWEyrcSOSBuW7By0gfDBGjWLjnhu2mLqDFt/eza/4k2hKjSoAhvYV0TEqNBLXzQSMmJH/TXuc2EfDGRTvryLQJQ3+KbBXs2vPJ460CAkXA1A/VSPhOQDLHjVPGxh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STc+7qPN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STc+7qPN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc55f6612so3907641b3a.0;
        Mon, 11 Aug 2025 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920568; x=1755525368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TkgZu4lFW0Vc4DILpyx020LMKPq20W67fxhd3y1OAY=;
        b=STc+7qPND62EjsaAdDCPiNq63ZTY9bJN+hExTMnTOwABlIkhGPjt8lzK4qb4l9B5rD
         J40k1LFQ15MXFDdEbQRX8U0pJlYEiSnoPIzOSN/QGwHI5J5ZwPDUR7iXcyW1hoUX2+EG
         xSomofsNhVvbCiKDwEPTYtCOC4mvGAaMdOn5eCdyISXM9ImI6zgld99WSTcrp69Iwle5
         7f7b1QM6qQTzfHzLyGLPOuio05eYYxds0Q4aH2S0NVMmGaMC9sQbXDrDON7dopPJcMjh
         Rf6XQWSa3P7+C80vgnja8o/IjKIl9tWhdPxcuvEt7m+Bzx3zDwgWa8XFfEJHB+fYfbPe
         6wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920568; x=1755525368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TkgZu4lFW0Vc4DILpyx020LMKPq20W67fxhd3y1OAY=;
        b=XiPnm2PhRVmuhej/u6KviJAAdBTEKNL33AMlIDLhDMSJGy+TINN15XaykuzaVvyIHf
         Dm76tGeHIR90ENaYhR5aM0vHGV3syhT/9wU5+4NislIQN+0PjQ3mUbvtH9GhmbcS37lc
         iG0AfL6jwdKyc5T7/61/gomE4hT1U+0LXaGTgsXQVmvw/jH1nLOKLKksRLBQXzDytEKZ
         eIQZl5DbfTsfYy9luNrRhJ/lFpACyC4Cs2pyogVELsQD8YadzRYEqCYsObOhuI3hmOeJ
         t2sRFgEtp1MBMr23WjmOMrdtEaGJJH4dhtWTF2tBnoKPOwQ8e/yzehcXeQlnYCUx6Uk2
         fC5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+3nHDOzR3n9Jr9OkVJaescxygiaBNLljFy17+Zt85E1mgG27AA7fXdMlUZAgjvVnC9ksKe1zLigNH0JIh@vger.kernel.org, AJvYcCUtqGtmh7oilu4YDlgfYWujPh3/W0ZbGVtpCYayNBe9Derr1L1fwiYUbCw/4PmSqFcsvQwyNhyJlso1NsmWXO3cpA==@vger.kernel.org, AJvYcCVhN+Lt1c2xSP1euJriYewPyvUtYb9K5Bp/Y7pYmeTD8BgRKh1zuKwxsw8Mcu0ico3xEBQs2tUQ0wuY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eBXiELOzK4ZlTPnWwIhv2b3DBXu6KLXT0yt2RO9Bn7aBD8/B
	Eo6n0XHAMtWzTl60/sChPDIpG6UT3WC3Ct3s8XmNGYZzrkM39F79Iz2XtvZ+0Q==
X-Gm-Gg: ASbGnctSGjb4WaA14EvI6Z7wbf2whmybit4C1el4VK9NuzPfxD6yeedw9T2hgK4LVAs
	iAJGSOUyEKJiuuI71AJKBJhC2QqylEvGGk+CrgUqIec3+IEkjGGrVn9k1xzqXdX5z/QjGbUE+4W
	ZzahGPOB1Xucs9srlaZmPl4AsjlOSuUU41C8jBWpxq4ahY0g/Zufwgeg/50UNrz0QBoqI/gxYLf
	54h+buCiQSi0j7jP4Ji3/TFI+98o7ZuWkeoM2gIetqAhXmrgDlV/9U0zesDz1Q2QX+Cj1jtM7vK
	WV/B/L+EF5DC5YfzBllOcBF3lF1Q5gZ1PwYHvq6H+3ht94Q7erR5eMnfihSmDou1BVGFC3gv6ge
	eJsoUx4MZnSHB5aZEG/0FAEmIO5F2kHeGBIMWbiVlSv+91GQVYwYPqoFr5A==
X-Google-Smtp-Source: AGHT+IFM0r92KIDd76drb9AfD4f8GscL/2M3otMIYXHISpVmF9rpA5lLjXRXeDYdiLY8zXfmBr6yGg==
X-Received: by 2002:a05:6a20:3945:b0:232:22a4:bd50 with SMTP id adf61e73a8af0-240411ec8d6mr30274086637.9.1754920567854;
        Mon, 11 Aug 2025 06:56:07 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:07 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:42 +0800
Subject: [PATCH v8 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-10-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6996; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=WuH8YXRWTDJpsqx0u6Hpuz6usLUPET5IKer40y1frRo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZCWmCfZi0x4WcuwRWfWR4pOc02bLS7TmsfL
 GlRiMrv7nOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QgAKCRABygi3psUI
 JJn1D/91gQc72s2uw5Y5vyAn0IW141NhTedP0ezv+UN3wQRDjh24MDb4xQxbdcBazJwPXipXDxI
 GaqOBQc583X5WTStNAPf+Hff50R9rU17Z/kVAOdWWqnq3VCr0NgKtuehp5SRGoLuAIzHV66prVp
 T8T3r47HlezDyQLKePPsfp0gXgQ4h+U+jbmF1bVYf3gXFU4enRIpAyhu5Yg5WkLkcNNZwyz6Fe5
 uQpOpd1GengoRjYcGi6GuMNFCXdefj8vJq/PIh739lm7STOxxdLXYZwFlEjD5VbqqknbB99AEvu
 tpC99OVSHPBVnwkH60UjRRvWEoUf3HqfXpVD56nX6wpLSM2P7TYVKiACXwa4zV1+bpr1UHmRv6M
 Lztt9AmX6t8ClmJZNyRhqASGtWMazZTuj6TdOQFHAzRmXU7Sq/HDOSEsHroIHzgo5LCZffDxv13
 BaWgsAXSvsH+NnmKkX9AinEou258uOEYtLKpb5xy4q/Ha7hzMSro11VYOaHWgT0S+whjlcVDnkY
 mOkiilhsyWSEjfkcRO54lhuAkZitWxtIkq59ZdUfDeLqOxx1WfzuomCeOx63MNPWTS9KC0Y2bI4
 EB/VKO3f5qiXbeRNjwzCRh+xFh55jZp4/pqXeyiCW/wqguATfYF43USFsIjR8E2+dh0W1yFtfhH
 Kk1K1DOfkBLqmvw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 121 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index a95f4b717857b30284470487827954dd4b139010..bfaf926fd47b02a7d77ac31cbb97779b5ebedec4 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -289,6 +289,109 @@ static const u16 a8_pmu_event_affinity[A8_PMU_PERFCTR_LAST + 1] = {
 	[A8_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
 };
 
+
+enum a9_pmu_events {
+	A9_PMU_PERFCTR_UNKNOWN_1				= 0x1,
+	A9_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A9_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	A9_PMU_PERFCTR_L2_TLB_MISS_DATA				= 0xb,
+	A9_PMU_PERFCTR_L2C_AGENT_LD				= 0x1a,
+	A9_PMU_PERFCTR_L2C_AGENT_LD_MISS			= 0x1b,
+	A9_PMU_PERFCTR_L2C_AGENT_ST				= 0x1c,
+	A9_PMU_PERFCTR_L2C_AGENT_ST_MISS			= 0x1d,
+	A9_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	A9_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	A9_PMU_PERFCTR_MAP_STALL				= 0x76,
+	A9_PMU_PERFCTR_MAP_INT_UOP				= 0x7c,
+	A9_PMU_PERFCTR_MAP_LDST_UOP				= 0x7d,
+	A9_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7e,
+	A9_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	A9_PMU_PERFCTR_INST_ALL					= 0x8c,
+	A9_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	A9_PMU_PERFCTR_INST_BRANCH_CALL				= 0x8e,
+	A9_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	A9_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	A9_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	A9_PMU_PERFCTR_INST_BRANCH_COND				= 0x94,
+	A9_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	A9_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	A9_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	A9_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	A9_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	A9_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	A9_PMU_PERFCTR_INST_LDST				= 0x9b,
+	A9_PMU_PERFCTR_INST_BARRIER				= 0x9c,
+	A9_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A9_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	A9_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	A9_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	A9_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	A9_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	A9_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	A9_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC			= 0xb3,
+	A9_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL			= 0xb4,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	A9_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	A9_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	A9_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	A9_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	A9_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	A9_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC		= 0xc8,
+	A9_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	A9_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	A9_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xd3,
+	A9_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	A9_PMU_PERFCTR_MAP_DISPATCH_BUBBLE			= 0xd6,
+	A9_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	A9_PMU_PERFCTR_ST_NT_UOP				= 0xe5,
+	A9_PMU_PERFCTR_LD_NT_UOP				= 0xe6,
+	A9_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A9_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A9_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A9_PMU_CFG_COUNT_USER					= BIT(8),
+	A9_PMU_CFG_COUNT_KERNEL					= BIT(9),
+};
+
+static const u16 a9_pmu_event_affinity[A9_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A9_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A9_PMU_PERFCTR_UNKNOWN_1]				= BIT(7),
+	[A9_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A9_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[A9_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_INT_ALU]				= BIT(7),
+	[A9_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
+	[A9_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[A9_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]			= ONLY_5_6_7,
+	[A9_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_3_5_7,
+	[A9_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -796,6 +899,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a8_pmu_event_affinity);
 }
 
+static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a9_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -985,6 +1094,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_twister_pmu";
+	cpu_pmu->get_event_idx	  = a9_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -1034,6 +1154,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.50.1

