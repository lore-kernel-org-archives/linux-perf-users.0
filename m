Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447509;
	b=xUtZYcnSGPVaMQyJrecup9yAYQpnZRSrdYdMLwNCYoBvz1Q4N+tpI73GkdDRgnurdbgZ
	 LCDEl90G/3Tg2DAl/GTjCU5WD0P83QG3VjQBdO3Ms+2msDaK1m3xDCQGqWqsEr3WycmSE
	 a2JQvyBRm5y1v7uQW02d5l3Wt7tzP8LafpSBN24y6eXI3ymusnQGNacpOcfKpiNr878eO
	 ABAUkE7U6hrFdhGXejZ58mNgz1B9N8B2OUk44nVJEChMw5HuMI2UzCQHBaAYZoYc2xxdn
	 EFfJUaia/oAMhSjFjf4SMP2GcfoidATSSKkabarheCiZBdmpyoj30beW9BvtWfK5sYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447509;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jjIaTrYcEzw6WReKB7K1tzW445G8ptEgd9uakp+7ots=;
	b=o1xYC3r1c8TYzj9/CYxkzZogn90pxQP5d5MscAOBOnYpBu2wYkK7FpAgje4LzXuGyYjF
	 mdwcTiILeqcxnSs8ClbacclNX5AMaVmDMXgz1T593cfvpPQP0dF3dA/jbNwoVxmhSt3U1
	 CqUWfj8mwNWoHM6L0LXOLFDvCGnhciVVDYHqRck+r38Zfeqdqq18SRev+y1ZRx7V7aICd
	 J6w//+jB2ZZFRUsSmnCf8plll9uNqP2lz638LS3CQn3tmh8F7v9D5IhZSk4i+c2QHn9lf
	 MfcUvuDYBkJUIYI9RjDOZIKArWVxJHl/4D5Q0L480ACjYXqgXRkEAC6rdkzieKHtk+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoSU9U+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C664606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoSU9U+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0889B1F00A05;
	Thu, 12 Nov 2026 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447509;
	bh=jjIaTrYcEzw6WReKB7K1tzW445G8ptEgd9uakp+7ots=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoSU9U+ElZl7j32msOy9AfeTcRrVqcB+UiKQ7BXETgcJZmwGc4DLGZAJ0W2n6d7Zb
	 K7WA8yeVDrs2j+IO2WY0+/cwDfn0I4tK1K7knlHIkr7IzE8V6nBXQ/NOe0oGcTiZ5a
	 W1v9jnFu7VkDSz/OkdNrdoAWxtkyPoEUlgPmN2pbbDMR50N9MumV1nltnLX2HUKVTv
	 IIUNFIad2F2RZBsCtZzB5OfrE830x00+nbZgJulmsMPlAw/DcKMDrQAZ6YwXU9OuTr
	 5yGsSyrir+cosAfRPTQkr2K82SIJXEgpxF+DxjC8HPOUXA/o4jnQCgrejNT4QV4xJa
	 qC3zTCE1L656A==
Message-ID: <sashiko-outbox-210077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] perf build: Support building BPF skeletons with
 bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112011514.4032822-4-irogers@google.com>
References: <20261022204627.1813821-1-irogers@google.com>
 <20261112011514.4032822-1-irogers@google.com>
 <20261112011514.4032822-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:38:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Support building perf BPF skeletons with bpf-gcc (>=3D 14.0.0) in addition
> to clang (>=3D 12.0.1), similar to tools/testing/selftests/bpf/Makefile.
>=20
> When building perf with GCC (CC_NO_CLANG=3D1), prefer bpf-gcc and fall
> back to clang if bpf-gcc is unavailable or too old. When building with
> Clang/LLVM (CC_NO_CLANG=3D0), prefer clang and fall back to bpf-gcc.
> Explicit command-line overrides via BPF_GCC=3D... or CLANG=3D... are
> respected, and setting BPF_GCC=3D or CLANG=3D to empty disables that
> compiler.
>=20
> In bpf_skel.mak, pass the bpf-gcc flags (-mcpu=3Dv3, -fno-ident,
> -DBPF_NO_PRESERVE_ACCESS_INDEX, -Wno-attributes,
> -D__TARGET_ARCH_$(SRCARCH), and target endianness) and query system
> include paths from $(CC).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112011514.4032=
822-1-irogers@google.com?part=3D3

