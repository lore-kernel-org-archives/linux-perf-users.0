Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C3F1AB5
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895685; cv=none; b=jF+7pJjw4kfxjZJnPoLFHu2tBvJQDfeUqcCr0BteeYvO4G971bFvBAe6/ZpLbch3a2d6hLUNmc/p7iKv2BGCdh4ZL05ZKa+sngCckCcYiEQ9/rSRMCZsHTlBzIb1x3ImaV3FYQwzXsvqyZv2DglqEckUmyyUa1YkI+KSES4Er7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895685; c=relaxed/simple;
	bh=il7iB5GJVyw6ArXF9j9C7bPvLSXXTbFE4ka4RDhEEp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iB4V8NMguRcoUPU9ylAf2kXTKpnevgbCDLl4PGTUO5+W3OZ68uNQt7zsvKAzcCT3tFCiMWeP5LFMDYAN6BIZgE9kc1Jo6XDE46JJU8vjow1up0wD48EZ1oMsbqlwzWMtviVskVx1Lvz+XMf29pbBFWYw9iWTgblpMgSF7XRa3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZpcz/tc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZpcz/tc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjmKzXbjKhCHmtx2rpBPlFTDcxKMT/ZJGQfdrok6APM=;
	b=TZpcz/tcDmgNJpbk7rVVRQHfOFwQW1XD7YhpKNQbMVr5YJt86zC+sxz0Bv0bDS3d/1WmRl
	xW/uV5oKqa00tdOT23dKcxzdNXF++T2lHwsf+v8/jv3EQqa9+l5EOjq4Jo/MzVaP7Af+X8
	lZS874teHyhoBmwM7KH6CtfCLG5riGs=
From: Atish Patra <atish.patra@linux.dev>
Date: Wed, 01 Jul 2026 01:46:56 -0700
Subject: [PATCH v8 08/22] RISC-V: Add Sscfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-counter_delegation-v8-8-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Migadu-Flow: FLOW_OUT

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the scountinhibit CSR definition and S-mode accessible hpmevent
bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
counters directly from S-mode without invoking SBI calls to M-mode. It is
also used to figure out the counters delegated to S-mode by the M-mode as
well.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index b4551a6cf7cb..a3b24b88e401 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -241,6 +241,23 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
+#define HPMEVENT_OF			(BIT_ULL(63))
+#define HPMEVENT_MINH			(BIT_ULL(62))
+#define HPMEVENT_SINH			(BIT_ULL(61))
+#define HPMEVENT_UINH			(BIT_ULL(60))
+#define HPMEVENT_VSINH			(BIT_ULL(59))
+#define HPMEVENT_VUINH			(BIT_ULL(58))
+#ifndef CONFIG_64BIT
+#define HPMEVENTH_OF			(BIT(31))
+#define HPMEVENTH_MINH			(BIT(30))
+#define HPMEVENTH_SINH			(BIT(29))
+#define HPMEVENTH_UINH			(BIT(28))
+#define HPMEVENTH_VSINH			(BIT(27))
+#define HPMEVENTH_VUINH			(BIT(26))
+#endif
+
+#define SISELECT_SSCCFG_BASE		0x40
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM
@@ -322,6 +339,7 @@
 #define CSR_SCOUNTEREN		0x106
 #define CSR_SENVCFG		0x10a
 #define CSR_SSTATEEN0		0x10c
+#define CSR_SCOUNTINHIBIT	0x120
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142

-- 
2.53.0-Meta

