Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5052267AFD;
	Fri, 14 Feb 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543459; cv=none; b=EEt+prXYumXVfykUh6jLOp1QfDXulETqse9cFZL8zo17UPxKTGJwRG49oxS2cDOuC6AJZFC8Pah5SL8cLqYMQmlheZIK7vLuOOC1drpHKxN1+zZHaGPLKnLGZXVercjDDDmIni4WCm/XnqU4EY4evihw+T3iHup3cL4duIuEenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543459; c=relaxed/simple;
	bh=IOLPmmdLpTyze4pMSwzOoHnsgDuo2hfTL3xYJ/hiFU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEe85Am6cj7Ho4hDKeV5pO8qVDSsFosp4zYmQPDcuAhR9XBgV/NZBwN2hhmV2PjPZFjc0+oX+uLGMWw3/mhMlFT0GVDFhMoDVnzx/gudUwwIwpzBmHSnqvDn+Ctnr9VX+f/71w39nZ/nhic0Tqtb2F0VJHMdpz9+YYHVNADJKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFncDFhj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFncDFhj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ca204d04so28581695ad.0;
        Fri, 14 Feb 2025 06:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543457; x=1740148257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2B4nOgCKpnlrw/lYJ2ogw5EzOWnWn32vvattNHW96K0=;
        b=JFncDFhjy2Z3BiUHe401Xu0sc29Upguk0TOllHMn5Igik1Pd11pb9ffneXDZuhQuzp
         TuBcLaUO5JvW8u+5rU/qXCC4SPwaruXdJSisOMFhuVLZys9LpXELpu1rMRpCTaq+EMVU
         mwxA14ksrSnZsEGw7Ty8zJlfnpWSVcUY6aJ64rWh35TzpbC3b/6dvpIpUicDg08npCSL
         RDv1Tc03fz6jVDxDzaDiiyI+8xtjAdbawPZqBd2cedXa1Pr0rHOo61X4aQ87o8hsOBsu
         VyuGpMr30hW4KPRL1jU1g8BSjQI9fnkp/ciQe9pE+WpuOXi8d2VZh3nkOPv6bts06OmX
         6Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543457; x=1740148257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B4nOgCKpnlrw/lYJ2ogw5EzOWnWn32vvattNHW96K0=;
        b=d2hho81WT7ZcBXj3qDgmbD/oxWHx3yaRoFR45yUW7VEvrqLowHV43agIYXrMQ8/3uK
         IbN+r889j3SXBuwW+qGwk9LHor+Lq+wwOMzVgqaHvj5wW147ONJpNLIV5Q8W5goHVAnj
         eR64xmT3DTe+cmIvZGTLJelV55kv2i8+BAgzBdUt1u/LDyl4qB39Cax78qqOfVKwyJIe
         JdMSqVgxZiKL9P4jXpWCIiCThQ4E91nK7LOouiW/3H8C1aUzyxuKP89C8m7xgwzZyByq
         SPbZanxWFUtG+qzHp4qEaH8inwYbil21P1TtmkpsfZg0/7drEiFtecE9i8JwTvkc5eYg
         wA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN7lDPCy983+8nBG+REyUXENf/wh60y4jx/YIufE8Kiq/I3/sk7Ege2QcKMKRNa6D41BBRMZAosHtYzY74RD/8PQ==@vger.kernel.org, AJvYcCWVWTz1kuSvjQhwDvuxlkxt3iGFxcA9J8p6JqN3e61SeUpJhXClHkzKk1J/x8x58aEWdQhoM9E4bkE0DnL4@vger.kernel.org, AJvYcCWjrosxpYHVYbzeCiL3fZrjAPCukTCnfdUTYfkcsxG9Q6bClmnxxjaeZ4CNbrGpGXJ31lAXNgs2mmnw@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIGZS8/9qo9n6HkralPUAmKWn+zOksZ5PcTk/asLOJ5ex2m4H
	8JurG6P8t0YRJZjQeRkLFDJKaPvPA7fBmHiAwX0f7FtO3weqqjM/
X-Gm-Gg: ASbGnctcAF/0hggPqL+7x9zP9I9V1thFSl+8Cj5WmqshrxQrvA9QvCxT6qC321SrWCx
	WaULtVP7oAB1zU3tuK2wLUwD9DKqh9ZwfmVnIG68TeZUdzR9aooiSCW95G5eN3+yCGI1tBXsuIb
	0efzmrPoVXbEWSR86euWSsn7WnMq+BAT+FZ6lJVN8waEUNExN52GIR7MrM8wLT+a/UVAypzECr3
	637yDN+mJYp59fSdhNeopJ65M3BISs+8duYxQra6bdV4digBFJyitjnUre24YeuXsNHxBXEBg0C
	UHrRPO5xcvGFNrzX3Q==
X-Google-Smtp-Source: AGHT+IEVSE/Y6cpIeGYeF+jpYChzS2zybZlEniBjGqkXH0nhV91KooXSVZXwegRR86VoWIi9EndN+g==
X-Received: by 2002:a17:903:188:b0:220:f4db:98b4 with SMTP id d9443c01a7336-220f4db99a4mr38780945ad.24.1739543456995;
        Fri, 14 Feb 2025 06:30:56 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:56 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:35 +0800
Subject: [PATCH v4 09/11] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-9-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6995; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IOLPmmdLpTyze4pMSwzOoHnsgDuo2hfTL3xYJ/hiFU0=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OAAzbsZznXVNuG0tkE6m4quoPUcIv52LnDT
 Fby5td33cKJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JHI0D/0WjqcqLActa5VN4oKwyRqJgJkhkgdKR2odrxUePOx/6B2laKpsAaekCusP5IULd8WwKwB
 Ye9v72R2/Xh02/+BPap7uRiw8L23EqT+0i6iuccO7L3uQjszRRV54WggB4/pm4gbS4GEbbLCDZN
 Flt9JH+OUpyAxrW6UTP3tJKGgw6TvtdvsKdPrSNpVJV7oKHa+JfQkmHhHbJ0PBG/GK4GBO8H1NP
 9jBZctKWMEysZXf9Le4tIZuiF/Q2Xqlp74+5Q48+lYoC45VTXIxAgf84ZHKxptgslDchKDxEMMn
 uJSyhs2SRS5mIz8foei1Y3vpZysrgHFd7tMtV4SGtCunYs5xjoalp91yey/rpZwHqndvdccWC4j
 CPr1sPJMkDCjMU7IaDmGgfqscVBGIJr3emveUU3/IzHNsNgYeLK9eFwsXG2ZPE88hdefON8ZHPC
 cwZiFrxmtHqUgSehZvrE3JZ3XQBUQNM0ww8DOLlMQN8JLnAyrNO4xMN1PuBk3lrpw7WLAChifxX
 O07MuGSKpG0RH4UXJUpTvICsKqsy4DzM/tMWlQCTFPnBoxBdvkO6zKhuBonaDHO+22xnYCp+lgu
 qeC2bDVCTd18o51CGTt8jXXdWe8lC4kKP+IOmrN5AVhk0Dl5fPM5hFjxzvdwzkSh/fUU1fmsKsH
 5i1uNhXH0F6CAuQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 121 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 04825a1991ab1c670563e3ce91b43fa5d8c85920..f7ae5cd56980b75d8f2073368479d0af77ab351c 100644
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
@@ -769,6 +872,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -929,6 +1038,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
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
@@ -978,6 +1098,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.48.1

