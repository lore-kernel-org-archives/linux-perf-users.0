Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942873;
	b=UyxDa6HYphPVQnrxcse7ihXfctFST0bMpzr7aYa3GSDK40Vcy5yMOvTAOYXowKEStrzG
	 2deFd/bNgzjrRtvTJu7k5CCnXrU8riNL1IjW/DpnZOZw4isDD37xujRJ87ZrKEbpbWZK3
	 0PN7yoslyEAN+RRCmI0GzojypVipSyukO2L25HsnLUHegIKfKMSlgZGXSDSsNWJznH8aP
	 mHEPxeBrzyUVZ6KdssCJtYxSpBDZcusKMmqxpqno6bzgr+DmPfAua9N8jiVVJXTsRlBHA
	 gOc39ZGgR/vAisrTs9H+Ibjsjjxoe5zoBo1bRBHADOB8jC/49kI0wWYAQBzYUF7nvQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=imWRi1hlgdhkJdhqLGAjYxXsY9Nc8x9VhB1eV/Xj1ec=;
	b=o/0ZBHLSrDm5NmaMHtsEB3G5gyRVLCuaecuG4ppgYl1JWE/z3QkC7K3CGvjYz5/Nzs3l
	 JyIVwNl5nYWBtv2ZsidEWA7xJrOJoo26DU0h6Hl1tUsRN4yWUGTWkTF8uRCj4hf/Na7mP
	 D1KwvMsDjKR5CvpSxuJ+e48hyRNdUlZp0oYKCXCYrVF/4eC0hAWW9J+47HZhmp/5HGVYW
	 uofiEgjVvNw0k9yu72YXtagnKswkXfUTgwCnmLDMfI5sNqZ71q5NNnpM0La71W03jOQjs
	 HzRYPffxLe9FnL3NPqqf21QIcGAkfVXt7fhCA33kUiRl9S/ScX9pNamSWJftbUD6c8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy6A0Umz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C7606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy6A0Umz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB4F1F000C4;
	Tue, 17 Nov 2026 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942873;
	bh=imWRi1hlgdhkJdhqLGAjYxXsY9Nc8x9VhB1eV/Xj1ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zy6A0UmzoyBtkcuQOYXxhBepp5INuDrYO646GUsDRAkwYea6XHdXbswOFsD1jD9XK
	 f6ZpXg7kCo7nLb6fR3l78w/GmPL+H4uQxglpATDDAmBJj3SxawWjKYA2NrCPM0Y6mQ
	 9+ys6kC+MHzanv0M+EGtWlNn6vK92vp62xbhc2xsfQ/m288Zf7nmDWDJi70M7G3nLD
	 SjbHn1uoMllrHCdejaYu6cW26Pcl9S2AYxIw7Uhm16SQNeVyvdc1WinY4ZRbkGcNS0
	 O9YLq6NIT9zo6S8WlY5YuAi6TPsrUBKTfY688HnOeN4dvphYZNEYPARvlpcSqhI3kw
	 KxQ5n715Qhp8g==
Message-ID: <sashiko-outbox-219453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] perf test symbols: Add tests for symbol
 shrinking and session alloc wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-10-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:14:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Ensure the new symbol sorting, DSO-lifetime symbol and DSO shrinking,
> dso_symbol reference pinning, on-demand DSO reload after unreferenced
> eviction, and session-scoped allocation wrappers are verified by
> 'perf test symbols' (including under REFCNT_CHECKING=3D1).
>=20
> Add unit tests to 'perf test symbols' covering:
> - test_symbols_sorted_insert(): Verify ascending symbols__insert(),
>   out-of-order dso__insert_symbol() maintaining sorted order, and
>   unsorted symbols__insert() followed by sort-on-lookup in
>   dso__find_symbol().
> - test_symbols_shrink(): Verify symbols__shrink() reclaims the secondary
>   symbols_by_name index and trims unused capacity in symbols->symbols
>   while keeping live symbols intact, and verify
>   symbols__try_delete_unannotated() preserves annotated symbol tables.
> - test_dsos_shrink(): Verify dsos__shrink() evicts unreferenced user
>   DSOs while retaining DSOs with active external references and vDSOs.
> - test_session_alloc_shrink(): Verify machine__session(),
>   dso__session(), perf_session__malloc/zalloc/calloc/realloc/strdup(),
>   and perf_session__shrink().
> - test_dso_shrink_and_reload(): Verify dso__shrink() on a referenced ELF
>   DSO reclaims auxiliary buffers while preserving symbol pointers,
>   dso_symbol__copy() pins DSO symbols across dsos__shrink() until
>   dso_symbol__exit(), and dsos__shrink() on an unreferenced hit DSO
>   evicts its symbol table and transparently reloads it on a subsequent
>   map__find_symbol().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D9

