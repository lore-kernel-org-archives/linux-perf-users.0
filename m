Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AA14B944;
	Wed,  5 Jun 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610807; cv=none; b=ZRa6CbahhFWM4vT9o8QgnM9QMMu679fLKg2F/KXEHWdi/Ye3R0bUyX9mz6pnfdtXYLpaJg0g4JASGJOyq3pFGDwWhsmIi3C7dL+IxYR+oZ9Q+rsZ+OjvNzdh6CNo5S6xU2OEkewOZIa4dJ1vWBy3ilOyGvdc4jlBaPt1O2uOHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610807; c=relaxed/simple;
	bh=5WLgWmi7391vEDkONzbYlVsXiq5rBsI0l3Wft0d2pmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrJ6Z1wtMFaq3N7cFq4hx+EJf//JcLZaDXHcx0ncu3xN4thHz5X93VyGDzH1z5/DoI/zfKuSLlKCjmXQ+4GNG+sP5FtTEecwElFZnDcIaK4YotAKcz5bUJ5+cOrHot0smtLqzXFF/xspYdKIXFdWfWHIODQ+xcD0VZImo2oMKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLjJiy2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLjJiy2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8F6C2BD11;
	Wed,  5 Jun 2024 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610806;
	bh=5WLgWmi7391vEDkONzbYlVsXiq5rBsI0l3Wft0d2pmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLjJiy2Ri4l+KMnvg98/r6lSB63VeIuqIbk66sBo6whE1DzQNBHsIsYsJWDgxFLGs
	 JT7LntNOIe98YiQPQrXDmdIMI/BSdjYlu+csdYXmRLjRjjzFCIcPsAGEnm1rgEFFPI
	 goVMzhoB3T6U2YlyZgkevetfl0IzC4SyYK1ma0//MGkpZkt25Ptk/9K8du9BZHH29E
	 RPHRjlgT3WeZo2+VO+f2p0y/yl+3/ExMeImgsPXUXb8w1/5CE3sx7oKIOXJ0bQCAj0
	 yAN4rRhLd2JWa19Rw87TTXl8wJcnn0wqWnrUTlMNM4xxNR/r5E1u4IFakHd2mEIOkK
	 x0dwlIamvULsQ==
Date: Wed, 5 Jun 2024 19:06:40 +0100
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
Subject: Re: [PATCH RFC 3/6] riscv: perf: Add Control Transfer Records
 extension parsing
Message-ID: <20240605-thaw-giant-87eb299c43d0@spud>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
 <20240529185337.182722-4-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RRX4c9uXLV2+FCJl"
Content-Disposition: inline
In-Reply-To: <20240529185337.182722-4-rkanwal@rivosinc.com>


--RRX4c9uXLV2+FCJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 07:53:34PM +0100, Rajnesh Kanwal wrote:
> Adding CTR extension in ISA extension map to lookup for extension
> availability.
>=20
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Same comment here about $subject.

You're also missing dt-bindings for the extension.

Thanks,
Conor.

> ---
>  arch/riscv/include/asm/hwcap.h | 4 ++++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b8cc459ee8a4..aff5ef398671 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -86,6 +86,8 @@
>  #define RISCV_ISA_EXT_SSCCFG            77
>  #define RISCV_ISA_EXT_SMCDELEG          78
>  #define RISCV_ISA_EXT_SMCNTRPMF         79
> +#define RISCV_ISA_EXT_SMCTR             80
> +#define RISCV_ISA_EXT_SSCTR             81
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> @@ -95,9 +97,11 @@
>  #ifdef CONFIG_RISCV_M_MODE
>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>  #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
> +#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SMCTR
>  #else
>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>  #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
> +#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SSCTR
>  #endif
> =20
>  #endif /* _ASM_RISCV_HWCAP_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index d1fb6a8c5492..4334d822b2f2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -298,6 +298,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>  	__RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),
> +	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>  	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
>  	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
> @@ -305,6 +306,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
>  	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> --=20
> 2.34.1
>=20

--RRX4c9uXLV2+FCJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCpMAAKCRB4tDGHoIJi
0kEpAQCsOUjZl8R2wNCVzJXQJV4UjjC09oI/oJy7iOQTgrCXpgD/bslLlxazlWXA
89hLVyp5e76pm/wa8mAGOes1wwKLNgo=
=memG
-----END PGP SIGNATURE-----

--RRX4c9uXLV2+FCJl--
