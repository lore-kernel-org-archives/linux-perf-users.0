Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491568;
	b=QxeO47EGeB1xFEmG0UlgIW/g8VQqT+XN+kdRxSYQfiQgDOcpcpBe+6SCtLuTCANnpX8d
	 W3rI80mYxYDJNVsPKXnspLfLdxz9D/kuG+kl6zAxh18uT6X0hwjm6HSimHpBpAZkiWy1V
	 Ds9CokdZck9kjlOIDC7KEcbRh6hKlHgCVIo+mS0YHfeO5Kh1y7DuoBVh1p3Lwqaq96TFW
	 5HBHLX8VF892AGmp6q0IGCGOv1iJKwbAhLXUj4MPSz67fQc8gJwERJFNZIJdUIme5khil
	 o27WYw1PvFTW3d+YuGis3FJDpd+UkjpcS5fiGcJUqPAfQkLZpNqAw/CFLTnojRgt//A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iT2GCRycit+/DfL44GzjfbzUZ+PYd+Oybru0uCUtmuE=;
	b=fukNXzfwSB25IN735loxdsU/hzY/ZxL/vx6bWxvI/pkjJWEgvkHyAjLHoSo7iXPBPK5X
	 ADhvKo0+ILp5V0NiJqh7rzsbNQCvcYOrp/q3YxP5krzF2kPJ93dxZS12ldlY+JP2xvksi
	 R9W75ppSW6coW/YtWFylKnH9ev1gFF4cSsAZ+OIjPDLz+IzZgGo5ysxDB4d0SbIN8iJU0
	 VQqTVO+VKzaUp+M1ISW1Cie0NDWc0nQHywaWUfhtlkfHqFbSEPw9z4kXst6R8TvNf+IS3
	 SyCpzT6zLrsYadnDt+miGZ+VEegKupJeXUvE4iTIJ80fbj8CTclAYj7RVoWNxTjvcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cODQgDWh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D1606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cODQgDWh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E31B1F000D3;
	Tue, 24 Nov 2026 03:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491567;
	bh=iT2GCRycit+/DfL44GzjfbzUZ+PYd+Oybru0uCUtmuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cODQgDWhZmXTYQ0/WT/nZwJtJja2xvYKST/mmTG4EniVH49fmGaIUTLiU2QKtkePI
	 A/EEhvRahbLbw/Cit6gFTxVM89ETJLMvBHhbDzRjSbPB4VNFgPWVYdn9JiZ2iU643l
	 Zk1K+WGuvGUvIS8Jd3RnZPccqnfjF/Y2+KAQ7Ju0bRWvc+Tj7KX9IPqhE/yWgysA3R
	 J04aitifbjw2m+2EjvVGM6fVcO70JT4vLrsUOIHtnYYjvfrI5lsCHfOzfBImxehD1Y
	 LpGMZUDSL8HZ8UxsKTKB086CAT7437LIQ52j9yMHcmSwBgg+po6EU28gOymbm2zlNx
	 1uEr8n0F0xUog==
Message-ID: <sashiko-outbox-230475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/11] perf test symbols: Add sorted insertion and
 equal-start alias tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124032902.3859564-5-irogers@google.com>
References: <20261124032902.3859564-1-irogers@google.com>
 <20261124032902.3859564-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 03:39:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf test symbols: STB_WEAK alias test in
  test__kallsyms_fixup_end() bypassed
--

commit 728aaf364c23458b2251cf89f0396157b988f69d
Author: Ian Rogers <irogers@google.com>

perf test symbols: Add sorted insertion and equal-start alias tests

This commit adds unit tests for sorted symbol insertion, equal-start
symbol aliases, and STB_WEAK / STB_GLOBAL alias resolution in kallsyms.

> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index b73da581f8956..4e4f8eabec5b8 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c

[ ... ]

