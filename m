Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991198;
	b=E4HVQHtCLCvQ1mc+EpLnECnMQnX+N96uGNxOZTiBrO07KVc0/li80nQwehxwCxAPHAHC
	 mB+oRNNkf3jzdBXuy+x4ZiXXWM2k9caeMZIB+mzSDdnuh9A8DC6BhwrZxcCdt9381M1vL
	 BBr6HhpK7oe7V7GWfzpEBcimie6pqEzGjJm+lZZbP5/dBUhZN+r/xXVIN7mDdf+BYCBBD
	 pNE7eYNnMAKZ2JYd61Crwl1DBdygKyeZB/A92cfF2wd+kgiAK0FAsp3w3SWjuR9b6MI8o
	 qmf94vVEnFawa1Z/xYyydGi5aGF0ZsZrcqUX9Ce+l28ZRB0aohB9rLufyECjexGBQuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0tOFSumvFkQB1V70ACgTw8fT6PtkYodANZxMwokD4fg=;
	b=DQpXzvOPyBzkAEZmiWjUAac4BEMyLBp/GlxRxjF3kaidAKZu3CdcHrNtx+de1Op/omad
	 9wwpq077eNVJYo+Ffd9nKA6v/b5GLYlQhsWWTwyeJSo2lpgH1deU8BV7xNrABbkPvSWmW
	 jIa8hUc9RJWTssmoLl8W/ujJ8SW95U1IrDAlPM+uxNSb9m9H6Wa0zLxl6XaEM1y/b47Pg
	 j+BVt1EHSGgi/rwEqxGKh/lCr7bM313k74wWpEd6e6Ypj7xCVU9nqCzG1kimP2yDnP7Vp
	 9gDx+5qqcZLNk3DWhN4qY2cCCe9mR59W/tbgbGJI5BNaiZqu5+QfBUsfiImMQw5A1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltTtD97f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F911606A31C;
	Wed, 18 Nov 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltTtD97f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63751F000C5;
	Wed, 18 Nov 2026 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991198;
	bh=0tOFSumvFkQB1V70ACgTw8fT6PtkYodANZxMwokD4fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltTtD97fmPODUBJtjAQaA44d5Ew+M4O7MFFOngBL2TsO9Qt4LYKcKA+OYaj36xGyf
	 r+cWpR4UVjT5vEZ/0HQfnzuJPAEQl1zrhW2WktOXIMgH1NhlC8RADKPTlgPZ7QzA52
	 bFQdU5ubbVfsFlMp9Q6AVSbBsFi8JC35/RMJq3JVZBae73aV2ghvlgZ3V7/CaYuelG
	 57WH/mFyCBy16ccPClbUfW6UqitTsNhs4R3ophCAaiThob6q+GbSyui9rhSIe7bs7E
	 fO88fCqlMfY+BXiau+e5TbioNvf+QXu0cBSPqIv1tOnBeZy7Ob8oM8AwOKhH1M5aJh
	 wVe79suZ3Gd2w==
Message-ID: <sashiko-outbox-220464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/5] perf: riscv: Probe the experimental PDIS CSR
 layout on matching CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>, linux-perf-users@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118081327.10684-10-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-10-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:39:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf: riscv: unguarded non-volatile asm goto output in
  pdis_read_csr()
- [Low] perf: riscv: riscv_pdis_cpu_starting() leaves counter CSR dirty
  on error
--

commit 5b0b1f9bcdc0e64d6c714a4382c017740354c7f9
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: riscv: Probe the experimental PDIS CSR layout on matching CPUs

This commit adds opt-in CPU bringup probing and teardown quiescing for the
experimental RISC-V PDIS CSR layout behind CONFIG_RISCV_PDIS_CSR and the
riscv_pdis_test boot parameter.

> diff --git a/drivers/perf/riscv_pdis.c b/drivers/perf/riscv_pdis.c
> new file mode 100644
> index 0000000000000..b7671e5ad63eb
> --- /dev/null
> +++ b/drivers/perf/riscv_pdis.c
> @@ -0,0 +1,137 @@

[ ... ]

> +/* Used only during opt-in probing; missing/unauthorized CSRs must not o=
ops. */
> +static __always_inline int pdis_read_csr(unsigned int csr, unsigned long=
 *value)
> +{
> +	asm goto("1: csrr %[value], %[csr]\n"
> +		 _ASM_EXTABLE(1b, %l[fault])
> +		 : [value] "=3Dr" (*value) : [csr] "i" (csr) : "memory" : fault);
> +	return 0;
> +fault:
> +	*value =3D 0;
> +	return -ENODEV;
> +}

[Severity: Medium]
Does pdis_read_csr() break compilation or risk miscompilation on older GCC
versions by using raw asm goto with an output operand without checking
CONFIG_CC_HAS_ASM_GOTO_OUTPUT?

GCC only added syntax support for asm goto output operands in GCC 11, and
scripts/Kconfig.toolchain disables CONFIG_CC_HAS_ASM_GOTO_OUTPUT on GCC
versions affected by GCC PR 113921 (< 11.5, 12.0..12.3, and 13.0..13.2),
where inlining asm goto with outputs can miscompile the fault label edge.
In addition, asm goto with outputs is not implicitly volatile in GCC
(GCC PR 103979), so callers use asm_goto_output() from
include/linux/compiler_types.h to include the volatile qualifier.

Could RISCV_PDIS_CSR depend on CC_HAS_ASM_GOTO_OUTPUT (or provide a
!CONFIG_CC_HAS_ASM_GOTO_OUTPUT fallback) and use asm_goto_output() here?

[ ... ]

> +void riscv_pdis_cpu_starting(void)
> +{

[ ... ]

> +	/* The first version requires all 32 COUNT and INITVAL bits. */
> +	if (pdis_write_csr(RISCV_PDIS_CSR_COUNTER, ~0UL) ||
> +	    pdis_read_csr(RISCV_PDIS_CSR_COUNTER, &value) || value !=3D ~0UL ||
> +	    pdis_write_csr(RISCV_PDIS_CSR_COUNTER, 0))
> +		return;

[Severity: Low]
Does riscv_pdis_cpu_starting() leave RISCV_PDIS_CSR_COUNTER set to non-zero
when value !=3D ~0UL?

If the write and read succeed but the register implements fewer than 64
writable bits, short-circuit evaluation of value !=3D ~0UL skips the
pdis_write_csr(RISCV_PDIS_CSR_COUNTER, 0) call and returns with all
implemented counter and initval bits left set to 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081327.1068=
4-7-zhangzhanpeng.jasper@bytedance.com?part=3D3
