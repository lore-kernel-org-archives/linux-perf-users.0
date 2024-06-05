Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80077154C0E;
	Wed,  5 Jun 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610603; cv=none; b=V67jnF9D2/YxP8CVzOWEoo2l9j+g3hHNIUg5W+5VY3G1DYzcRUVeDUyb5mjnd3hqxneuTEaP2IuCda+8OOj60jgVjWbc1FsuPCbIqOG4vnW9C0Pidk+zYwjBMmspFsGsOH7B4civWgL0sxZvBzAxtKuiWIE/Ze7aw58IDLTmx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610603; c=relaxed/simple;
	bh=WArTwWnRq32lxotUkfi4osAL299fnM7mL+wrQf5QP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuITcO06CIZV6GdrAgSWc3FfOxIt6APn1Tb5BjS6WnQXywgJZlwAuk12j0ygdOQhgrXMxRN4ebtxfHh34upMH41UP1EE3IPM45ZaSECiBCo0vYp/G8PrXhDbzWZcGzAbLSGDirNRm3zMO/haIHP+mjLCI3dWcX1tfTl14msiM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOQbkYrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOQbkYrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FDBC2BD11;
	Wed,  5 Jun 2024 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610603;
	bh=WArTwWnRq32lxotUkfi4osAL299fnM7mL+wrQf5QP9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOQbkYrEiQtzDxjUAFPT3wScBuptAXHhgvzyn4FVnelso76pV6wPvXIaKf/Wb9r8L
	 vpSVHIC+4OQ0s6HV5sVRRZ+EoocROGsEHFXSBKNeXPBM9fi9uZgqvS0GBNwDqnolzO
	 x7VIlwWkFfhIjvPpUtB5emOHWmqpd23KdglsGNryq2QIgkJ+r7a7T8eOjuuSEnXFwn
	 sbQhQBosxBbo+XloFsM3lYyZ8PotUV+qWZbzATRGZzb4C9xF8IFQgCB11uxzw6x2Xp
	 kFXQs2paYymTr6PkbTzShu3dlWysNw5t1gWR/fVmKK0GDxAqEnkSpPA3Tf7rbHFgNc
	 ja/3a5tqp/iMQ==
Date: Wed, 5 Jun 2024 19:03:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com,
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com,
	beeman@rivosinc.com, brauner@kernel.org, heiko@sntech.de,
	irogers@google.com, mingo@redhat.com, james.clark@arm.com,
	renyu.zj@linux.alibaba.com, jolsa@kernel.org,
	jisheng.teoh@starfivetech.com, palmer@dabbelt.com,
	tech-control-transfer-records@lists.riscv.org, will@kernel.org,
	kaiwenxue1@gmail.com
Subject: Re: [PATCH RFC 2/6] riscv: perf: Add Control transfer records CSR
 definations.
Message-ID: <20240605-manila-exploit-d7191ec7a4bc@spud>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
 <20240529185337.182722-3-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gAmoqjSbm9aJCwFl"
Content-Disposition: inline
In-Reply-To: <20240529185337.182722-3-rkanwal@rivosinc.com>


--gAmoqjSbm9aJCwFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 07:53:33PM +0100, Rajnesh Kanwal wrote:
> Adding CSR defines for RISCV Control Transfer Records extension [0]
> along with bit-field macros for each CSR.
>=20
> [0]: https://github.com/riscv/riscv-control-transfer-records
>=20
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 83 ++++++++++++++++++++++++++++++++++++

This patch isn't for perf, so $subject is a bit misleading.

Thanks,
Conor.

