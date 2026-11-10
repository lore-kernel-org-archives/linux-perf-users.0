Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349298;
	b=gfT0CZG2AaIaLNARP+xrqSm5rnyUZQIbMKwnCPVYSusQWbVrBjxpoTICfcNrV6iz1tFY
	 lewNRwvB7p7w0wiEqDOxfMfFT2Ec2HIUzB+2mK0MkES23UlQS1x5BHBMHR+Kk3beQXJrE
	 ukXbV0o7eKgG3NhjTM4gi/w+Yvp+qI0sYT5cIykk6uzbHEntO7y1XHFl5zg2GXgOXdz6E
	 IENEQgnh/2unLc9MsBIEOdd8kua/Aln2BOxPu8Uq9TSQ+LLK8l9PbM06qXTSEe08VLuuj
	 daLfOAGEDglumQ7n6YROFEG/PltW0BY2DwK99XSuL6wmTuTfVCMtcRfpaPjkGm9FE7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1sOi2MmoYkesQuWUj5N0pWEYbGWsZKogXszMdSlw0Q4=;
	b=K1vZ2odHSPA6dk8985uQtVRNxkprRtvEM8U6eIqHrk1D03ZKONYnVo/YtnbDTLH7rItR
	 WGBfYuGT/H//NcfTOormGKzJM5GzGdfB4/WzcRRQmVKRl8AirlQNCQP2R+aK4kKkZdp+i
	 jsax1DKuOz+E9HgIeaGnd3Ty6QLCDJf67S1eVP6O83cVpQy6HikaJZjARgwjE0cce68r5
	 MbggSYylcmiqjQVxcUUFnjWzW6o5x0JQMNFJru7uKg0WCAdXsRnIbeEk1n3luGCpaE/QG
	 cveVd4vIWmQSDYnyJbKKaKlQPvpA3/cxx7WFdDXHYjJ4Xnssf0TQBjv8XV6z5lkfeKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0Hy1M1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEF606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0Hy1M1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAAB1F008A2;
	Tue, 10 Nov 2026 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349297;
	bh=1sOi2MmoYkesQuWUj5N0pWEYbGWsZKogXszMdSlw0Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0Hy1M1f/Q223C94Otv01nJ9hmaVYWIl2XaZjEJx457lM/FSnABECJAF0W0ZBiqs0
	 zFGqB0NnllL4dUfd9uYEh1xJmrPUXQH7YLsgGH8OQm4dLOqxeDzQly5pOw2aXtG74q
	 ln9TgvmL8EyjRLAyqs1Nn93M+/9cUwRseSj2iFG54hkBuB5efGFtqjDhk5tqXdqJgF
	 EvsEzK9Z1IC6MUDy09g3Mkybe6ln3+UoYndkHK81r1Jaut12vDHXTS5E+iWRoOyiGK
	 S5DXJZaeFtuRsih3kxc4k40Xe0wXoy2SNYvGvkujF7WhIVDmm+IDm8nW5ZhLbLATJP
	 lY/x2+epANMwg==
Message-ID: <sashiko-outbox-207820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/20] perf bench internals: Add symbols benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-10-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:21:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a 'perf bench internals symbols' subcommand to measure symbol
> loading, sorting, and lookup operations directly:
>=20
> 1. Loads symbols from an ELF binary (defaulting to the running perf
>    executable, or specified via -b/--binary) without sorting by name,
>    reporting average load runtime and maximum RSS via getrusage().
> 2. Sorts the loaded DSO symbols by name (dso__sort_by_name()),
>    reporting average sort runtime and maximum RSS separately so
>    address-only/lazy symbol loading can be evaluated independently of
>    symbol name sorting.
> 3. Inserts synthetic symbols in two ascending runs (simulating .symtab
>    and .dynsym), fixes up symbol ends and duplicates, and queries each
>    symbol by address.
> 4. Incrementally appends symbols at interior addresses and immediately
>    queries each appended symbol by address.
>=20
> Example output:
>=20
>   $ perf bench internals symbols
>   # Running 'internals/symbols' benchmark:
>     Average DSO load: 9.174 msec (+- 0.220 msec)
>     Max RSS (DSO load): 75640 KB
>     Average DSO sort by name: 2.787 msec (+- 0.019 msec)
>     Max RSS (with sort by name): 75640 KB
>     Average bulk insert + lookup: 2030.050 usec (+- 13.376 usec)
>     Average append + lookup: 54.650 usec (+- 1.466 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D9

