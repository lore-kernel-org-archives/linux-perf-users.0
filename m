Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622337;
	b=ABazc6TgQJJXret2mhsQ5Om4Ao/MMnM0NA+UUpSbkvONiR+NV/++MpxSZUtdXapk1Ut0
	 Gvt6ap6NAJ3AIDb/FWIQvlPDLA2rZgHf5FlxlwgOToVAAjdemRFV1ZQrlEKpvXmTXH0yc
	 kpZMYkaVkxD6Wzmw4Fqp2IFgq8rEM74hCvp0dCxoHdv8O7aMQqijk8k2Y1fZRddCYMNuW
	 0YGztDd+15cXO0gQPKkcws6aQ6U8riUrilkrWW4zBq5yrq5CGbquLMxC43dkZl9mNolpy
	 m5om4v/kjdI5MoEjAC2rVpLZWjXb+ZgW/5NMHXXYkO7U48kcD6RvEOajZNiV4GgjItw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622337;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=63jBMDF8pQSvB/jWedzpgXPAtPL9LbDB0n7hQRUZfn8=;
	b=vnzS6cpKu2lKFG+EyYkqZ+hwSs9ctVQhArCknUMFQ9eGCRl+NmuaJ3q6mpROyqfN3CZJ
	 jNWskwWdPGCuHowrHhpVQNHsicrKw2uo2BDzTvXLhpvS8WETdBUYRQ4UCPgLi/e+nI0By
	 BziojDSf3je7IKXzwxm0l/HWIzWq0dclY70zpTEZWpr+iIgaarEJK1Gj9dDTT+vX3sHka
	 /moHn4vhNvAa9S0tAtS+2yDJRp9yxhjAMcLTP68QY7/BhL+opzOJX+MyXT6Sw4Bb1KNay
	 LTG5H0sUDoHRxYiW4c649vW/NIb5PA6L1D5Yzbf2o1YoKwV0B+i301oasZlVEL8abYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI9Lymfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A4606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI9Lymfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13DB1F000C1;
	Wed, 21 Oct 2026 22:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622336;
	bh=63jBMDF8pQSvB/jWedzpgXPAtPL9LbDB0n7hQRUZfn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AI9Lymfxxx8WeP7Fh7uObhrVRIHzy3uRehjYLXE0Kn9xqCCVs6VlOawMAbf1BSH0c
	 ONE0Ryw9CHnT0KI8sdFTa+QJJoxrCZHWPghtlo/T5jIb9QjpEYMz24tOJ9yCMyvk25
	 KCOql4vNaZ4SH13/kSV2UTPYTk9fh2+uUrFqU6yIuUUaVQd1aVZ+IPTQhduF2z5570
	 2K7XrxJRgw01r0vp76CZnuxAWZeUsEUYdnbz4VJ+n8weMZqfzlbQUMKoqhveFC6jJl
	 uGf0MmyoPqfpb9ThsuHY0J9Jok1SsnfWzMYPvYZ5Xyjyz6XzfMcK3LYC6phonSnK0j
	 JlSEmLhvWEA7A==
Message-ID: <sashiko-outbox-180724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] tools headers UAPI: Sync linux/if_addr.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-3-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:38:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   7cb8198761e6 ("net: ipv4: report multicast group user count")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/if_addr.h include/uapi/linux/if_addr=
.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Yuyang Huang <sigefriedhyy@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D2