> @@ -240,24 +476,28 @@ static int test__symbols(struct test_suite *test __=
maybe_unused, int subtest __m
> =20
>  struct kallsyms_sym {
>  	u64 start;
> +	u8 binding;
>  	const char *name;
>  };
> =20
>  /*
>   * kallsyms from an x86 host where nf_tables was loaded in the page right
>   * after the last symbol of dca, plus a kernel symbol followed closely b=
y a
> - * module and a module far away from the others.
> + * module, a weak/global alias pair at the same address, and a module far
> + * away from the others.
>   */
>  static const struct kallsyms_sym kallsyms_syms[] =3D {
> -	{ 0xffffffff81000000, "_stext" },
> -	{ 0xffffffff81000ff0, "last_kernel_symbol" },
> -	{ 0xffffffff81001000, "near_module_symbol\t[near]" },
> -	{ 0xffffffffc0c4aa40, "dca_exit\t[dca]" },
> -	{ 0xffffffffc0c4aa50, "dca_sysfs_exit\t[dca]" },
> -	{ 0xffffffffc0c4b000, "__nft_trace_packet\t[nf_tables]" },
> -	{ 0xffffffffc0c4b0b0, "nft_do_chain\t[nf_tables]" },
> -	{ 0xffffffffc0c4b4e0, "nf_tables_core_module_exit\t[nf_tables]" },
> -	{ 0xffffffffc2000000, "far_module_symbol\t[far]" },
> +	{ 0xffffffff81000000, STB_GLOBAL, "_stext" },
> +	{ 0xffffffff81000500, STB_WEAK, "weak_alias_symbol" },
> +	{ 0xffffffff81000500, STB_GLOBAL, "global_target_symbol" },
> +	{ 0xffffffff81000ff0, STB_GLOBAL, "last_kernel_symbol" },
> +	{ 0xffffffff81001000, STB_GLOBAL, "near_module_symbol\t[near]" },
> +	{ 0xffffffffc0c4aa40, STB_GLOBAL, "dca_exit\t[dca]" },
> +	{ 0xffffffffc0c4aa50, STB_GLOBAL, "dca_sysfs_exit\t[dca]" },
> +	{ 0xffffffffc0c4b000, STB_GLOBAL, "__nft_trace_packet\t[nf_tables]" },
> +	{ 0xffffffffc0c4b0b0, STB_GLOBAL, "nft_do_chain\t[nf_tables]" },
> +	{ 0xffffffffc0c4b4e0, STB_GLOBAL, "nf_tables_core_module_exit\t[nf_tabl=
es]" },
> +	{ 0xffffffffc2000000, STB_GLOBAL, "far_module_symbol\t[far]" },
>  };
> =20
>  static int check_symbol(struct dso *dso, u64 addr, const char *name, u64=
 end)
> @@ -287,7 +527,8 @@ static int test__kallsyms_fixup_end(struct test_suite=
 *test __maybe_unused,
>  		return TEST_FAIL;
> =20
>  	for (unsigned int i =3D 0; i < ARRAY_SIZE(kallsyms_syms); i++) {
> -		struct symbol *sym =3D symbol__new(kallsyms_syms[i].start, 0, 0, 0,
> +		struct symbol *sym =3D symbol__new(kallsyms_syms[i].start, 0,
> +						 kallsyms_syms[i].binding, STT_FUNC,
>  						 kallsyms_syms[i].name);
> =20
>  		if (!sym)
> @@ -296,8 +537,13 @@ static int test__kallsyms_fixup_end(struct test_suit=
e *test __maybe_unused,
>  	}
> =20
>  	symbols__fixup_end(dso__symbols(dso), true);
> +	symbols__fixup_duplicate(dso__symbols(dso));
> =20
>  	ret =3D TEST_OK;
> +	/* Same-address weak/global alias pair resolves to global_target_symbol=
. */
> +	if (check_symbol(dso, 0xffffffff81000510, "global_target_symbol",
> +			 0xffffffff81000ff0))
> +		ret =3D TEST_FAIL;

[Severity: Medium]
Does test__kallsyms_fixup_end() actually exercise the STB_WEAK vs
STB_GLOBAL check in choose_best_symbol()?

Because symbols__fixup_end() skips equal-start entries with
curr->start =3D=3D prev->start, only the last symbol at 0xffffffff81000500
(global_target_symbol) has its end updated to 0xffffffff81000ff0, while
weak_alias_symbol remains zero-sized.  When symbols__fixup_duplicate()
then calls choose_best_symbol(), it picks global_target_symbol via the
 earlier non-zero length check without reaching the binding comparison:

tools/perf/util/symbol.c:choose_best_symbol() {
	...
	/* Prefer a symbol with non zero length */
	a =3D syma->end - syma->start;
	b =3D symb->end - symb->start;
	if ((b =3D=3D 0) && (a > 0))
		return SYMBOL_A;
	else if ((a =3D=3D 0) && (b > 0))
		return SYMBOL_B;
	...
}

As a result, the test passes solely because global_target_symbol is
listed second in kallsyms_syms[]; if global_target_symbol precedes
weak_alias_symbol at the same address, symbols__fixup_end() inflates only
weak_alias_symbol and symbols__fixup_duplicate() drops the global symbol.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124032902.3859=
564-1-irogers@google.com?part=3D4
