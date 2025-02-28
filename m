Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC781A08B5;
	Fri, 28 Feb 2025 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715964; cv=none; b=dbDVgflBsRnt2Yxj4xJR/q7s6HZZeAFVdKIUnZZ8seSMzsvuRNorVX4XKWM9nIApOBK/KKBAcDADmUDO9oq59dO29AHnO5sWJPruukuX/uoHDk+4+Fk6y2thdfjQVz+cBQdoWXgG/0Z2ao81AmmTvAeRAZpx8rMB55OUh9fIqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715964; c=relaxed/simple;
	bh=lf7A3C0Zz4tESlVXeyHjO47IaZTEqkMcyB+fvyCShrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dkieq/GMk/nJmbuVR6VGbEyYUU87kHl1tLobT1o07KXWVHpqhnIm5SG9MmKQcxa0zABop3iZCAZ7n/Ae6jyFt8XEHSU8t0OK8iixLkREqH6oOrHR2EGFFrXnuLG4UZDVUQG8FAqAHrxiMORtmNNR+ouYeK6Ni3pYHvdIxT2Mb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKXugfJj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKXugfJj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso36684705ad.3;
        Thu, 27 Feb 2025 20:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715962; x=1741320762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4ZTs0MDQiDNG8cQ+zxDnSK8kcgECMnzyQbgcPHl0+Q=;
        b=OKXugfJjsVswxdLJRbJF6dLNcK446GeZmhr/NlSAkdYVn3MnlAn6U+YL/T9s+H/yfZ
         58u43RTJEZwkxxujMKyKAm/8sCZr3oQhZjAM1crepr8lgmbNM73cfL89iuGI0aFN6OQh
         4X42d4I4t0SjbB9ERUeUAonZjV9lRbvLNc01/DrId/JXAubCh+4TxaB02xP6aSIHcgl6
         HDS/F0jjDGQdr0cIJwlhGB8bJ1yyLXVbijEe7mNMGm0G9S1WHLU0A/jAZOYnAWXNWqtO
         kDZnInh5z886uPuHxe5sga/2WEQu91dQ9BNUwCRdI81pvwg0lFrAg88dpnKLBFzFNYPC
         KjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715962; x=1741320762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4ZTs0MDQiDNG8cQ+zxDnSK8kcgECMnzyQbgcPHl0+Q=;
        b=FSdbFyPRmlpIR25le91U5pcm2mXZngEVNUuz79JgeLI+swgzqCQjnvTmkTWPMPPp2v
         lhtNyTz9s6LwJnxvBnN7nlEb3QIooSGK/FpEzoljeRxAq6BOIV1CKmovY75eMDbYZGTL
         G0xs333hxhU4aKl5rCq6avqsqPeLAahxyDMjpGtmprb0S3jO5B0vXxHRi3EgrURKoo1+
         BLxeWddNyqVs8On6QSpNisQx45TkNZXqSzY3VS7cDfzhthSiO4zYH8h4j1gnpab4ISf0
         ukl1aofxdoWPzqj0s1MSAHhMhaBJXzw97mZN4vORTCAydyLgvpbBc3x1i+fRPuE4cLNu
         TDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv9S/SkP72SNqU0BoLYwn92Run6H7NPeIsvLWwBUZUI69JtVLj/xJtsiJY0HougZin9Fh1hnAmpGsrTiMMJLhrQQ==@vger.kernel.org, AJvYcCWBogfUJTeMHRFTyGqQHdC8MuKROntrLLj7Utvza32fRrX5d0i+WBbIG402RMJuE3GYAQy6kfr0BIMR@vger.kernel.org, AJvYcCXyTyy6Qmw0aKErJscfw8nO8+/hvHsdgW/Sz1lYymmoExNjLGMrI3YYOLiIQEy8dmnTNKrmakbUSZd05KN6@vger.kernel.org
X-Gm-Message-State: AOJu0YyqP4PjYcSlXZvbQcgGknheb4auS5SEhqVJMmNUZPqjDt2ZVu3/
	TYH0xtis9w+oPMnGGdmMT5/VAfz6EvnjxZEZKwo8UhVHUMFk7FQd
