Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D734E255
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988714; cv=none; b=swX+pGPvF6vmF8MhIoh4+EzwhKlJhTwsROashs0rC9qi9pEiu9/7Vuse2NIUO/gL1FuD0Cc4Ue4w7AozuGyP7zbTv8drA6RhdfgDLEcqhw8icbUxEuCDhGF9oEQChumShjO/DAHCW2sixL/TrnPI1+RmLdFrk8TAkmM0/wvrGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988714; c=relaxed/simple;
	bh=2QlkQ5sdKOme7Mv/q0BFxpV/faYzPgbeDfOS4FED2YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1h3Wr/vwH4MZWATcSCvlOXslKxgOFuHytG48iK3Xz9drcgZU+9ChmMN5Cxf4jaYjhR25bDPTnVl+L/mfrFDlvpAwEcuxR8raW0Z9otJfa9zvBb+JJzz1kLafbTgn5fsWFL05yfzrgn+evPErDgUGQ5xtnuhkfGXUbkg7sXQnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCEocQEi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCEocQEi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso45623025ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988711; x=1766593511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaU4XbWG80z9dgP85MHp1bFwcC8OyOc+ojO7hjR41sA=;
        b=FCEocQEiNP0wDn3fX/ZCUPVpehUXl/8MVpCykZOhojDNU23T7oO0JREF7A+K9WGOUk
         6FIn04MD+bY43cu7uM/I6QDzQRRHfIaueeQxaoayAplRfNlmK1C1Dq1kx5wMPCl2xP2y
         LmNWZzwI2dgRoW2HR0hCabJm0ay/iCerU8863PkR/G+Mu85jDHoZJO/gdCcbIem1XOD2
         N+pt42D7JrbIwnXy8UhHY7jadJCz6k5IpSk8oiRhAHibBfaKc0jTtWGrPfgo5YciMP7Y
         RYV8KnrSnRo0SXE1CAKiDVMmEdqctMBFdcYHN6t2DUigkGj/4JCzwHClPib81VUP61YC
         3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988711; x=1766593511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AaU4XbWG80z9dgP85MHp1bFwcC8OyOc+ojO7hjR41sA=;
        b=VqmDiLI+IC9OmI1CulLSMD7MbOtoktUKaxjnFajAQQzNsP7bm9u4KPDbDGGwDY8hEw
         02ZvYIhKSDD+MXqAX/OdZsr+rdz5xyF33QKnbN5s4VjyIAYgHneKKI30Fzgt6cxPTJ1/
         A0nSN1lbQlb4/YfgXzd6CTOmDpxi5c7WJvU/DG8eKBq2dl3gSs0Z1veIi61oe5VqfgCz
         G2KR41j7/N8K+JYIUTMsveAE3M6K+Tx7aECYgrIrXy/ugM5qO/dH+B0Ke3Ty1IIdobnr
         yuTFKfLX7lIKucxGTr5M9rn1hrFtuLq6jzxSKJj3jk0gcN6yAxtKZEttOzl7r/ckxQS2
         G9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvjPF4HEOmT2xPgU1gDnvTnO/UAQ5fKRiqct21k4OvGpziIBukJQncYOZsXqk8g7Jx6TCgNa4SzCCFluxVKKuW@vger.kernel.org
X-Gm-Message-State: AOJu0YztQbSWFGTsrIleE3KU6o4un1kNMh1BGFw18w0gfz6ozO4/dfuk
	XD8zPBvamvoy73nVOGkad+pjD4StJIpTUEgZ/A28ftE2vx4qwbAozMyy
