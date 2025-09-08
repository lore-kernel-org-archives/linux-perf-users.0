Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FD2FDC57;
	Mon,  8 Sep 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325692; cv=none; b=T7p4+/b6pKzsnno/9AAcmETmlf5SPvY6Da8OOnGYAgCXZDB6mDtfmerNFeb3CfGgoY0USLX61hmPCIVRi5L5AOuOmB3nQViS8UhoMwqhz8n2VGbkuGKzLp+4NPtfwMdhiyI+BkbyZPAjF9wP86BTn5bGsxdntvbFs4FghP7AaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325692; c=relaxed/simple;
	bh=LUTF42ROOv9lWR+4KsOLqtJZDON2mQ0ehFAdOL90kEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9sbpdhqgYdrCMWSOlUnvprvcQurfHdzaqR4KxqI3qH9I7YjgPkDKevn02GDw0V9vAzxbuR2A3Z8zaX7d/RUc10XIWibgmf/iJXSj+6vtw9582eRZnf+jVf409C2fkwQMewIEYhKk+tuYnx0PRRfWdo6KJDfDZhlnRKLSjMG4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf+Zovhc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf+Zovhc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b522fbe3088so569187a12.1;
        Mon, 08 Sep 2025 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325690; x=1757930490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW/u6QKovqkYoXjfaaQ4q+qjIiyLs7/vzeRi0yEodtg=;
        b=bf+Zovhcyrqflf9YsZJ/SKZ/A1iQEQHDTatCPtvu7ckcVuOUTvXHDdUCV7Cd0sRihr
         rj4pJGlHz0xrYbKx887CgURoex27VlcRSnN7vvqLSnbNgVvgBTvBIF2qYQxjwr0Qa3t+
         PUaR/V9GGab1/EGwqCc/VdCiDl1lmpI4xOUsWi4ryARdttKFHosMy7xF3limmd2gjDrZ
         Hxon4Y8y69jz8VaPNiGs7AR17OATCS690YNs4Ke0qQhSPP5rZdijN9m1cWaHEJcxoGJu
         GZCcnT610jDPnMbRZ15meF2dmPMG/GJIhH2y9H5YOIeToBOXbMU/EEuVlqd5yWayuKEA
         gUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325690; x=1757930490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/u6QKovqkYoXjfaaQ4q+qjIiyLs7/vzeRi0yEodtg=;
        b=aBPZuJNYJI9n/xR9ZISOo171dXQx6cSwIQs58ukpPBMdjEg7RCtSzcm7uEjtsl+iA3
         C2vK41LP0/W6hwnLfB1pExSydVvFuggeBYoECfqWeggNYzMy+5J5l421c5Mu8Vn0KNok
         ZpE/sZR2X8npNj3yWOEjNbs/c7+nsO0lIOaO+4IVoZBLihIRttmaiSSh4VkWchlj8ow9
         9DALdS7OtvaG9K5vkoNQganVftE+NOKDFzGFNbTZTY5VXiMIExvTI2ERm0cXxcnWGRKb
         xXPIQcCcbFS3JHHr6How5fuaGi2wwSzySWmMcffx4VvMbg2kKqscAdTh33jahRK0hidu
         gBmg==
X-Forwarded-Encrypted: i=1; AJvYcCVAesYERnDcs/BlbOrlQduRmpepZQ8qQfkVhySwrZcTdtuxfrN4XTiTWSBNeOWstcZQ2IoAweyfZTrk0Zv4@vger.kernel.org, AJvYcCWqTfTattvTPG9ihzMfvzC5N+vvxlhLdPtZOmxwbRjNWkcKidBgL66V008Jr9i88K2DA0cftYUjqwr0@vger.kernel.org, AJvYcCXFKn4mkvbqwt/UnuBiDGuYPy89mK0ujNSPmS0pZNFtFVrePjPtNTWzwiGVM7PYao97HMnS4a2vpgK2UTzso8+c4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwarC4FmyA0AQygJTNVA0eIZo7PPfHKrZeiyXeAg1w+dBfyq68H
	o5OqQ/7w1+7vYmClPyjoanHJGTz1z2ZXBe7xjgbS2xxpKjwYIvNul571
