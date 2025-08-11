Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FF213E74;
	Mon, 11 Aug 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920579; cv=none; b=W6WRSkpZJ2FwHgxnwSap/dndl6qvoVaV922ZyRKNCKFeIFpTHfJych0XS27i26tc0nc7fXzoNLCge9EQQL3Smurgh+gRIhpE7nsamjsQspMwk5smfgWpG0ijoAHJLmB9Eq3GbNLfQiYzgL1t7Km6NH70xz+l0ciUvZgin71v1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920579; c=relaxed/simple;
	bh=GbBsZLU6LcYQItYH6LxeFjqfhzMXOcLKbuyFdqUdTvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdhtha+KY1+Y+NooWoF4JHbotyxYgaISEzalf6pgLe20kFNyU/XsvQqp9VyZAg4ir1SjFEYsdJNpSwX/7BEtZIL7GtMxI8LDkZS9JnfKBf1LJ4FFXLZ54bhNHcSO1WVijVyk59rgAq3uYWbW+KGtBqCNwGaVLdIDueoai/7+hVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU3KrTRj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU3KrTRj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b421b70f986so3076847a12.1;
        Mon, 11 Aug 2025 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920577; x=1755525377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1DyNdVlPCPoU7kqeDEJfXr2KX/IPfciXZD7aH/9JiM=;
        b=fU3KrTRjZ2CrV5ccVskb/Z+HWtA7yLekDPM3+aiV+GQa9wq5flrcUuVDiTNZYXJRbf
         z0E0VHSB13tLl9Dyyxzvk/hspLIkYLxtMZO63G7LyViyD9qaIb6RdqOPQ5bNIYht/YDD
         X0Pd9TDfD32enPLkngL7zILn8cCOYA7FDsYV/dR6qWBM8yqvMrE0r6d1CGX4mIiYoFIh
         qM8yvjtKL1V9QOqEaCDGYDgWyEDEHWohHXxlGDulA7DpZqsgsWyi/7yto+gju7tfDxJJ
         2yvsRqQzr42WWP2q4U3HGIK8UHJOLN/XaEF9AqzQ+n/MiVWdh0LT7HcBYfDAB8abfhO1
         Kjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920577; x=1755525377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1DyNdVlPCPoU7kqeDEJfXr2KX/IPfciXZD7aH/9JiM=;
        b=KldFWLks/Q02SJlKcByeiFFaBa8vGItdMYB+xqwNuYQozLhsYFb1TsL8Tacbu4eEjX
         GYjDdHPbp3O7uqcVbJHm7g1Ivx/DlwC+A4rHPI+fOBDT7Y7Y5f6ccXJJ0BRnqfLaJ/P/
         yILIdikAdqxud5Rs9vcg/DqBU1JRDAUbeS0NfQiIEQKoMXAvTRegejpLR/npnUBpGyfV
         LDAaqOWtHhRehH4ZLtKR8ljogKXPa6iN53tutsAw8ch3HQnNJjdpY7hOtHaPtaNSF/sO
         QGewMSP22hqOXgUFt7qBIimyplVygpaTuwTJQHxwHkNDPmr5BqHVhS802Z+R3W1JdORK
         aEvw==
X-Forwarded-Encrypted: i=1; AJvYcCUGzthB3UKEDLuZNAxBJLR4oxKp4GUc9oCBIXBxHaFY02FW4RkySO046a+m7lB7gEOF+S20pV8l1/HJeTQ2@vger.kernel.org, AJvYcCWYxoEVN79pl/YYZmEemQJgk/4QTKT9LTr2E+nDnHzz8RiNnil2bOcAJpapU4sag7lLRssLtS9Q/m9w19QvDslv4A==@vger.kernel.org, AJvYcCXTrr7VM0CmI4ADzLqvzjO9jbvxyrX/cM6Rb6u41EU8swoMLBnHz1ko+y+w2106EbHAF0XnNhSg6fDo@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrlGug0Bp0URgrSm/D6zNFfaDVGmVhqwd5CzEvxfs9Ey6CI4N
	omSjef6eWxzjZyoL6lzrNqU5vzS3FzI1L8Q0XvQ76k0LSbfWYSKW9dYu
