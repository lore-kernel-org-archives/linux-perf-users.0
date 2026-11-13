Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591057;
	b=0CP3fyKaeNKPSF7RL8SaBthL5H0o7RIs0Sp/rS54DjRPsjMQsZrbV3AeNX1AyKR/4ywv
	 ZI1PWL/R7biV4aeJs89IzkuMt60DylXJ1VMSiQb/FrZ2PanEJ/38akkc8pw1YEwIdYk8/
	 4M3E86oOds/WwPHzGh5CXdU20drGFTGvqZAfAK5VkRZJ5TLXpOOgsbw8CvZtmq3lvgIMA
	 8xLQfThZgDfFkw91LGaWmBMANlezvCtGdmhZM5hE+P8bLw7xpgqqjcLSNwLSsCD3Vbg1Z
	 1VT1UEO0u7XYVIWYKNVWKGdC7Ufsuru5GcgqdcOC96ymjMtrFbz7D6Obzf73hNOXo1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/JbVDwPmZ5b+kl1K7VdbB5xv9VhIga3gB8vkzik/Po=;
	b=VrksnaNgvjS1ZnawoRdHQ2Drmc+7XNiDl2QlvITTf88cfwrwo2DIb7G9x1MBDxf+6BhS
	 Zghnta+nU7eA0QjH4YYCegm2p9SlEsNbQA0idMi4+Uy6xZ6IXdEJ/K1Ip93xYQj1DBNIY
	 XcG5mhLHMhEz9l5gVgNXWE3d9OMpLCHxF9ohi0jc/T4omVz58BaIkU38gUTU6C+9CMCMG
	 VbSTxZ1jFiQsSXTRiGLdDrPLx4z6DQKvIVceSk00sTGUoA+L08a7Rx1YHoTMk+JYKOFa6
	 ooHeo+hheBARFJ2x9q9YOw+ECGN/zbq+Y1W+IaU/urmtWr+1dzOgSU7m9fsse5o2Cag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OODzgwxB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0277606B829
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OODzgwxB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF041F000C5;
	Fri, 13 Nov 2026 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591057;
	bh=w/JbVDwPmZ5b+kl1K7VdbB5xv9VhIga3gB8vkzik/Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OODzgwxBZT6+G/VC2ai4brVWAWSGzIzZLj3FcAM2tJOMr6ob3X+R9P6uZQOZvUFDy
	 PrzvFzaMjLsrBFCPdyzi7U7Xmpivjw8RO155e0R1fTN489ATcQORczyBDZVFE7Q4yx
	 1qSlnxJi+oXMTd4vq+rNcT315GXQDUOvChNd4LZBSEdB0+xDU8YsvtNTzaK+7SsJ9F
	 Y1kIzHDYCCFVFJOR185Dw7kv19Y7iNVOtgwIJgUu4+sPUUCEqoH9RVGA/Y930W6wE+
	 bJj2Q3cz/lXjtq0z7YAdr2i1D3RmUqI1ppV9g4Y9E4AMJzH4FTkrx6XllI9i0JYtSA
	 3YW6WVEDbxO9Q==
Message-ID: <sashiko-outbox-213315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/23] perf bench internals: Add symbols benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-13-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D12

