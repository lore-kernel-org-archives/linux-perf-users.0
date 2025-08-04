Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B770838
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275901; cv=none; b=uGxjbG6VDz8aGqBdKz0mvtUgpfqve/sacmNBEjUqFgVYey0598Da3+cIBG88J+7TE3bZ5AIn6eD1eA07IWvGpvtw9huP17AflYxECEeNQGYcksjfadpkBLSE7OkDU0ysq6mE4Q/l/oCO7eFXCWhy7zsIom+7AccvoMbJSFREGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275901; c=relaxed/simple;
	bh=EhGd6gIenyb/JLJh5qNleIbNoKz8jaEu4G9DhpC1VTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXNG5liUZfEiCwyh2tsf8vqskEKXEAoyGpsww9JnkjnK86zh4cnmC6KTGP54AZ63cWWQBpWKRiK757vR0QiO1urZz+3QpmNS921VGDaBgF9/qJzvmvITwHPlnhav6wlecJ1e8n25gPIf0TgT3lIsLe0qivY5p+JA6jm+cbjOfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dxmg5WkD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dxmg5WkD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso3131074b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Aug 2025 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754275898; x=1754880698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kppyljle9MoC1RO3HWHQlYBE2gQj+CD/61kPvhIKZUU=;
        b=dxmg5WkD1sdsnaR1J5zK5oXIQoSeZ4+a6UYlvECyUGEsUE+s1nTtnzjtiLk/gG8VKN
         ueq3nA6Z/xUa50Ro/XRgGaq3te166LDcYv+HE2jiPH8i4v3R1f6tljp5H84RvbkXAkda
         D87d82nfqj/OPhknz1TIhxpEAdbSlzYTo0ETqddKZ/tTYBokNXlpaQwqYN7p1oOwqzTq
         yDhQ3hKCUXQ040pMgGa6ioiqrKDt9i2CUR/j/57aIjuInTKrOrHKWsmVpcb6m19EDcPP
         Qp7UcB2cR2j1sUOSIE13daIMgd9/DXaVJJYLuinbonvJtuiNFDluNsUFad2QJJG2o8As
         /ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275898; x=1754880698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kppyljle9MoC1RO3HWHQlYBE2gQj+CD/61kPvhIKZUU=;
        b=e+Hk4o8VXdGq5tFr/ot4esBi46x6lgx5jW+J+/kkCyL3DfvgsvJgTAOdmn2OrkLa0+
         9P4oQ/VU2olZFxgNiAgZWVaxZYg4cT89hd6bQgjemNvYv/jxU4M/hGbGtpFxic8dJmv+
         sZ6KjhlifPa6NyKFmoC39EQ0K2sm5dTZwuLwsi7Iq7QobcaVqTdRZUZh4KXeFA7H6ScN
         9njxzVr9l+dIaKBOJAVcsJwG5ATHC2PfLwfy0ZDhOrA8APNXF/EvVcYJtsiiLDXFpu1L
         5MkvtEMFeVmQGRsZwgydVoalANyLNT6YEKG6dRRSMepFiwvr1Ce6X86E4laTyByUsSM1
         NpuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbvKfRZ3Wu84RkliBtz+vOlA2hwrskvmbsVJ8diuGEif9MRQFz5WLAPacD0tON/xwRfLvfJk6afalbgmxPTIck@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFrVJGaW2IJYUazBM9NwGituypoqlcYN2Xlbfnm16V8GJKuK0
	H5cQbtDsHCC46fcVNgeHmQxe41kXX/F2Q/NlVpcEpmCQ+XKXoE2wZLo7NHAm8p7mXug=
X-Gm-Gg: ASbGncv8B9FLb5PmEWBqqPjw7M8LuGHT2vpfK828/tKyMGLC94jwRYj37YoX4rFhohJ
	snb4AL8UzJ+K0hmXlXdDeCqF7rN7cN5tvfIjc5YSnAp2/qEXlpa6Mo7D/LDwEXD0uC2XXTbMJjw
	aKPgWQk9TkUz1agMWLJev1fUm9p2cmn08yIAumdFNvRqPkuDgr1YNafkOvBQWZWZzKKRRmTW7fY
	UwzQJiFrhQINkuZsakaAui0WjAE+SXU0quDWg6R2n6e2VWCDXmUldX1HuErwIcLp9nBjTJ927Xc
	MjAkse6Bb4onRpdCnkLX6dAepV3c1JUF6tlAE1CGfGmujP2yrG4flD+3piw+IR/aBDI34wR/w57
	CgoIOb9ZPfyMnPTfVrpULdvtgPMvJ1tMlY3N5fbRS89tbYjXzAcDKSYijwfGJ+w==
X-Google-Smtp-Source: AGHT+IGnAJTT+IrbnsWZCRCk+YCd+3FYDN3fJPd3vuAU12BnpRFJPFCkmur1SehfCljyn2rk7N6/hA==
X-Received: by 2002:a05:6a00:9a5:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76bec30d23dmr8835977b3a.5.1754275898337;
        Sun, 03 Aug 2025 19:51:38 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be9143983sm5181960b3a.1.2025.08.03.19.51.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 Aug 2025 19:51:37 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] perf: riscv: skip empty batches in counter start
Date: Mon,  4 Aug 2025 10:51:10 +0800
Message-Id: <20250804025110.11088-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid unnecessary SBI calls when starting non-overflowed counters
in pmu_sbi_start_ovf_ctrs_sbi() by checking ctr_start_mask.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/riscv_pmu_sbi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895b..3977f7488e4ef 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -877,8 +877,10 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
 		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
 		/* Start all the counters that did not overflow in a single shot */
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
-			0, 0, 0, 0);
+		if (ctr_start_mask) {
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
+				  ctr_start_mask, 0, 0, 0, 0);
+		}
 	}
 
 	/* Reinitialize and start all the counter that overflowed */
-- 
2.39.5

