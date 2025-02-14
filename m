Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8F267723;
	Fri, 14 Feb 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543453; cv=none; b=ZDpjPzsqQNk5qF7R3arxlo1V2NRC6XDN0sTpvmxWX0u2IeJ8nSR0LHPKXpZUA83nlU7N8OkMYI1UmeRVqg+Nm3hEi9nACSybaJVeEXhoTuGh/vfMHdR9o+R7lS8ZjTx3V8593Wt6qvk3dmPr+F+dx/LPwDmqVyX4Zoiw7s2zfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543453; c=relaxed/simple;
	bh=HIk4rf7zxCOA98DOmDx17AWtajnJ5bX8H7E5/mhDlbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2432znL6uaSHHKBzVOzQoYOF24djiND0+y7WMHxnNisdxSIFQzHT2l/1Q/q8GXQvn/0xBe/dc3/YhP9dnh/KPU3LA3SEQSDabYm4L5zqqNxP7lLCfwwEZAm9MFZD2KCmaCmRpJREKDm9THKaLPBa3pR4Y6XoGYIsNKqXCzrmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7dcEYiZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7dcEYiZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d28c215eso29507805ad.1;
        Fri, 14 Feb 2025 06:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543451; x=1740148251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka7CcpwLE9gHGyeS4O8xFmkIDbnrXqD0zo80hBXzFQI=;
        b=G7dcEYiZOP/kv7XapKwqV8dOLGwiXvO2WOclRBGLaUBJ993NQmjH/PwPCC1tvmGNTJ
         p2OzqTjjIUYF/4aDyubjTx6qsPRJHuDbGAI9sSw3Y92RB/OmeKEKwVag/bFwRvfKeocs
         pd0Dh2EQRWdyHH7OY7Ap1oZhdZpVOt+qX30zIrV3qYBA1/8PxsBUEKfprEcU9/W3h/b4
         q2dPW+YO40cYHUEwwELxe5AoOFAwEdLT3g9Eiw8zg2JJ+t5gbzlBVUcHqyDyT1j2hIUa
         sPYWL87lPYPHyxWQHAeXuy2pJ1QTVktDSplJmy73xhsSc6+PIkxQIIV9E/CCKJ/CVXkQ
         qhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543451; x=1740148251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka7CcpwLE9gHGyeS4O8xFmkIDbnrXqD0zo80hBXzFQI=;
        b=fy9ek1q2HHorUxehY7qNfadmiM87sr7yQNW6Ozyq/RFlg4G8+fCmGwohIj6lNUXlUr
         dIyewhjV2ioyl2tG2uD7ZpvmorlhGwc3UFg1iz3OD4fTKhrNehSJyUTbXqG606LkYz94
         opS+rwIQ1EQAAI00076h+3SWszB7eHSJM8tFmtDnJKZSmobzvUvhOJI7feutX1PveErX
         hjPjzdGTzRtw2ALD0pjKhIN/gVwCEFhGX0gNPRXqdWFac9EyXFyQejpFJHbXONs5u3/q
         rq4T59mcgvC++7RtTuLEXhHX9Jswty1fP//cQgOrbFWi7OfbY8wjLzwLyiPYKFzbGECP
         Kmbg==
X-Forwarded-Encrypted: i=1; AJvYcCUEurDUDgmz/PuhNIUEodeHv0WJpPtucPbHknG49Bi2rel6x7pu3no80vZL10b9d97UDB6L5UKc2jXiuU+rGLVY1Q==@vger.kernel.org, AJvYcCV3Uy71QgAqU86SwpUGR+9UJwMVcO7qpZFAOXcH0CWSeGyxzKQuWEZvGy2t0bmS9icHcwGSYRFpanpA@vger.kernel.org, AJvYcCXxaOyEWPjDIwJ5hni6ysQdMYTpYoyALK3Hx+giSyus2a/98Cdxggt1usyROud1dS+bcXeDGurvORIuJ1WH@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLPdZAL1zw0Ls6cT2x0Id3iqm7m+xJji3kYSh9syP2JHb/rBp
	BWKM57rvD70HqTAxAKliMlpeAkKdbCSC3dmRtufrxmunI6gVNnQK
X-Gm-Gg: ASbGncvcF0Tuw7PSTZbwCk4XiMa2OVEXHuzWPCsTWPTU74D7jI7a+0p4yHalc+94RxR
	zzd6T3YlLoztGTyGFr7YrzhU0kX2OpRRrQHKMQ6DHnCoJwz2j/mCX13MSdcU4SUE5eoEgH2sa9h
	sbmy6AnM+b+123qQbtI5CxrPZQCJeeKWBdqLK5FAJdj9Kl0eZ2Y4m0Va8gLsp4kxsKWnfM4xXz2
	MBmiZa0GfQS0xjvfG36fetWhajdfYZho35h5yum+mN3p7qv1T95gVbn16UpuWUIK/3W4RKAQYDo
	LiVijzsaFuVog8SbjA==