X-Gm-Gg: ASbGncu3MaDalVE7SLDYYfQ/DJ3e18j/qZFfU48lN6bMa7qIjIMPXoGdAppoKmmlSJ5
	uACOtRis6vuQgds9wCcD36uVBvcLV1z9ter6O+J56Qy3xV13R1uFRTG0ZLGKuGKzfn2zIeD7cvp
	D3rL/zqIVXAcVD/HTMelsbKQGSifHweXVbPXPSgzzN+qw1KqGJkOJ76XcvQrKkiIkDUQgplzgcp
	f1cdCBw3YN9rCQu8amyIehCb37o1OkgOSNMQkK7Ra2xSIFvEa55Q2dkx7JCzhGjnSKq63LnlTIF
	IwwsJvP14DG86JHLiYPnsRDNFm0=
X-Google-Smtp-Source: AGHT+IFqhQ3+Jin8whEUoGVZX7bKcsoaW7jd2jBIN54ncu/S7t7Uf9bs1cD4DmZoE84D6Q3PRQpLmQ==
X-Received: by 2002:a05:6a20:2d22:b0:1ee:ace8:8170 with SMTP id adf61e73a8af0-1f2f4d220d7mr3421754637.22.1740715962418;
        Thu, 27 Feb 2025 20:12:42 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:42 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:50 +0800
Subject: [PATCH v5 10/11] drivers/perf: apple_m1: Add Apple A10/A10X/T2
 Support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-10-9e124cd28ed4@gmail.com>
References: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
In-Reply-To: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7476; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=lf7A3C0Zz4tESlVXeyHjO47IaZTEqkMcyB+fvyCShrA=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeJF7ARst1igEsDf5qEZuBand4fL9ZxzBSTT
 JA3d4lXXAGJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3iQAKCRABygi3psUI
 JNHrEAC2M1m1LpUSscWJBx8QJKJ2X32+SuIraOYtLz0f/P232SPcI0/iCwexTyVvs5ZtKahNgCa
 tUEpGqLG65Y9Aq3bhj/uNS/8mZ3MRklfHNMJQnutbMIO2+cMJtumeQVnQ2seFSGdQFY/S97GTkX
 uDagO93Kx1NfWc5L1fOm79+3OLe1PmHsNJImrHkEymyXPy65MKX7+/AROwcd3L8QRlLxGifUbaK
 7VhU15JV7pD72Nr/xbVe3e/pWBtKXQqxA4skKhZYwCsy+l+Ri2hZIeFuHsssrLXIGDIwHSuogMe
 w4AJ+7JmUBtTPWUuv0abWFt2jDZ6ZyEc9jLGzxJWsrRzlVDIkhuHicPh3gs40gu3hdXTf41YFCn
 SQ0SoaltYo0aZ5fzNH+W+fkPY4Xoc2PQzn8I7F39UgyDGhWr/IQQjrP+S0aL+VKHGvLeyz2TzIL
 zQ5SlRohf98IPf7sk/EOo53IPIwt/x2Uo5TN6dkP33rcKk1SXK0SV+YTMn5C66qaUhwFG05bQ3R
 XhZzbh0iOhuigN2OmC6TC5NadTQAuj3tjNPsvlrnlM+lDaILdhNL6k9fqccKIJO8h5Vv5ETpr6X
 KBBgnMMIgj85uM7U7Kw/R/4fbiWlSOqvOZq+/RyV1m0MA/MYS8sYSxt9ZxP2aT6TQlbIIz0ptb5
 Khrxw7k9feVOB1w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found in the Apple A10, A10X, T2 SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f7ae5cd56980b75d8f2073368479d0af77ab351c..e66ec1426f5d9d48ef52abd539acff7648958785 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -391,6 +391,115 @@ static const u16 a9_pmu_event_affinity[A9_PMU_PERFCTR_LAST + 1] = {
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
@@ -878,6 +987,12 @@ static int a9_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -1049,6 +1164,17 @@ static int a9_pmu_twister_init(struct arm_pmu *cpu_pmu)
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
@@ -1098,6 +1224,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
 	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
 	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },

-- 
2.48.1

