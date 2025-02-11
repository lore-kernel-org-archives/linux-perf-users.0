Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592425A343;
	Tue, 11 Feb 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290119; cv=none; b=Za/uwmNTRVKkih5uMd3gLfQlhHLKqGXRS/sVCnqnh1Y8satbQIwdHaBo5JOvB2bWUvRAJMpu2+OtAYWf7JLdzh+zHgUwaYTZ81YFiY7vHwktJvPLakDelPfS7hI8BAg8zKlEVvhIhypyDh1rn9rIlZwUQW5/EdX900akkdBpi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290119; c=relaxed/simple;
	bh=cRVX0qZipF1a3qWrtGdJGv2+CmNHVPkTZK8m87LPi7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoOCgFLi0DxvndlJfhjgaIfkSIxiK0xzQYmO1fsQBXIXGxD0QYByz9ocUazHQzu12dze0o4qCr3o3zjl0IXtVtLrhshfT/Ba+6iseetQ27NorQaEQlGkRZPcR7nZc1LFWJWGirhfzm6LHPrVyfg6Z27EWdv57loTaaC24OXA1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb2jS6Et; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb2jS6Et"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so6453559a91.1;
        Tue, 11 Feb 2025 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290116; x=1739894916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98z2XYYRzQ8D8svX8siNUPVhrLU1wb1YkFqSoCD4z3Y=;
        b=mb2jS6EthZ9fV27UxjnPz+doXo0BGuyn/kRj83sl6gMxkM6ekGN8Lim+tDO1DC83HD
         owoQZo8e3xFEai5Ymoa1shqmtoL+BF2aE9IAufVZOMu9lUG7Oiy57BLNjmtxNUh0bmHj
         rg7yosjRom8P59pjfsycBSeXgO22co0CUC5JjwTwPiwYDaZ87DtkO6pWm4syiEHRF5Sb
         6dpnS3PcpYOzT+d5lCU+cn/qyfXZvlaQTPQAmsLMT6+R7opHF630irF0Ke40sj0G80eg
         HALiBTYULxb0AmsuCoCOTGCofdAzczbCW7/dOrmPPAyJZ7zDN9B4PwID6HfUNJ0KyvQI
         fRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290116; x=1739894916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98z2XYYRzQ8D8svX8siNUPVhrLU1wb1YkFqSoCD4z3Y=;
        b=s38QF/nvshYUkMyCHcJf6h1JZOQlapKU4AWabvDG1hWhLAlmdhQ+4kmvZ71aDxkfiI
         oXBRuJsN+FJRx4RViF7P4BO3BmeKgQdweCX+h3o3OpZ7rBkFLiRJKgX51sa6NW6t8Tkx
         fXmMgAzn9C2QgnW48vSuia0r24yS6jGnkOnKOc8+tPn5R7HdiRMiiGGNbfUhbB78Q+OT
         ajlRKX8fTVZJZ9uDN8pUap97dGAl2xDNevtffao3TY6n60jUZ0lzJXErwmnfzzbW9fa5
         0eFR/Vx6aMfxRJnVM4n7Na9HNkPtzNeXv0CeH3JCgFbEMjCd9VEqgj7ARkmzvK+ILUZN
         5kwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+pNPEgj972ygKS6dItKnQWPnf79YSz+pxvx7+fS1/8xZdph5gDpdYKz0hAa+36e4BTUUsRNpSE1z6@vger.kernel.org, AJvYcCVFiUTyMMhAbivLcJpVJlBIr77jbltLm75NvEA+UVp5nd7XooR3z7kr12/74EaEWEu/IKXNu2Hov1GuaV/DFdJF6A==@vger.kernel.org, AJvYcCVRlGBa56qIiYE4eddIJ4fW3m67Ia5vn09dpT/DC7u3BS/PgOAwC5CBK2XX9TZRV/RHqCO76UC17tBb95Ky@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1fP+JuxDEaBWobgNdN5U3ctfQajAKxMsygNJKCrrCsdSMk8H
	kcGq8kcWlRwlzpTrDmlQlGCHhiSygNg8H9kEgcXIoQ6WkXyAuJ6A
