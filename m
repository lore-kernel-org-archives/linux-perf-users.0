Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20524290D;
	Thu, 13 Feb 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457404; cv=none; b=MGFdpszhyGl01IdloEFh5PpMLIW1hQwfSG1fixtKYXEhj9WWACUVgzWu4Dup5L6N7upZqmMOESxydYVdB31iMMQSs0jwvexKOYqn4B76JXnJrGrlj8N3sT7G/Ip5es4QOKcP/rroXT78h9YvLLUwHdbcZGksbom/MR/jh2KJ6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457404; c=relaxed/simple;
	bh=iE2xp2YgTOHAtDaAC68OUbJ4XHgbUi4E4JAVvVKyHxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=io9ilJ1HjnkMTH2IxIkWBcTyri1skvAcsart4brDfI74xNC7oCWUAeB+XshgQm1Un7soC5nD3KiSngskBAkYnjSbzZKIB169w/alHJ7iQd5+cqmxe96Y0zHoh4hG3t+Q+1GasM3EfTZB+DnAzkr1UOJ9O1kaO3c87UFO7QrbWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDdosxl+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDdosxl+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc11834404so1085764a91.0;
        Thu, 13 Feb 2025 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457402; x=1740062202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETo6S6ORT2iqSyakXn67i15BhfjoQjDcIunaEZxDj5c=;
        b=aDdosxl+Jd8vLgBbfcIkVYUPMKW4Rap2FfenVlrTPFPk1+pZjxQ/WisAHWRwEyl1HL
         oFU+BeCt/O9JWxMoPcZbfMJRYINS/SfzH+TBDCvcr6EfLfNdaEQ9Z7WtQ6IjFd7lLvI7
         M2i8TwLbEl5WUBQE8TV6EUAozM4xXcpWpxcWlHf+Sf0WHJ5eic/V+S1eOXQ6dFkNk5aj
         bIe2EUzg8sA9LMuf/vqImWOTV+cdF9MXwQEh+rGXvJ9DxyPTmPpf6oRM93riFK9jX+YR
         vwnLwgi79viwmx35xf8+9NfhlcCybwJgQmNX2NjkSI1ijLA4BrukDqBY7WK3ptWIaj9W
         dRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457402; x=1740062202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETo6S6ORT2iqSyakXn67i15BhfjoQjDcIunaEZxDj5c=;
        b=ajHaST9DWlXOWBln+FTgSZ5xeZhjdg5vynk6vmxjzbCRagrgwUy7XQJvE6OoCMMOwQ
         1JDeqQnHJy6bfz7tnpelnmQgmklqoV5o0NmfJZZHhu5g8lHCxSLFS7YgTu61CYZ2OLcM
         DG4GjUMYSIK8W+CXYUgenovq2yJ4HH017p5NOLiArQCl56qHLdmBgmorxa8F+l3hcBxZ
         paCL66I+fzeIk9knYeWJ5N/rFImMoacFCdgQ963nlO4Mtbxs4fZ7+mpqHKry3CjPymX9
         Yt7frZ2I+1IEGlfYHAYdCbHr57IWFodmTX6qPn2GRC1hhHtL73opRKIjn58Htyf75mxw
         GqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKSEtK3tslmUazUJr757ll7MRN50xP1P2piqiPaPbcxKzPKrO0QkmgHzbELIUYRjtGo7A3xEkq9PybOeyy+4F42g==@vger.kernel.org, AJvYcCXKbS+fP8ooam/iLZ1TYX7dYorZL/4R/QeJZ6UxZ0w8EL0Zo8//bcU/tANr1DrEQyBvF5RTDc9X0jz3+rOb@vger.kernel.org, AJvYcCXXXSJ2NUp/YEuA5L149m3pUs0Brd4yO52G9BDPFTNtSJzOaa0qTq2UOCCyxdDkQqq2fPTKLyQ3PyPY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8+Uhd/8eoxZkRMU6T+Ob2NhkXlSxffCogv0tPcXjF95UxqOF
	Zj8rMAXtoJXu2fguKod/BN7/4yJB0pB+USEGlWyuMNqwOQr3LlUy
