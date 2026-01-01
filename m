Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B62848A8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258197; cv=none; b=p6CSMpketXF7bOAJdNsb50cic+0ZB5LQWQFjOUcnUru9q6dIH/xJ9N0DU6Q4i5DSjhFQuvx/8UhOusmZZ+IrLieQ8sVotEkGPNCeoRvYf7pgk66vvd66/FlcFKaMbzBqsR5mQeMlmOzOK8UlcfZmxCKDUk4D3FozT9VsVgVvPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258197; c=relaxed/simple;
	bh=x0Cq2iz5KjiCkyeJ7YF8BxUETaGjpABGcg5ZPiVTUOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjq7qtBcfyKBDTGoLVp+4T9/g1eneF1t8dsO7GwdBldPQGrx8zc096o1qEsqGUVHUaUNowe2IzZr4sXpgDeevNfA5YW9QwReD3fM1olBaqk3z4A7fJ51bOne/pdmN6yLX2k6RD9IuNi9QOTh9sHODHiE9GVCbE3f9EThyQyJN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RysTgo0M; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RysTgo0M"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso9037105b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258195; x=1767862995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/MCZJZdSCnmXMnq5tn+XRZReSP8mv4rySs4OgIA3WA=;
        b=RysTgo0MM1qP7qGvwSbR7cDx9viMo88Yk9vz4e0C5I31NQEpDVyPrzl50tmXtxQMcE
         bsVNCFOke4tt1SGu5dXylzwW+BWoK7WECsj+6NYHZU6Z3FOM30obizjtws9R/RzrNcEq
         SnfgJN70YKXikHmxn5jDs7z28ISjeeyVa/e3TQ8E3MnabyEDhC1mshQ2J+FOeHlt4prz
         9CExoNO0ZcA11CLs6FNR3jDrCHmv/lQeQDbIBD5VxTMK7buhnkEPgvP6AxBfmOjfUE7g
         Oe01AERhEaj2R5ImCJr3LkxZtYdYj4atf1oIlx4uZPzqUVJHUZ2BRvx82v1X7D+irN+n
         lZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258195; x=1767862995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/MCZJZdSCnmXMnq5tn+XRZReSP8mv4rySs4OgIA3WA=;
        b=kpi7NxwbmMTcvqpUQkafw4QW/sjUgVb+j8XBmj6vTKRz6cIFTK8F6C9XvV3jZMwgXN
         xxBew4rr6/I2o68PzTd3XPhTnev/sTJIZaXZ861qUdd+n6uzyM2hHB2U4j7+LhxdNxmb
         wHUUIM7GoKVzEQjYawIHjXALWcw2d+/xzvUg1Aejv8Of58RicE4IVHTKH4xyK2Pt4Vj5
         UG8hc3bP49QkAHHC1M04zokwiAg5mZupht2AZL991o8SrdqoAnwztvtR+c/IkLDUZyta
         IAsCz+SZPwyKpK6xjlM7Y4pUV4WtF99jAQxx7lDuqka4p5RAzJ0a11sHB8DTWqTzkK3b
         1ngg==
X-Forwarded-Encrypted: i=1; AJvYcCXbt1fHhkRz8akY8dInQfnDpicLhnTHW6trW9NfUqPMvCnrnp8AI/yVberIHzZRBFb0oolpl/dKLLj9bLIZP53W@vger.kernel.org
X-Gm-Message-State: AOJu0YzjULk1vmEJCTGvN0WhKWTA+attSeHCmu3eJJMJFVKKRYNrXRez
	j5SNQaGwRiYLxYWEc7D5Id+F+5hmyhEQagvu3thmQX21s8R9/rsyQhWq
