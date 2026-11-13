Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591465;
	b=fgmxYugVO1hvd7BAbLK2RJSdg3WlYh5I1sWk05nWQy2yCZ0+1xMvkfc572z8vXWvdHwH
	 1qCd6Zuoq8EfOWTMGGH5ll2kn/P4dDPa41SKPhMh4kXGSd5IZ7m0mUDyDi0d3g8E6Fh+V
	 fkHWt82Z5FVr3rqkYz2y6KOMedPFDAJ9oydlj9H0y+y+jlnSbWCARfpCJKJCj/PgUISZ/
	 Fwp4GoBBDXRC2OP6pgzHIvcUC2L5RdEawDwEN9zhFN4b2mCnzCNEQA9PHBzFZO6KFlU40
	 gOVSerfPXhcMZhnl+uaBQJ4uFmOXfOrVidXJoYQF+JWPRyBM5+bmeToil1fcpn2Xz9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591465;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qow3vVRgLvCcnMnguYsfKZp3gcewxnvM8Wmr5G5iya0=;
	b=E0m1dqbz6bGxJnKldG4lEfa8+4u+GgvzjTF/8TR8RdwfFxSxIwbai0qews2jreGU7DPm
	 dM4Lkx56ZBxRlsaxKKKdqXUHK9v+55xFGAs5IIZqafPW3G+pcyFFsC0Ld/lvuSxgh6YZV
	 MAMyx7FHeGxauDOXoPw++Vj1i4vh2SZYfRaXfgauwS/bvJXH6xZiKMuZMJ3y6wosBkY0c
	 b5XXWL0Cihej/vgtDrGispxIr6AFE0tfSGvoCzLERbRrYdQQhKTxrMF3u3XAjOL0W+hNd
	 +p4yTN9dlz55sh9Pe8E5XB71dS1rlfAj/QhWk2YQwK1/W4qxWKqqGlsLz4uU0AQ0GAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Io+sbfHI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4F607D2C6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Io+sbfHI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC5A1F000C5;
	Fri, 13 Nov 2026 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591465;
	bh=Qow3vVRgLvCcnMnguYsfKZp3gcewxnvM8Wmr5G5iya0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Io+sbfHICZjbic2/uBuSCb/X6mgpN9Na/E8zQjvAjqbs3OPiIfIobg3ReS+WtvHmF
	 yxiogmEWDGltqHfKW8oZan9fR8o+Jg3PC7JqE1WcPjJw68EbzkY2zWaE/cqUtyjXhY
	 cPi4YSbSzr7W9DJ1sGX1ilqs2XJb6pGtFJ5zLN8AQXfpy24dxsMGsjZp+mCYmOC8wF
	 3SMENamPLG1EkFVKejk8lZ8sjLj/8qH5IOwUg3shdx4SOwVKk6tABsnPw86fueSqPq
	 HobeoF5Iyal7+CF3GUDl4DFsF6oIJv18DzxqzWopT6Gqp4/r4ws0w0vqfBPtJTcXiX
	 90Dv9VGAzCHew==
Message-ID: <sashiko-outbox-213333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/23] perf test symbols: Add tests for symbol
 shrinking and session alloc wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-24-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:37:44 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D23

