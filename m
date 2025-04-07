Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BF2248BB;
	Mon,  7 Apr 2025 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001196; cv=none; b=D9RtlA7GDegMq+c9ToQgX3N8JolVT112S9ZXfOG2i4bHh2jw5Uq6eg/hNnXxtH9ejpKiKFjClfpc1LfjWr8HUNH06ulMS0/HQzIrSDl00kNJudKCwURpxDi164GBWcCEGlhcekWVy9M4Fv/6MGeRtagRwZ9Yk4dFm/b/8dBDxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001196; c=relaxed/simple;
	bh=W4HZa+NpM2ESOXzUAr4zGaMv7Cw7ppma9xh4UBE8JRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibtn8NYD5pqlan7xaUK3OCy5fKpPnA20IOOHBhY1ZQYBLJNy0n7PB1RgEtmjPKmnTgSdmK2lv5EFmrC/ZAuTaXyYyiThYX4/wMFqXE8bo0lzrhN30rQqdZ1uf5iV2dwlcDaOzfH9k93vM9h9n/wPCxsVfJHOZb5AI4tc7undxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSUJWVft; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSUJWVft"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af519c159a8so3450324a12.3;
        Sun, 06 Apr 2025 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001194; x=1744605994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlLudR/sWk/Kne4yinSxqoxYxOt3q1pcjfuUzQsQpng=;
        b=cSUJWVft+vAzUG4XutaT3Mu/SUXqp9IDZzZ9QsX2RMYn+naHLHe1PbKk1K5+J+r7R1
         cJyUTw7CHQ27uxo6rGZRqgjYDnOBuQidqqj6Jd+TkYpK7NtqGQtaM88IJZZiw3xiN2Mk
         oRsbLwFIcishnyTJu00yCSC0qRE9AXNafzEval5sPJhQxvqGLO0bLYFCbwCsWziMsFhb
         +urHb0XQBWVLiu8n49hyW7PCgKgoYH4PPu2MTflc5JfK6lmReWlNYdHqmbo71SVMLtbC
         bgc5uRoBh5FfH5RnFuicmBT0DNu+0ytIscLap0MxRyjVNDNNgy8InuQYM5wr5UOHSgbv
         LocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001194; x=1744605994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlLudR/sWk/Kne4yinSxqoxYxOt3q1pcjfuUzQsQpng=;
        b=oloXG6HixXIvF7mKlWZOQWFTVnH4ZKKHcDB4TP1z3xzRL6OIzN3Xbk4Miqg6EDYv6f
         pnUBS397zJrKLbwUT1tf2J/ltlZoxtXxl/Y3GO0K8tnBbPy/LHkyp6MHwHg120cERKjj
         +EE1SmNf6gS8a+GdH7pe9jENwh3hFTTNbryp5Px/u9IytdHqQ91rdc+SrIt27ZXyYl9+
         HGkhxxUhx7Owa86ezVYGqjJilHobeCNGLdzsa0pEoKibRt6/+y+YLrfhwynWQB7NwMGB
         5fBfWEuAJ1wo+igtzt/nAkVlDJ2ZIjoZehqq09tvVtX4T7sXW3fdTx5pkAjI00sRYnEv
         Kkng==
X-Forwarded-Encrypted: i=1; AJvYcCWN0fLbGLJZXKOzUyTI1rThcciVfUIJYkpJZb6Ss7RXM+/Ky2pKQMpWPXZ8l9oooVkCwGJCT+2KMkPH@vger.kernel.org, AJvYcCWTH24m/aH76LICu4YtABPvra2+BPKJyjnfGyvJFmbBFzxO1u3QOByVbq2Hk4hsViDiUGe+q00fQOmG+wf+twytvg==@vger.kernel.org, AJvYcCWh+jUzrY9+l/86R/ehn5zza4ioIp5NKIVDvozVZCLv5oMtLNeMyqIp1YXawsLGNzj89y1RuILxePNQvGbA@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaZdyWsABUEZtLRX7X5Vr7dQ227svuyR2odoNAkq0jTcBlK3B
	Au0haRKOgn4hrNVCy4YCOitdwSLidqks69GYWgX9QpFe3zEGaRwX
