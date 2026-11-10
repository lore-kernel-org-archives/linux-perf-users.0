Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350701;
	b=PiljopU6rhA9qogjV6ouezplAEeUycVEeoyymdYa+78xDbm7yg4+QJ593gdcJabamgi4
	 5GZMGDSaPlCvCnG1SbzP6bGhOJkAkFFylfiZnm1x5uQLvIUHraGwRxZLLTk1LBjqqG4xJ
	 BiyAHBlNAk5YG+AcGUdQJWY9OVDC5cgQRfq8+z6F0heKLlORc9kCIUBgZbNCjXxnd/DiJ
	 n4aijZQd6jVOWv/77zoMAs/1cw4umAEH6enpOq1T1dPGqojr6aosMAObA4dEcDD2tyg0S
	 ci91jVnIJq5tq7cpTDRiI+qj6wqEl7HgUFZC7wxVrOUeoG+8LfdQvha6IrSbaItC38A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350701;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b5xKkghwtd/9sbSJ1Sa+t+wW0ySYueLBxXQcjJmolAs=;
	b=aoTj9x8NlXuhZZ99z7QPNAMbfJujV9GmZbjSE7E9mlFlDu4yBdLlFv7z6DBZAFXXdfMp
	 y3H27kRbDk1V1fNgwyfLODOIC7s3hfWXCfECzh483IC0G5tiE33XMAtDoMsBDJC+PyGDY
	 BmBJ36L9cfnK/lPCTM5SjD9HAPOO+vaImqH5XNG1h8dBuxVx1808z2Cxop6kicP+VjTPz
	 sMJA0JtvBsrhtyJkYpkV8HaEPsRmKwh9wbzKNl9lg7cLA7ZqIGT1X8dU7bmqVmR6GZ5vr
	 3QmLoaGzXbpMCRZB83QlQNxEwvFW30GgF12B1YnmoVoEmTkBEEwaAZrwMBvRuL3vjQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYtwQmXi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB803606A332
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYtwQmXi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739471F008A6;
	Tue, 10 Nov 2026 22:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350700;
	bh=b5xKkghwtd/9sbSJ1Sa+t+wW0ySYueLBxXQcjJmolAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYtwQmXipm17ekENNCj5ZZ2vlUdM2q+bi1qiNPTLyu7nYxwXXcWO3cwo/k2tJ9DXX
	 jv3FgmJUxqgELKoxxuS9LgJzZd0gb4R0md2ADMBxlSU46rBfJ0cTm4UhV2dDQ4ee9Q
	 /Atuh0sxLpRvMdTDSONZBxlYJyuRWd17VYTYGAqWcNurOSpFimC/ZpAlmPEFPPmq76
	 taIeESLahhoUDP9RftH7qnV1/TiT9NfPJRoqjb21G5EGKfuwxlX0HncX6whXKZ9dMJ
	 V82TeIRGLO/IGlF0h+S6ULscvQqu8e7GC567lYBDBUkaYGIeFPCpADrJzjwcy+/++a
	 5ug8N+JMsa8Nw==
Message-ID: <sashiko-outbox-207844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/20] perf test symbols: Add tests for symbol
 shrinking and session alloc wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-21-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:44:59 +0000
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
> - test_symbols_shrink(): Verify symbols__shrink() and
>   symbols__try_delete_unannotated() respect held locks without
>   deadlocking, reclaim the secondary symbols_by_name index, and trim
>   unused capacity in symbols->symbols while keeping live symbols intact.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D20

