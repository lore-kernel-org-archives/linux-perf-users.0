Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591021;
	b=nmUBnVdM6CLqZX3WGhJNbcmoV7u6jtSfZ3c5f8A1dEMQoJolZVcxTRjoHKNveUIretGp
	 gELwHGy4MpDv5S3ODWmjWYfdV8j5rsqllgWWwN7P3VYM9D8H6BIat619dZJqX2v/33V1i
	 OwgJtCtQTp/E9ym4nr9DwXDCzXbwX5if5Vz3uCTkwRur94Zn9sFH0Yzah1qomCf732K3A
	 RLBJ/AEW8pYYfjVrJpEFKoFmMoSwIl3eroXke88gMibuqjLp91aRqDYKurwBH+aJKemRf
	 leA/0SFWg7BlRpHjZmgzTgZA5LTcfSirMN9B+91o1VUV6oYo9Ml9E29wivUUGmeMhQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mi87GUQwa7rUO93HI4XvnWm7gTkVguhfaVxDY6JVtVA=;
	b=kSD8d4iQBQq3iuO6apQfFChddjY+MXMknaF9sUi/AIGLkJ3QjcH+cahHhDggXzC5+6uk
	 yp6i7QrIpdSyeYkNp4KkBdGTJue4mQn0mIIDH2rCCbRDXJhcDki9FHPxDM3pIcrIwK/fw
	 2ren/cJ4ldqai0hrBNLGKU0Sia3XuzQZTLIal1wfn5wrFj49FqhLN1tdVqE7iTqOMNlYc
	 lVvzDlE1lWXkzqEpPUpg56+kQ6/FF4tLxBZGmrASOYGPBf14ipus0/AQlTG8a7CaWlAse
	 m0HZ3It72s6ETQjb0TdDpcHxU0p+VB9qx8Lkd/eAtEC+aVe0VDYORACSOOOYWwxPSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ct6pAf9/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DE6070F3C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct6pAf9/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E403F1F000C8;
	Fri, 13 Nov 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591021;
	bh=Mi87GUQwa7rUO93HI4XvnWm7gTkVguhfaVxDY6JVtVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ct6pAf9/D2goFGpTyh+FC7+WHuRq3/sCi6QcYtZ9LxERAZPBjx4ZP5P85oBVAjczY
	 nrp0/r38i5XKvOxIgPG2skksURHEe2i/zvjOEOoSXJT4+e7QP3KZPrwOh8IGY3o7Rr
	 bwLmKMiPU8TbIkgViug7P9dvA6Y48Hi2A7y1NRr6ly4dO1pAm/zslhjrLKU7RKoqHq
	 tweR5L15l+tRDd/LinRxqaFpZBnl2+4YrzedgNgHplWfPKuNVp1V//LpHtVOe/6hLt
	 aV6QUz0P1EvdobV50RWbnw1gkazqeBjdpzAeqnr6mBmAFLOoPNg1DrEM5spg0plW1S
	 CRuuRHx304eIA==
Message-ID: <sashiko-outbox-213313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/23] perf symbol-elf: Cache ELF program/section
 headers and defer symbol name lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-16-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D15

