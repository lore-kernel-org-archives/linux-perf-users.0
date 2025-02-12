Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB325A631;
	Wed, 12 Feb 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381012; cv=none; b=da7n5sk7IuvJsq9ethMK6GlGqdcZKXhbxPXPtXdEwWvk7gQdyHuGcoi5Q023e6GO3IbwqYisUYPA1LQN/G7L8MkJwhezrnekD9Hpa/1ekQXFMdvJJDAPShEUR+QORMVerbL4yvOCceDG2YMqC3eUwQI8i32CiDb9tbh+DLO0OF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381012; c=relaxed/simple;
	bh=X1FjYP6mBke/3D24Hai2ue885wXpUkAZdmez50aXc0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/uZ0baM7VvZ7EewbHzX1V1/EZlstWKG97+Pm3EwD09541Dry4jOv0ZGvYg+niAzvGVu0guEzHI77XVDSpBI7IoPzDHYVj83IrJ+hrRwEzncZdpEu1R26N+H+JTHe9WSOf6D10XaiDK1ZzzobVonrh0qoPTUIYt2bsAM8fad24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5fR2cca; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5fR2cca"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f61b01630so18295585ad.1;
        Wed, 12 Feb 2025 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381010; x=1739985810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0q3sDAF4oQzGjpTE5UFq4pISwyfntsajHJYAfkfV5U=;
        b=V5fR2ccapSIH+sJdIAuY9FSR/fiQMgu9gtb4FMK00MJ214FBMw2otG1dCrLd3xeWn+
         04gjyvsdeG74U1pO1r98ZQUszTHDnk860/zuyX2cu3ynNk5Gs6pPeUC0KoPlGKQw8ukM
         +USFeicVKuyKihYIksWzFLcmr589Jr1BlkUizBqEZTR197I+7E1sqAwUwm4rXFt4PQnu
         jCFTM9Pq9lfmR9Ulp4DfY5ReSZmVPsxZcoklOCqciCKFTasp8sPeraLemC/tdb/pZEUz
         5//i32L6/OMi0rrl8/fPzlSXN1xF5KrtamrXDZhvgSHYut1FCmdvQo9zJW1h8TA2Rnhj
         5S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381010; x=1739985810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0q3sDAF4oQzGjpTE5UFq4pISwyfntsajHJYAfkfV5U=;
        b=Lalk8NUfGGZxxELxBZawurq5M32uV/A34DDFDrLzHWy2JqxmBeDp1/nfkDbx41Qj2N
         g9bW4cXu4EmMry8KKUU/0k8f35rcencwUZPf9sVuExApKw0xB1PS4qTncnLvoGohfMkr
         3BVA1h0DJ0RNt4Wn0+9SdWxIbVoI6qeaG8GLHwatmpfg7/bad/YnSeiNrzqVD4iVIFJQ
         cFKtmn6Rgok0Y/DUWLbVzPD0D6C5sWuK/uiIW8IpqTGDZvTUEiYV1SnlBMTb/juTkVcw
         vj9cZehe7ixxURG6GE1w4lJ3Z1tnkFs/75on3FSChiiuRFtEICX2Gw+uEPGTDvYOICQC
         m6rA==
X-Forwarded-Encrypted: i=1; AJvYcCUhZ9eCD8Hju0Y6tBq8IoDY3TNp8+l0q0CnvlivVX4VcFLZPQZCLrMxy8c/addgFiKJULQcvuwJlB7s@vger.kernel.org, AJvYcCVeVqowYyD56mxVlLY4NgWEEcjk3G8BE9NwS/EI9PfUCC+P1VSX69eITX7t3ZwDtcKp/MKeu17wyEZBUrRo@vger.kernel.org, AJvYcCVkHlQl5znkUQ121CMf35qCqKgeidR9geg9u2PJhyTdzXNg2mdQqoulairGgi0mT8uSIafhT8h2Y116JbnHXqJ3bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJaaf9frwyVL23pVSBjLhxhMU+GHA8+t70W9yfoQ7sKMPpsB/
	MWgi3Y8zXyQ48g2SDN08ynsiPs0XRvl00g49rrhZsIrmY8JFsFQu
