Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350789;
	b=I/Ce8iClwkk/NdbublNHybV0IgbEn/7oeh5nvSbXBg695A3jHZ3IsJzVTZwxobCNLdfj
	 D30EvNQsOZYEAYGgGbzBSosvLx2ozeolailmtzTe3sJkDTl5YT826CbK2YAFRbayynFRJ
	 NTc72gnUmWHyK9DuWX2J5Q74ww/thhsrXKoIV0ol8SMWZf8DdW+Yh7DDQwkYMyEoOtSSq
	 mdWqGRU3FjmbOdMLKoFRE54/q22MFvKdq6tTDfEnWXtb0W7Mpr0eZpWZF2F0yF+evONRE
	 uGyol1g+DPpXVMYW1qMJmbzBhs+SFatqKMjBYM1Bx0bN2papDTD9IB2pyi+ugkbyeEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y4pVBcYymIkl+I/JK2wluJgVSjFxENQelHYGTkIaj7M=;
	b=uvvOTuqVUGxhzK3OYCTs22wwG79ksYVYg/5mG9F00MiCAXDQ8rcQsprnxC6s220YiTar
	 xqnKGNOrvWt1dpPktCWjK0SCVJFWJ2HE4MI/E0mKMxMWeOj1GjgWW3mNdauwjLYiDTZ5c
	 owBG9/6p8hZyFjnhZqeehhBsNNxMYunXRSr7EDmVBx4o7TvUqPWA7360i2ZTuP/TNJOe1
	 LPQM2hUbukEIYdALJTRW9fkFSksTt7T/GVdjFSO72W948gCFSJjSPFINDnOyeY/RpSQ4o
	 qVBwMJva2jZTkFw4Nk7YmwcW9tsq9jZC8zprhIcZYy+pq7iR6spfDqkJWGcB4Ci9pbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxqswxZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E0606A33F
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxqswxZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668DD1F00A03;
	Tue, 10 Nov 2026 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350788;
	bh=y4pVBcYymIkl+I/JK2wluJgVSjFxENQelHYGTkIaj7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxqswxZTybQm0N6SdWC6bUq1RmKbuXVTTeP673SHrSwZMpn70IJIFYCSVQH4rSsYY
	 wwDYN7Crsr+XYJ5mviBTXaTFaYdEJzX66xOwTJ0Hvz34tWyQWtALe1rPwTLlGmdPqg
	 4qVulqqxYRHgrzLy79xnliYSC3ozmFet7PmAi392GI9MhDvrhqAQvTqpNco64VQs7P
	 Ij6kIec14HhpVfmI/ERCu5k55o9GSjldmPnB8waFDQg2tRgU+bdG6UtU2WIoUqepwV
	 mwjEZ4C6Te4v7VgCg02WgRnAhx8Oeada4GYCrX9hkbGV33xcmALTzHhHxWTVTvSrcp
	 wLq/PyU4hbDow==
Message-ID: <sashiko-outbox-207845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/20] perf symbol: Add memory shrinking for symbols,
 DSOs, and machines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-18-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:46:28 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D17

