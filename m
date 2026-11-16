Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814575;
	b=2Zg6X1FHtuhZ01KxufIb9Bmw9YyLnkowaCFM5NO0qzc1kTX4F55oa9yn/qkwnhkvrnQZ
	 aPL2h9QYVQ4P0BM2oQ/05/g+vMm8g2bl6XhZcGwC+5fQgMWXo16xD1WUpL4J9g356z+Fb
	 N8AHYx7rPGd64OCGRNjTCWr8YYEY9ZDfm0/Vmrv7R8p/PGrFgpaWxMMGYiCsme507DQeg
	 zGd6hXvGagou6P8rd/4CYBEUhtjuEhVjiQtgXR0ufODCVOveM19lfflyXoGi7B6I4icF7
	 E8EapS1eBChI7gN2VebXqK/IXUg4LcKi8nq/h/7ZalzGnF0TG4DTRgS8CzSt5fTVFlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b3ADc/DvtmT27QNZep4MZ31OjrvKV4pD+zCE+XYmzJk=;
	b=DFkGl18Cx0Re3mBhl+ZYjaVUsuSBxMkKVgu/ir17bH+zRPBKuv7yQ5AvtPkxTcqVBTwT
	 lt/Rg+avlrSqvQsk178YFa1paCe+DwovMnRP2VeA0Br30SYhvDlqrO0VURXYfO2ADmgT0
	 vN6WIey2ZARdObgFqhsbISEFTCXhKRGV60SOClG7Fj208yxZPp7xB5jJDYmqWc5LZI7iI
	 fJiqkAa2U7IaJkTSmig84mc1e56seavc5dt1u+dxyuAL79BYXTFCIe/UJ3pEmQuy6QChe
	 PntJ5WgKPKvk+0ks+d/sonq+jjKv4uiSd5v5CiJqLBuphqCQWRTHyWkkIKEsQ88cUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBQhlZGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F8606A335
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBQhlZGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ED61F000C4;
	Mon, 16 Nov 2026 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794814575;
	bh=b3ADc/DvtmT27QNZep4MZ31OjrvKV4pD+zCE+XYmzJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBQhlZGQoHDk7OIqoEYw8KLuUyAFoz5yesbdLUGD8REJ7DDsp+Xe7w/PnK1C07PzC
	 tBUVarZMn6axOsQ/E7EqUSW2dJVxNzV1Uq0UR7JDX8Yqmq6bG7XlT1GJ1R49Gg0dob
	 fQSbh9DP741putU/OPM0i/K10jLIsUE3WgHAT53up8KmyVFzJPkHJWW+MxBIB+jh4U
	 xfpKgqn/gus1GXISHps+LwMPUZQAcQvOy5GAP8q7GxU/Nse2dmsx0uGgLeJ1AymBvc
	 VllC/m3O3u5XWElQULyhDpLJ10hzVJnXHmWPs1f3rowai0ywlbbWLKekeV7uIaXq2j
	 Mk9LvuWgWKlzA==
Message-ID: <sashiko-outbox-216442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] perf symbol: Add memory shrinking for symbols,
 DSOs, and machines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-8-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:36:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D7

