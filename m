Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AF2253F3;
	Mon,  7 Apr 2025 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001204; cv=none; b=TnOLe+VPK/QfifS22ZraruCxSO8Gr5NztE4BN/A7oIO3BwxBg+eXuBcf39T6A8NCpP58/5pDh5QlhI1XJRWAaZ/slMhwD0Mg2SbEVXuudoQsNd07gJea+rwXivCF6Jng4KqDKkgeCqDpOaSn/vJ6IM/LFcFRtqYYv7kMRlCYf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001204; c=relaxed/simple;
	bh=vhfbuGedj/1gevD9XOwj27XPecCoXIxQmzuoGb/VE9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2NKoWM0/CEh/kutMUj2cHdab1mflP6+00IM8+E23YmlsUBd68gy6qVfX2/T+muy0NeTd1VdILR+dAZLJTUwpBlV5H/by6koWwwcM5ffN67kc0QMd6jE4sydezFx1tK9UshbQePkS3cL1ancTfg7Bu4eqAEH+ZMGsJw5qCHIra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7cGKfed; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7cGKfed"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so4403880a91.3;
        Sun, 06 Apr 2025 21:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001201; x=1744606001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFyQ2/X4VLHFdJNUOvn00G8enqPCOq/jHwfmpSv21RQ=;
        b=c7cGKfedq2J7yJpift5dsCV26s7UtN2Sbc1gD7Ibu6pGuLi+2gXpHm2r6rCef1bRhF
         CSUophYB/0c+laIRxLeEE+sCqOPHvFZmHx7+rFJYXA/dGacSpgS+HtPimG30dI8ilkmH
         wXghDFoa+VzgXtR6MDq0BLTrenGX/s/TbdPpxxYhmAU/6tvsFyHCiLxSbz4Cfn4BJGLb
         V4psG5F8ycV7OnR7346RLRB+bW1HYR/18v6c3QcAFND4LTzD4GBHByweLQcw76JzxCMr
         BuqBhuWl4rGzUB9I2lMgOUO6FX00pR7EFEn4Ifc39xPI5dIas2/R2NWFw1FIOcUNpVCq
         fK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001201; x=1744606001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFyQ2/X4VLHFdJNUOvn00G8enqPCOq/jHwfmpSv21RQ=;
        b=GpYN5bjQW7SVvcuuKf/sWD7UampFcNri1x43FrG5BKhahT0gxiAHooXquzMRZD9Z58
         5sD0EWA+FIGuKl1otaoSfxAZbP8ewOTPG3RLk7PesXHHCoyKpMqzF35bc1hA98unVsw7
         /fa8sEPrC1NZNH/sULyfEk5119Q8b9jxJvmx3Y0EZSjJPxhDEpf7TW/DKcyaH90/ilYg
         /zvOY7RieSBsbyJLAfzUZSCk3pkR0egfpUgOcnORfPNwMg65zWISlj3WUa4fKrqI2CRD
         GQF+zwf/RhZvWGKs84V7bn98j5YtxeiSNVzGNeDvIX7zgEOTvCwnUxBso7oppQ/FHFzK
         SqjA==
X-Forwarded-Encrypted: i=1; AJvYcCU6UCSIV1l6BGf6Tqp+46TpA+CgXf9AhRh+VtPmhhPoagWIKhPosB1nDCPw6/ZoaLs00r6Fufh2fvglLVkP@vger.kernel.org, AJvYcCUIxDCY8VZFUzi1q90N7dfYREKasvhJLgCnyC9ePmiEPV4h7DGmeTwiHu78SsSC//tDr93RHXwi07MzQkLGfXtLzA==@vger.kernel.org, AJvYcCWyEfIpX8PQQClMQSZZae8Obk+I588LEaaHKdQrjUDe9Wx3WXysDfZKpvXkFNW7TWN9pTY2DLdL9fPr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gwn2DM1OLbmB9HCCAEcFg/Vb1rGklej0sBECjfpFaWOkn2WU
	jRp/Fv+tbM1cFvEKJjf1UvoEikjk0JN84FXfy9JJe7QGO2bqgF7w
X-Gm-Gg: ASbGnctCMNb6CiYW6pQgUKEcD64s24SGJTxcnvbVl05SVY4tRiP61XHDDOvB6GQfbPt
	8iWCYhs8DNTibwL5AHk1L+N/zn05b++QCcjr2kTaAQQ7ZlsV1pd0t6pFkcUm3qAUMgDkaaox3pk
	SXQdrLjllRjhfqjvvLlrPhQ8SDN9L0cx5TlfnTsJ9x1ZNTF2vP2Eoin2f668249SEYEoIVZ1F5W
	IWpTM3OtvP+HICZmMl+fknfp6A4rQ48vdhHIfx8G9VvPZophdYxhknWE/paXJxuxuHDnaIfVwiC
	aLNzjl0vdFN2NCbeGBDjvqEJsFy8FfYcvOpQgNBgQK2Ajx8=
X-Google-Smtp-Source: AGHT+IHCopq78Jv9nQcFbb2I/Z2cxOn2n7ieM9CFwSW1nMv3SlQs8hYrDcxv7xEvFmI6cANuWo/VBA==
X-Received: by 2002:a17:90b:518b:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-306af745a6cmr10802216a91.15.1744001200796;
        Sun, 06 Apr 2025 21:46:40 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:20 +0800
