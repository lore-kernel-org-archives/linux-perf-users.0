Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349533;
	b=tzSBQGbnX0wqtQB8+Ywc0r39v7+cG4RAYo2UT0VJlx8mOfCT5Xv2SB+ynl7ioOWTawSU
	 /txInXhF6+L0Nej0ctJ+6vYCRjT3u/uv2O02hGMdPl0Qa6wGC8wewA/kbaxGOl7GfpRf1
	 LPsPm2Csrp84RdF0eQMgRzfe6TAGaDC5Z/rdP0KCe0dQZSMuDij/Fea87xXz8+uzneOhg
	 mwI1h3XuKL8TwY4ODcPXS7qwqhfWHS/Zqb63296RdGHxc6zPl7ZBODzKZLZOthx+dZzY3
	 SY1ApCOJPCdRT7EFk71ojJeyr9Poj13ZwenCAwe559rJdYQLTUrp5sqgFRPCJ1vvN9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349533;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kT85rSwbiKmE/yUEKGX4kMJoUEvCOTF4E4+16/4F2wI=;
	b=z5lHtqtpPvvCthIyDia6u9tv+/d4+IlfDcOxqpTRYUBxLTUCaUR8hEpdYO+RxRvJ5gDh
	 s2Z/NVqkJ5hV7x/MICAjc6TlVGgIpUdEpU0n1EGh40bT1LITWMiIZcRmEbdg7oA9K0vCN
	 4P9Hhre7t7tnFpqrcigwPcvuPpnfCCie1q+l3lHVCnPUMwRcfCFTi2X6yCqroXNFuDqil
	 DrhEroXGny4CS/5v0kZLccj7SZv5dPI3AmZTlqJUcjMYRW7xjUHWc9M+AzwilQskOYag8
	 mtLVwYSBUkTm5CXRz7PsitvO95/r8PaJvai1B8tojaRk9Jnu6WmPmZewIFGJK1j//Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzvkiyCI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBF606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzvkiyCI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BDD1F008A2;
	Tue, 10 Nov 2026 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349532;
	bh=kT85rSwbiKmE/yUEKGX4kMJoUEvCOTF4E4+16/4F2wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzvkiyCIfSOuT2wpBKG/ojupRU2SqyzkKgAYFIR1JSQhAAqQg9KBu7RaZfkPPRsuA
	 4WkVWm9RM38K7HoOQpDrVeWpilE1UGW6JneRSZfIqkFJO3Z+QbhyIROhIvF/45j1OT
	 A9qjLAUM/ikw7bDPU4lauXngtbT23su+zoi5jo4Af5Utfe7WtSJXyttvGove6mPd6o
	 3pg9576IKOQc7heNpK55QCIQtBU0UuNcZVO5LPi8IZljucNGWZxuSYnwwX8uQmwj2V
	 Y9RJlU4xyLdl6qJww45nb4B28BK0PwoOCGK1P38x8K0WfIHtzfNLqNoKvlsr+Y0Gvh
	 WXBzDPmDzJvSw==
Message-ID: <sashiko-outbox-207825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/20] perf symbol-elf: Cache ELF program/section
 headers and defer symbol name lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-13-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:25:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Profiling dso__load_sym_internal() on large binaries showed significant
> time spent in repeated libelf section and program header lookups
> (elf_section_by_idx() and elf_read_program_header()) for each symbol and
> in resolving elf_sym__name() before filtering out non-symbol and
> non-allocated entries.
>=20
> Speed up ELF symbol table loading in dso__load_sym_internal():
>=20
> - Pre-load PT_LOAD program headers into struct elf_phdr_cache and cache
>   per-section metadata in a 64-entry direct-mapped table in
>   dso__load_sym_internal() to avoid repeated libelf section and program
>   header lookups during symbol iteration.
> - Defer elf_sym__name() lookup until after non-allocated and non-symbol
>   entries have been filtered out.
>=20
> [ ... ]
>     Average DSO load + sort: 22.433 msec (+- 0.260 msec)
>   After (libLLVM.so.21.1, --no-demangle, -14.8%):
>     Average DSO load + sort: 19.122 msec (+- 0.226 msec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D12

