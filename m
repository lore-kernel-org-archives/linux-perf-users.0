Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDE46D551
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090181; cv=none; b=X2d6j7/ED/VPS27B5WpcRKx5ucLfHkbKSI10nOvavV3Sdc2SCBiFwnBDRReRbM60D3ZIU9P8mEhXRoym/9p2zOXs3qgxALsJXUKO/vvXjZVWDeUTItxJ0psgDGqHdT+YLxXjgjnO708TroSYGFlR5Xa29D59yHUBpreqsf6UUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090181; c=relaxed/simple;
	bh=pD7lUY+ZzddjHY50PUCWkDbTOMu3vOUSZtZ94DJrd0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkei7L7+n8yA5TSpnw4nubY3XCKzmkPCGFFS9iR95ddGLBOB5CnG4IMKDHabiw2vr0KtKLRJab0WBRCHLl2+aYLddORvNasBIeDCMvClYHKBbjfmYCe8ZA0WJTjtcyHbuSZ2aPsFP4RZimIQSdazy5raVcuwkMFlqAXp1yc9Z8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PUHal4RD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUHal4RD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/aatG9xeq1PJrzz8GhMwerq64hjkacWtLJ3rJGHBR0=;
	b=PUHal4RD0h2MF1ycbehNZsMgPk5LWMXgH/wVZHIiTvG15dOtOrgXOFXMqFIoG9DNbkhe53
	ZV3KAhrCCA5wyoPnJmf3OYMn3TefEP2fvqGUvBiu/sY6rj7oQss3Eda25f+S7LMI+hmGFU
	53antfsmj1oHf+AjhymEY1+Ofs1MKBc=
From: Atish Patra <atish.patra@linux.dev>
Date: Fri, 07 Aug 2026 01:09:00 -0700
Subject: [PATCH v9 05/20] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-counter_delegation-v9-5-58658104e487@meta.com>
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

From: Atish Patra <atishp@rivosinc.com>

The indirect CSR requires multiple instructions to read/write CSR.
Add a few helper macros for ease of usage.

These have to be macros rather than functions. csr_read()/csr_write()
stringify their CSR argument into the inline asm template via
__ASM_STR(), so the CSR number must be a literal token; passing it as a
function parameter emits "csrr %0, iregcsr", which the assembler rejects
with "unknown CSR `iregcsr'". The stringification happens in the
preprocessor, before inlining or constant propagation, so it cannot be
worked around by forcing inlining or by only ever passing constants -
gcc 12, gcc 16 and clang 22 all reject it alike. Underneath, csrr/csrw
encode the CSR as a 12-bit immediate and RISC-V has no register-indirect
form, which is also why asm/csr.h keeps every one of its accessors as a
macro.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-5-7909f863a645@meta.com
[pjw@kernel.org: expand "ind" abbreviation]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/include/asm/csr_indirect.h | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/riscv/include/asm/csr_indirect.h b/arch/riscv/include/asm/csr_indirect.h
new file mode 100644
index 000000000000..0f558fac8f5f
--- /dev/null
+++ b/arch/riscv/include/asm/csr_indirect.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_RISCV_CSR_INDIRECT_H
+#define _ASM_RISCV_CSR_INDIRECT_H
+
+#include <linux/irqflags.h>
+
+#include <asm/csr.h>
+
+/*
+ * These have to be macros rather than functions: csr_read()/csr_write()
+ * stringify their CSR argument into the inline asm template via __ASM_STR(),
+ * so the CSR number must be a literal token at preprocessing time. Passing it
+ * as a function parameter emits "csrr %0, iregcsr", which no assembler can
+ * resolve. RISC-V has no register-indirect form of csrr/csrw - the CSR is a
+ * 12-bit immediate - so the sireg CSR selecting the indirect window cannot
+ * itself be a variable.
+ */
+#define csr_indirect_read(iregcsr, iselbase, iseloff) ({		\
+	unsigned long __value = 0;				\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	__value = csr_read(iregcsr);				\
+	local_irq_restore(__flags);				\
+	__value;						\
+})
+
+#define csr_indirect_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long __flags;					\
+	local_irq_save(__flags);				\
+	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
+	csr_write(iregcsr, (value));				\
+	local_irq_restore(__flags);				\
+})
+
+#define csr_indirect_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
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