X-Gm-Gg: ASbGncvMi66Rp4JfpNwuIyD28jASKaRRK8pfUR8iDY1Y7nPSqyzZx+z0jCzPfBe3jGG
	xTUlE5Nq6N8/TWOK9HH64NMwlQccxNAehxRbtwSw6mBZHhdrbKQ2NDUpbh+i9hey0ibXo+nJ7zK
	AAiIHUyQGGnFHrAkXCqziw4PZ6hpz6/oEuWnJ0ERdVbi/DHBcso5YCkMsRMHndZIAdHGxkxVixS
	egt3dw1W6KbXhqK+3Y2iNBmGB8Bn0/Awj6TJNIQbUX1zXlIO78h0uILbrBfL/LSR2rzl9E+9SRL
	n2jCEl6WU4meSdey5g==
X-Google-Smtp-Source: AGHT+IEa3CF3xADG9l/I+QXDQmuLBL7PjfQ7ANfxCISA1TEkx1LlnLJoYyCHx4/48GLfV2Ndk0oMlg==
X-Received: by 2002:a17:90b:2747:b0:2ee:db8a:29d0 with SMTP id 98e67ed59e1d1-2fbf5c59eb3mr10078716a91.26.1739457401621;
        Thu, 13 Feb 2025 06:36:41 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:41 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:08 +0800
Subject: [PATCH v3 06/10] drivers/perf: apple_m1: Add Apple A7 support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-6-be7f8aded81f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10283;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=iE2xp2YgTOHAtDaAC68OUbJ4XHgbUi4E4JAVvVKyHxE=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNjbDhtbzdgfp79Zgfkni/NzGG1fbGSOrsSO
 AmJLLRaXAOJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYwAKCRABygi3psUI
 JGkzD/9bD6jLL8PywNPEzc8lwpOrCLD/8zu9VcaimsuWy4yrlHu8BNkQuw0bmSRNiZqBgiy8oqb
 rcrD/9ZJec3yn6/iOVZzsRPquKB1pBIqdhSSH/K84gfkTNUcGIdRnEBAAYFLQJo31Bitm6zKjq0
 WIA3FGATAcNryTAG2sv0pvodOmgud0BeBarn1J/mE563IjWzuf/l4a+DyZ65bpEJ5Msjer7gy9H
 h7Bg0ZXGW724nVkiUAoVxcoe7rZIg9AhvtfYEW/lunzzAOjrRkgTVhnPlNxVYtbwncM1O+8tfvX
 9yET4u09baq5gD0lvDkLNU4excpxFWDHzraypmTnQNByXeKp0BLblvar/7XenDXxAORDe6Ccbee
 VBDTl1q9uJ35eR7NfRAHy6QMu9ja2A0FLsGrXjhl2qNK1EHFaHD1u+mG2+35B5AOh0eZWJPexF7
 1lY1CJidMINkO+X7EouHgxhAnDZmH8ucdM7lxqFTRNWNuga/TYJXXB86A1M9oP3ZEJ80pZH/6Cb
 H7ASNyNaAWE9ZrWwdli1hMC0se3vmgdnukRQZfOkrsM52cGD8lcorzGVT7a/fHDABqqCSj/P1XA
 1iQn/OSGQQiz2sN9T7fX+cXHm1nwrLPHkUVR+phx82LFRfbYK3+JMHdI63Pxt8J1NV6rPnRTkZ3
 Ts5YFoBAm6b7wYg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A7 SoC. The PMU has 8
counters and a very different event layout compared to the M1 PMU.
Interrupts are delivered as IRQs instead of FIQs like on the M1.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 178 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b601d585d204f9e59ad7f5216679b97852a46a04..1321d775d894ae94dea76d3461002de1c112a456 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -18,6 +18,7 @@
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
 
+#define A7_PMU_NR_COUNTERS		8
 #define M1_PMU_NR_COUNTERS		10
 #define APPLE_PMU_MAX_NR_COUNTERS	10
 
