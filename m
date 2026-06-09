Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4783327204;
	Tue,  9 Jun 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985712; cv=none; b=ewSVNgfRAZRtreq/FGbhJCDac1D5uLf3nreUITnXQp+E9Db+7UdTXLQn7qDb3I/pwQ0q/Qx+0AQTJCyq/szLRh+YxO6yFNGm+Tr0vrMD473IArWYRFs6ankmRR+YUEwXWe3CDQH4mdN0/x2jFKpHwTKdb0+uX6vM2UL5TfKc4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985712; c=relaxed/simple;
	bh=qpkmfvCU+7f+UslRVfbJCcqrwx+TBjTwQQcOP+NTR6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ixn499RGY1R0kTitNvupnDH6ouHIML9Xrn4e0OB1p3iVJbBlU9hHGzl+4/ov1vXWbXSxDKMJFVQZFOlaE0j6Cj8cZs9+1KqjQqcSYV5IEA9UREy55MlMf8vskTAAlKB7mE5V0XwoN3+AaG8lfsnQ4Wy5vyXNdxFc7BwvkLivEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoC+6Uo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoC+6Uo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E31F00893;
	Tue,  9 Jun 2026 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985711;
	bh=Hvm4jV+/KJv6DS2txn505jCxuJKmwmuxmFgX6eBO3ZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UoC+6Uo6UfZF0npWrU3d8MMmPoOQ7fMp+14Ndk5n4wR0bttWaG6q0tovjjlKqFqow
	 lNJwvhKNOtaQeijqF3iEVZ+aHt2MnRsV66bLBH/mHjvwPqPjp3KEer6MwRMAwu+iiQ
	 WIFiLU0siyBz4isJy857UWumd1SHJ1PFkLpwPIj5ifrlKJltITu3MevwlJrzb+MuuV
	 tXR+j2gw5o9JzXby0NSeE/zSU7VoVMCxbdEt/9LEj2/rQUAbGR/YuPo9mXI29Z8Go1
	 8q7X//aBBB3yUu9vLygJOtCyzfTwvCbkYosUHVkdqcDbeLPw+88I/wbEs3FLIPmFb8
	 H/NGnsW9O2kxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/21] RISC-V: Define indirect CSR access helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-4-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-4-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:15:10 +0000
Message-Id: <20260609061511.276E31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unsafe statement-expression macro definitions causing delayed ev=
aluation and variable shadowing hazards.
--

commit 572b7555547c1b5bc07701482ba67d379f6a2177
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: Define indirect CSR access helpers

This commit introduces helper macros to read, write, and perform WARL
operations on indirect CSRs. The macros use statement-expressions to handle
the multiple instructions required while disabling interrupts.

> diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/cs=
r_ind.h
> new file mode 100644
> index 0000000000000..6fd7d44dc640a
> --- /dev/null
> +++ b/arch/riscv/include/asm/csr_ind.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef _ASM_RISCV_CSR_IND_H
> +#define _ASM_RISCV_CSR_IND_H
> +
> +#include <linux/irqflags.h>
> +
> +#include <asm/csr.h>
> +
> +#define csr_ind_read(iregcsr, iselbase, iseloff) ({		\
> +	unsigned long __value =3D 0;				\
> +	unsigned long __flags;					\

[Severity: Medium]
Will these generic variable names (__value, __flags) cause shadowing issues=
 if
the caller passes in arguments with the same names?

Evaluating macro arguments into unique local variables before entering the
IRQ-disabled region would avoid this regression.

> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__value =3D csr_read(iregcsr);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})
> +
> +#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
> +	unsigned long __flags;					\
> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	csr_write(iregcsr, (value));				\

[Severity: Medium]
Since value is evaluated here after CSR_ISELECT has been programmed, what
happens if a caller passes an expression that accesses another indirect CSR,
such as a nested csr_ind_read(), as the value argument?

It appears the nested call would overwrite CSR_ISELECT, causing the write to
silently corrupt the wrong hardware register. Evaluating arguments into loc=
al
variables before disabling interrupts would prevent this, and also avoid the
risk of evaluating expressions with side effects while interrupts are disab=
led.

> +	local_irq_restore(__flags);				\
> +})
> +
> +#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
> +	unsigned long __old_val =3D 0, __value =3D 0;		\
> +	unsigned long __flags;					\

[Severity: Medium]
Do these generic local variables risk shadowing caller arguments?

> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__old_val =3D csr_read(iregcsr);				\
> +	csr_write(iregcsr, (warl_val));				\

[Severity: Medium]
Is there a risk that evaluating warl_val here could overwrite CSR_ISELECT if
the caller provides an expression that performs another indirect CSR access?

> +	__value =3D csr_read(iregcsr);				\
> +	csr_write(iregcsr, __old_val);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})
> +
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D4
