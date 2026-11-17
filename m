Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942039;
	b=nEjkWtdTm6kx66fC6lrrtUNFeaofPqVjqQCYI+NHu4w2GGvcV+W1x7TK43O54SeIDrlx
	 LbiiXWO3p63jGN36cBWBZcRuyWr3g5kqZeyEBOZwm9sdwkkxTT2SWp60vy2+mbroihbxH
	 qE6J6wHKyWbAaP+5LGsDZeMnLog3f5alJjKBuG+L6xlOMuSIdinhAgN2KE2OoGjAgxQF9
	 zXfqi5M7D9DC+85FqxqnC7NB+3BS6kdjSaDWA6u++suuVUHmPGOoToc/rd9k8JcGXBE+w
	 Th7R5WGSiBemNUNUYkDBV07AqcziB1HYkXtngNcW1H2EYM8SZTuiFz2n99KvhyeHDBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nn2yv7VMJibpe4dckMgI7lkfwJ1mqUKZqDoUBaRBAnE=;
	b=1KtkfVKv0c5U2M47gCjZcz4sbU/0a9XtxocjD5dVdM8ZkW/RyKsk+bTQrMyschClmcFf
	 AhU7XmojDGImkQGmK+zbyVART9FhY/lVq5JxzA+dj1h/XY7/M4itB5E/6lJpAQmoZyiqr
	 o2ZLsRt7PbX6Ok5rA32SyCYYxWq1zjqjzZvH2uEExBDVZNrezWrld5DZYNYMpIRO0xMNm
	 /ezpIj1vudu3f357ECnSxyHnLOG85Iz1ubSrgJqi1wBWebELXvOKfB4UwV23AriEsQOJk
	 RSZAPwf9xvO+p6ibtMCrNbTAt8DXASDWyPs57DIYBj7g8SZG46QyiqSQCo3/4CGJoXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ee7CljiD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED5606A337
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ee7CljiD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE401F000C7;
	Tue, 17 Nov 2026 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942039;
	bh=nn2yv7VMJibpe4dckMgI7lkfwJ1mqUKZqDoUBaRBAnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ee7CljiDK0KCdu7f/8cZRbDbtYL0XwU6o9iAQlK8h7Rf+2WYB6fu1F+LPSZuVQGg0
	 83N+Cs9o/CU6ndF9o3cOAl7Ds09qn815ZhJ5eKeU6Hfl+67K9TnU0D8REQMD7rTB1e
	 +k4B5KgYAFJnvLEm52rlALag9xiWHycNEtDVO3hiulU3epCV7eSFj//Sso0b566whc
	 lWmrABHkDVpDBzzEoJ+QWpcybIbcmMuIlbU6GVMpRZ3NmKsveuA2P0C5SLiz0sQBux
	 t3PdMMaQxHSiPVxUBSjmEiN/Sk0cb4nivnFP+3PIyHDiCYBnS+scOS9XiYcSYROxFD
	 tJpGWfpKrqaNw==
Message-ID: <sashiko-outbox-219416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] perf symbol-elf: Cache ELF program/section
 headers and defer symbol name lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-4-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:00:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D3

