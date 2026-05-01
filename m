Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9E1D798E
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666426; cv=none; b=LDD78n1w4SICvHeYP0+oGMmn/AULwO4SRIIjWEu2DXR0mx8bC0LLT9RR1X2YfPgiopwK51EO/dH4F0j5Mobw4J4X4x4d5E+87+nuE0jqcJ88FS6qAj+90Qjg2zX9BXaiz/cDhySnfnpWXfwrjU/nLNiRTEgmGK1cbbdLccOG528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666426; c=relaxed/simple;
	bh=mAyTBwrwwCeDiJdF0aVF1eJCqvyCOleWohCv0dH4esE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lip+gxxvmQbZS1xEbUK6rr13c8FGw492n35r0euzFtYIdBFk/ch3esoWY+s25HnMS4mVSO3QZR6EnkCs/WbNew9uihFpkKZCgC4V1HvUwjkzC8gVM38kekFypaxur74uf0+pucaKsNfPaJps7P0pAZtPDYbPQ/VM53oqEEpVmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU9AWUZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU9AWUZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759ECC2BCB4;
	Fri,  1 May 2026 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777666425;
	bh=mAyTBwrwwCeDiJdF0aVF1eJCqvyCOleWohCv0dH4esE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EU9AWUZS0ItpBoEz/dkYEFu+aKSdr3wDI3wv9BLCoZLWTb73udw7niFpiHN6dWLW8
	 s92epqxeTVVw3QdmZo8Ad6V/ab20B653lPNfoFfn4nftV+GGPxx01jzSeKeimK5TL0
	 SYqvFVh3v6ozXjKqAfiCVhKWuBeO+LLEBVlcZYhnZ/vyeJWVRcCPlH8bxShXh2Dnjq
	 mPtCJ2j+VHgUhwrbC8ucPPvz0VdBa+QlbNTiDRP3G8nSb/K7VDApXMaQyRa01xL/7M
	 Y65o94ownEHyTCCO6siP17k+mV/Y7FbMtgxcJ0n2yzBQSETOz2DnI2YFhA4k59GX9z
	 x1Km6SCK9hydw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] perf symbol: Lazily compute idle and use a
 global lock for updates
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501182021.3651851-5-irogers@google.com>
References: <20260501182021.3651851-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 20:13:44 +0000
Message-Id: <20260501201345.759ECC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new lazy evaluation helper `symbol__is_idle()` is never called=
, and the migration to a tri-state enum breaks existing boolean consumers o=
f `sym->idle`.
- [High] Data race on lockless read of the `sym->idle` bitfield in `symbol_=
_is_idle()`.
--

commit 2ef259ec3239aea58dbf7c1d14b3998396292f27
Author: Ian Rogers <irogers@google.com>

perf symbol: Lazily compute idle and use a global lock for updates

This patch moves the idle boolean computation into a lazy helper,
symbol__is_idle(), considering kernel version and architecture. It also
changes the idle field to a tri-state enum and protects updates with a
global lock.

Link: https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ib=
m.com/
Link: https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@=
126.com/

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index e6a1f23634ec..8ec4b2836b44 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -384,17 +389,6 @@ void __symbols__insert(struct rb_root_cached *symbol=
s,
>  	struct symbol *s;
>  	bool leftmost =3D true;
> =20
> -	if (kernel) {
> -		const char *name =3D sym->name;
> -		/*
> -		 * ppc64 uses function descriptors and appends a '.' to the
> -		 * start of every instruction address. Remove it.
> -		 */
> -		if (name[0] =3D=3D '.')
> -			name++;
> -		sym->idle =3D symbol__is_idle(name);
> -	}

Is the new symbol__is_idle() helper actually called anywhere to lazily
initialize this field?

It looks like the call was removed here, but the new function doesn't appear
to be invoked anywhere else by the consumers.

[ ... ]
> +bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct p=
erf_env *env)
> +{
> +	static const char * const idle_symbols[] =3D {
[ ... ]
> +	};
> +	const char *name =3D sym->name;
> +	uint16_t e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);
> =20
> -	if (idle_symbols_list)
> -		return strlist__has_entry(idle_symbols_list, name);
> +	if (sym->idle)
> +		return sym->idle =3D=3D SYMBOL_IDLE__IDLE;

Does reading the sym->idle bitfield here without holding symbol_bits_lock
cause a data race?

Since adjacent bitfields in struct symbol share the same memory location,
a concurrent update to them performs a read-modify-write cycle that could
race with this lockless read, potentially resulting in undefined behavior.

[ ... ]
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 5d98d7e84d57..717d2f876d58 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -43,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>  			     GElf_Shdr *shp, const char *name, size_t *idx);
>  #endif
> =20
> +enum symbol_idle_kind {
> +	SYMBOL_IDLE__UNKNOWN =3D 0,
> +	SYMBOL_IDLE__NOT_IDLE =3D 1,
> +	SYMBOL_IDLE__IDLE =3D 2,
> +};
> +
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation =
(see
>   * symbol__annotation) and/or a browser_index (see symbol__browser_index=
).
> @@ -58,8 +64,8 @@ struct symbol {
>  	u8		type:4;
>  	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBA=
L. */
>  	u8		binding:4;
> -	/** Set true for kernel symbols of idle routines. */
> -	u8		idle:1;
> +	/** Cache for symbol__is_idle holding enum symbol_idle_kind values. */
> +	u8		idle:2;

Are there still places evaluating sym->idle directly as a boolean?

Since idle now defaults to SYMBOL_IDLE__UNKNOWN (0), a check like
!al.sym->idle would evaluate to true for all symbols initially, bypassing
existing filters.

If a non-idle symbol is later evaluated and set to SYMBOL_IDLE__NOT_IDLE (1=
),
wouldn't !al.sym->idle evaluate to false, causing valid symbols to be dropp=
ed
incorrectly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501182021.3651=
851-1-irogers@google.com?part=3D4
