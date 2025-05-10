Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A92586DA;
	Sat, 10 May 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889928; cv=none; b=jV2kiW4EHFsBgveOxFIYJ+qgmCV0sKijVxYIqSrJmlnkqxun1onA2El0AeFghls6H8MYrx7ZPMkSfzbQTGh7iHwQ4O7s84msdYc11/P9cpRgt4wCJPLUqTl7JO7V6WGvZtK69ytqQu8npcY+yqQOCcbX0mZGUSHrAeZcq1r+MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889928; c=relaxed/simple;
	bh=7wE0yzPS1UdR3HX1uhwHr/0JyraXWlDKVwdFlazVm24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjSNCpd1i2Y4CDMqynWOeePl+pcgOqAMo/XLTr3mA/C4RrH8p71REMc5/I4gseEBr/t8aMbx+qe/Z0eKC9pbfnelaThh/FOSXxFbM+bmbribV2IUswNXGbH+voaYIpbpXWaWtVqKXw7jQChR80Rf83TAsUqBs8kM0xEEI9fqCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFX+gOvd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFX+gOvd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2969046a91.0;
        Sat, 10 May 2025 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889926; x=1747494726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCmmFm1CBk+EorNRxn6b8lIA5MUEJivXBfyAC9O5RSk=;
        b=EFX+gOvd3EgIzqAaAFYC5W60tV+p8CpIcO5mWxdeg86U/BWWQMdGi2A5zmgyJsgEV4
         Wh8ZNwPIx2XvALnhMR0OhkYh+t0idoU/cGHyDlE/wICwT+aMDfe3XzlyxwwUgtePJjkS
         Qi+zCoptm+orfFjRbRRrBz0+u/KvVl/JKru6EH2rO3luBQKRPWc8r6lcP5VE9bQV6EUr
         BHVW1OtRf/2NzAU1ALf1kHpI189VCH3cNMm9GFhJiLPa7NwnaM2O6L2gZ+149ic9HmWg
         w8LXlvd5ixF0Of920Ro8ugezp1+bW7bT6j1RWMhHAS/zN1vcvJgu9q50WwLWxSj4P0zn
         w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889926; x=1747494726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCmmFm1CBk+EorNRxn6b8lIA5MUEJivXBfyAC9O5RSk=;
        b=RRE4nJiS947QLdcd5JAtUq1Lr9bwxGLvk7YpV+HZFu3V8e7XcROvQTFWnDmR4GoPCz
         MkS2EXx0+o9z7ObkqgmImHO4tJ8zeubI/HPWRHbSPqvPYNl9WY0jihLJTvdVxw4wf9gz
         IVM0gxasCJZEymyysG9YZZj09QWHqS/wtfoaE7q4IttHpNtnueFES6oE9cTa3OlzNH9N
         rw98xE94EHr2Ogs0ybUANIyyjY1xD3iHl1OlxGnIdav3Cz4rPG7chPb0ytFzevcXNfPR
         IxDcIbjbJDwsWiSzZPOMZ6j151m8pixli+J+5ipExNK03+8mLt54RbhUjzDwSq27u1HN
         9/hg==
X-Forwarded-Encrypted: i=1; AJvYcCU+sO0ZQP4IDv6wtjpG02AjxCOPMeH2eIEo9W8apVT1DfcoAb4HLrrSRISB566mPrA0tRvfTeb/CiBrnHYuyFBRqg==@vger.kernel.org, AJvYcCVEzM05xAEvOzuDera3bSr29ilGiI5YjB2qbMLiZr3avUQZxNL2diBEyj0NvjdXywhRpdGdZ4tyb6/r@vger.kernel.org, AJvYcCWNCCr7+1eqlX2EVlCN/exCOmPyAMXoR4MHI3IKWlv0VTuUPMlFwC0/Uw99Biwe5MqMnrO48N41js6hCoQW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxej/Wiac5xXpP1rc1xwpQEWaCmrDM71855iL9/1IqhC3mZIfMH
	mg4n9yx81wgexsq9oD+yZPLOZ7c9vD4nGxRf7JRB02/3+sRFT0WcuTDuxA==