Subject: [PATCH v6 11/21] drivers/perf: apple_m1: Add Apple A10/A10X/T2
 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-11-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7477; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vhfbuGedj/1gevD9XOwj27XPecCoXIxQmzuoGb/VE9I=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iHy8+4Sd8sfx0kjuH3JoHtkF4RQ9YJ9A7Sf
 Uu9Vf9SDhuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhwAKCRABygi3psUI
 JLFuD/wJdF62sh3UL5109mkKhq49omov96qJ5csB+zRAL6E9Df+Gdy4FbEIX4L2yWe0sLWsWrqf
 7o52tXD0/LwYu81OkH+DA/J8JA1otMnEXKYwPlE82NgNmxIQV3xR5HY17Vl4fWCrygve5ldaVW0
 ejji8ECv1EyyBJ44300xfRIu7WFRUbPjecnKccfbPVY8Of9/R2dBqmaeZ3tI9iCpcqEbczM2h8F
 S68CUinFQVQ1wAQBM6F5zlResTGp8Cz/bF2HZ7p1hFp0dbc2wkku+cyY31krx90o2QimRdhb8mu
 hCyUxniUYyvc+fhRlUF/+b9UvDB+YpPAH5rPQng3VpO41BVFyNK8qn2UuWUwbAus+I0dMcim8h7
 WGs2EP3KYvVKy9FRBsQOKv32gXouJTZRa68014kjchHCITr0k37lfZwFFMPXxlDQYBPpQF5kle7
 jJ9T0XkEQiXrmBYqPQAQqyp7vn8v5d2Ng71lWuKnvvgmjMoAkN0DbngfL/+7hZ/J+lML4m4m3uN
 /Mn6qeD3iNimoOAgW+s9v2mNeiIeSytOjLUZv/K9174Nt1mxN104nytlc9SLhTJbZaTXmCjjKmK
 TndWf/Ek5Tq0ayGWT+cDeKR0VlDb4Sio0aToM5nxNGGWg4rguC2vV4F3tYyj24zVrr9tGnfrPtZ
 dFM62O1+dhqfq/w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A10, A10X, T2 SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 0f59a22812a424ecd442e731a5c6b5be828be77c..4f65ca4ea24157bced11d42a4cbbad5f2dd23d4a 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -392,6 +392,115 @@ static const u16 a9_pmu_event_affinity[A9_PMU_PERFCTR_LAST + 1] = {
 	[A9_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
 };
 
+enum a10_pmu_events {
+	A10_PMU_PERFCTR_RETIRE_UOP				= 0x1,
+	A10_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A10_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	A10_PMU_PERFCTR_L2_TLB_MISS_DATA			= 0xb,
+	A10_PMU_PERFCTR_L2C_AGENT_LD				= 0x1a,
+	A10_PMU_PERFCTR_L2C_AGENT_LD_MISS			= 0x1b,
+	A10_PMU_PERFCTR_L2C_AGENT_ST				= 0x1c,
+	A10_PMU_PERFCTR_L2C_AGENT_ST_MISS			= 0x1d,
+	A10_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	A10_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	A10_PMU_PERFCTR_MAP_STALL				= 0x76,
+	A10_PMU_PERFCTR_MAP_INT_UOP				= 0x7c,
+	A10_PMU_PERFCTR_MAP_LDST_UOP				= 0x7d,
+	A10_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7e,
+	A10_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	A10_PMU_PERFCTR_INST_ALL				= 0x8c,
+	A10_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	A10_PMU_PERFCTR_INST_BRANCH_CALL			= 0x8e,
+	A10_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	A10_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	A10_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	A10_PMU_PERFCTR_INST_BRANCH_COND			= 0x94,
+	A10_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	A10_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	A10_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	A10_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	A10_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	A10_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	A10_PMU_PERFCTR_INST_LDST				= 0x9b,
+	A10_PMU_PERFCTR_INST_BARRIER				= 0x9c,
+	A10_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A10_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	A10_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	A10_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	A10_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	A10_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	A10_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	A10_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	A10_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	A10_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC		= 0xb3,
+	A10_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL		= 0xb4,
+	A10_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	A10_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	A10_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	A10_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	A10_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	A10_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	A10_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC	= 0xc8,
+	A10_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	A10_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	A10_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xd3,
+	A10_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	A10_PMU_PERFCTR_MAP_DISPATCH_BUBBLE			= 0xd6,
+	A10_PMU_PERFCTR_L1I_CACHE_MISS_DEMAND			= 0xdb,
+	A10_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	A10_PMU_PERFCTR_ST_NT_UOP				= 0xe5,
+	A10_PMU_PERFCTR_LD_NT_UOP				= 0xe6,
+	A10_PMU_PERFCTR_UNKNOWN_f5				= 0xf5,
+	A10_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A10_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A10_PMU_PERFCTR_UNKNOWN_f8				= 0xf8,
+	A10_PMU_PERFCTR_UNKNOWN_fd				= 0xfd,
+	A10_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A10_PMU_CFG_COUNT_USER					= BIT(8),
+	A10_PMU_CFG_COUNT_KERNEL				= BIT(9),
+};
+
+static const u16 a10_pmu_event_affinity[A10_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A10_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A10_PMU_PERFCTR_RETIRE_UOP]				= BIT(7),
+	[A10_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A10_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[A10_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_INT_ALU]				= BIT(7),
+	[A10_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
+	[A10_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[A10_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A10_PMU_PERFCTR_UNKNOWN_f5]				= ONLY_2_4_6,
+	[A10_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_2_4_6,
+	[A10_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_2_4_6,
+	[A10_PMU_PERFCTR_UNKNOWN_f8]				= ONLY_2_TO_7,
+	[A10_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -906,6 +1015,12 @@ static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a9_pmu_event_affinity);
 }
 
+static int a10_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				 struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a10_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -1106,6 +1221,17 @@ static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a10_pmu_fusion_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_fusion_pmu";
+	cpu_pmu->get_event_idx	  = a10_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -1155,6 +1281,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },

-- 
2.49.0