X-Gm-Gg: ASbGncsSBbGjix9qV3B3uZ7baIqNdNmQmqfi4JvBe6WvizG7YS0z/MeTfvQVLfalU0l
	by6Ra3jX7FoRkgfIMcHRlIZkTMua2G+MOCvZJSv1fy7gHRXaBB7o8ftFbgVtY30ypM9vBHmI6QG
	reXw1/ZeYBr57iOjFDEP4YXnL6Cn/vs/l/9fY/9Qxi1sntwxrL7lOokSZdmcIgw9KxnVxB9hkV9
	Caea5zEVj1wPsNeYDyLupS4IdOuXdegWb7zCNfRGYt+5MXWQWQRHDqVtP/jNXbL5y5PbjLlRKDp
	78iizGecPdqRhHTrNGajfFWZ4d7i3r7PEXew2vkysk5GDQFmn7X4RHbexl0CUrskHmf7odvCmKx
	I4m7iPKPvcASDU9P1B55bhmaRDbxZ5uC3YmdFgfAmI8AlDCc=
X-Google-Smtp-Source: AGHT+IFof9cViG8PJCVhS0DMPfQDUXYGXDWf1cFW3ukNym1IWYiqG+bFNZrJMBYi9agMNHu65xyW9w==
X-Received: by 2002:a17:90b:2dc6:b0:31c:c661:e4e with SMTP id 98e67ed59e1d1-32183e59e47mr23538370a91.33.1754920577348;
        Mon, 11 Aug 2025 06:56:17 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:16 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:44 +0800
Subject: [PATCH v8 12/21] drivers/perf: apple_m1: Add Apple A11 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-12-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7991; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=GbBsZLU6LcYQItYH6LxeFjqfhzMXOcLKbuyFdqUdTvA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZCUK0/mVTyMsN2St/7DA8ARfUMHWvopG0+u
 O+Dy7fxsiWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QgAKCRABygi3psUI
 JD2FEAC1DkjcxnKa4tNZY0hTXM3G3PvJhM2AfQqKho1vRKqXkKCx8y6UBVTQCpp+Q2nGJCrG3zF
 /PiHoDRFKcwTPuqpZ4XzsqVlpdXU8fTITTHA6kNCW7HVHSIrZjthof2v8YQbvkjpZdb+XSWlxzd
 s/Jw8xIYKPaCcDY9nmgpqmm5/XAz1ZYE7VXJzZ+rDnrPFBRt7PjgxQQDC1lxnnErhGprSPvosjX
 0sHCKiiXwbzMNOL7OgkA3VDfPBdalkvNvd2PSPfZKEmibdZYUaIWnHn+mfvJkEMTRr6dqrHZMzS
 onJ+Nlu5M7AWFdteP/zNUAVtItpwysP4BfGA0tuov4mN2SI3cT5LIROmOPEeXh1Py/szmXFJZZW
 M95d7VsZ/sWYu2/Bf/zvH8jZVCCBMfSlpy0vF9FtpCcxXHkCT01/7okBPfCM/pJsUr61TeKiqer
 3nahI0PS9oPjUNSaUyb2Y99jv1GsSHZJ0xA54hS8pGcZylatH3SZ9dnGKwqn2tvMAaOieZt6Eng
 GLOtJ/6Pd7iI0jjOrbEvYRQyKHSNZGgjkKRS6mR8l28oAUAGigt51jiNxI9Mn9zPnRQMFXAhf2F
 t1erQfH/52WxQ86Y7creW3cdWws2EGDOe2sOVGBHrhxINrkEYZE9BhbnF5tsib/wnbiWhx1HjWO
 TAQwP8nKbkv5unA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found attached to the performance and
efficiency cores of the Apple A11 SoCs. This PMU can deliver its
interrupt via IRQ or FIQ. Use FIQ as that is faster.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 137 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 37ca7e99aaad97526c468d3c98ec7ce4fe115763..31fe89c928364719ee0d71011286a91adaf6b99f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -501,6 +501,113 @@ static const u16 a10_pmu_event_affinity[A10_PMU_PERFCTR_LAST + 1] = {
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
+	A11_PMU_PERFCTR_INST_A32				= 0x8a,
+	A11_PMU_PERFCTR_INST_T32				= 0x8b,
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
@@ -1020,6 +1127,12 @@ static int a10_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a10_pmu_event_affinity);
 }
 
+static int a11_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				 struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a11_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -1231,6 +1344,28 @@ static int a10_pmu_fusion_init(struct arm_pmu *cpu_pmu)
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
@@ -1280,6 +1415,8 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,monsoon-pmu",	.data = a11_pmu_monsoon_init, },
+	{ .compatible = "apple,mistral-pmu",	.data = a11_pmu_mistral_init, },
 	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },

-- 
2.50.1

