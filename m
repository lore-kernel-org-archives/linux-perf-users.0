Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726062;
	b=iTemINSlcj2nUjn2SS+COnv6QC/zurGcUJNDdcHv2klr8gz3cvonBLKVaMO2wHC0wg7e
	 MzamyOLYRRBgqyO45Hnxck7R4wMwBRvMzFSmn4VMzGrdtTFjJ8QzJEuPbwXjcn9mVdGc2
	 ZFVlZ8Wbp/MUplu14T4q1U28tvOzIm7kSLeRhCBIiByls1tKRKEhT+nYQuM40SIaUJ69w
	 PzTOx47WCfycb0BjjpI1KtNrapk6JlnF88znoBRyOsbH083RdVwsGQpp/2irGMnFh6OYt
	 tchR7oNKmom9ZMnyEwRWs3zee1WVMIOITk62oS3Cy5c8OGkyDrfppSGr26VrBesn6Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EDVv/orCvShxDsQ9Kyrmsuy3uuo0NtaQFUoA1nCo3yc=;
	b=kyMVNYA6TtBxlZq7IUS/R+5ZEqFCsQwy7J3qy6Ls4ROieoPuA8PVW4bXfTq1cfFNbo5O
	 AxyiQGbtB0btIuX2Am+9eKGBf+2hZxZedUp1hCuC2qoBLY+R40EHzTZQzV7AEA9weMIVT
	 rIkKRn+YC7+pGiK1PSihEUBbhhVmDO67h/GmLV4Zp/7luxVhYuHap/CVl8r3vRl0Re5q8
	 CwAYP7W/j9ThLQ3d5DIOJ0uE52Bp+lePgkUXVs6gOjkI9re/LaRWKKZTpLX0KJymMWV6b
	 RkH16MGvQHGAMwsLi5DeeUP8ANXZdVUch0X8FykWLl3z7wMyTKjQ3ZsfyCaU2D4M9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL9jvK7o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF57606A32F
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL9jvK7o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F7E1F000C1;
	Tue,  3 Nov 2026 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793726062;
	bh=EDVv/orCvShxDsQ9Kyrmsuy3uuo0NtaQFUoA1nCo3yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL9jvK7ok1wjw0FlEvWTnzI9YPmiLMH0dm8TKGDS9oZrEyyj6zKcrnW9ljSafOFr2
	 a1oV/aXzkD88esR7OcXcSSlX0ERdI8McgWUu70K7ITIcksML46uP3ukwHCmjX6lNkT
	 MiVomUciSjjpUO4Qyspe1DXTPZ54C/klxkqHePHNluhTSHkyol408cRGOKBF28dPeQ
	 yeTHwiVu26YFZ2mIC7BDqfBsIqddGc6JvQUeIrd6nq7Sz08GtbftN129dBCxIvl4V5
	 lJX/iiyFpSEbniFEgwiAahDqeMkQOGELakwNiauZckG6u8wqJLsQTR2LoW1apINhRU
	 Z5M1Yja2c+qXA==
Message-ID: <sashiko-outbox-195780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf data: fix inverted strncmp() in has_kcore_dir()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103171127.1628-1-gubin@cmss.chinamobile.com>
References: <20261103171127.1628-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:14:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> has_kcore_dir() scans the perf.data output directory for a "kcore_dir"
> (or guest "kcore_dir__*") entry and reports the match in `result`:
>=20
> 	result =3D d ? strncmp(d->d_name, name, n) : false;
>=20
> strncmp() returns 0 on a match, which coerces to boolean false, so the
> assignment is inverted: `result` is set to true on a non-matching entry
> and false on a matching one.  Consequently the loop stops at the first
> non-matching entry, causing the function to incorrectly report a
> kcore_dir for any non-empty directory even if none exists.  Only an
> empty directory or a failed opendir() returns false correctly.
>=20
> Both callers in perf inject treat the return value as "the input has a
> kcore_dir": they enable copy_kcore_dir and mark the output as a
> directory, so for an input directory without kcore_dir the copy is
> attempted from a source that is not there.
>=20
> Negate the strncmp() result so a matching entry sets result to true
> and the scan continues until a match is found or the directory is
> exhausted.
>=20
> The prefix matching is deliberately left unchanged: comparing only the
> first n bytes also matches guest kcore_dir__<pid> entries, which is
> what the fixed commit intended, and matches the kcore_dir* glob that
> copy_kcore_dir() copies.
>=20
> Fixes: 65691e9ff0c9 ("perf tools: Make has_kcore_dir() work also for gues=
t kcore_dir")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103171127.1628=
-1-gubin@cmss.chinamobile.com?part=3D1

