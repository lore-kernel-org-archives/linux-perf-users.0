Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813D25EFBF;
	Wed, 12 Feb 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381003; cv=none; b=p3u49i2cN1tAuWkoAgTCVoKaRsvpthxsx4fswGBGg9XdRm7Q2ii8TgkiDVmaXEOHpj80wI/V2eanmwoQ8XaRXtX+LhGqW9iJ3SbXOP95WCw0JQZ/T3+KRxSVrTx9Kd9TCLVNtoWNTC6UATi60nzLb3UdvRRzpRi00MWSLFHMoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381003; c=relaxed/simple;
	bh=o9XQ+tue8DU32I7ubSPkx3HiW7qsuXyLKj6Ej7DckAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGZ2fCB+2G0jgvzU0kjLTW9v0tmq0w7BksED1uoRX/f6mlXnjqpc24BS5K3nY2t3DYUfL/wFHzzYwQpqv+2j/BZFmetYXPASuHLfODq/9RJHEIuKs3ggPNKUm5JUd3xbuUxHr/FXZRUmVg+UJJMm79UDcgJWYGKJLE3Q2Hc0Yyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM+MftWi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM+MftWi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6d2642faso116551765ad.1;
        Wed, 12 Feb 2025 09:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381001; x=1739985801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm9woTVUSz02jRtjUKU2FYmRTWXh8koJl310GPasME4=;
        b=lM+MftWiIrWbooZOJ1VSFxYLsOHLBYyqDyMqsg6UzAV1l5kgcQ7813DPS1yTom5/BV
         LMI20hzaEk25FJPr3XRMJKq39ngvSdtKp2QWQDMjaSA1rFWWfxIr+vJwLcZCx3csJYUH
         dq80T5LNZaby+qqxSwtAeFHzKRNdwhmn7mboR1vzLV4kcd1lbTPMeSTxreAMb1IfekQu
         FqBczyB+N2LPhtE020NcM01zZZlfxLxlFQS+0aYI/83O6HleYYw2Oie3VA5pcwdDlQID
         7/CrxmZ6ZKpVzJayICXWyvDRRyOEH9YJua9rGJzsCu2r3uFiu4GUKcqQLce7l0HhLBQW
         jlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381001; x=1739985801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm9woTVUSz02jRtjUKU2FYmRTWXh8koJl310GPasME4=;
        b=u3Shc1qRYzuHSnQtM7EMIkuQH7DSKBe4lScPGI+jR4OKEPTpjqG8MUmoSA9vkyqInM
         mdF36CLiAR/MXyCAK0U8XamqRSfWsj2+mSvabyTW4dYriSooiPGXXEEI2KryZg37bQYS
         DllOyCSkrR4WNDttXM8zk6Ym1jdb44plIp2DSUXt4w3vjGXIkYasNCZJWXoKpU2oGWxx
         51tKhG7fbdyzia2kdxtMr2cV0SSDqXkVE98tCsulFptAAIL9d6pjDUI7cnP38yMn9UjD
         GCSZU/xp+HyhRnwqiD/Kjo5EIyzqRce9nF6DXQtHn9QBAsOqS0NxF64cFfHItjWt4y3L
         QyqA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jslJgO2wODEo1DzL192/swhjleANMsSp2BAz8H6i8TgcJGw6+2+SukxC/3BQ5RWEDwfUgmBmrliiCNnn@vger.kernel.org, AJvYcCVm3bvgDPz1TtUDMkw2tyzSO81iVfBFpW4OfKstxR9aIGoBXVBpS2JHwQKgyZAJmCx6QXq0gqwao0N5O4RRdbxT/w==@vger.kernel.org, AJvYcCVwaTFGDGEiv63oB5qqWHOBCMc7pIz9I07AcHwahg2eYY7DVaWQ0qR0cYGX3RqvGJLkdJ/uOn4iOoEi@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtmoB3CiaTlgaHmyrQqepdKBH7+lXRS2FLaH5U1xH+wf7wIB4
	3OoPrvCUUOm0eEGQ54VPBU4XOYmzB9CdgnraiBmkYJLmhOQuP4uN
