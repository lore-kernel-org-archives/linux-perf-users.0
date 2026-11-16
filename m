Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815142;
	b=vu9rbp0rH0H/u6how4U45lZobAEb4Nzp4FGjVBNw3+ygqdOrQhAme0ComPdTHJDpgaSe
	 BtUs1/B/qpEKYx8dzf0a8WrfB0vBqUnUp0+T9iN2CQF6QWwQx3Kp5q4XpxJa1FKsMqYpc
	 bdwlQZQMOtkAoXYYKJrNX7t8SQdWc7LJ6cfUsVwM8fBhZZNxPUfkExf253gkxh3G1xyZm
	 ak5grv57+h5lc8nq4SGJX104wCJIM13EO3VAPBYvLdKWF4MrwuIjFGJnFWcdMdPDXu63d
	 1EcONH82qG93Z2CEI+Bpujw+pdQsBVkoRyL3cujTbBs82Lp5y3E+3Eu065rTa0iIFmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9jDE5PzznlGWRPZd5xnd0POtbNAabStCgrdMLuwobXc=;
	b=M25QNj/v2D5h97FIs/5vIUwaXFt3DYzJciLD6ERRUulzzoOwFw+DhAtHJepHKrdszOts
	 tASbXB+/lOHvp3HTOhlh7TgQGS1YeGkRuZHeQDaCa90rBDn9NgBeJSeUXvV64j9Up92xs
	 aDKy9NRcJEK38N8gdaG0iJ65AODgJ4euGz0SqtUSXodXrGG5K0GXa5FYD8f8QwKnc8C6E
	 5r/BRhjH9AiClSzNYDkyk2zo9Q3tpaxQCCYrfgAcQYAbzbEeZBatVGBN9b0hKUqVxjL6G
	 FyADENIuMOXsuoo+EpkrYr3b2Zvlm1UjnT4eJkj1PfoIJEGQWTVdDLMrgjMuRt2tDlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oWn9jk/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4A60A2625
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWn9jk/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2F71F00932;
	Mon, 16 Nov 2026 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794815141;
	bh=9jDE5PzznlGWRPZd5xnd0POtbNAabStCgrdMLuwobXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWn9jk/dvy88Hwqdlf88+GWtIIzl0AagbIEw0n4E5VjPKEg4hEwdszxOGc2PsxWIB
	 02UoliraV2FBACIJRu5xuvhLGdg0OLeziHC6giu2ikH/WRPTAMdnGbxVc0VYpalki2
	 sBffE9F1iWsNLQmld40gSYYd+W5CK+CcSkKcB95QqYr3Htyk92mwA2MGiucVBzI0kG
	 9y+aho1Ucazp6VpaSO2Fzk4nBFN5xFjNI8rGhYACocxgFEXcmsjUut1g/xumGDigvt
	 GAsXJ9JDYoIy5khcI75GLaAtVirAj4WsdDbdFfG38IQrh3mJPxHzhC9mGVHK73NHBl
	 SDSDIfdKZ+XDA==
Message-ID: <sashiko-outbox-216456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] perf test symbols: Add tests for symbol
 shrinking and session alloc wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-10-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:45:41 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D9

