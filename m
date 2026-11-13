Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592496;
	b=n4WpP0I07fG4yx/EYef1Nn2/EqsrmJBk0ds4P5G+ELoXAeQ/A5UO9GF/H3dnClOK/uSf
	 iOrN3dqqEsFWDuhDyKpLt7zP8/dQQd8q2Rochfy6/TeRJZmVYvdNH5gLAd1qqq7U987Rb
	 sM/gKM3oLb/Jeirv2UrLsTroB+hN8NzAPHDpWBHimCJKEvIvCxxyWxoGjvkkwr6tGEHSf
	 uDD7837UX+bF10JJgR22eUP0H9aUshfu4wGlyRQslDS/PycK6gq2lxJn9PXOvvTVwoxT0
	 m37Vu3rYO2nOsvnPXCByINvo5FuDI/ea85o9XL4MK7pI/tGpxp8Ea7vmuNdJUyWsKkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I6xwkmyTuUjbGic/IlUvEm8+MJuuzaypz/G2iSHEj1k=;
	b=D0nZXo+4y27RsidSucv3xpxZkbQMKbyy88++7bLxQeQ5297jYmaPoDcp8agtx8naMBrx
	 Ba6BLf0n6mGPbKxo5Son675IhE2nTg+oamizOXw8Qu5Hb4QYgy/mdav40Nl336hAojA3t
	 PmBCMvf8i6+JOJAyIx5IqZ+OHJjVEOSawfPgKO9gPyGI0BvFioaU1tvf5u3+zZ4Q43Ug2
	 eOElPYvMMAbWX4G7yx6/MpxKVzcDb7U3O1WgsFrDzNr7vmK+BqzMdYAox5zstg32Ccxbf
	 Ok9y6/YHos5tGSi8RndpHGcziei5Wp0VaBRVciffpzca7rPU0e9gSAyOuj9AezqTuZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWa+yi9v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEA606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWa+yi9v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C271F000C4;
	Fri, 13 Nov 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592496;
	bh=I6xwkmyTuUjbGic/IlUvEm8+MJuuzaypz/G2iSHEj1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWa+yi9vGWViH3K9OrhX7/ro7xCWc/FptNdZkKg4k89tNPI9dYmG9/hlldeemwAy6
	 od5HIqHvsoCVihwvuRue+BmNf9RKwLA6q7CAvQHSk1oo6W4P12yyVDO4Rkcc7NgrHp
	 09a5uIOpvCMLbnBxEv6GZNfvaxqS9GJ2FISCRdeoOuHdkV3eiQK/Vpelosg2uE+Ot5
	 UOptvOM0UwVI+lDrrEnAswYUxf7/UaZgExxwcET4Qfg4oYogzeH5GX63uv5YN/9NSX
	 ZzMSZQdqMX08/NH8mhmBW76OV8SB3tjRSVsTNGJGTaXDtJNbutpOUMLFyslreJnR4z
	 3wNi0qFuYNC5w==
Message-ID: <sashiko-outbox-213367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/23] perf symbol: Add memory shrinking for symbols,
 DSOs, and machines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-21-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:54:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When profiling large workloads or systems with thousands of processes and
> shared libraries, perf can accumulate significant memory in loaded DSO
> symbol tables, secondary name-sorted symbol indices, cached DSO file data,
> and DWARF/addr2line state.
>=20
> Because the lifetime of struct symbol is controlled by its owning
> struct dso, symbols in a referenced DSO (refcnt > 1) must remain valid for
> the lifetime of the DSO reference. However, auxiliary per-DSO allocations
> and unreferenced DSOs can still be reclaimed under memory pressure:
>=20
> 1. symbols__shrink(): Reclaims the secondary name-sorted index
>    (symbols_by_name, which is rebuilt on demand by dso__sort_by_name())
>    and trims unused over-allocated tail capacity in the symbols array,
>    using down_write_trylock() so shrinking never deadlocks if invoked
>    while a symbol table lock is already held on the current stack.
> [ ... ]
>    shrink DSOs and evict unreferenced user DSOs (refcnt =3D=3D 1, not ker=
nel,
>    not vDSO, not hit, and not carrying header build-ids), followed by
>    malloc_trim(0) on glibc to return freed heap pages to the OS.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D20