X-Gm-Gg: ASbGncs1XqWFBf63iuXrpkoiduhzyA182AAwFKZ8GqSohV7+lfVaKs2yUfhEKGSWntN
	UvjaMLVZnstygchExrabnjbm3qxZzUQ1+cF5tVHJAjc6qvRvr8ZDjZSkz4ExC9KPMfePgRvCYl7
	qq8JbXxTcEg/qeNeH6Ea8zfNlbHdJskmgZnsVRcsGEAI+jONBuqMcaj0tEUkdS1rUwLzkcXHkHH
	q4ui5HT/1e1WoqpSfRO712P9VftlJYQvh07vrs8Op0hRgygwbV0o+WBRPlVQobOSLvRlw8LTFwH
	nT9u1Rq/EbAQayLiug==
X-Google-Smtp-Source: AGHT+IHwsLjg3DRxCvwcCl+v5x4KJHE2dMmCIBkhxrkv2o/hOsyT2iWaGfM08yqMNmhtKDK8Xf3Xzw==
X-Received: by 2002:a05:6a00:2341:b0:730:74f8:25c1 with SMTP id d2e1a72fcca58-7322c3e89ccmr6064849b3a.15.1739381001101;
        Wed, 12 Feb 2025 09:23:21 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:20 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:30 +0800
Subject: [PATCH v2 07/10] drivers/perf: apple_m1: Add Apple A8/A8X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-7-87b361932e88@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7247; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=o9XQ+tue8DU32I7ubSPkx3HiW7qsuXyLKj6Ej7DckAc=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjwYvXAaprn/edNY5RfMsgxHwvu388DAXY8a
 yV2NMv53neJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY8AAKCRABygi3psUI
 JFV7EACe6Rc/HN7KFnLKi5006gvnzcH0fYCFUbmtXX7lOubdKpA1DDNyNVLVz8UiW9DRZh1acbD
 XnZGipfFqcPJrtgbqi5Mx1QoE2/FbWUzpfZswpToN2B0dToIfTmpypvHp2ys7aWWC1NzsUmyuOD
 1kx2W+82BLbwMn+SuK05/+Omimn6MAD+hR9CE6R2OCzxunPaj38kLXgsF9GpQl384jRqe5izHug
 SOElSvlh5ECoDbiPGoTQZr+/AsxcGz/H0/PHDd2E0Pd1wO3IUCNXGmSktTDIdyl1VnRxaso35Qx
 AlTQ38DH7ABFA/QC94lPcZPwqNhsqrNL58BSbnngNi0PWnz6jZByR7peWONGYAsaGs1hCHxnxqM
 vMvl234trKrUlrxTsqyZssNqPwWydIVtGv4sgEPra3E6WMQuhvs4Esr5BrAOxUPmCfICpMjHUQr
 bZydnMEXlSvKI0uvDvQDwTdFCkQbcFRLnv2Z/PrIpEmoZ9djhqe07lU0G9ZBPCc4udr2isdV+1g
 9F2IeX00EohaYTQsCScCwuOh7FVnRjrSCqWuHpeFIqFwnRckzmKu5p4Zoot/GUCpL9wBLhJhS2G
 SNVXYV1aiEu1m/0NIQCMI1W01XAMgaJRSjHioEMsAZkvgApgul7VhaVivETEo2TVsBl2ZtclXa+
 4wuKXGt+GRfTTQw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found on the Apple A8, A8X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 123 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f852cd5633d7f180dc9dbdde11332ec825a3d558..07eab1d5ee078de5db3d08e2f1714bcfe5d3792c 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -27,6 +27,7 @@
 #define ANY_BUT_0_1			GENMASK(9, 2)
 #define ONLY_2_TO_7			GENMASK(7, 2)
 #define ONLY_2_4_6			(BIT(2) | BIT(4) | BIT(6))
