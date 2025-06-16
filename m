Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FF220F5D;
	Mon, 16 Jun 2025 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037566; cv=none; b=BGJNoTtQG3FU/g9kQ31Kqj0qBM0avd+0YvZvOY2S3nz4KYX3F0+k+hSOnNT2i7hTDgzGl1g/7qLnITMYmYZOjwcdf48+EY6VYU1MjZ9mqGI2Dg3982aOshET40vng7FpEfSjMaJ7GOl4wrGWJLGoPBiXNQHMPnRpfopnxPWRIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037566; c=relaxed/simple;
	bh=YYxBoRi9tg74DJBz5VJpYdMNCrAuGOPZ8JV7L/qISSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkcUboToO0/Svcniw73jbncGOep8d+O8OZFj/ZjdklGpm+RqYvGYeMlxUM+ZZPY9sbOKzDZwtWd0xIA6pUTPbBuI+/Gt8KKgUVncArr+BPV30ayN6bUdltr/wjWBhK4wF6VmeVP75OkYKb6oDbF5FPW7GA0jmsnPGZfbQEm8dpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQeUKxWK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQeUKxWK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2352400344aso34188365ad.2;
        Sun, 15 Jun 2025 18:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037563; x=1750642363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1Ef58P4CZiJKncAdu2DCccWJXMfX5tqD5QoG4RSffM=;
        b=QQeUKxWKcUo9hXS6JqRXCYyRpmiT07xZfdV9dv713rSOLMoUhoAayM527UI3Zr4l4n
         /rIZCtRHoEFDdwOijp5tktryu7NXA0Bg/9j/UmFQCe3H4ZL0NxeNZFYvJAv1kbUm5150
         goaCNQyIH8KnAwp++zSMZEoMRTi5lmh/8+lM5f9ki71U9MaQxnq9sNBz+QnzODh/Cz2z
         gU2hcjFVd6PRvUBUTFIXhHVRWnFZvByVSE7Eq7vcr0ej9/gA9BX8YELWLfl5kp5Epst4
         5HPNMPZgtuW+NQCdkC8EE+2UVRrKmIn26Eu5eLQXx1EgtG9EEtZhdutzdzmoFWp5cx/k
         7/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037563; x=1750642363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1Ef58P4CZiJKncAdu2DCccWJXMfX5tqD5QoG4RSffM=;
        b=tvM9r0EPSZHgdDMyEnIrRotcQtffBkuE+9NpBHqitNoAJ5Vxw4CJ71JiRfCioOtAu3
         6O3gXcy3zruU6/dqZMibhAkfnmHZw+gW7m6HI1qaFaDISH4URWRUjgcBYN8wlGRjml00
         3pboZT/W4b9SDoT8i4bEQkl/EzDq/1lgtrNtpTtJuwB/ghmI3SFHfkV4FnNvEreLChkf
         6iHiyUyx/g11w/ZGe5J6w0u2nll1ck6xHUDhqrDaWXDBrmFw7NAoZOrfdhYqwCJ5HBZW
         grMBh5G22bi0Ou2dnG3qZUwf5/kd+X1DQfjymrhqBV7rHcarCSeHRrQ5ujXFze6PhU36
         +zug==
X-Forwarded-Encrypted: i=1; AJvYcCUloaqOZq2+UjCbfMV4JnbX6QZ2fdBlYTwTpjDzpF7Tmcey8UkvipKobNPCJGWEOO/UJVqt/mIHdw8k7Rx1DiZrgw==@vger.kernel.org, AJvYcCVcHn2aNp5WXnvVB5Vgc3D6Rir7ZB7m+8ZgrbaGjRdL9ckue8DgRPcYTLkgyzRuiOUrGs/01ZJC8I1+KESs@vger.kernel.org, AJvYcCXCkMiyHul+MKz2yrCdEAKOPSYB7AIxMfa3Edcae/6uHblSsZg9OG6uvyLFkyIb0k8B26QYoJXcmp+7@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlSvkJnC+NcL4WachZFsCa99ddp8kwdYB5/xHbQDafMc4PzjU
	mM99rZdFz+JO+wmMs8TVPzqE8i6KEOu88kio+JbsTQ5qJQnS3LotUz211ERt8w==
