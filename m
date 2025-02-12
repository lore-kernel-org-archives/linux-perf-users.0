Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437725E47C;
	Wed, 12 Feb 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381001; cv=none; b=tgyO/ovCBHJyzL8sWIn00p4qcXpDtJGx8zc82lCm+o6B0ogkvScqzvkmg97krBbeAKLN5MXVCx8cdj4nuruTiV58UgMZKQz+AL/5p/hUYosWTzkoCQO9ibLk6P1SObAOb4he3wpQ4MryxN1PKnWNcvX/UKf5uK6RHLZMxCil0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381001; c=relaxed/simple;
	bh=6N4R/5wlV6Q+zP94GRU2QOpJnSaI9H7wPa7gYBlAKCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fl8Zk1T58Z8JwvbOxPIwITzNftLGYTaysYJYoqaWHLY1hh5XyNahaYroO4yisn844iK8pglirWX5IYP2bGbWAlE8dL7j94Cdmn9L8/GjmAkmzENJgp7+ndy8OF0ILMwGWlzDWxL0x/ba1IlmqoJIEhkVK3lIfl9gACDfqK7RSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUo6UYm1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUo6UYm1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso12614745ad.2;
        Wed, 12 Feb 2025 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380998; x=1739985798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLaI3VGYtpeJuIp1j9/JvqZRf6Ca8yZ9tLlCksPlz30=;
        b=KUo6UYm1DLYCoH/Fz0xvx3PPFpSXybP+7AroobfPc1TyaB4zqgv5oXzQflphaeMa97
         jN/FAVBGtygMflIa9nxB2UYipfw83L+FRbsZBZMTQSt8cbgdHxoy8GBV+FG8s11smnyp
         W0TVOCuQzOu5AxL/fHYYPymKMHpZyKLY9x1Us8CpkJO127fNKWZODWi6QwcL1GVu9+ef
         iYk+b9yTIZS6acLkMA+H3qBSe8+yNbJASzwE8RO7oOfqVEMCLHHcJI20Bsg9T9mhojLn
         SLdbY3JrOnnNXxLk7BXzM+rWvemN/jbX2VDfOIWKNjdCulcGym8yQxIT/XvbmmQaMzL4
         z9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380998; x=1739985798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLaI3VGYtpeJuIp1j9/JvqZRf6Ca8yZ9tLlCksPlz30=;
        b=pR78bnBn3Hr8AwmEmHzRcYAeLbPcV3hTkYzSkur7Rmgj44MwflBsEoifXHlqrXeKQ4
         xVz1jEBqs5wy8iI71dzUhyokQm2kB0fnC53Y9zGetbe22rWztrAb26ntmC8Y9Q3LiKuE
         8wqgJFbMFzubPTi6edoFDTzu4QUJ2n5b2zyxYiy73LrB5Xel5N6jDHY6LFuGNwKBYUEg
         KHPCNpOo1uTY41alOrhzd9lFOULWvZLsDiJATCq37vcEKPQVjBx8dNEi3GQi8pfD9XRX
         qplUzoLJV3W7x7wNMQ8NbevrC48+dctmvOvXl288xjbrpmbsXMsM8UZTZ5kR2aSXILyf
         ksqg==
X-Forwarded-Encrypted: i=1; AJvYcCUcBp0tqMcf7n83bm8NWmlt1ekZjAtYoTqguD2BVjxnwxxEnoQ6B9ZdxhuMSXsyU0A5dpAFXdqFTfFBfiQdJGS4KQ==@vger.kernel.org, AJvYcCVd3i48PFvVXKWqOlfwawsFQ08t+BDQlQa05mrqBaUgSy7uBqBcUvodpeSkBhQ54eUpLXaw78zJPPx+JHbP@vger.kernel.org, AJvYcCWhv11GYruMMhT0rStUboDIN132tCQEVzmWRKcDwBokif3quBoxL50eT+lZxrhsRUuT+3BTvdJ7UfUf@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYXOrLjIyTzo1yCeEF/r90woharJPHLr/Tw3n1oG4pIPxW32B
	vwCphDyTfTFo8efEat4LZsS0eXCxQGQWsCLjY0Vaqg8V39gcIe5L
