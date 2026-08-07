Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467E46D542
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090190; cv=none; b=liPB7/ppf11nHej4ih3+lqP3Pze6ddGL9oZ/nd73AralDSREjNdU2utKJakeeuL+pMDVryFXPUny1fQ4HZDog0Ug8SX6yb5Ua7dx54CK8jUTGYO4oPtZE40T4RhGIRlv8xh6jXmENTeihUAzLeP3QkYqrmV1N25u/07WVlwTLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090190; c=relaxed/simple;
	bh=yVI+F0ij8WOs2bR6bPYqFPorZNO4aG1WSluSdMA+FAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BM6eudnY+uZL2qHX59AURSZK5VskCkipRizM0eoL127HEyWGunjpEd6y1BYjfWcRH6Z8aNn8e6HhKW4MRKXSdj01I7dht0OYuiytyKbxTnWmlOp26zHSW8OPGNT3yD2/9GWV4zdORpCTIfosWBUTQxdUGTlifZ+Ii2cZ8NAzEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=glwRAdrt; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="glwRAdrt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBqwitrzuPPa1Vxy+koJRidNylMz9UIgzSZlHnhJwUY=;
	b=glwRAdrtcWYpCghWdNdouTO5vh1snHIseTXAD9UCLKQuOxg8X509L0wUp9woGfdx29jZ9j
	92AfOTilHbr5L0zy1rBFG6f+/qol6LAVsdlvwnid+YU+FJ3ewHyuzKa30FVvIcUA+iQPJc
	OzyRN+ddQdYSLS7ge4Wu8QcoLfYY15o=
From: Atish Patra <atish.patra@linux.dev>
Date: Fri, 07 Aug 2026 01:09:03 -0700
Subject: [PATCH v9 08/20] RISC-V: Add Ssccfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-counter_delegation-v9-8-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
To: Will Deacon <will@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
 Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the scountinhibit CSR definition and S-mode accessible hpmevent
bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
counters directly from S-mode without invoking SBI calls to M-mode. It is
also used to figure out the counters delegated to S-mode by the M-mode as
well.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-8-7909f863a645@meta.com
[pjw@kernel.org: fixed subject typo]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/include/asm/csr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 7f09e54a0f9a..c8b94f3337c1 100644
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