>  1 file changed, 83 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 701963b64fc4..a80a2ee9d44e 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -309,6 +309,85 @@
> =20
>  #define CSR_SSCOUNTOVF		0xda0
> =20
> +/* M-mode Control Transfer Records CSRs */
> +#define CSR_MCTRCTL		0x34e
> +
> +/* S-mode Control Transfer Records CSRs */
> +#define CSR_SCTRCTL		0x14e
> +#define CSR_SCTRSTATUS		0x14f
> +#define CSR_SCTRDEPTH		0x15f
> +
> +/* VS-mode Control Transfer Records CSRs */
> +#define CSR_VSCTRCTL		0x24e
> +
> +/* xctrtl CSR bits. */
> +#define CTRCTL_U_ENABLE		_AC(0x1, UL)
> +#define CTRCTL_S_ENABLE		_AC(0x2, UL)
> +#define CTRCTL_M_ENABLE		_AC(0x4, UL)
> +#define CTRCTL_RASEMU		_AC(0x80, UL)
> +#define CTRCTL_STE		_AC(0x100, UL)
> +#define CTRCTL_MTE		_AC(0x200, UL)
> +#define CTRCTL_BPFRZ		_AC(0x800, UL)
> +#define CTRCTL_LCOFIFRZ		_AC(0x1000, UL)
> +#define CTRCTL_EXCINH		_AC(0x200000000, UL)
> +#define CTRCTL_INTRINH		_AC(0x400000000, UL)
> +#define CTRCTL_TRETINH		_AC(0x800000000, UL)
> +#define CTRCTL_NTBREN		_AC(0x1000000000, UL)
> +#define CTRCTL_TKBRINH		_AC(0x2000000000, UL)
> +#define CTRCTL_INDCALL_INH	_AC(0x10000000000, UL)
> +#define CTRCTL_DIRCALL_INH	_AC(0x20000000000, UL)
> +#define CTRCTL_INDJUMP_INH	_AC(0x40000000000, UL)
> +#define CTRCTL_DIRJUMP_INH	_AC(0x80000000000, UL)
> +#define CTRCTL_CORSWAP_INH	_AC(0x100000000000, UL)
> +#define CTRCTL_RET_INH		_AC(0x200000000000, UL)
> +#define CTRCTL_INDOJUMP_INH	_AC(0x400000000000, UL)
> +#define CTRCTL_DIROJUMP_INH	_AC(0x800000000000, UL)
> +
> +/* sctrstatus CSR bits. */
> +#define SCTRSTATUS_WRPTR_MASK	0xFF
> +#define SCTRSTATUS_FROZEN	_AC(0x80000000, UL)
> +
> +#ifdef CONFIG_RISCV_M_MODE
> +#define CTRCTL_KERNEL_ENABLE	CTRCTL_M_ENABLE
> +#else
> +#define CTRCTL_KERNEL_ENABLE	CTRCTL_S_ENABLE
> +#endif
> +
> +/* sctrdepth CSR bits. */
> +#define SCTRDEPTH_MASK		0x7
> +
> +#define SCTRDEPTH_MIN		0x0 /* 16 Entries. */
> +#define SCTRDEPTH_MAX		0x4 /* 256 Entries. */
> +
> +/* ctrsource, ctrtarget and ctrdata CSR bits. */
> +#define CTRSOURCE_VALID		0x1ULL
> +#define CTRTARGET_MISP		0x1ULL
> +
> +#define CTRDATA_TYPE_MASK	0xF
> +#define CTRDATA_CCV		0x8000
> +#define CTRDATA_CCM_MASK	0xFFF0000
> +#define CTRDATA_CCE_MASK	0xF0000000
> +
> +#define CTRDATA_TYPE_NONE			0
> +#define CTRDATA_TYPE_EXCEPTION			1
> +#define CTRDATA_TYPE_INTERRUPT			2
> +#define CTRDATA_TYPE_TRAP_RET			3
> +#define CTRDATA_TYPE_NONTAKEN_BRANCH		4
> +#define CTRDATA_TYPE_TAKEN_BRANCH		5
> +#define CTRDATA_TYPE_RESERVED_6			6
> +#define CTRDATA_TYPE_RESERVED_7			7
> +#define CTRDATA_TYPE_INDIRECT_CALL		8
> +#define CTRDATA_TYPE_DIRECT_CALL		9
> +#define CTRDATA_TYPE_INDIRECT_JUMP		10
> +#define CTRDATA_TYPE_DIRECT_JUMP		11
> +#define CTRDATA_TYPE_CO_ROUTINE_SWAP		12
> +#define CTRDATA_TYPE_RETURN			13
> +#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP	14
> +#define CTRDATA_TYPE_OTHER_DIRECT_JUMP		15
> +
> +#define CTR_ENTRIES_FIRST	0x200
> +#define CTR_ENTRIES_LAST	0x2ff
> +
>  #define CSR_SSTATUS		0x100
>  #define CSR_SIE			0x104
>  #define CSR_STVEC		0x105
> @@ -490,6 +569,8 @@
>  # define CSR_TOPEI	CSR_MTOPEI
>  # define CSR_TOPI	CSR_MTOPI
> =20
> +# define CSR_CTRCTL     CSR_MCTRCTL
> +
>  # define SR_IE		SR_MIE
>  # define SR_PIE		SR_MPIE
>  # define SR_PP		SR_MPP
> @@ -520,6 +601,8 @@
>  # define CSR_TOPEI	CSR_STOPEI
>  # define CSR_TOPI	CSR_STOPI
> =20
> +# define CSR_CTRCTL     CSR_SCTRCTL
> +
>  # define SR_IE		SR_SIE
>  # define SR_PIE		SR_SPIE
>  # define SR_PP		SR_SPP
> --=20
> 2.34.1
>=20

--gAmoqjSbm9aJCwFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCoZAAKCRB4tDGHoIJi
0iM2AP9Si9iGkGWZfIT4Wvz1ik8Yid4XdH6yDVXY9JRWgW2TLwEA36YWxUghLcHi
yEnAbSIY+i6bhhpL9m6M50Uq5UF/mAs=
=DmjO
-----END PGP SIGNATURE-----

--gAmoqjSbm9aJCwFl--