X-Gm-Gg: ASbGnctxgH0fsST/c9l0JCYjnoqWyquzmS5P2EkgV8LM7fYMtOk2kkegRiSwyXfPjX2
	0YK2iEkkDWYNTJdX+JrbOQhdlZqK945jNy6FBwI8tF5fwOSu21mezDZEXjkRSk+zyCuRYjQOXlc
	X3Jx5YugJPnv4nRBS3vNEB/vTOjVrhwm3oiJm8V+2JMl8AiVA5hvKYddqdqT9MxjKJhHxRxNfs8
	mAUd8hZ0jQ/rnMGeT712ZA0R62EY8bbWyC+RXnqhKVNQB2HFfpICGfZBcog5bGlDNz5X/Xkwg6U
	QZkXkXnMQUMcPZ7xUQ==
X-Google-Smtp-Source: AGHT+IEGttjZzR0TUKwySNOQPMm37+7I49oIev0SakjRm81aNZvhsED7pG4H/sMq6NqNcbqv9PyTFw==
X-Received: by 2002:a05:6a20:d81b:b0:1ed:e7f0:3136 with SMTP id adf61e73a8af0-1ee5e5b9674mr6122637637.20.1739380998116;
        Wed, 12 Feb 2025 09:23:18 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:17 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:29 +0800
Subject: [PATCH v2 06/10] drivers/perf: apple_m1: Add Apple A7 support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-6-87b361932e88@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10318;
 i=towinchenmi@gmail.com; h=from:subject:message-id;
 bh=6N4R/5wlV6Q+zP94GRU2QOpJnSaI9H7wPa7gYBlAKCQ=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjwew9/CNnF4IlqzMFXILSKPHm+MuPDHWTcB
 jAnsB40umuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY8AAKCRABygi3psUI
 JBKUD/94s7BttBhFlrdl5Q7yvRuOTNPoFK1hRiQRnIjNPLN4Ue0PV9vkYV3KzA/U5AP6I3H7lA/
 aIngR8l8xp6WyhH7J13FJSPxikgzN01TD2rLDSSDYWX1wQJzMLc/bpFaSGZTLD+F53wZMehZc+u
 i6yv0x7pG9yTcHozXAMLYfH5lIAc3fupWIAoya3EtG3Q13mYZx05wInbIEEyVNtCsjLhPhujeA/
 TB8rk4oDLO52+cRfpQ7HqXb5YpQksniLYWypqOwB3xOjI7vyVHwClPW9ogMKCVIZD+pdfAuyPlD
 4ydnrtP+PcbydXX/8hJZlstM5rwF5BIiOnylU/bRinX0RA514/Tykyxqc33Ha51krER6IeE4Cia
 dURBnT8jcmUbnkOPbaZamKeLvQLoTKNGG2pq0F7yN2MC3piEBix3O3ClwB8ViQ0lgK4kChU6cQk
 moBklTygifmyMZe84rmHuzQo9BBusC9XbzAqieFx+eNbtfcG3fGM/UZ8eRW6FG/kp3bw8JncK94
 kajPN/nmHPROKjVrwlXZJSWqsI4mL4vr5w823Ri5nKY9ncVepfN55m89V4Y15JKTCSoyiFwUdr9
 Cqz3RwPpDNbD4AfNybFKGKA/XKRvJ3W9TrXsoe/CK1rKBU/Cjm0DTo5LEyHzqmoO+pcnbDz8qCf
 WbzTDbubgoL/oSw==
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
index 12eba1075b36768afc29e211926331b9a426c54f..f852cd5633d7f180dc9dbdde11332ec825a3d558 100644
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
@@ -491,6 +637,12 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -514,6 +666,11 @@ static void __m1_pmu_set_mode(u8 mode)
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
@@ -548,6 +705,11 @@ static int apple_pmu_map_event_63(struct perf_event *event,
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
@@ -573,6 +735,11 @@ static void apple_pmu_reset_common(void *info, u32 counters)
 	isb();
 }
 
+static void a7_pmu_reset(void *info)
+{
+	apple_pmu_reset_common(info, A7_PMU_NR_COUNTERS);
+}
+
 static void m1_pmu_reset(void *info)
 {
 	apple_pmu_reset_common(info, M1_PMU_NR_COUNTERS);
@@ -615,6 +782,16 @@ static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 counters)
 }
 
 /* Device driver gunk */
+static int a7_pmu_cyclone_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_cyclone_pmu";
+	cpu_pmu->get_event_idx	  = a7_pmu_get_event_idx;
+	cpu_pmu->map_event	  = a7_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -660,6 +837,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, m1_pmu_of_device_ids);

-- 
2.48.1

