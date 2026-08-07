Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7C41B8D5;
	Fri,  7 Aug 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091270; cv=none; b=RnVDHWN4oCw4YskZi7vQtMs0jUWwvFm45WQFRgLVcDqNflvtJqlllAkkbTAWXCddLQT+7kA5pC6WEEGlCOjsJxA3JR/URdZ0URmu9vQPbLEyKte7weigsj6zdU+pXRupGJ49ITswxmsjE2AoMNRPIqKpli84IUsGQuqcsAAUFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091270; c=relaxed/simple;
	bh=VRqn+ZdGRPNIoqPKHs9GxWp57X6agcGfQuRuUMoRylE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H2iftP7a6uf1+VcHcgiY87dTXcavoi5Ga7kEwUcNoDY8+/2eTolaAkMK8CXpUXoJ9Nmnemsj+uLidx13Ox1NxaVlvNV4puWhLdcBUe1jeOgw9YWKNjCLX9XxGzJuOpkGIX1gKGyH0R4SE+iWeAGMr0Mw5r5x5Ggv/fM5Ecbev+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftGQOECh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftGQOECh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CB31F000E9;
	Fri,  7 Aug 2026 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091268;
	bh=C1QM1qAo1sy8ykyFpPsdL5HzsG0iz1Roo9oXcGPvolw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftGQOECh5taTCazX5uyeACLVYqXfe7HVh0N25jGINL1JyckJ2Wl6Hoh2/ee3we1+w
	 Ep4HgPs2pzP9eC2aYI3l4AO13ULjAlvYatU54GOwzfDjTF+5YyY/QXBZRVk8MteIXO
	 ykdOsMVELQf1fJM/D6uCxy4xiu//61v9kNQ4yC5ANCFU4RLZqjscL9Fm43TPULpSZr
	 3kZf1yKUPbw9PcMO4cBIdtwhKi1MXMMYn1ZAHOR9U3ArGeaAhK4qnWs1Nvf9qj8E79
	 RzCoXouEqYrX2j2IrQL8LHV9lv+uAgwDxDp/MsEJYZz1ajQqlLJc4CRSkKeDDe9OJe
	 ywgXcJdUKfLKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/20] RISC-V: Define indirect CSR access helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807-counter_delegation-v9-5-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-5-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:27:47 +0000
Message-Id: <20260807082748.18CB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The indirect CSR access macros use generic local variable names =
(`__flags`, `__value`, `__old_val`) which can silently shadow caller argume=
nts, leading to logic corruption and unintended hardware writes.
--

--- Patch [5]: [PATCH v9 05/20] RISC-V: Define indirect CSR access helpers =
---
commit abb666a0789f79a51327c355784dec21386f3bf0
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: Define indirect CSR access helpers

The indirect CSR requires multiple instructions to read/write CSR. Add a few
helper macros for ease of usage.

Link: https://patch.msgid.link/20260701-counter_delegation-v8-5-7909f863a64=
5@meta.com

> diff --git a/arch/riscv/include/asm/csr_indirect.h b/arch/riscv/include/a=
sm/csr_indirect.h
> new file mode 100644
> index 0000000000000..0f558fac8f5f7
> --- /dev/null
> +++ b/arch/riscv/include/asm/csr_indirect.h
[ ... ]
> +#define csr_indirect_read(iregcsr, iselbase, iseloff) ({		\
> +	unsigned long __value =3D 0;				\
> +	unsigned long __flags;					\

[Severity: Medium]
Could these generic local variable names silently shadow caller arguments?

If a caller passes an expression using __flags or __value for iselbase or
iseloff, the macro's local variables will shadow them, potentially causing
the macro to use unintended values.

> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__value =3D csr_read(iregcsr);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})
> +
> +#define csr_indirect_write(iregcsr, iselbase, iseloff, value) ({	\
> +	unsigned long __flags;					\

[Severity: Medium]
Can this local __flags variable shadow the value argument if the caller
passes a variable named __flags?

If a caller executes csr_indirect_write(reg, base, off, __flags), the macro
would evaluate (value) using its own __flags variable (which holds the saved
IRQ state) instead of the caller's value. This would write the IRQ state to
the hardware CSR, potentially corrupting the CPU state.

> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	csr_write(iregcsr, (value));				\
> +	local_irq_restore(__flags);				\
> +})
> +
> +#define csr_indirect_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
> +	unsigned long __old_val =3D 0, __value =3D 0;		\
> +	unsigned long __flags;					\

[Severity: Medium]
Similar to the other macros, do these generic local variable names risk
shadowing the warl_val, iselbase, or iseloff arguments?

> +	local_irq_save(__flags);				\
> +	csr_write(CSR_ISELECT, (iselbase) + (iseloff));		\
> +	__old_val =3D csr_read(iregcsr);				\
> +	csr_write(iregcsr, (warl_val));				\
> +	__value =3D csr_read(iregcsr);				\
> +	csr_write(iregcsr, __old_val);				\
> +	local_irq_restore(__flags);				\
> +	__value;						\
> +})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D5