X-Gm-Gg: AY/fxX6eamTeBEdRC4Q/muIuktcmS5n2gXa3On3j4S/qfZzii3oHPfVwVaJ1cZ6dcqu
	QggP1YO+iuqxFlvGmYh5WzNK5VDZPpepsYuo1TzoQ5dtHNDnEsEzo7quPG2lxdc78FCifeUXxeq
	g2etZjvCxNupXD5CLY1iW6NEeheI1v56z5ocklomoqLidZKTQ/iCm917RaqxGvWHt8YmSzEHuvM
	hyFIR2nE1iUNfrw6U7WEo0+JBV3f7ffCvOBjzYTfkBlhr560I4aPacWc1ROrsPl8OX7Kd5bpzWJ
	n47NBuJOOcydoYXg0FkqaLhOkVosjkWh6f/47XkLmn4iOu1+9nbY+I2XPYvDkgwMgZt32rXleSM
	Bjob7G1OS51RYgnyyYXCFsa3Ut4UK7AJG3OA+xdqIDAlVPoliZHK05cBBanNZdYlJX9E3POLwoK
	SYv0sUnopPEFUH
X-Google-Smtp-Source: AGHT+IFPbMrtQ8L75en86FOgy1+ozYTQh8z4gOoC4ANwDEDFoyox1rgTrNTjsGtbnK26pa2nvdXe+g==
X-Received: by 2002:a05:6a00:3285:b0:781:2740:11b2 with SMTP id d2e1a72fcca58-7ff648e61aemr37085450b3a.25.1767258195090;
        Thu, 01 Jan 2026 01:03:15 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:14 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:48 +0800
Subject: [PATCH v10 12/21] drivers/perf: apple_m1: Add Apple A11 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-12-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7908; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=x0Cq2iz5KjiCkyeJ7YF8BxUETaGjpABGcg5ZPiVTUOA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgo05Q8bvLxJVWQ3+PICPel0cx2rwTCZvbSM
 7spF9Z+kjWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KAAKCRABygi3psUI
 JKXPD/0a6VER715ut88ocHJj+ZA3cUb1qjvNI1vPsQHZxuEG9UaQ0OUukgod1bPL7NdPclDtZ04
 RHKa3/WyeXJiREwrYyBVuvO4DWVv440uX2oPJBAVWn5HPOab98+HJ5/w3z+RhEit8f/IWBlTfA+
 KN0JH3PiS4w6PXJV4EsTaGlvtW/lKNn7ztx7v81Yggg671aDjsnQ1hs2ADtO4p7GcwU9zKDxjUE
 O05AvyUtV8irMXR/k3JIe0/+vIUKY6BAIvE35BFNTV1TJDXqdgyUZurbhEsVFXHb6n3zcS9WdCw
 VYh/Ptwl7Qy8M4+bCg6zdOd+r8vmhD91JsWeUKThMGhUR5opPHwckcXatxKev6D9q0BsdYqJMKG
 OfNlbWGwNJQ13yxXTDan4DO0MkinZekDipdqOhuQ/ZeS4fIXQqh3W20XynJxBAbNxiWvbCp/IRq
 4VO1ybZWant2/TbvPfmObZVmodVVXxuhMlD0l2EHOIcPDpLd8j+USIDF5HUvi4pjw4jo49+pL6R
 07L2BxOgXUBotM0zlaYRMWdJoajJsNDw2v/SAo8sJtd2G/sxEMdcoOXHrsoJ6iA8rDFTxfLOY9X
 ZrFpqwajXKWIKgq9lsyEYOGxu8D0JlZm1IR5Rau4HECeTJ8F870RMkPK7mEkKKmvNW2Aevfuf5l
 jMtXOKlbWDHd8zQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found attached to the performance and
