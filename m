Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD61261369;
	Wed, 12 Feb 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381006; cv=none; b=jOFGIatBqLFNTNcsXpQLuP4Gz9CKyPP95FNurUFQSzrLVzSDjCtWz+58NMRuRt1xgnQFa20bb8eQoUUvQ1tbPpEyeRVyGCFj5a+dvekj7h2a/i5dqgnfI6CzGqXKxdNCTC2JgJ7JliLyhxh5wEjuzBegF1ZKlHCESC2wF0w8wvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381006; c=relaxed/simple;
	bh=+NHsdiTChFJI267XhsAcL79c5EIXEmeoIiXL7aDkemk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pd38krf8XoAMwRNJVUtcOMNQ/LmQHCpQsrVngH1iio+JltDQoZKQO6EQRgEQpzaNuEQr2/oCS+TYSjLEWBI+N9z884XlNfTyGkzPCcPV8CNXbYU2vHjxL7BgmNwbQlDFtRKXhOUSQXtJ/v6IBEB1NbS02WEZzxpTiuKnk61cYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlpSCaVs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlpSCaVs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f1e1194so109196825ad.2;
        Wed, 12 Feb 2025 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381004; x=1739985804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTYbcdY7/Jo2Dh85xeyI2rjRTlgHRrAo4vBrkDmLZJ4=;
        b=dlpSCaVsZboNvnVQ8FxnH3Gcm2zS7oIHDBjEeeHTRgi0dAxOaFBt6v/PcTGcc+NLGW
         dGsvcss7UOMXs7lubnkOeOgx9LOAB6YN/vvYn45CIV2LXSrz4DRhFw3vT6/Yn5WMJMcs
         zI3NI/Q9WwUv/RbN/yLJpjAol4ZlTyEXUmcUWPcl4G6PVTbRY9i0mR4wuVgpAnmRc9Qu
         wFc3ylBntTt/ecolVUH6uB4bx5L4lKnsPP/suWz6yLztgltingdC25U9VbpgU45M+cdT
         2G0iLm4z1LgIWMBnLenD6lGzBYqqVcAxZLF2re0PT2Y5hTU0YMcNybA3dfG1Oex7s6rZ
         5yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381004; x=1739985804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTYbcdY7/Jo2Dh85xeyI2rjRTlgHRrAo4vBrkDmLZJ4=;
        b=bdxlY9oSTmr1dKzGsdXBMNwZ8kdgV8RXSauZTq4ksdqaiJHMvnbfvZZIh7fAJOl2pN
         CwDJpQ1Ig0Z8A+a6ePVGYyM7MaYcqZFxQ6bCdWy8172oRL2wXxQXT2s+rrcmm2wx2ngO
         DGYdQT/Wnz3krv3pfmsaL/R3wn6+55Znqci4UH9gYxppOldqjbb8Vqzgot0hlbSCOR6j
         2S0Irf0r603DLDGOSR6S1Hu84U4y8VFfYV+0FC98Xr5TcAzvj/3Etz/A2FNtpMMUb0k0
         sClVH1duWGpqPlA67gN2VlH5TsHXYIiu+zP3Rjh75IcVfgC4Ocfkl/LJv2RFkrsN4cHw
         ydWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+mrIFSMHXiYrt55fhSoa/v9YZ3NbsW4sN/QVswQT1TP31uAivSeZBtMmbUVeeEzmvHIWhJWIjgr9GpHu8@vger.kernel.org, AJvYcCW4axoptDB68EpG9zYHtgrBO24jnvlMHyP+jW9D4IFgSm8yVXQY0qc/akYEZFCDdz+HbdcT3wKUxCwL@vger.kernel.org, AJvYcCX524cjHHQ713pzvgFYvx4YVN2TxlRMftjEQEQKEElUJozNlEiUyvPbV10drd/stSEmwfeeMiOYcRJ39E09GaJe8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YynLSn/Nxtk96tIRgaIFVKGWxEYaSsAMRRZbFIjeOdu9Xhy0HlI
	2M5WhkTgcvP2e/4KrMaq2ZMBi2nHsIWwpL/UbuGQMUSTebkZOOj6OyuHBQ==