X-Gm-Gg: ASbGncvOR0qI6UwFWDMkELztyZDkaswpwvaUCw+CVlIuKBpkreER7IVp+FVodJmqtsN
	oJmtowKqROCLjvwdijlGiowSz0JUBO5watqMyhQHOj8jbNIIgljoVNIDV3Ze+PpkoGB6S5+J+9M
	OQHLjlSYQjfkYp1MFeVXjxW6LuMUBQqEsYbVDEeXjga0L4uhHeu/2y22UBOGf5hIbjftOWI/UcR
	IoRmtZRLdNZZNV9elkWOVdYK1RULnKyM1L7j5ovOGQpYk9fzgi3PjctvQxL4sywzmNuE7sPukOU
	+kAWr6m0yMsScvTIYOemiCI0+wKRaVQQfnK5fx6ircxswvMy3x6tS4ylE0HpA252
X-Google-Smtp-Source: AGHT+IEMTcMe7F0hl/lByV8g9kMKJHS3o06vr+7sIPFZmnaXdwiR4EIQrMASWCJjHnSGW299FFRWdA==
X-Received: by 2002:a17:90b:4c0f:b0:30c:5479:c92e with SMTP id 98e67ed59e1d1-30c5479caaemr8043625a91.4.1746889925702;
        Sat, 10 May 2025 08:12:05 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:52 +0800
Subject: [PATCH v7 11/21] drivers/perf: apple_m1: Add Apple A10/A10X/T2
 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-11-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
 h=from:subject:message-id; bh=7wE0yzPS1UdR3HX1uhwHr/0JyraXWlDKVwdFlazVm24=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ybpB5bq6wkNUkvQWmGqvteVM7SC8jSm7SL2
 73/SxqeR8CJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smwAKCRABygi3psUI
 JCwGD/90AgUU8arlwTXQNjyjreDKDJrFH+qhei33gqFg7UJfECMXAgBmtFqA47XuGyX6+rujkkU
 6xNzi/YniiWPpQZT/IZxW9dtcRL8VXkZvDdWXvV3jhQhAx+ydJaiRIxeRxekNiDRwzEsVfw26rk
 ldB2ZT7sY33MEMCEK0L/XsoFOiZYclLCjI4hCISLPI7FnPuEFfrz+JaJ+XERVMjGXXlruy+7m0w
 qrqL9xpD5boYDhYLdfIqk/uafJjte1xe2H0KSc1lCBuI6RohEMwHJGotLY23xcSxPaRzH2oDCRo
 +kjUjh+RTMVfFQlihY8E0nKcJz0HaEoVLeGGKk2c1enZ0XydO/rKC9J9pSN2/QHRsF3Y0P938bT
 WIzmu0Mgj8oEeRP/uad8W/be20JcpqcU8Ex0U/IiE1MndcjUO5aNMgA2kIsVlS7JRedFnCIeb6+
 UzyQ3ok3VcboafbGKxKMwxnENQKOY0gX8OUvWAvWVIf70q/krK/uf2n1RSI6ud+YmXi7W0pr1q0
 ODufeP2gh1/utLhxhNSaNEy6qb+6l7aN9BG79E7LmLrtHNTxvrKnjVM4aS1dqR/SeozzeoKSIga
 zDQ1IpOy7ujE/ULSb5sSj7yNuih1gxsxCYXPamfHCWkvFErwHcwLxuXe7X3Z3gbZIam9rBS5BpM
 Jyov44W3aUBr02A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A10, A10X, T2 SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index e89fe646a849f50615a3dc809e51a6cd95dd9a1b..02abad2239340e75719e989c4345d411d55de89a 100644
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

