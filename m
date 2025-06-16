Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F2262FF1;
	Mon, 16 Jun 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037570; cv=none; b=ZRqftP5JCRRyagXUoZtZDPZ/rymPpqtxxneJHs6YyI+1c8eGpC4X4p8qyxUl+yDXN4gHBb2E+dMBKu/jlQj6EKJg/3j+Ypiusu6eEVQ6r0FkbeUDdfxNTWDN3P402NlujLhQfnzvqMmRL8tPfVtgKLTPD58tIF5Xt6FjIHxbZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037570; c=relaxed/simple;
	bh=wl40dMXc8W0PdUzpNjblXnUW0iWApVwrvUwg8aXHqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KayAxTpfflMrtPvJR1gPmxx9DRSMyILEbUrevd24I8op32n5+QKVe30Ub7Z5rVmgBpwrgl/rhoRNhHC03s3P2EeBW/VrxryIbgfj/0tLd/W23853pYDYOCnPGew6+r5jBiU1qMutaLiY4T9wjIBmZovToCruqVa+dHvVODm7w9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iESY7yvX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iESY7yvX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so3108912a12.1;
        Sun, 15 Jun 2025 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037567; x=1750642367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO+CRRvlUPzNUKpb5PbYeTSpZmUgiBhodlwNzhHRruo=;
        b=iESY7yvXjHvv8q4VeCOt/B4QlID3jSq5PnRdkovfDICZkDtiqvDckc8RXM9dAuSlFz
         x5bMWV5UWWa9QeGkARCiiFxRxRBz0qY72Zkahl6QQK2vyujkQeWZa4+PjJQ1/5Nu2+Ek
         R4ORBl5dkAHAwrZ5305LtdVHxqqzeEswWyjSE5lbRlua+VQdisNdPxkSlhyrv3tV9Q0Q
         2LLQeYj2iHgR3QWhPfm5N6LN2BQN7qwx3dnB9NYeTgA/ltqlagenVGAS5xu3cnPJf7hk
         TmMwB96p9SKevZBjfLEeBiz9Eq1PpULD66+VaJAuICgFFUUV1iu8kKXNWJAUn4Xqa7Vs
         /dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037567; x=1750642367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO+CRRvlUPzNUKpb5PbYeTSpZmUgiBhodlwNzhHRruo=;
        b=NzMBhNJyXEWrBaMLA0+endBtv7IcvcRLQ9enwUtuYCdZLtUywtSxfzrOv5TVmWqK8I
         gcpFLGpGXGcYELAg3vSm0rnXUZ56R6d+lEVtmUf8IKu8YLqB0zyAV5lGC/RzxuWaK2Ey
         am7Fk54nH6xZ4JANM+wSnm1jFhjfa256ioO22TAaSHGfat6COKTkwBIYqYlWPdxOhtXS
         rV2yMPDXhDLc1AfGDrU4t2Bj5Zec9aY1BCwyEMG3VpmoGu5QAcCmRipmQt34RAA3SYBG
         DU7+xzVzfAAWPvxZUPGzdVRxtuKKZMdAeXbxXrOI12t7QdAmDb75xvBueGv5D0TwUdEF
         5ysg==
X-Forwarded-Encrypted: i=1; AJvYcCUK2cfxmgFt21dLM2KUYZsWAfVgpFxFa4jW+7R0j+15y8b3yygE/MyNx7KNbBtvVaGgNEuVSCW9yN+9JS6WOcOK8Q==@vger.kernel.org, AJvYcCV7gYW0Ug2/11PT59H915XlUW58X7Uw5kus24JYbWSmP+XF/KzDMmiNAqRtzQpRBHpX7TX35RQJOa/d6q30@vger.kernel.org, AJvYcCVgPYbaK/sz1xYhdv4kkLdn016YucNpeChBvRtXowGnCl11pozuuOTdRIhOFLnULZvbQjfatUYusajY@vger.kernel.org
X-Gm-Message-State: AOJu0YynPtftSRnU8wRTY1A2G3Gie4DL4pQyg1dPdNfmxkCH2RY0MG2B
	SU82TQ9oIdK0dsuYAVG63XyawBlmvfqi2pP34yByWEV3n4W2M8REExpWdbmjoQ==