X-Gm-Gg: ASbGncuEENwzFieyk1oKmF35RjKhQNg3najbbaCLrohzl0GLUuCEkgRl8MqLB9hQBJL
	r4Jy7OLDlmSn9aLvaftDqNccXfJp8OAxmoxGNRLFrjJAu7bYvwLdYRISE/626ITVUdXXjSQ4dqt
	8f+Zi7ZNAJtbTd3oLkcp8YKMJoNiQhNpAVxLBLbgSkFtY7Aibo1ElKKdK6NuznmvQWymcmD8jVf
	kwKmmzatnoYX2ZCIgYTjEx1b3tGIU3aYUdyXwPCqiFfLNUvs7QuiDLNCUD8Yvf0ecDkoIixfRoc
	Pb9jx0D/pu+v9YV6aA==
X-Google-Smtp-Source: AGHT+IFJWddhKsl35rUURVv4XH6l+qORH0jW/f9aPBCnuIQfbythDxx0xXqNOVOvdxO7TPj5xX55jQ==
X-Received: by 2002:a05:6a00:2e9f:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-7322c41ba21mr6573334b3a.24.1739381004106;
        Wed, 12 Feb 2025 09:23:24 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:23 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:31 +0800
Subject: [PATCH v2 08/10] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-8-87b361932e88@gmail.com>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6930; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=+NHsdiTChFJI267XhsAcL79c5EIXEmeoIiXL7aDkemk=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjw6Bac4EbEaWJzQItqzFAQjYw7jkkmY4hPn
 80JMO9tyIuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY8AAKCRABygi3psUI
 JDAND/0XYHwMatuebskGA3ax33Qo1jfLpkeXIplbTQV7wNXGDLCieTfhv8+3BB7wvVz0cGrZO8E
 SZ7fXDfmbEV/GILoltfzYcNosmpxVNLtVQqWXPg3rkL8sWV8CfAke6cVAa2dKHVEe/hc6c7AHzp
 etJ4JPrrwGbVTOyO8/TDinbeJnsrgQYCaj0nO9eOS5+bt/YJCtHpiBq5II4sZf6MXd+QwCS9Slz
 TwFVwpSHlVdCedejyMe1e8xHC49O56T/kpfpBD5h/7XlzSKow11D5m0UriW/9F44sj9zFpg5HVw
 tOO9H0ngGhLtIs7kvnVSMPV6xfEUShMDZRbfOKUDwhzXhMjrc3aDexed9IQ+rG4V5QVVsoZ1+9X
 YM10ODmh5mla+xp9JnMDL/MiMtJSDodAScWtLizY57hPQq3P/xBhnpLzzbjBe6o/1UtSJGiof0H
 l5AU9bIBv0eHv69rEnFTl3EAoG8QFN4pZtZ0KDSn0KhZ1pXDa2FY7S4FoyHCntBGg5xdNReGoV/
 Co3l9IMOvsu/R0oGzMoBRu9UrYLGzjLEKzkuV6NOqfXnJQYmJgzusAzGnGhdB+9yUTdU5gSQ2FW
 lAZZcTVnbjrWwsxMC3Mt3CXSIk/qUCaPxEtIlDDhyR9ACo02cBmoMlcMlcqYFplE1RMwCizQ3A7
 MASek+3L4ughlyQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 120 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 07eab1d5ee078de5db3d08e2f1714bcfe5d3792c..3f72de1051b31a1c0b417092590bfd89e747755d 100644
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
 	return apple_pmu_init_common(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_twister_pmu";
+	cpu_pmu->get_event_idx	  = a9_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, A7_PMU_NR_COUNTERS);
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