efficiency cores of the Apple A11 SoCs. This PMU can deliver its
interrupt via IRQ or FIQ. Use FIQ as that is faster.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 136 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index c7f58f53a5aab5cf421c5bda82e57acac9b92a81..23cff6e6c4e701b086ffc7fafd72e4be1aa26a8f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -509,6 +509,111 @@ static const u16 a10_pmu_event_affinity[A10_PMU_PERFCTR_LAST + 1] = {
 	[A10_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
 };
 
+enum a11_pmu_events {
+	A11_PMU_PERFCTR_RETIRE_UOP				= 0x1,
+	A11_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A11_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	A11_PMU_PERFCTR_L2_TLB_MISS_DATA			= 0xb,
+	A11_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	A11_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	A11_PMU_PERFCTR_MAP_STALL				= 0x76,
+	A11_PMU_PERFCTR_MAP_INT_UOP				= 0x7c,
+	A11_PMU_PERFCTR_MAP_LDST_UOP				= 0x7d,
+	A11_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7e,
+	A11_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	A11_PMU_PERFCTR_INST_ALL				= 0x8c,
+	A11_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	A11_PMU_PERFCTR_INST_BRANCH_CALL			= 0x8e,
+	A11_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	A11_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	A11_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	A11_PMU_PERFCTR_INST_BRANCH_COND			= 0x94,
+	A11_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	A11_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	A11_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	A11_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	A11_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	A11_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	A11_PMU_PERFCTR_INST_LDST				= 0x9b,
+	A11_PMU_PERFCTR_INST_BARRIER				= 0x9c,
+	A11_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A11_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	A11_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	A11_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	A11_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	A11_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	A11_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	A11_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	A11_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	A11_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_SUCC		= 0xb3,
+	A11_PMU_PERFCTR_ATOMIC_OR_EXCLUSIVE_FAIL		= 0xb4,
+	A11_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	A11_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	A11_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	A11_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	A11_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	A11_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	A11_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC	= 0xc8,
+	A11_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	A11_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	A11_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xd3,
+	A11_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	A11_PMU_PERFCTR_MAP_DISPATCH_BUBBLE			= 0xd6,
+	A11_PMU_PERFCTR_L1I_CACHE_MISS_DEMAND			= 0xdb,
+	A11_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	A11_PMU_PERFCTR_ST_NT_UOP				= 0xe5,
+	A11_PMU_PERFCTR_LD_NT_UOP				= 0xe6,
+	A11_PMU_PERFCTR_UNKNOWN_f5				= 0xf5,
+	A11_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A11_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A11_PMU_PERFCTR_UNKNOWN_f8				= 0xf8,
+	A11_PMU_PERFCTR_UNKNOWN_fd				= 0xfd,
+	A11_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A11_PMU_CFG_COUNT_USER					= BIT(8),
+	A11_PMU_CFG_COUNT_KERNEL				= BIT(9),
+};
+
+static const u16 a11_pmu_event_affinity[A11_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A11_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A11_PMU_PERFCTR_RETIRE_UOP]				= BIT(7),
+	[A11_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A11_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[A11_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_INT_ALU]				= BIT(7),
+	[A11_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_SIMD_ALU]				= BIT(7),
+	[A11_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_INST_BARRIER]				= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_UNKNOWN_9f]				= BIT(7),
+	[A11_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A11_PMU_PERFCTR_UNKNOWN_f5]				= ONLY_2_4_6,
+	[A11_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_2_4_6,
+	[A11_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_2_4_6,
+	[A11_PMU_PERFCTR_UNKNOWN_f8]				= ONLY_2_TO_7,
+	[A11_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -1033,6 +1138,13 @@ static int a10_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				       M1_PMU_NR_COUNTERS);
 }
 
+static int a11_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				 struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a11_pmu_event_affinity,
+				       M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -1245,6 +1357,28 @@ static int a10_pmu_fusion_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
+static int a11_pmu_monsoon_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_monsoon_pmu";
+	cpu_pmu->get_event_idx	  = a11_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
+}
+
+static int a11_pmu_mistral_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_mistral_pmu";
+	cpu_pmu->get_event_idx	  = a11_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -1294,6 +1428,8 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,monsoon-pmu",	.data = a11_pmu_monsoon_init, },
+	{ .compatible = "apple,mistral-pmu",	.data = a11_pmu_mistral_init, },
 	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },

-- 
2.52.0

