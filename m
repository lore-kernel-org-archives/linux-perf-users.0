Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946108;
	b=z63CUnRjAKIF2bBOHbW3CjTIkyTwL9fKYbL705jion0pdEQPj58+IWLsqcmXAfRnL4z6
	 S7adSmECHLrBXR28XmW89ZkjuRAjf0HvOYH+ZmNN9a3Z4ne6hE7SAtCUp0U5cDT1Xi5zG
	 f7TuFYasWIxhQXk4rNUL0DH5UE2UoAE8KttaW0PuqUIBUXJQmdbZG2dGHsQ6UziHNlERt
	 K5O8TgmoOuyYrT7/aEg4ss/oWzUx06ttlK37Fzp5aTYw+cAaxX3l6RAF319Z0J9iVR2qZ
	 xlCNFycSYx30dv+TUZkC+fC9ehCC+00fzCVHK+vQ6qTYDRuTNUhYMBXbsImHLIYXeRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hrAenPKA74ww3PAKYEqOt2zTt42vQhBdyA2Ec2xHZ5g=;
	b=agmrOB0y1nWeIXXG3mTZ3bdOgWkS0vZt8EjXa1rmxml/tKRQRvutmgMwzGkZV/ALp1Jj
	 MKYpUVyDTgTGHFbcDyKTkPKnVvmZmDcCatlkhjg0vHF2TrcezRJsCQn/EdEasnuhKJoHB
	 wWWhZoFPyNqE2TpNgmWDp8jELZqZ7KWog3fe1h56c6tsinmaKG8Jlz4MqrDMeqMXc5EW6
	 N4PT5t489YuLAlbb6o2XNgPwnM3S1t0Gkjk5MbSA5F/DKcozVWTCgG2Bm6TkRd0MdmBwW
	 XTZG0sZH6unsE3pgJcNzWfmPEX4EzoXOqib/Yi8mEyiYF2n1c5o2qE4tszAY93lSkjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h6/N0QyE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076B606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6/N0QyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E50E1F000C4;
	Tue, 17 Nov 2026 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946108;
	bh=hrAenPKA74ww3PAKYEqOt2zTt42vQhBdyA2Ec2xHZ5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6/N0QyEU6cO4t2LdtPQUpB3bJHGUviTeAcG2ywWYMWp+DbPjpv54DE8cKDWqv+VD
	 zNwP1Pe5Pur6OkYYOq6fXJK7wQzKmbHDqdwScxzZwa/HyymrZvvhdCmDB5yxFYnox1
	 F70BtSD17tm2fXxOIXv4TNKvmlq8fHr2IL6mnxsLIF9y7skC1EMwU2SRV8d//5FuzO
	 J5Uxkbr3Iy7palPonhVdZjUv/SThqvSKgue2F8Hpb0Sw9FNOO+XdLOHohc6Er+9Vwb
	 /iwE5ejnKc3ziSB+CndHFUgUyoAYqSxphZL5WwIZLlpXG3Bgh0VnNkZJz7lSarhksp
	 QjcBvCDQJqbRQ==
Message-ID: <sashiko-outbox-219565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-10-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:08:27 +0000
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
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D9