+#define ONLY_3_5_7			(BIT(3) | BIT(5) | BIT(7))
 #define ONLY_5_6_7			(BIT(5) | BIT(6) | BIT(7))
 
 /*
@@ -182,6 +183,111 @@ static const u16 a7_pmu_event_affinity[A7_PMU_PERFCTR_LAST + 1] = {
 	[A7_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
 };
 
+enum a8_pmu_events {
+	A8_PMU_PERFCTR_UNKNOWN_1				= 0x1,
+	A8_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
+	A8_PMU_PERFCTR_L2_TLB_MISS_INSTRUCTION			= 0xa,
+	A8_PMU_PERFCTR_L2_TLB_MISS_DATA				= 0xb,
+	A8_PMU_PERFCTR_BIU_UPSTREAM_CYCLE			= 0x13,
+	A8_PMU_PERFCTR_BIU_DOWNSTREAM_CYCLE			= 0x14,
+	A8_PMU_PERFCTR_L2C_AGENT_LD				= 0x1a,
+	A8_PMU_PERFCTR_L2C_AGENT_LD_MISS			= 0x1b,
+	A8_PMU_PERFCTR_L2C_AGENT_ST				= 0x1c,
+	A8_PMU_PERFCTR_L2C_AGENT_ST_MISS			= 0x1d,
+	A8_PMU_PERFCTR_SCHEDULE_UOP				= 0x52,
+	A8_PMU_PERFCTR_MAP_REWIND				= 0x75,
+	A8_PMU_PERFCTR_MAP_STALL				= 0x76,
+	A8_PMU_PERFCTR_MAP_INT_UOP				= 0x7b,
+	A8_PMU_PERFCTR_MAP_LDST_UOP				= 0x7c,
+	A8_PMU_PERFCTR_MAP_SIMD_UOP				= 0x7d,
+	A8_PMU_PERFCTR_FLUSH_RESTART_OTHER_NONSPEC		= 0x84,
+	A8_PMU_PERFCTR_INST_A32					= 0x8a,
+	A8_PMU_PERFCTR_INST_T32					= 0x8b,
+	A8_PMU_PERFCTR_INST_ALL					= 0x8c,
+	A8_PMU_PERFCTR_INST_BRANCH				= 0x8d,
+	A8_PMU_PERFCTR_INST_BRANCH_CALL				= 0x8e,
+	A8_PMU_PERFCTR_INST_BRANCH_RET				= 0x8f,
+	A8_PMU_PERFCTR_INST_BRANCH_TAKEN			= 0x90,
+	A8_PMU_PERFCTR_INST_BRANCH_INDIR			= 0x93,
+	A8_PMU_PERFCTR_INST_BRANCH_COND				= 0x94,
+	A8_PMU_PERFCTR_INST_INT_LD				= 0x95,
+	A8_PMU_PERFCTR_INST_INT_ST				= 0x96,
+	A8_PMU_PERFCTR_INST_INT_ALU				= 0x97,
+	A8_PMU_PERFCTR_INST_SIMD_LD				= 0x98,
+	A8_PMU_PERFCTR_INST_SIMD_ST				= 0x99,
+	A8_PMU_PERFCTR_INST_SIMD_ALU				= 0x9a,
+	A8_PMU_PERFCTR_INST_LDST				= 0x9b,
+	A8_PMU_PERFCTR_UNKNOWN_9c				= 0x9c,
+	A8_PMU_PERFCTR_UNKNOWN_9f				= 0x9f,
+	A8_PMU_PERFCTR_L1D_TLB_ACCESS				= 0xa0,
+	A8_PMU_PERFCTR_L1D_TLB_MISS				= 0xa1,
+	A8_PMU_PERFCTR_L1D_CACHE_MISS_ST			= 0xa2,
+	A8_PMU_PERFCTR_L1D_CACHE_MISS_LD			= 0xa3,
+	A8_PMU_PERFCTR_LD_UNIT_UOP				= 0xa6,
+	A8_PMU_PERFCTR_ST_UNIT_UOP				= 0xa7,
+	A8_PMU_PERFCTR_L1D_CACHE_WRITEBACK			= 0xa8,
+	A8_PMU_PERFCTR_LDST_X64_UOP				= 0xb1,
+	A8_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC		= 0xbf,
+	A8_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC		= 0xc0,
+	A8_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC			= 0xc1,
+	A8_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC	= 0xc4,
+	A8_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC		= 0xc5,
+	A8_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC		= 0xc6,
+	A8_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC		= 0xc8,
+	A8_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC	= 0xca,
+	A8_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC			= 0xcb,
+	A8_PMU_PERFCTR_FED_IC_MISS_DEMAND			= 0xd3,
+	A8_PMU_PERFCTR_L1I_TLB_MISS_DEMAND			= 0xd4,
+	A8_PMU_PERFCTR_FETCH_RESTART				= 0xde,
+	A8_PMU_PERFCTR_UNKNOWN_f5				= 0xf5,
+	A8_PMU_PERFCTR_UNKNOWN_f6				= 0xf6,
+	A8_PMU_PERFCTR_UNKNOWN_f7				= 0xf7,
+	A8_PMU_PERFCTR_LAST					= M1_PMU_CFG_EVENT,
+
+	/*
+	 * From this point onwards, these are not actual HW events,
+	 * but attributes that get stored in hw->config_base.
+	 */
+	A8_PMU_CFG_COUNT_USER					= BIT(8),
+	A8_PMU_CFG_COUNT_KERNEL					= BIT(9),
+};
+
+static const u16 a8_pmu_event_affinity[A8_PMU_PERFCTR_LAST + 1] = {
+	[0 ... A8_PMU_PERFCTR_LAST]				= ANY_BUT_0_1,
+	[A8_PMU_PERFCTR_UNKNOWN_1]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_CORE_ACTIVE_CYCLE]			= ANY_BUT_0_1 | BIT(0),
+	[A8_PMU_PERFCTR_INST_A32]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_T32]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_ALL]				= BIT(7) | BIT(1),
+	[A8_PMU_PERFCTR_INST_BRANCH]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_BRANCH_CALL]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_BRANCH_RET]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_BRANCH_TAKEN]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_BRANCH_INDIR]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_BRANCH_COND]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_INT_LD]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_INT_ST]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_INT_ALU]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_SIMD_LD]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_SIMD_ST]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_SIMD_ALU]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_INST_LDST]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_UNKNOWN_9c]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_UNKNOWN_9f]				= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_L1D_CACHE_MISS_LD_NONSPEC]		= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_L1D_CACHE_MISS_ST_NONSPEC]		= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_L1D_TLB_MISS_NONSPEC]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_ST_MEMORY_ORDER_VIOLATION_NONSPEC]	= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_BRANCH_COND_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_BRANCH_INDIR_MISPRED_NONSPEC]		= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_BRANCH_RET_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_BRANCH_CALL_INDIR_MISPRED_NONSPEC]	= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC]			= ONLY_5_6_7,
+	[A8_PMU_PERFCTR_UNKNOWN_f5]				= ANY_BUT_0_1,
+	[A8_PMU_PERFCTR_UNKNOWN_f6]				= ONLY_3_5_7,
+	[A8_PMU_PERFCTR_UNKNOWN_f7]				= ONLY_3_5_7,
+};
+
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
 	M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE			= 0x2,
@@ -643,6 +749,12 @@ static int a7_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return apple_pmu_get_event_idx(cpuc, event, a7_pmu_event_affinity);
 }
 
+static int a8_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, a8_pmu_event_affinity);
+}
+
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
@@ -792,6 +904,16 @@ static int a7_pmu_cyclone_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init_common(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_typhoon_pmu";
+	cpu_pmu->get_event_idx	  = a8_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->reset		  = a7_pmu_reset;
+	cpu_pmu->start		  = a7_pmu_start;
+	return apple_pmu_init_common(cpu_pmu, A7_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
@@ -837,6 +959,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },
 };

-- 
2.48.1

