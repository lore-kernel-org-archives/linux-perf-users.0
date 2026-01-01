Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E0284693
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258191; cv=none; b=napNz0JR78Wg1ebuJ7TK1/F7AtFHNwcyzgR/+nOxICfXTowL1Nk1xsuK3WkKuFbLi1q/fE0xBSlF8LnDMgGyA6E1ZTCKVEhppT5VthzEMrAogMoSYC0eai6JyqPMjZwA+SbI1DnNXiOi1hKh0YQpXMFoC/T49ieCvMk5wIMUuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258191; c=relaxed/simple;
	bh=oVjy541ZBoiQRLhg3yJtDhlPYNwhomAgw5k8/id/+cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccg6IQAgt1dK+1yELh40zM8NuGlk9/zrqRiUIN6MOg8f6R+Dbw5coLFgui94U1sfYdTN4mNbGcGfVt/8GYowcipGY00H6t2ig6DVROYQBGras2PERdZCqzHm6w/FdB7riNW4IAGq8iyxV0kNJxOTNmbOADfoMfTquq4Q6OGYoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTbHNbWh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTbHNbWh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0ac29fca1so95802325ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258189; x=1767862989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9+piKMs9G1VmQiTpap3yj2Hp00XA4sCypGJ/MWdS5Q=;
        b=cTbHNbWhhRMaXwXHvclCx7RVfwPWlQiw1aDrbVnP9s7p6EmmaxlkmAItvMIfsL+dZ5
         gMWUEIueITNA520FPZCOAi1u5pJyn3bbTGkd8DWGI9ni+s5UNhZRBk/hp4vN4cKNAshe
         jb0wNYAFlKKYsMllBk+wgwVSGvT/oQYfgYcObo+U7RkyMzF6j5XNThiEYv6kSbEmttdG
         3Z9JP+O62Qxgjankknb0ZRlF8kC9ZtCeRPVIIL/0K91sxxRmPQ7ZBiQJIvHs0F0bi8iM
         +QJXnw41l2kfSIivXAmmUgAwMx+Adr7n9A+IlmSXyyMmyMsm5kGJZ2tjzHdIW+zsUdYs
         Q9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258189; x=1767862989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9+piKMs9G1VmQiTpap3yj2Hp00XA4sCypGJ/MWdS5Q=;
        b=XoCWHkDhI5HUl+qDIwkB7Ee+pm5gK6VpncFNHIwMUnPuhC9J2FfS3W59QJ7i188wlX
         0loYyE2Ad2tBwUp8vjX3gGdcNGZDteS6YUOkkjTzpMj0GxaTumlzeasF0FW0GyxCS10a
         Qen8pylMIuA5utKBpYu8qVfNqpcXxgparzK+eDz3mdnMl3U1Dz0XsPUp36coIskfcm9T
         2gYFl2EGFkIKvcILyZ/B5JZnK79z6n3D7OGMLnnn7f/GiAg9C1EkMPgcnN9idGtORZaK
         pGd07LbQFfOXBj7oV29/65YE9G8VJ/DgPgu/QlKzKm9vdbcgesaegMfx8YBgxdqTOYfA
         F+0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbhLMjjNNvj5tyRIusj0LIOmAfwmd9AflHBIZTo+vxTkqNk0wik2naF6ZrW8/njbZD6Vcdq1fC3HF/EUvs3Hlj@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdOt6pMf84Lp4xWAg/+FvOUhh8DHfp+lzUEyfR8MSp9GdAGuX
	zAYSRox9WNSPqU+wAdglFONe/gO6DoRm5OL3Qhv2NMnLa+JtOgZH52Ot
X-Gm-Gg: AY/fxX6Klld68PaAP7ZnUDEOO/4fQP15mNDCOt3rhAajt75eoZcpMVHiZNhgN3CssKy
	NpqW5Mrponp/oXYkWnvQKcuVGGF4Ux98TrTAtZuvWjBXbMomZA/FriTFwgCS7RBnabnoXOEkAkY
	MkQOGho3Vlb0RiwNldiytftyf/RJGWr0WSQIWOJ0K/ovJ36s28Conrj42MRES6FL2qTm29wU3Ad
	Wq8U25CIjj+cHf0hEsqlQESN0L6noaH4uWfYqZ2b4o83FJ9+dwwu8UvSDiiXB+iF75UncttNY/+
	xxp4Yw1uc1pJrdzPris79xbzN0QDv5OzQlBZL1MhrQ4be1BuGu8SZwIPH49g4JtnFMbKGUirswf
	6I6E7JE4YIxKeMJtCep4DlROrqyKZ1Gw3b7bq7W25EVoZDsVT2K2M8wpgpehPT/q9S3c3XO9ei8
	qwTi4PhWIIgSOV
X-Google-Smtp-Source: AGHT+IG5e2xC8neFWXScdjmBlYktxqiTkUekJYUnYqefzLOE2TQp1Vdct7IJHfwRyqzlQJMS2iUOMw==
X-Received: by 2002:a17:902:ecc8:b0:2a0:a4b7:44af with SMTP id d9443c01a7336-2a2f232bb66mr312113185ad.26.1767258188670;
        Thu, 01 Jan 2026 01:03:08 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:08 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:46 +0800
Subject: [PATCH v10 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-10-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7154; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=oVjy541ZBoiQRLhg3yJtDhlPYNwhomAgw5k8/id/+cE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgncoCTt+ciC+1PLUm11mFFPV2nA2i1R1w9X
 lHzlgeHgVqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4JwAKCRABygi3psUI
 JHY9D/0aADWM1apo1lxJlfin56ZAnvAD6UHgG7mD8ziOpcxv8mesbSBVwmQZD4VWk5YUs0RISS2
 tuuCSHFw+//wZFa59pV9TLuKV+5tPif2pXdBFCyK0OMBN2VTNBJA/fGID4ntnA2f/UObT0Iau2D
 eY1t1fMxdweyfmahdw7EkbMSqXRlLeINMOYSSby/egqFsWa6QxZHyzLav9/Vt7nCfjCjJqu2x56
 6VzBM20Hy4y+oVVhnoBkI6vHbr8o4zNfFwPpPk6ZDVUrsv4qCye1ikCj/93zxM15jC/zgMGU5DQ
 b4Xp7tMfIOhEiFfLBOm+2bRzeHOCkeRCKl7ab60QhyI1d8eAEGwkkkpzTq0rMAB+mL0mlbhyTi9
 LjL9z1lt0Bz+6I0giYbQEUGbSUkz1WUgcbOGGMHO8lf7uD7ku6jeV6zqN8ys71jx0TyMAB67ZIJ
 9G94S6EdNlVlQEjHujrVUCi2XC7YL9o/6E55zs12esFI8RvilElHuHEKeSO+TZc2krohy3dJCLN
 DBhlgqHyHdRTfx1Jq7onXJ5R3m/VOaMVrHQvE5k1Q/z+e/nJwIy29iWfQKWq2KZguIjSqORHAmP
 GrFPw6uVCE62KxcCbAHDUjFcXX6LlzeU3LMgeqtFlm8SMinaGCksqow3Xr2tXIIs2uOr+06un1X
 kPMLPXOrdCJOLGg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 126 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 512b3186326b12627febd033886774ba44641846..fbf13e1ab5c0b61f60a1bcf1e66cb179ae7dc809 100644
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
@@ -799,6 +906,13 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				       A7_PMU_NR_COUNTERS);
 }
 
+static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a9_pmu_event_affinity,
+				       A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -989,6 +1103,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
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
@@ -1038,6 +1163,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.52.0

