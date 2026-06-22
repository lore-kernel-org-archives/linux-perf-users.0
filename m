Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D16838E8B0
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115507; cv=none; b=JYx3OtRDpwS0pOIXxl2cQrhx4g+PUE+ETkf/7l0ntjh/m1UvnY29bycjaoOH0zvbuszocME/zT1dhZFZGGpGF3VaXwTiUpnh1pCZq4pUewPgwrF12riqpzCW96PrFQatzluhawcdn0Xtb2bdtBUC3IQjIZsqi3BoZIDjDYlJKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115507; c=relaxed/simple;
	bh=d8QlKHkfqNhfYohsE98McxXyqugfqZ6DLhV9E4Pu1qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cslu+F3XIjoIwyRpLuLJ0XmQB7+srnKNuW1VRkN6A74cZH4kZCzpVHPljC+ZFiIPZK26BC+mAJCoUxyEI50+fE/WSmPWJ6LqKxyUzdAMQCHl/vOmoP91jlRbjTnz6yx2p75q2HNv4RPQI+v7kXsjxXhYswtdKDsxSOE7u3XLnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMz5onJG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMz5onJG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782115504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu7UaTVidpWvsx9wHZ3XDd5Hh0ON6Lo1UHqkFEyPu34=;
	b=PMz5onJGo2iytdsKN0gVKAMx9CqmyoYRT48ivoi3eiGrrgwFkono+aJhbsrObuzuw7YBK1
	D5fb9CW/mLusS6AVsrngn4n+113XCV82VcYz9TRMmh+Z9eiydhG7h8J7+lbMZvehx4S1BB
	V+xWufBB/G44ZweqL0V/St1N4xPyxks=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 22 Jun 2026 01:04:17 -0700
Subject: [PATCH v7 05/22] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-counter_delegation-v7-5-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
In-Reply-To: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Rob Herring <robh@kernel.org>, 
 Ian Rogers <irogers@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Namhyung Kim <namhyung@kernel.org>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

The indriect CSR requires multiple instructions to read/write CSR.
Add a few helper functions for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr_ind.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/csr_ind.h
new file mode 100644
index 000000000000..6fd7d44dc640
--- /dev/null
+++ b/arch/riscv/include/asm/csr_ind.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef _ASM_RISCV_CSR_IND_H
+#define _ASM_RISCV_CSR_IND_H
+
+#include <linux/irqflags.h>
+
+#include <asm/csr.h>
+
+#define csr_ind_read(iregcsr, iselbase, iseloff) ({		\
+	unsigned long __value = 0;				\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	__value = csr_read(iregcsr);				\
+	local_irq_restore(__flags);				\
+	__value;						\
+})
+
+#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	csr_write(iregcsr, (value));				\
+	local_irq_restore(__flags);				\
+})
+
+#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
+	unsigned long __old_val = 0, __value = 0;		\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	__old_val = csr_read(iregcsr);				\
+	csr_write(iregcsr, (warl_val));				\
+	__value = csr_read(iregcsr);				\
+	csr_write(iregcsr, __old_val);				\
+	local_irq_restore(__flags);				\
+	__value;						\
+})
+
+#endif

-- 
2.53.0-Meta

