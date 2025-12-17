Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAA34E74B
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988718; cv=none; b=p+1yxcxgCVIAOyXQ9o6ZXahClcuDqtK+xP5tk7l9JFmj2sprdJ75iF43DsjdXs9xyb7TiKOGh3dGEQy8VBF7PPuPKtIrQe4u/tiJCWtajRTHCv2LAFBLYicwz43YFR4wsBfivkcPOnJ+lZyRnK2bXAEK0RXLZ3qf2VMfopPo29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988718; c=relaxed/simple;
	bh=vvhARVvISRkjbUgtSLfeU3ym/rX7ZSMkAa7WIK94EZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IATSMvf3GriYXlan6qsU6LOPF+U58hxuGTuI9QVyztfxNUYrKTy0E9chpme+TqHUmX+5VMcVPlXFdNjNhBoPnCaAwcrwd2bb+LhgLZStedbaHKqU4GaO+at8Mz44IDIp7ZgyCFbhxDigGrIahnsi6uPXv11NQSWRL1d7ek2yKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfsKMEal; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfsKMEal"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a1360e1392so20298315ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988715; x=1766593515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO9j9wmjye25/aeps0nrIHuAVf4y9/f0VvjmXWc9NhM=;
        b=TfsKMEalQWbQ0lQTSB9dD8RwwAjzRulnuljrpo/hdA/9NUfiTmNGv7gYIbUteHayRv
         t4odHMpkEotMdodPNJyv1uSa9nfIe9c6RShr3V8dg/lZGTFkRWrW4jI7GtXdmk31Gd9h
         OyYib+l2K5Dln+G4P4p9DeMjwRs6HA7aoZF+P/jSUPS/G01SUfMPjBnuuQiGgT6ByCQj
         fBvwcGEqht/z81VT69yckC/VdpVps9CX6JokUy9W+L1I8KyrX3hyjpg5//vlWnQoD4mE
         K2+Zo2Biza13cX/o3ZhuksusmY9hLXZnliq2he1FSVyMGVpUJ1LXoysgIfhQys30C4H9
         7xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988715; x=1766593515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KO9j9wmjye25/aeps0nrIHuAVf4y9/f0VvjmXWc9NhM=;
        b=N8iNh8cTgp+mO1h0RPUuAshqPYcv37Cm9tK4HrM4nmFdEByiLG+aOcHB+i4Wo/seV4
         SE2rUYMSELOGftve2f0L4q/d3Qxwk0jjFUUa79uKzz54ExZtMDuaKXS3lr7wXEG4Y7s3
         NXg43QvZt475U3CyhNitQlH4Su1WqHYBgaZAA2bBXdkBw0lBq7Z4JL1IjOKH/W5N9YgS
         Q7GhKMjUWTafThMvp8QGkFdtvkBbovpIq66bJwkHI0xqOFcEhgf7Wvly3raSW9JI3RFS
         xsNRcfPVB5vHYkMhDoLQ04bSC4cAMHRZuHy96hnZH0R7hE/l/rFFREDIRAJZpaH5D6N6
         Txkw==
X-Forwarded-Encrypted: i=1; AJvYcCW57PFAzC2KFb9vr03LIivzQ/tpRru3U8IMNoO9LCALLZpYefzyUh849JKOcb7TTGgO0/7lz+00utcY3KEeo+LN@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRmKY1l1LOWLqg1jzAP3g5+VAG/7jcQxU3fTCHUnOLTVVJIaz
	cu8Tr+H05rSishM0PaQSkVRWWtmOVtFc9hYN8bvkxaOIxMdQA1WCy03Q
