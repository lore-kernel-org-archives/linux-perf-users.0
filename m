Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703516;
	b=FN7a7hfKTyV3U19uNrrlR09dl65l89NTOPjT/b2irVVdpgAVRIvfToVG6y9DvTvTRkYr
	 dkQ4cR0ZD/qpPn8x4tnb3Zvh5+bnlmqbAaep30pPTFoCIUiA+Md6isCNaMzAPlN/+tT3O
	 yQ4lQC8wNg3+GMI1bQ/PN7mt6nGc6f6pxMPCI9na1gagQR10Dz6XohnLjPHkIz0dXCX3Z
	 iiNaXifa83oJDk3YQTPPOl/NZv9dkIXZ9Aa9FlM9QFjIoR9eM6CVZNjCD1gdB90f3THUs
	 bSX6Sh26cMveqBEigi5dsYYtxQ1dAkRZHemPucW8YFVQY0YKp3EC+bGEOQJDMM4IMOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2MCP2APTyPtfZ25pyrzZYxsYIzEPK9q68q7Q/BILmIc=;
	b=vl0P/XHXvOooDZtTRAyaRp8CsQ2XzeM4GEVH/gMWzaEGSJIiCBvbB9t9sfJvhm4IKY0o
	 q4eu0OBLaIk6Dbhy+wQiookh2ndvlKgyKpN5JGzsRIztHh6nxkq0rYkQYwjbPZnJ8DBjq
	 aLBMRB0zWhf5o3c1ZobCJf9cavu1p2VhyNvt2y7IALvbhGR7zMXe5hvUxG1gWV9kVy/U1
	 0mPEtcMVH4+XYLB9/6/q19daEGNVZ1Y8oufoWvwiL6yp8fv9yAGlUEkKzwn2u6VyCFi2E
	 yWA2WnN9l61PKsPbW0NPljc1+SU7UvhW5nFKrXOa6kgnZodSSf3al7qD+3r2kJBaiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrN1wJj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6081606A8AE
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrN1wJj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF0B1F000C4;
	Sun, 15 Nov 2026 00:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703515;
	bh=2MCP2APTyPtfZ25pyrzZYxsYIzEPK9q68q7Q/BILmIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CrN1wJj8M7uvDmpJTvoZmDFv4Z/7Xocczse+zA/9lMXlGHja26gavVjX88pjMBZLI
	 WWziALiVHPHmdfc9Rrc5WC6uZbnh9ZT2+hQxAkZT2z47QK1elkab8sapiAyz3Jpltx
	 5bn/GHF8bNAV6h1sn1n6RmMqalj2BKpXjEeYofnCQsALQPTsWMxOwmWjfEnWLDSsoD
	 bI8jyq/0KBBHkYAUvdpJmz9swnghbGj8XYMh8EhgTMBuMGklm5/wWZIdMF5Sicylkt
	 BjHL+OSPr5zmLMrnpe0EEVm3M652J9pHV5IhxRc2+Fy44haKu/+Pod7xw0Z2HShitm
	 FTfS7wceBMcjg==
Message-ID: <sashiko-outbox-215156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf python: Compress the traces of the perfetto
 script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115003916.1873857-5-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
 <20261115003916.1873857-5-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:45:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Perfetto reads zstd and gzip traces directly, so compress the output by
> default. Add a -c/--compression option:
>  - auto (default): zstd if Python has compression.zstd (3.14+), else
>    gzip, so only the standard library is needed
>  - zstd: level 9
>  - gzip: level 6, with no time or file name in the header so the output
>    is reproducible
>  - none
>=20
> Without -o, the output file gets a matching extension: perf.pftrace.zst,
> perf.pftrace.gz or perf.pftrace.
>=20
> For 4496 samples of a two-thread workload, the trace is 127KB
> uncompressed, 37KB with gzip and 30KB with zstd. Compressing takes a few
> milliseconds.
>=20
> The shell test now checks every compression the Python running it
> supports.
>=20
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115003916.1873=
857-1-lalitmaganti@gmail.com?part=3D4

