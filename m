Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2F24500A;
	Thu, 13 Feb 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457409; cv=none; b=BzoXso+hYuakAtQnIUQmwLsAxcin/XW8/+q/UOBGuhfT8CxUlGjkS7VTOzZl+oBL0IPnLxT5ClCD16Nzm1n3EybHxCnmBLs2lY4Jc7qRzErtnCSdhPla+aAG7cJfyUj7Xg6Lt6Y/fHfTRIojmBTz3LK5W+deBTqjZJSSIs1d51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457409; c=relaxed/simple;
	bh=jP5SIcv2Sg/VVBpyFEtSXMV1FvySTLQcpUIVN1vZ2J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o90IGoEDXvHC2V+Oj87Y/lKg259jOSnZcobox6mtrtC4zG1foaurxtoksh07gohzGyZSB46IGNsaQaNXVVeWOZGX3rPlpzjILOWK8h+FfMsPS0Jf+lPnmcEToO9KkviS6JJfdursmDZRgJHxxODfs7SVetKGjQj+R+v62/rPqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2HjjMc9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2HjjMc9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441791e40so1416375a91.3;
        Thu, 13 Feb 2025 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457408; x=1740062208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT88wEPfPhqQKTQym27LOehc4zdehNhVFA8MHCW+/bc=;
        b=Y2HjjMc97sktXNxWzyFnyuXMc5lXcorVJUSjpLfCOWyQLpQY+EUZ2o3pekgeGUe2bq
         4z1gJB19s0g4Us1Tssom879piqd4hbotpxP57iPGSus7yVXv3TSw4Ve/01ouR7ZDaGe/
         vUohr9rfS24Q+XU7peGV0dLrxYvPDsWcoEb2CLsr7jWdyK7x5A+Dn6eNlMvpRwKnSScx
         t/W/KNZ9IWapNo95MUK+6XUclZvEQ80qN9W8Q2p7az3QuaSw1Q0VgwquwRyvfIF2Fefz
         QqeADnE/t/nW2KmfMXTo7gkrsX1TxBSfdsde9ml7csAWKXtzjEBPD+xmirknhczs0JBu
         ciJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457408; x=1740062208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT88wEPfPhqQKTQym27LOehc4zdehNhVFA8MHCW+/bc=;
        b=IroXYQidewdXjYgnGVTbeD5MCO+afV98KIE/k0Tg9Zu90IuK9JOlUouaq8C4TXXAb1
         za3pSf1z0TUyTyAz02BeW/pfZEPlO+BA7LJ1ecfBHrbefb14uIf+ibKGoVne8R5jw/2Z
         YQ4/J02dI6NstWF6vO2mEIKJs/GaCo89WIFKTYOjaC0Wcooaq0aAETxQTi1SNYqFOJnH
         pWuNnpE9YicKZhbGUNILmO4V7mRc2SYW1COX8/5xVx71HqSqLRcuOe0FmQlnuRNWKIxh
         MrOV9PjsqrCikXCpevQPvgERSRDvRs8gJ4ksZj2fPrnsag/JesvSf9/ry1kGHR/eJ7lZ
         178A==
X-Forwarded-Encrypted: i=1; AJvYcCUJCOEcdlii02D1Q0IPKsCVwBYSojqPGQWGxJxpkHKJ59yCz7ZivUUPbDw8QKmqJke6hq1NFm5OipbYMCXbVRdlvA==@vger.kernel.org, AJvYcCWr2xbR7k06Tsu/9IsffhfhTUTmZ++yDgCtHNyex677xBEzodb9KwEyka2/viKUJaQ7aYrIUBQv3iFq@vger.kernel.org, AJvYcCXeXmaJ7WtU+w71sJWtoPwjKek5zNVjYNO6PpwNL0sh59V6j4cel9dPtwjj2+pegYrH0Lq11LOYugb13s4W@vger.kernel.org
X-Gm-Message-State: AOJu0YweKvQrUF9aw5rfML+GLbu0yd1CX7XWm/C/38YZ1uDAoIBsnrcb
	Lnt/vVtXKgEPk6Idx6S6dIwGQdk4a5YCD2i7IW4H8jEdY+m7Ed/T