X-Gm-Gg: ASbGncsKK/3UNTw1bhPAyUNOwyt3mu4LQH0yn7QxDvXEw/wBRWPT1P9f3FtvmCuiUrD
	kScvhQHkVEhtH3JNrw0pRJVLATX1KIanY33iFI67VvgmBVovf/0Q6Fo/njwzzl47P0HVEY1cQXg
	1vJJ//v14sY8T+Pj3bjsssALlpAiGwA7FerJvmrUsloGXBg6PaE3AUkKijFiGwsk2O9XsxvuU19
	Ftvwdb6d/3WuiEQmGrBg3FaOoZWvUGYw1Ds7foqQzHXl9xJKHRATcfLZI/Caipo+DBF0XokifQ2
	nBBw0DbBiEgd5IdWzxJksn86iwX5+gctVjE/1mCwNVe2KlqLefVFSVE7UvRf9BdIPIbMzcLY3Q0
	tWsY=
X-Google-Smtp-Source: AGHT+IGzgn8x9GH2fnBRE8OJX5D1ftpxVvWrn+GxjRK42tJAqkin6Zz8PqZgb0FbjBUwZoreECVLzQ==
X-Received: by 2002:a17:902:ce92:b0:233:f3df:513d with SMTP id d9443c01a7336-2366b144dadmr120458625ad.35.1750037563553;
        Sun, 15 Jun 2025 18:32:43 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:43 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:58 +0800
Subject: [PATCH RESEND v7 09/21] drivers/perf: apple_m1: Add Apple A8/A8X
 support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-9-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7313; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=YYxBoRi9tg74DJBz5VJpYdMNCrAuGOPZ8JV7L/qISSk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QY9jCRcgHRf+ghE+yXd7sFBwZIkZSNZjTO5
 xCXvU6dMqiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GAAKCRABygi3psUI
 JKpzEACSmZ2P6P4SHeIyebwYCiQuR2tWnhDgXRgM7Dh8gbKzlv5wY5aCh6YEVGrItTQUnCPWfIa
 gbyURQoJZX+EJcZ90Gn0z0o6vvXcv+Tz969BMSX1NUoReGASAdiDtxJJ3YX7iZ47cKOIj+F/SS0
 E1K+tEj2w6pUnFjnfxwFtjMtrv5I1ngKDAmvuzDNOEdUi1izHH9MmtFk4UJiskRrvJtm7nAVgx/
 YE/UtHGil5Dff9hYUBfgR3ferCGFNQALObq6ug2oItCtZGEe60VesBF7YXmzYUFYTBAcBnriRGz
 8lq8aa4oP4q4LUfXpHOW/AzN5ukO1QwnS61lIhawpdIvCEfMpM0DsqmvTXfXD60NDOsST5H2Stn
 4RN8oWX3yM7BWiCSCdGnytng/dcJvaRs4NIToseN/emn56CEYFj4OIpQMrpzfulCGGEHgtIx7bw
 kQtRfQIWiJuhp1/zEjHU1SwKqk12FrNHMWVgZWMiNXIqfi6nBxxzl3sIj6uqyCxcCpIGhDPOWHP
 wHhEaFhXXCigvzlJlU+Z76nnmLQNwXXfr2Q4gui6RIe34eqtX8TOgw3yR7uyNGWi9FEji3GQZ4s
 EaWi6eEex2b602HkjF+umdbPRi6nfrVxS4C/1blIXGCe8G5xBff/F4V30XdS69PU7oKkri16A07
 nnlSdjOVo8oIYKg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for the CPU PMU found on the Apple A8, A8X SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 124 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index ac9beafff3d691b226c261f222c2dfb057959a56..e56f7fa9829da9e9444c6834b03e4a79dbc02c22 100644
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