X-Gm-Gg: AY/fxX6kfHNFgaiauc9XURsve5H20a2WmDAASEAyCoPYbMblCkAT2loE3EK+RfBRsis
	1Es8Gg5yg2LPspiB08133r7uVZLOVQbDv/nyoQtEXB4xQveCvvuxWUDDs3279JMQfzXcIK+clQv
	vuU9eqg+R6E+7rtdoXWKn36QB02Br/QcUHLzXANnljPViAgeou09ryKrT8IpDRAXj1ZjAHfQ145
	ClGPPh5LTWCvXk6vJTRN6VLMo5+qPe18bUTZ9suSWZ/GzhTN/S5GcfA2qTLNtUJmXS0Jkam1dOx
	/W68k9ZfllF9pSl80u9l95SUr586He2+2+hXqjTfh8ezbsgrLWX13pu5yKz8ph4ObgzjQNgAiT/
	xrPNSCaDJhEbHAJ94oPguFUqiuj5L1SgWyebcqCBo+2k7CQjvVUNNYWcIT4Y9VYeDYByZLtFGKK
	4RX3nEQGMpPh3X
X-Google-Smtp-Source: AGHT+IHBSeGjBMMVKRCxLWdVOAH9uuF5V0wqkrC07VW2vnJuwJLyD7X2XjffcbHiQvT3NwN+y1IbMA==
X-Received: by 2002:a17:902:f608:b0:295:99f0:6c66 with SMTP id d9443c01a7336-29f240492c0mr166064155ad.36.1765988711170;
        Wed, 17 Dec 2025 08:25:11 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:10 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:23 +0800
Subject: [PATCH v9 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-10-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7158; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=2QlkQ5sdKOme7Mv/q0BFxpV/faYzPgbeDfOS4FED2YU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlBidVRK8dSsHdFWe1evHRA10AvmORixyLiy
 k4BRWTPmzCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQQAKCRABygi3psUI
 JFwcEACsbPM4gMa2+Ov3DoR1z5GWXoAUgoUJCkFfl4dKszzPcquP9NtvIY+5MyC2eDvV16DRu5B
 rTwlktxk1Z38C29vX7FL2Rs2LH3U45BIdVd2DaSVHCiG/9lry+IyPuTvkwkBnq9JE1ETkLOHmP9
 X12j/CEJwlpS5VzhfUIQUlHByTnbJXOIYHjHA9HF3rzibLZakH3TuIOw+06Av+jDhlKKEzMsZMf
 +513ayL4K9n+PicV5BrmS98UkqQ/Cx+DPyN5mxxcU7gr4VRGovqD+CVjQXKu91/vSSsZjbxGra4
 Yi3HcpFMMuAVjk0m3izC2dQiTawpVbZPHZrh6EVV5uOfF9hg6zLTMuI25Iy2202AommDsjW6yRp
 MBEVG4Zu18PZGFIx5zD7UqOhQYdeu9uUQ5ciDWYRXtFe6aEaZbTs+OSMtz0LuXoEb+vYutQ0jDf
 n688ucD4iuQAKQQ0q2JLdfdK181lXT8zS1Z39FqAWaD+raRoZxM1HiPhdAd0gBBCrU6teqKmq4p
 Ve06WaVbb8Iu/zZQsAz1r51W1LmSFpgMnpBsvkImOu6cYCx+OH6qlaGiD3/APImQBXzMEuZtmBD
 lePqhs2g9PPMviE8LFfzxF5SjcdYg0sLskbi+KMm+4UDRsrjuTg4MR6CUT6T0c/hN22xqV5txy5
 91CQP0cRLTybh1g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 125 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index a95f4b717857b30284470487827954dd4b139010..0ef39c148dd2ed032e4d14ac01e7c7e7e088b394 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -289,6 +289,113 @@ static const u16 a8_pmu_event_affinity[A8_PMU_PERFCTR_LAST + 1] = {
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
+	A9_PMU_PERFCTR_INST_A32					= 0x8a,
+	A9_PMU_PERFCTR_INST_T32					= 0x8b,
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
+	[A9_PMU_PERFCTR_INST_A32]				= BIT(7),
+	[A9_PMU_PERFCTR_INST_T32]				= BIT(7),
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
@@ -796,6 +903,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -985,6 +1098,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
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
@@ -1034,6 +1158,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.52.0

