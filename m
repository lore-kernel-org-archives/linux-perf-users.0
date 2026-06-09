Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD803CB2E5
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984907; cv=none; b=Exboi582rO7nl+F817Q9N2FSgF3mwidAzON21ONHeLu2Zjxav1BpHdbdavZ2ZIdl9Hosg/RflzhkbYdAHMQOmOW53N8Y2SdCxggSYvR6vza0ltiBmVfd4kEz9Mg4RHpZDNSPMxHsghOrLee+4IQ81ufAGyW762Chs5XEk4mSc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984907; c=relaxed/simple;
	bh=d8QlKHkfqNhfYohsE98McxXyqugfqZ6DLhV9E4Pu1qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+I1mCdDF+EOt+mtvSJAX2Kq9YNaGN2sxf/2X6ufKxe+RH9Ta9mZm2uO7ZfsIL5KuFgCifD6sWp3HgW/eUjv66xhnItoH5nM/b/EqeCQk3xcbTVhQTBrMrDIni3eozv/pA0y3io1UfijoQYAiVYDLWC8SLyfxb6Qc0wrr8Ul9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WT6Ohiol; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WT6Ohiol"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780984904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu7UaTVidpWvsx9wHZ3XDd5Hh0ON6Lo1UHqkFEyPu34=;
	b=WT6OhiolxkqKy78e365lfBny3qt/Y9J9QpcCcbQCiUH4bVvJ1B7zNHjqqhd4DdLpaYR80E
	A2QRg/b7jfIiLkugqJ/E/q3b+J14jz5G1N2XO1RBuYwGMyZ1/+yk37nEPvFTrczG6IUSNi
	bdMcj6deKuZJV7MmAtHWwZ1q8pPNb7Q=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 08 Jun 2026 23:01:18 -0700
Subject: [PATCH v6 04/21] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-counter_delegation-v6-4-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
In-Reply-To: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
To: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