X-Gm-Gg: ASbGnct3CHnc6MqIwQN8ONdFuXFyJj6+gTGAx5JqZ1wsKt66znnibXWv9rm0JKPypj4
	Ue+snPTnO3AtNjffvbS4O5XpqvL5yzyjnh90pB/7VQfqmy2Tc4rwzwYBvKzMc/NgdsB3x39M7br
	pCtvvjAsLzR2z2qcxdZb6aN5ePpQ2sFAU9FmY2xGmHoLiL3UoahmLvyN35PCd9+TEihutIls+CD
	i7JG+2rExS0SR6kmYLD8gLyF1ph9PqT5HlFps7BAqRd/Zsd2nbMnhgwRuFhuLPnIZfpmYRGJ+Ce
	SCdwc40wElI1sM9nNA==
X-Google-Smtp-Source: AGHT+IGe5gVeQtD1xhK8/Wxd6+hlJrs6sqvgu2aXwMpm1l1/bn/qyc+/upmSMKQjieGZYSM3Flzu/A==
X-Received: by 2002:a17:90b:2b8b:b0:2fa:e9b:33b8 with SMTP id 98e67ed59e1d1-2fbf5c1cc63mr13248798a91.18.1739457407702;
        Thu, 13 Feb 2025 06:36:47 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:47 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:10 +0800
Subject: [PATCH v3 08/10] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-8-be7f8aded81f@gmail.com>
References: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6916; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=jP5SIcv2Sg/VVBpyFEtSXMV1FvySTLQcpUIVN1vZ2J0=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNjFCj+yQERB4/K1EUiZI8rkCkcmSV45N/zu
 YSnPP0wt1aJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYwAKCRABygi3psUI
 JE5sD/9z6p49AbKtwxsWoGGNsbJ9dXpFvDjlTV5amzH6ojW4LBn1bSDPz34E9NhMp6+ueZJb0H+
 lj8jN4vRGribRRqGMbt2PuuiCFhx/BHBDRV2hKbWr8sBY7sbBHu9G8uYH+pwOvg7MrBWtNwFSH4
 6SGlibYFBT/LLcYWma9ebtVKkfoFm5dHEzIzDny/2AkHFTwTiXzq8C1nuckkCKe5ejhjX8rGOpO
 AEm1q2yKHid4rfTg+cSX4GkNKIXCTXmcledyXrfA1pMKVjU1LmCfq9eQZuwxmLzGEGFoanyV5Xs
 XafdWjF6Nl/Usn5l8ADQp4adKvRgIxuM6NIACjZafSRUtvHRkQJBDTxFk0Tmm1mKinGW3Q4O/+K
 8S3Sk43B5ZFnkiROQ1Hh0kn6m7nDmaq4/XZSrXJE1wWPMAhFESso9c+4tAYA1Nje3aK2ynQ9m5e
 pIcfbsVddCtsyvuT1CntHqkG8ne6h1lbcwehW0lGV643mZsLNZGVs8YvxuT7NxzjJdPPg/7xZ3H
 M7SkZVn34tU2AS6QzTsZIG0722RK7OfuCCS5nbK1igALsqACJUBeS0Am7hhGgC0UfTx0p36x2md
 KrOB8Wj9sD9n83C18cn1R0GGk/KP/k0X5e8qUsh+X3/iPdlPC4n4IUQKEtmFXrPDE5Nm0XlOMRe
 D03aYrt7sbzzo9A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 120 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 2f9ed8b2883913f67518484ae6f174a3d03b1f9a..1d272b0edf30a00c603462c11a7101b01ed41f41 100644
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
@@ -758,6 +861,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -917,6 +1026,16 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_twister_pmu";
+	cpu_pmu->get_event_idx	  = a9_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -962,6 +1081,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.48.1