X-Gm-Gg: ASbGncsLU/y7mFqJf6E3k9G9mUbwtUzugjpB33ZaFTco2jKxW1N8TiDy95Hd8uZOK+J
	4o1oxfwgD3kxYSX5j4Eg3duGQBdXGGZ9W69Z5ZSy6dRk9SJUzdDZcgTfdtwu9W9/oVUWLpG2tYb
	i2TkP4CKkiFCdvXh5iNZP11cBZpr28WtVPrNbss54CyOqL3QP/HlsKov76qxnKdWktJ86TX1OlI
	ZbA80gacgWws2VqGV4DHqu6oaQ5ZljBxZT3kDls3oN03i/PKfdwjDFDN/iHR07uEJ5HfWEga7rG
	jh7RUMizgd62Z9yw0w==
X-Google-Smtp-Source: AGHT+IGVSSdvwzosWg1IZcwS8BMskgkU07C3H1XRsLu+vnpTLU7/3ScWN2qrDfl3HyrUXyfJua/Nlg==
X-Received: by 2002:a05:6a20:734a:b0:1ee:64c0:aa85 with SMTP id adf61e73a8af0-1ee6bae9454mr154934637.6.1739381010171;
        Wed, 12 Feb 2025 09:23:30 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:29 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:33 +0800
Subject: [PATCH v2 10/10] drivers/perf: apple_m1: Add Apple A11 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-10-87b361932e88@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7847; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=X1FjYP6mBke/3D24Hai2ue885wXpUkAZdmez50aXc0I=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjwOHiCdDt45QwCr4G1/VlK0JHGnfJwb+zrn
 8eBBKHLFJ2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY8AAKCRABygi3psUI
 JM1pEACLmL4+xOpOZg85I4Nh44mq3mvJfCduwshN8rdiT5luta//DE7QcG0XtgtpMxFlP8B3ARQ
 aIpTgRS4e5h6pfYpwHPlet69I0siHVFNzKv+Kxk82eJT0vDGg9cLJeVlwwOKVI9ofrpSTvmh68/
 wFIvvn1CFmwtCyVIe++NljUXFapT+MmezijyvcER2///viHi/BZjHH6UybjaW0yFjJEY3LJsAWr
 BF8PDxUFg1OBEYd+wyR4Rsm2Yv87qrGucpcywdFqsblUDxjc9yd3FpDOYAcMAhzmVZNAq2iSVin
 Fg+b/l/zM63lSI5TOE0v4lUsVqGORLWmHLbt2a1GNOvwg+bdlNZvbcy0AhOrmA10xj+w9n1uZeG
 5waq3DV9Zs1xZCCp8gYEtRHKU0xNKM3eWxTcAE9mpJLXksa5Orhf/5ff/m50eIqXUtqJt2VK696
 k9p9UscCcXpeSMOIS7IVWqBfqgUrn+ix2rLtO9EL1dTWRB+vVUo29geit57m/ljibzW0y5OopK1
 3woxTgkBPr5tRA9sHK+pAj4pF9XuPI9St0uCTyLzoFSr5ACIIMC2BXt/P54rrvIfzKQqIEYFmtd
 0DDr/wGjvf5FhOrrJgQwy5KSdPvHrg2ontXOTgrvTGpCzkAlouDlXq+ofJJDmvRBb8YV87e4+Hi
 6jo03XxLmzd4eTw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found attached to the performance and
efficiency cores of the Apple A11 SoCs. This PMU can deliver its
interrupt via IRQ or FIQ. Use FIQ as that is faster.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 135 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index c084c25f69d29756ea7a2e542e33888c1142d80a..d4e7436d0edfe785211ad700e4b0be4e1475e8c4 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -500,6 +500,113 @@ static const u16 a10_pmu_event_affinity[A10_PMU_PERFCTR_LAST + 1] = {
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
@@ -979,6 +1086,12 @@ static int a10_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a10_pmu_event_affinity);
 }
 
+static int a11_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+	struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a11_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -1158,6 +1271,26 @@ static int a10_pmu_fusion_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
+static int a11_pmu_monsoon_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_monsoon_pmu";
+	cpu_pmu->get_event_idx	  = a11_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
+}
+
+static int a11_pmu_mistral_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_mistral_pmu";
+	cpu_pmu->get_event_idx	  = a11_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -1204,6 +1337,8 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
 	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
+	{ .compatible = "apple,monsoon-pmu",	.data = a11_pmu_monsoon_init, },
+	{ .compatible = "apple,mistral-pmu",	.data = a11_pmu_mistral_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },

-- 
2.48.1