@@ -44,6 +45,143 @@
  * know next to nothing about the events themselves, and we already have
  * per cpu-type PMU abstractions.
  */
+
+enum a7_pmu_events {
+	A7_PMU_PERFCTR_INST_ALL					= 0x0,
+	A7_PMU_PERFCTR_UNKNOWN_1				= 0x1,
+	A7_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A7_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0x10,
+	A7_PMU_PERFCTR_L2_TLB_MISS_DATA				= 0x11,
+	A7_PMU_PERFCTR_BIU_UPSTREAM_CYCLE			= 0x19,
+	A7_PMU_PERFCTR_BIU_DOWNSTREAM_CYCLE			= 0x20,
+	A7_PMU_PERFCTR_L2C_AGENT_LD				= 0x22,
+	A7_PMU_PERFCTR_L2C_AGENT_LD_MISS			= 0x23,
+	A7_PMU_PERFCTR_L2C_AGENT_ST				= 0x24,
+	A7_PMU_PERFCTR_L2C_AGENT_ST_MISS			= 0x25,
+	A7_PMU_PERFCTR_SCHEDULE_UOP				= 0x58,
+	A7_PMU_PERFCTR_MAP_REWIND				= 0x61,
+	A7_PMU_PERFCTR_MAP_STALL				= 0x62,
+	A7_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x6e,
+	A7_PMU_PERFCTR_INST_A32					= 0x78,
+	A7_PMU_PERFCTR_INST_T32					= 0x79,
+	A7_PMU_PERFCTR_INST_A64					= 0x7a,
+	A7_PMU_PERFCTR_INST_BRANCH				= 0x7b,
+	A7_PMU_PERFCTR_INST_BRANCH_CALL				= 0x7c,
+	A7_PMU_PERFCTR_INST_BRANCH_RET				= 0x7d,
+	A7_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x7e,
+	A7_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x81,
+	A7_PMU_PERFCTR_INST_BRANCH_COND				= 0x82,
+	A7_PMU_PERFCTR_INST_INT_LD				= 0x83,
+	A7_PMU_PERFCTR_INST_INT_ST				= 0x84,
+	A7_PMU_PERFCTR_INST_INT_ALU				= 0x85,
+	A7_PMU_PERFCTR_INST_SIMD_LD				= 0x86,
+	A7_PMU_PERFCTR_INST_SIMD_ST				= 0x87,
+	A7_PMU_PERFCTR_INST_SIMD_ALU				= 0x88,
+	A7_PMU_PERFCTR_INST_LDST				= 0x89,
+	A7_PMU_PERFCTR_UNKNOWN_8d				= 0x8d,
+	A7_PMU_PERFCTR_UNKNOWN_8e				= 0x8e,
+	A7_PMU_PERFCTR_UNKNOWN_8f				= 0x8f,
+	A7_PMU_PERFCTR_UNKNOWN_90				= 0x90,
+	A7_PMU_PERFCTR_UNKNOWN_93				= 0x93,
+	A7_PMU_PERFCTR_UNKNOWN_94				= 0x94,
+	A7_PMU_PERFCTR_UNKNOWN_95				= 0x95,
+	A7_PMU_PERFCTR_L1D_TLB_ACCESS				= 0x96,
+	A7_PMU_PERFCTR_L1D_TLB_MISS				= 0x97,
+	A7_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0x98,
+	A7_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0x99,
+	A7_PMU_PERFCTR_UNKNOWN_9b				= 0x9b,
+	A7_PMU_PERFCTR_LD_UNIT_UOP				= 0x9c,
+	A7_PMU_PERFCTR_ST_UNIT_UOP				= 0x9d,
+	A7_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0x9e,
+	A7_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A7_PMU_PERFCTR_LDST_X64_UOP				= 0xa7,
+	A7_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xb4,
+	A7_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xb5,
+	A7_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xb6,
+	A7_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xb9,
+	A7_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xba,
+	A7_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xbb,
+	A7_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC		= 0xbd,
+	A7_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xbf,
+	A7_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xc0,
+	A7_PMU_PERFCTR_UNKNOWN_c1				= 0xc1,
+	A7_PMU_PERFCTR_UNKNOWN_c4				= 0xc4,
+	A7_PMU_PERFCTR_UNKNOWN_c5				= 0xc5,
+	A7_PMU_PERFCTR_UNKNOWN_c6				= 0xc6,
+	A7_PMU_PERFCTR_UNKNOWN_c8				= 0xc8,
+	A7_PMU_PERFCTR_UNKNOWN_ca				= 0xca,
+	A7_PMU_PERFCTR_UNKNOWN_cb				= 0xcb,
+	A7_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xce,
+	A7_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xcf,
+	A7_PMU_PERFCTR_UNKNOWN_f5				= 0xf5,
+	A7_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A7_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A7_PMU_PERFCTR_UNKNOWN_f8				= 0xf8,
+	A7_PMU_PERFCTR_UNKNOWN_fd				= 0xfd,
+	A7_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A7_PMU_CFG_COUNT_USER					= BIT(8),
+	A7_PMU_CFG_COUNT_KERNEL					= BIT(9),
+};
+
+static const u16 a7_pmu_event_affinity[A7_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A7_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A7_PMU_PERFCTR_INST_ALL]				= ANY_BUT_0_1 | BIT(1),
+	[A7_PMU_PERFCTR_UNKNOWN_1]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A7_PMU_PERFCTR_INST_A32]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_T32]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_A64]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_INT_ALU]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_SIMD_ALU]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_8d]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_8e]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_8f]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_90]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_93]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_94]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_95]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_L1D_CACHE_MISS_ST]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_L1D_CACHE_MISS_LD]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_9b]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_LD_UNIT_UOP]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_9f]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]			= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_c1]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_c4]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_c5]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_c6]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_c8]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_ca]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_cb]				= ONLY_5_6_7,
+	[A7_PMU_PERFCTR_UNKNOWN_f5]				= ONLY_2_4_6,
+	[A7_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_2_4_6,
+	[A7_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_2_4_6,
+	[A7_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -162,6 +300,14 @@ static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
 	[M1_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
 };
 
+static const unsigned int a7_pmu_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= A7_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= A7_PMU_PERFCTR_INST_ALL,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= A7_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= A7_PMU_PERFCTR_INST_BRANCH
+};
+
 static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
@@ -494,6 +640,12 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+static int a7_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a7_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -517,6 +669,11 @@ static void __m1_pmu_set_mode(u8 mode)
 	isb();
 }
 
+static void a7_pmu_start(struct arm_pmu *cpu_pmu)
+{
+	__m1_pmu_set_mode(PMCR0_IMODE_AIC);
+}
+
 static void m1_pmu_start(struct arm_pmu *cpu_pmu)
 {
 	__m1_pmu_set_mode(PMCR0_IMODE_FIQ);
@@ -551,6 +708,11 @@ static int apple_pmu_map_event_63(struct perf_event *event,
 	return armpmu_map_event(event, perf_map, NULL, M1_PMU_CFG_EVENT);
 }
 
+static int a7_pmu_map_event(struct perf_event *event)
+{
+	return apple_pmu_map_event_47(event, &a7_pmu_perf_map);
+}
+
 static int m1_pmu_map_event(struct perf_event *event)
 {
 	return apple_pmu_map_event_47(event, &m1_pmu_perf_map);
@@ -576,6 +738,11 @@ static void apple_pmu_reset(void *info, u32 counters)
 	isb();
 }
 
+static void a7_pmu_reset(void *info)
+{
+	apple_pmu_reset(info, A7_PMU_NR_COUNTERS);
+}
+
 static void m1_pmu_reset(void *info)
 {
 	apple_pmu_reset(info, M1_PMU_NR_COUNTERS);
@@ -618,6 +785,16 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 }
 
 /* Device driver gunk */
+static int a7_pmu_cyclone_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_cyclone_pmu";
+	cpu_pmu->get_event_idx	  = a7_pmu_get_event_idx;
+	cpu_pmu->map_event	  = a7_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -663,6 +840,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, m1_pmu_of_device_ids);

-- 
2.48.1