X-Gm-Gg: ASbGncuLLqTFkWzwFTXAInfe949sl+GMFRtxVeMsSuxt1mYAQGAtCfrOl69orujE2Z8
	GehdUMut/UvVA5FGfv9X4rnz4P1GX7qrQoQS63mpY2Yavdb7+wTg2Qk/oJ2nfj49yjtfNKFVvPD
	/3Jcg8DxuRYLvwA3flrE6q7IUeQVTYMrMXi6EKCwyxHLF9opTVwSg8YlZjfgCanPSSO197xDvn+
	ziiKhJ3Hp0X+XgeKOpOzgpEJtUPSxcpG1byihm6MHrcKteYFQh0TnexWeDYqd41lJVJfIxp1eJN
	HjcJa4/4cVaQTN9ew9k54OZlv2tBk9RGQAThz1b1aYrlEnk=
X-Google-Smtp-Source: AGHT+IH5JkTcBJMuukZNf+9MfA8BQT+SAwA+y/0C4BCeewQDuZqf4Pc9lMKi4zvJRM0gplro6hv1dw==
X-Received: by 2002:a17:90b:2811:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-306a61208c8mr15295672a91.2.1744001194224;
        Sun, 06 Apr 2025 21:46:34 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:33 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:18 +0800
Subject: [PATCH v6 09/21] drivers/perf: apple_m1: Add Apple A8/A8X support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-9-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7313; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W4HZa+NpM2ESOXzUAr4zGaMv7Cw7ppma9xh4UBE8JRI=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iGjHVDO1ZdGaJ2zjtbAtFktvr9MybUKBWfy
 qeT+d0oFtqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhgAKCRABygi3psUI
 JMNFD/9B8m1X5mOPQEZmSkz0OKhtjGEllvIteJRoj7VWubBmsU1DpKwumnPYr0YD2iHNEM941A+
 OUqgZtWtsif3MsYGwEFwNvvVVgj8QLe5HZwW0PX6DrspNkCMDd+QJYZHYs19Yl2dbBKB31jIV4j
 PyOcH/oxNeno85GWMoUHCWgqhdhqTQap8826wZInY/jG1vANlJgIz5eZCVBvXBPEDwo3JGcVhDW
 wsdsJDQXHWyX4T5NJiUejr6mxJazo3sqnsFnItKk1C0GpmLyPTS2UN/TU0Qqe1qb6ooxVUMfKD1
 DFJ3yZ6KuNPFbM7l9fRyA5V4A7W6I5dkRE6R6CPoGJR10GHOJmW0tgr0fTajS8gf9K6oIrDXkGw
 AmtSU+8OBpN19Dwbm4zujfQNKp0tCVaGbKwO2k2PdZ3cB9xjGgYzQzxQl2LXr8rBXVYuX0w3A/W
 x3vdlBl+cLy0E+zlrqPGU7zErf/nxWjEQVToIvCC+ujJdbLs3avlN9/Z5TNIlrnUlgMIvRylV0m
 v/Sqq+o3ihQBIW8Uit6QyPnEMc41XZORioadwkqXcQ+1wEhsarKnhNp3Jykg2O7xM4NyH9Dla8w
 w4WeterZG0ndlJJOWC3CYTAa/5EQCXL2cKsVsN4TVfn6lTvZIyEepeVN85ESanKIOYsx0oCUez0
 K/sIm6bl/tfq6Hw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found on the Apple A8, A8X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 124 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 3c03d0e99ddaf90605cb8dafa68ab8770d371a05..5739a85f3ae07c52f4ce91c4eda3e4bcdf91015d 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -28,6 +28,7 @@
 #define ANY_BUT_0_1			GENMASK(9, 2)
 #define ONLY_2_TO_7			GENMASK(7, 2)
 #define ONLY_2_4_6			(BIT(2) | BIT(4) | BIT(6))
+#define ONLY_3_5_7			(BIT(3) | BIT(5) | BIT(7))
 #define ONLY_5_6_7			(BIT(5) | BIT(6) | BIT(7))
 
 /*
@@ -183,6 +184,111 @@ static const u16 a7_pmu_event_affinity[A7_PMU_PERFCTR_LAST + 1] = {
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
@@ -685,6 +791,12 @@ static int a7_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -863,6 +975,17 @@ static int a7_pmu_cyclone_init(struct arm_pmu *cpu_pmu)
 	return apple_pmu_init(cpu_pmu, A7_PMU_NR_COUNTERS);
 }
 
+static int a8_pmu_typhoon_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_typhoon_pmu";
+	cpu_pmu->get_event_idx	  = a8_pmu_get_event_idx;
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
@@ -912,6 +1035,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
 	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
+	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
 	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
 	{ },
 };

-- 
2.49.0

