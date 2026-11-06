Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949165;
	b=fqSFz6H+gis7fhBITeXHJxBvCfO5HT4iVGP1yrLR9PqSzz41/5NExTAURvzJvnImaUkB
	 3diWoZzohkk2Pc1+zsHsN0e0gkJCyHwsibi5cndCZGzMM2DMrbdnnZxunGltlOU9rm84L
	 VlifaR4oeXwvSIBIQHRKGSHfftsVyNDCMueHTw+lK8SSxUuTVkzNDgWfe8T79TjrP1lJI
	 YC73j9mqHTOjY3hTX1AJIrH8wDMPn2Kxav7T9hdJjU+czSZa7qEqZ4KZyjQQ14ohqwmcU
	 f3b6xH1DDu+t5vy7smX1YxJKYkxoZNqewgCL8otrf+sHvfQZEW14Iu4ExQzpkqpN4mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JmAhZvDI692DDSoF6EjDHoJn6BSNWG1c/fwAskcSwMA=;
	b=QOHNPExdsj7EjpPZfecJZLmNRpfVEIjIXDUuO+P986yea8ayBB8LHjKzqZNTe6oMukGJ
	 gDsyhEmm+Cw6RnbUU0mrgN5qBhoNtUHC5jICgqFcZOYrxvp9+7bbHISc/1vkFSyqYetkn
	 HqXMLbD1xf38LGeRttJZfwK2/DoxEpI+AWwmsEqlaDzjwCqMFPpXI7bHShZNYKoSSQzIs
	 W4jlDXi+KTPC4TUh2NhpDTTFuis1JEMYpJ2Y25revjhNucaIG6NVDVxQayhrT3C2ajkuu
	 uLmaGcsMc7VSs9F7inBBob5HV6CTcfqi0qCa03rXvGEPR4dtE4ithCt51JrgXC3bu2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWbbnMJI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D6606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWbbnMJI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C21F0089F;
	Fri,  6 Nov 2026 07:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949164;
	bh=JmAhZvDI692DDSoF6EjDHoJn6BSNWG1c/fwAskcSwMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWbbnMJImaQBofPEVuo5qBjvKaD+QRg4vnWTrTr1MBiTvEU0ByJqEKdz26bpSKKac
	 RmGOzm9YuTXtxkR4rGA00mUntbzch7Oqe294/9ml/vpS87c/GFvH0fSNtqkdoZCbb3
	 5v+EHXC9Wh7060gUnPX9iECKHdEkXOkc/Ouh4uTUaKJvbqIdtRQ8/Stfd636W/2Nlc
	 uMbFxQX7LxbyZPk0jkO0E57DDy/HN5B2CrfsKHLARs2InYwVK2W8j1Oh9HBcTMxi/7
	 jpYtUw0X70LJJGt3rjqXOoc5HOf5xiqWIH5ehlvvKVTDuTazrM77QLEDZY84DH5BKg
	 oC7mftBRnVJkQ==
Message-ID: <sashiko-outbox-200972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/20] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-15-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:12:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D14