X-Gm-Gg: ASbGnctlOaKWN6e6CHNPmSWv8wos/ho0CM73HIDLs/VrfPCs6w4UP0E/WbS+24O6cwb
	Qaz3ePoDjc1kSAUvIMBtosKTGymCh56c09jnvc8p/IG9RiSEIWM4Xod8/MsiiSRpSbey2coMGaK
	8JI2AeSCR0QjKgkp3FtjCANUloa54WFX8oYWaHWMdz1mxUrJnMWfHI7n8kJ8Ve9wOeAXqeFiDyU
	MBgvKlnmrm3GM/oXEJsSVP8VAGj+rwzWbTdxthpz/EdZ8yzAqN7vLVmaJ08m5QzA9Sik3zSyBMV
	Xpo5UcHC7Q0GHQ3j7A==
X-Google-Smtp-Source: AGHT+IHi+DuLcWnvWwCfZG64M7w8IG53o28CoOE0thaWDG5+fhlXqzhYXMbqXOqlnumqzWro3qMUeQ==
X-Received: by 2002:a17:90b:548b:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2faa090abccmr6691971a91.8.1739290116404;
        Tue, 11 Feb 2025 08:08:36 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm6040478a91.41.2025.02.11.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:35 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Wed, 12 Feb 2025 00:07:29 +0800
Subject: [PATCH 08/10] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-apple-cpmu-v1-8-f8c7f2ac1743@gmail.com>
References: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
In-Reply-To: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6966; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=cRVX0qZipF1a3qWrtGdJGv2+CmNHVPkTZK8m87LPi7s=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnq3XnjBL/eF/qM9ZzewOPxmTq6+xz/CEO25x90
 JyKoYwfN7yJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6t15wAKCRABygi3psUI
 JLPgD/9QPg1m+0AjFRkhm0c1a+zqKZyDbxlFH5th2Gq/uDzH+7W7sJ9MZN8TZKLADaGqmYNEIod
 UJspSGZxFjwcM0LavEWWMqSftpFZOUUapgQdpAOgEpYp1hwMHj5ehTndgxCyoyqffSrNkBcvjFf
 Trdd2ugjFNHZPgjGF4kZI0ozccILRbCqv/nsj+JGS6lrM5NXnO9T83LRcS7MYKY29SS0WhMT3Yh
 y5rFYJbg31krQbLwA/CP0W44NSQ3+kSN5B/6GJwDfuiuD7sC+WZ/XLogdsttdL1tJbIidwO+Mxf
 NgvcvcHbF0XJsK7u0Po6srgppN/hWE+Pf7c61MWruwJE+iPLj5thgRRnGYGqysMTUXzcrvJ0m5o
 we/I4m5tNaIMMq2xDv9Tb0eoTBJR8fzdoyYSM9jAId3QzgJdKuoxgTDP3+p+zLpjpe03Gx4rTWG
 r9xs46Klf6O5dQYTgNu7q6QyPUHiDPcFu/gJPrlE8PYeozK8wh6XhN4r9pTG2n0S+APyIYQNIVt
 KhU/2pAWaUznetQVr5UFM2PRvybGnM0yC4trruA4ZCSVvFy2MC0ulZV6LaiLMgz32SZAEpFMwwA
 29Vcm4/GPqTsletCoAzg5bFp7/17JntCVQJVER1vpZoX/ipTGTl09PvTu7Buq34rnS3TfQ8xgmk
 bcKtrul1A/qNIwg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 120 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 0adad923d50f05db1f977342c66f2b70d5e0de9a..1575f8eda874345eb56c00f8243833308c63a84a 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -288,6 +288,109 @@ static const u16 a8_pmu_event_affinity[A8_PMU_PERFCTR_LAST + 1] = {
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
@@ -755,6 +858,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -914,6 +1023,16 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_twister_pmu";
+	cpu_pmu->get_event_idx	  = a9_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -959,6 +1078,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.48.1