X-Gm-Gg: ASbGnctRRP/cZPEt7DMJD6jJcr453WqxyL0IeVYPbhmCa2HJGK4Udw8mnBNeSobgQmh
	v3AayoAlx12hhRp3FKmNeLF5NtiMByJq66ftHT1pI6+NP4L2zx68i3gDpYypGuO4s7/mCD0i5z4
	o6NY5l0R6oSeckONmYEds8yJMpINrK7KKvhs4Iha+pvO0W5gunq6SgquG00qmjbBkkFFkUED+rs
	uxHgfCLYJMlmEKxhmFCsHZWoN77MSjIGhHJV0hU5y3JChFwwAeuymX7EMFPBhUjltUi9YyGEXb0
	eBD/r8FC26TwKXB9+z/nkh5qFkLlAlTHkt9DVWS5Zz4KUrMV4pMwZ4iPeod0mBWzHSHJBUoUkIq
	6L0g=
X-Google-Smtp-Source: AGHT+IGP4Bg4DCRVjFm8nEqV5gNpsC6VRDJlEft+RdiZksO8mf3aHR/PylFGkwjINThc0ZO2BfLAqg==
X-Received: by 2002:a17:902:a511:b0:235:1171:6d1d with SMTP id d9443c01a7336-2366b32e4bfmr78629015ad.9.1750037566862;
        Sun, 15 Jun 2025 18:32:46 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:46 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:59 +0800
Subject: [PATCH RESEND v7 10/21] drivers/perf: apple_m1: Add A9/A9X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-10-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
 h=from:subject:message-id; bh=wl40dMXc8W0PdUzpNjblXnUW0iWApVwrvUwg8aXHqWM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QYzkM6OtNggSbVQTTUUqoHAtJZO/AYTiMwH
 uvS2ucgsjiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GAAKCRABygi3psUI
 JK+6D/0SosreD+Kv8mIQ7V0lkT+Zllm0HHJbCHRg0H+BhFH5YzW53HGyHd3bvPbqQSGc/CfZzQz
 XPc3NfB516oIUV/fXfS3HUEWuQUdOZNk/3HzrcOG54dunp0dJn4gW/avVXAyAoRrDyYPlmdmbxS
 9cljwk1oxmBba9X35ludf4hwAltUvK9D3t4U51UtU8+6RZdL7wwhptCjO6jkpjhhAdHx6qBfCuz
 NNSzQtBnc7FuZtEjDrlkg+BZFFMK6C+LPdz7rYIhk/hVIVlZzGZcJCoKgecPMTn+zdQc+OZTEIn
 oHf/eVQubM334p1Jhl2Oc5dQQqrnq8l1+oUOw0rAG4XBWgSdElGICdvU4tO350jfVKexgyOtPe6
 7F7MOk47o+FykXcrcZeNSaW/GoQEo8V7BwgEHeqX+/ZSytG62fFitO9QUeW3useEWw6l2K07m4K
 uM1CzU+0PmdeeSmH5cm5GSL8OniZLmCbDvDub8U3qXFz5UvItDt+zqH7Jzo6xX4efGfJAnr1k+M
 JTbf80AqHeFETLST0pHt1ktMf2NXChOLk7QkTYzKzlfqrGji+rScfHWPe3gm3LV62XO75hPp/uT
 BNNO7dIN49VVbu0eRxqZBkZTDdH1abbJ3hgB7EOv0MexbxU6kkrtJEzJzYZrDAMIOTfb+2S/JA8
 5K0kXLdQeJoq5PA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for CPU PMU found in the Apple A9 and A9X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 121 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index e56f7fa9829da9e9444c6834b03e4a79dbc02c22..e89fe646a849f50615a3dc809e51a6cd95dd9a1b 100644
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
@@ -797,6 +900,12 @@ static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -986,6 +1095,17 @@ static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
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
@@ -1035,6 +1155,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },

-- 
2.49.0