X-Google-Smtp-Source: AGHT+IHtM34hAdmN3/8lq/L+mXQ/bc0/1i4ErnQvcV/SkWbSoQ85kr8JWHLJ8cRA9xk99NkhJdwYFg==
X-Received: by 2002:a17:902:d546:b0:21f:f02:4176 with SMTP id d9443c01a7336-220d213edf8mr125352465ad.33.1739543450709;
        Fri, 14 Feb 2025 06:30:50 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:50 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:33 +0800
Subject: [PATCH v4 07/11] drivers/perf: apple_m1: Add Apple A7 support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-7-ffca0e45147e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11055;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=HIk4rf7zxCOA98DOmDx17AWtajnJ5bX8H7E5/mhDlbc=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OApy8rKggKVG+PcdjLuvD+0DYRXtlq77ybW
 ngOTYDOEieJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JM8FD/9z4U42h4UhGpIauPs/5mDjKcfZz3jgfwvnZtuykmEtC+EwwuOAyHSx2p0QNvLdLM8agw+
 DK/qkZ+1sO3ycjT3b1P5oK4x8RBOpaVTcXjLEfKuMEVmBXcsCPQ1IJM8S583lFjwoTMEZIVkHl7
 VJlRMoRLfTyNEH9tuKlh1Nd8H4kIfzcP8TrhXAsCnVGLR8cc5+KYSG4DmDqfma6dQlNvUv9FFFV
 CmOJq6mbMA2V5fVrXGCKEz53hlTak6PMYlIPjGFk7G80PzkGLkjKtcM9FcYpbUKYnnlQ7dzOQnO
 BHyDPS/y0T0d0FgO/fJESi3wnYELcKCelv0JWpX2yXJZGBqwz3ZBYZWQLEP8ypHtZHOahy2USlj
 VDMEPRVxCS7V0DcYJpUF7GEaNuDIfjSaJQzFfUazNq/RKcg1fomHFnNZggRdCbr65PRowzMbdcq
 eHkICOKYioGJKBnLfCTQDKnQM+qymyxQLVnrdrISu44BRT81JriM+exoxzmTk6XWN6s8UJ56RFd
 0MA9CsTu7hev0sksc1r2RxQZhNBaCTNYki5OibNpiQg6G/hRLlFmpQF4B+YRLqvjo3q3ujqSBFx
 WjfP22lhpJovupfbqEBW/PgjZ39A+GtpFxLBrCpFGPFBa1ywvi0UgFtDOcXxil01KE+c5IL508Q
 oHhvEGM+23DcABg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A7 SoC. The PMU has 8
counters and a very different event layout compared to the M1 PMU.
Interrupts are delivered as IRQs instead of FIQs like on the M1.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 190 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f98f3e95bfdbb5e9d0fe66357f6037f056fbf25c..93b49f08e5c740c5bba2eede191e279ed4965181 100644
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
@@ -185,6 +331,17 @@ static ssize_t m1_pmu_events_sysfs_show(struct device *dev,
 #define M1_PMU_EVENT_ATTR(name, config)					\
 	PMU_EVENT_ATTR_ID(name, m1_pmu_events_sysfs_show, config)
 
+static struct attribute *a7_pmu_event_attrs[] = {
+	M1_PMU_EVENT_ATTR(cycles, A7_PMU_PERFCTR_CORE_ACTIVE_CYCLE),
+	M1_PMU_EVENT_ATTR(instructions, A7_PMU_PERFCTR_INST_ALL),
+	NULL,
+};
+
+static const struct attribute_group a7_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = a7_pmu_event_attrs,
+};
+
 static struct attribute *m1_pmu_event_attrs[] = {
 	M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE),
 	M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INST_ALL),
@@ -494,6 +651,12 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -517,6 +680,11 @@ static void __m1_pmu_set_mode(u8 mode)
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
@@ -551,6 +719,11 @@ static int apple_pmu_map_event_63(struct perf_event *event,
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
@@ -576,6 +749,11 @@ static void apple_pmu_reset(void *info, u32 counters)
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
@@ -617,6 +795,17 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 }
 
 /* Device driver gunk */
+static int a7_pmu_cyclone_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_cyclone_pmu";
+	cpu_pmu->get_event_idx	  = a7_pmu_get_event_idx;
+	cpu_pmu->map_event	  = a7_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &a7_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -666,6 +855,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, m1_pmu_of_device_ids);

-- 
2.48.1