X-Gm-Gg: ASbGncta/OJ/Kd1hQElF4DHjVUAjl0EN4h9zI56u2sOGbEMLPmiPsRaUj5dN4iHRx8z
	1J7EjIIz1NpyhHubOJbvqIdI6p1ikgsrXiDPfokDSkb0i5XwNeN30A+H8+atGsMdrom+TIYt+E0
	iGLp7YQ/3Im+QnUt0fgP66r+N8GIz1BO3Ps5XYOMkK0PkpuUuLUyHt6pfhJC5wLnMMPMP2U1gfn
	3t6eZhlBYAMGtYkzho+xLdRxx37/5UamAuENu9cVvBEsopDLrGBe8B/yarwHlF2R8bPCOTTatot
	/GmhdJVPaFmc8Gf2nAcP5V2b0BS0SBps1jsy7fTh79GvZu2zK/Mha99NpTQ829ZizCOIMFlUgJv
	MTuCmCb9U/jqrKMqIb6pqGkqfRucwvECv0rVARw==
X-Google-Smtp-Source: AGHT+IGqFyg8M779JN7vZpNoonq5SLITan8X42VEYbjbAKkGB18BSM3pzr4jwL1baVOwYl2lLRo8IQ==
X-Received: by 2002:a17:902:c653:b0:24e:7af7:111b with SMTP id d9443c01a7336-2517427bc46mr80811805ad.6.1757325690097;
        Mon, 08 Sep 2025 03:01:30 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:29 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:34 +0800
Subject: [PATCH RESEND v8 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-10-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
 h=from:subject:message-id; bh=LUTF42ROOv9lWR+4KsOLqtJZDON2mQ0ehFAdOL90kEI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlD6gV4uasUu9A7D576CKcpDSoH8vJIWnHJl
 DgMA/Ff+xCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQwAKCRABygi3psUI
 JPagD/9uOdIfUGCw1TD6HbWDjCa/xmGgSz9LSI8K7Gm2yptbO58E9nN4jlUkHxC41mEc+ZiXtY6
 B7L2fBgVIgHHAaNJfgwOEdVr9XMRrqsYpgXWiPluK6+M6pEEljJ8rDU0P5DsWurK7KdDkFwjX2s
 n3Za9lvSY9vZ/Ejo5UQTsxQ7uIs9TjUR2MGNjgCC7s6PnlYIL3AQqUGv+nYNCSuNs6RTNFdULl9
 BI94caGefvzxQZgz4EWXEh3Nms3raJmGLgQlV9Ny0PWavDrlV/+gOE1aNid/2lIMbJXBWUTQOdD
 sVJfmfAk42YWlRgjPHNEaJFMKicDbI5UPD8jHml+PWNqyL4ifj2w74DGZ3hRWMnXs26M7+p0I1v
 W786BptuYiEKUaP4be+CcJAYoebSQDhNELbsnPJ+PVTkrm13QCy2+IY0D+M4aqZx5MM5aDDJwkg
 xc2q1zrF230LCet1XD0NRH8Oexop0JNz7BOBOl6xhqeIXL31QpOzVpQt40m0HHlFUwagEw3Qngr
 kenBt6D/7FYU5UN/7zyNUc8BcJyxXbA5DSaz0sx8zer97rmb6t8IXPsM3Gb+THDsszGhlbc069S
 JDm+VYXBcTOExHw/DBMApRYuLyswCEnRgQJ7CvRfa4OAVkwmjfxhA5u4Zn9RkcSNnKHvSIJPcMm
 EsPGOppqoHsGOEQ==
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
2.51.0

