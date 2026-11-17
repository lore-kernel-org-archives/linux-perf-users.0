Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943524;
	b=dqvktreorhqNUB0EcXHrdelzdai1mDkppEWzCrp65/p9/S2Wqi/UF0dFz5gULOENhF4v
	 3ywYlO5OFic6vYzgiq2rzPeC82H+04om6T4e2TxGdEF+bYs5s1e0hsoYS88I0HdogHeq5
	 GpW8qc1dm1kDQDZ8YsFAhuQXNmtkclEEyL/EoS4xgGBxTklX677824i4ZkETcXL86QpFn
	 YfqNe+ly4ZuvvLOhaD/oBKjl+nVOqxU70XdJLcMbi1QekeZMBNj+wOifz3ElLKkDXppkN
	 +LMKX+hRDWZl/LgcFHf4o+LC692r7laNhkE7NAjs/6+PylNXWYHzE0+jwds9IkzcX8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3I8GFTqhJvaQ7k6rANUxczFj88+Sii+xTTmRnAiL57o=;
	b=2lVHdgLcIhjYCOS5P5oxPKq3VDoDktudrUrOQVBI5tx8U+cdhEYWQNPqUbUEnZuwXVN+
	 2cLutRn1Rrsd1kyuToPv3yCNHxExVvgHsP1zTJimhW7blkdP/xyd7x3m3eyKTwMz60dyi
	 DeDLyuUNW7EWyRXK17Jbr+759dtqumpLzP58CO0i56/LEccTfJg8GwGkpk8Alp6IMxzk1
	 WiBwPAdMdJWrnYeF22y5jPlka5voiL0x2x5SXtgoDxORnZu+kiZY+nrHo3ape205Jtv29
	 Uo+9Nw+WvdhePFuxjH93qK3BkpXqiscrs8MYRbnTOjlYCN4D2NBI5aFaUti8YPe+4WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLI6ED0j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FA606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLI6ED0j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE691F000C6;
	Tue, 17 Nov 2026 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794943524;
	bh=3I8GFTqhJvaQ7k6rANUxczFj88+Sii+xTTmRnAiL57o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLI6ED0jkh507lDfAclJ6IlBpH4VwHrsYpNTZ1WDcI0jkxThClxvMfFDJ7IXDej4H
	 FQa6eMk38jGotGHr+Sh51qoSFcqXr9kMt51TTAD5q/wjWTauHJJ+j5vuAq4qHL/9IW
	 nKzL8P/G+lJpSFSqwciomG4Z2GYE3O37NMAZAknajce/83ZWo0J9kk3WJtecBzUewx
	 AkefU7y8ouKw10u0KdL7TFoXbkjxJrr8yVaQPEZJjmOxlv7q6OrCzGRReRfntVc11r
	 HySK+4Ax282O1dzdHRlgAp4xR8f1ir09U2bDmnlCWyBU0Tg/okfjpxPdgevi7Pnrs6
	 hmFTUww5ymkXg==
Message-ID: <sashiko-outbox-219468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] perf symbol: Add memory shrinking for symbols,
 DSOs, and machines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-8-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:25:24 +0000
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
>    and trims unused over-allocated tail capacity in the symbols array.
>=20
> 2. dso__shrink(): Releases cached DSO resources (open file descriptor,
>    cached 4KB data pages, addr2line handles, and libdw DWARF contexts).
>    When a DSO in a dsos collection has no external references
>    (refcnt =3D=3D 1), dso__shrink() also evicts its unannotated symbol ta=
ble
>    via symbols__try_delete_unannotated() and marks the DSO unloaded so it
>    can be reloaded on demand if mapped again; otherwise it calls
>    symbols__shrink() to reclaim auxiliary symbol arrays.
>=20
> 3. dsos__shrink(), machine__shrink(), machines__shrink(), and
>    perf_session__shrink(): Walk the session's host and guest machines to
>    shrink DSOs and evict unreferenced user DSOs (refcnt =3D=3D 1, not ker=
nel,
>    not vDSO, not hit, and not carrying header build-ids), followed by
>    malloc_trim(0) on glibc to return freed heap pages to the OS.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D7