X-Gm-Gg: AY/fxX6SEHTbLVLGigCEWS5X8WldwYxmoaDeAw3N9zO+0u4ZpZ0PPT+tL3OQD9n7FuP
	z/kGFbhCI1oFPoFe7srfTSdVVizZM62Qlj3rgb7Uo86njzrbWpzT3TdQLf/65pWKCcev7WXn9Nr
	nlcOZVjQlH5NA1b4JOCAYRjrJMQhhn6/uDSawhL10Ns5qk4fOJAjnvZRkxusKjVHHLA+awpzLoa
	zTajbGcF+dWfZDhDTWoLpwvg+aziiM8VInM9Qpt237HBIFLq3ynwoyi5Ooj3+i92lJjqKA3GkNk
	i1ogr+znGWAsTiC4IxSU8d47k6aCNjV4/J5AaHHu9bmNH4c1EVWHMvae+jMi5bzqMNDU4TnbUIb
	hIPy2NUgazBlBZgDLOYa8fY6mc2qXPkeAF6q+UDm6jzD6NUiET+d3n1rnn3YbW5TJLHVg9UNg+N
	tR+dB8SRawuGTa
X-Google-Smtp-Source: AGHT+IEoO8pTyxzphENRy8UUjWNt1rSFoq33/M1I4BVNF2CU0HUgKE4FufXy53yDTI/DFN6mVAJlmQ==
X-Received: by 2002:a17:902:d481:b0:2a0:c884:7f03 with SMTP id d9443c01a7336-2a0c8849826mr127420025ad.44.1765988714505;
        Wed, 17 Dec 2025 08:25:14 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:14 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:24 +0800
Subject: [PATCH v9 11/21] drivers/perf: apple_m1: Add Apple A10/A10X/T2
 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-11-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7698; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vvhARVvISRkjbUgtSLfeU3ym/rX7ZSMkAa7WIK94EZ0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlB4hEGGkYj7u1r2hpCRyIygPZm9Pnyl/UGd
 uhaAvnsRzeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQQAKCRABygi3psUI
 JImxD/9xCdPxzoD3syW2/+n0R23H68E7F/eYFywS9FvK/fscHEOv24setgYcrGE1lm+xJ1NvtoM
 tw6YfcBvoRjpjYC5Ujpq1JEzDM6v+USamixbwEXIsYyTeLDj8MsHiEBcMEKqMCSl+QfpeDCJHFa
 qs2BLmU33WeUHawiP0guctXavKk/OuhBHlMYl9Ie18WW5hwYiJOTSV503wnOVGXDD3sVJNp8Wk4
 jx7RZIZUwxT8GjdooTwyMIhCLU+AkGKOcQPQ4JR9v4wUAfqkYS9uEBvZqWFeemcloO8PWEgvOJB
 3U9o4I+pdwZhgrRQcOTzb0RZWj2vqExWa/ywwdKTYRnV6HHBKRnT2JKOR4y/Aq3fOI/GheIn01d
 p7ApujCkxMZAeCzv+xNm7PoXuFACkxmkkrE8gzIQTxpmMS3uM5QmSAkXYhhB+agwercRay6iyG+
 QxN3D9PxFo4jSWTYdRgfKW8PCCEh4ql7FcI3eDIt29W1ze53TqpcmlGHon2Uc8QEb3QvB1eFGwM
 dzU0sElS9AOBxbtbyVk3PqA9J/ZWZzEn0XN7edLpsXHFWRbMmsCoWW1GiETpfw6/VQuutGXHSiy
 XqPVVpmFrS0pfrxW+660yWDEis3kz5vJCnyTfMPRaP6KaZnkz6Ld4SLaVzC1yE+eVEHI55Mpx0Z
 qPHd+4PoxJL/wAA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A10, A10X, T2 SoCs.

Tested-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 131 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 0ef39c148dd2ed032e4d14ac01e7c7e7e088b394..8c252731408224c3596b4157024a3ee885d98d9e 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -396,6 +396,119 @@ static const u16 a9_pmu_event_affinity[A9_PMU_PERFCTR_LAST + 1] = {
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
+	A10_PMU_PERFCTR_INST_A32				= 0x8a,
+	A10_PMU_PERFCTR_INST_T32				= 0x8b,
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
+	[A10_PMU_PERFCTR_INST_A32]				= BIT(7),
+	[A10_PMU_PERFCTR_INST_T32]				= BIT(7),
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
@@ -909,6 +1022,12 @@ static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -1109,6 +1228,17 @@ static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
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
@@ -1158,6 +1288,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },

-- 
2.52.0

