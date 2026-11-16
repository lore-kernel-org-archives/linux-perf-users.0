Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813604;
	b=gBwzRlDJDSNihDoiqHiK67nD+vymUz0UE4gilEUz1Df/hCcEFFHLd8K4lnqmph7hW/ta
	 8VNzCK1n9x/wMGseKA8YpwUHpLj4zYknTa+OqSTxfWtiILrqMeKnshV/GzYPQSw7fqirT
	 3PdHmoxorFNl9e2QhKt77GXaREq9oqQ1LYi7hebjKVOplm0/UFG1xzIMrQk4pf7+AIT9m
	 gA2jWUSrYFz+IFLj1Dyc174eVEVCHFCz0OuBh1Y6aXIunYLWRJneoBgDr3f+JEZeyuNyU
	 IBm7MwCpn0vTiWrwOMCsgkV6WLW120dAQrzQoN5tztCI08kpkc5nFrz9jpJEiHC1ffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vnwRPll6DU6+vvUy7+V7CjMVDuNot0bEh8DxJ47ovmI=;
	b=b5HTPFnDMeY6vxQ44szXRu1f+K5Per6CBMoeqLiD5YMdIGmU4U+uuOhD8IHqZ33ed3UT
	 K6c+UmatvoicZeYKBDH9OFqEb3S2HsmiBl+2nEgMiSZAfaxfMdA4YoDgN9lK3nwetBKg8
	 Y19KvzKmmHViaqjwVUCIFQjm2b/BUuCA2jqj1ep1akwJgMguSRsrDYFl/aqp9zXRKVGCf
	 UvGB2tmRT6RlWO+5rkAGodLsrwKLQ4KAanhsUy+4fh/xX8STY8xcEYYMbshV6tXIVVyt8
	 mGFAqs4GkZENmSsjcWzXlKeXOVqcIen5qHmePaEIHYq2fLOAQod6QGsAg2Eb/I0RCWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opkdUXwH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A87606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opkdUXwH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616571F000C4;
	Mon, 16 Nov 2026 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813604;
	bh=vnwRPll6DU6+vvUy7+V7CjMVDuNot0bEh8DxJ47ovmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=opkdUXwHaeHKKFJGPryq6UMMmXLAEU0N8DEvtUHQqtr22lyJ4JwZFMNR37LiqDiAC
	 Gep5Pu2SEKn03hsB3cC9FNgl1hxTW9dMFQ2Jw9dPWT80BlI75ZR3GM09GVUCya/VK2
	 joFS+540ceecJXI0qt3/gQ0WJkKDS+1rSU2ycYvbTRH4zLkfcfzlo9THxohynLshJd
	 DLoXPT+Lzr+BYCHGJyFFVBklIq6FX/QcDVe1jdOIXZ7Sxu7oME5r9mYQiStjcxXN3x
	 VZOGVw24jzn/BQ+SfEuXIBMrxAerIALyzDk6yqPgFQ8aZHf28U1UMFjsHEcR+rzw93
	 Jk5UbO9g5kyxw==
Message-ID: <sashiko-outbox-216403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] perf symbol: Switch backing storage from rbtree
 to struct symbols array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116063435.2817923-6-irogers@google.com>
References: <20261116063435.2817923-1-irogers@google.com>
 <20261116063435.2817923-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:20:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, DSO symbols were stored in an unprotected rb_root_cached
> with a 24-byte struct rb_node embedded inside every struct symbol. That
> design had three drawbacks:
> 1. Embedding struct rb_node (3 pointers, 24 bytes on 64-bit) accounted
>    for nearly 40% of struct symbol's fixed header size and scattered
>    symbol lookups across non-contiguous heap nodes.
> 2. Unlike struct dsos and struct maps, the symbol rbtree had no lock
>    protecting concurrent lookups, sorting, and insertions.
> 3. Deduplicating symbols, splitting kallsyms, and trimming excess symbol
>    container capacity under memory pressure benefit from operating on a
>    compact array under a lock.
>=20
> Replace struct rb_node in struct symbol with a locked, lazily-sorted
> pointer array in struct symbols, matching the design of struct dsos and
> struct maps:
> [ ... ]
>   After (libLLVM.so.21.1, -22.3% load, -8.1% memory):
>     Average DSO load + sort: 61.074 msec (+- 0.236 msec)
>     Average DSO memory usage: 8755 KB (+- 1 KB)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116063435.2817=
923-1-irogers@google.com?part=3D5

