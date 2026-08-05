Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F211FBC8C;
	Wed,  5 Aug 2026 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890349; cv=none; b=AsDIJlnL4WtBD1s1NKwSmgR8qUsZyll3+6gTpEZsj2oYVCVt+8UUEnFfBKQsWHishnZPkPXm4I9msDV+i/ftYEAPO040Ybe8HhC57pYE0DC9SV8RpPAkgGqDzdEIEZss3flCeeFduv81l0L7hJow5cvr4Ece2yoQXrclQvQz1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890349; c=relaxed/simple;
	bh=cG5S4lmx90n6vQrUVNmVo4DB71kgP2MbE0krscFgdF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UPR5zJD6+7wmRTfZGYnFw3krWUe+vlmUT14FXVam945ITAN76GUDYXBC7WCn8zKEt+a52xKhPoBhAxlkypJNl4opksTHer9XaTR2doZWX+yRbuhLxAXZlh+JUSHthgH+nXNMKDw4XEovNW1sJ+iGw81VS9z7roQczE9ukBuMq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHNwopjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHNwopjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460181F000E9;
	Wed,  5 Aug 2026 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890348;
	bh=po07o5l5QWKcUpTBA8x1BoyVyCQ99VWLuvatS1Gyqg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=CHNwopjtbJpoJ+QoDPRhEa4mF8x5nHrdx4VEtFzOqDqCSTQwLUZIGI0PnQrfC6l27
	 PzarS6jDKA5kO+K/lFdnQNd1DsaywRON8+cu+RVPFvuCkMCcz9XF7zn9Dqv56FHSw9
	 bdQqi+uOkHZSoeI0pN1ZG59FXTUeq6A+qzammhGn7lzaUawutCRuqKsBd7iAhsPWkf
	 1tTKLgW164I6yUXtqvgfaKoXpvkJ/s8t7E1lflGfnuUTVxVgC4PSpZMjyz1nmrqiDH
	 cH7daKKXg/YiuiMEmOYyCFHgsXGLPqhZGnCsNB0tElpDNIsjD0GkVo+YHMpvM/cz6o
	 heBmCeJAg7Lzg==
Date: Tue, 4 Aug 2026 18:39:04 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
In-Reply-To: <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
Message-ID: <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> The indirect CSR requires multiple instructions to read/write CSR.
> Add a few helper functions for ease of usage.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks.  These macros seem better implemented as static inline functions.  
That also nicely aligns the code with what you write in the patch 
description.

Also, I renamed this file to change the abbreviation "ind" to "indirect", 
along the lines of this feedback here:

   https://lore.kernel.org/linux-riscv/CAHk-=whhSLGZAx3N5jJpb4GLFDqH_QvS07D+6BnkPWmCEzTAgw@mail.gmail.com/

This case is even worse since there are already uses of "csr_index" in 
the codebase, so it's even more unclear what "ind" is supposed to mean.

Updated patch follows.  Please let me know if you have any objections,


- Paul

From: Atish Patra <atishp@rivosinc.com>

RISC-V: Define indirect CSR access helpers

The indirect CSR requires multiple instructions to read/write CSR.
Add a few helper functions for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-5-7909f863a645@meta.com
[pjw@kernel.org: expand "ind" abbreviation; use static inline functions rather than macros]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/include/asm/csr_indirect.h | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 arch/riscv/include/asm/csr_indirect.h

diff --git a/arch/riscv/include/asm/csr_indirect.h b/arch/riscv/include/asm/csr_indirect.h
new file mode 100644
index 000000000000..3cd6a9059455
--- /dev/null
+++ b/arch/riscv/include/asm/csr_indirect.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_RISCV_CSR_INDIRECT_H
+#define _ASM_RISCV_CSR_INDIRECT_H
+
+#include <linux/types.h>
+#include <linux/irqflags.h>
+
+#include <asm/csr.h>
+
+static inline unsigned long csr_indirect_read(u16 iregcsr, u32 iselbase, u32 iseloff)
+{
+	unsigned long __value = 0;
+	unsigned long __flags;
+
+	local_irq_save(__flags);
+	csr_write(CSR_ISELECT, iselbase + iseloff);
+	__value = csr_read(iregcsr);
+	local_irq_restore(__flags);
+
+	return __value;
+}
+
+static inline void csr_indirect_write(u16 iregcsr, u32 iselbase, u32 iseloff, unsigned long value)
+{
+	unsigned long __flags;
+
+	local_irq_save(__flags);
+	csr_write(CSR_ISELECT, iselbase + iseloff);
+	csr_write(iregcsr, (value));
+	local_irq_restore(__flags);
+}
+
+static inline unsigned long csr_indirect_warl(u16 iregcsr, u32 iselbase, u32 iseloff,
+					      unsigned long warl_val)
+{
+	unsigned long __old_val = 0, __value = 0;
+	unsigned long __flags;
+
+	local_irq_save(__flags);
+	csr_write(CSR_ISELECT, iselbase + iseloff);
+	__old_val = csr_read(iregcsr);
+	csr_write(iregcsr, warl_val);
+	__value = csr_read(iregcsr);
+	csr_write(iregcsr, __old_val);
+	local_irq_restore(__flags);
+
+	return __value;
+}
+
+#endif
-- 
2.53.0


