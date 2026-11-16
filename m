Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873005;
	b=xs3RLqCw5S0DHNSSw1kPnjTK2bBBmosjFPeHtgm+BNJhHnffHzS10ZoAWJK6l3l7Wr2H
	 GzSgHPqceDgvB98jKxqOOI9LImgnCTAfal4R1YONyKl/mnIgnshJ67UVfRxhL0GEgVOCX
	 iucTtOK6l92HfF80bfRI7v2EIWytDoYvQuV1Mcw+ong9A/DRWKvjDnY82i8KoQE7vKWEO
	 CFYZhVYezh3KwShuw8A7XdVjINLXvSenaR2xWLh+LGIpOunl8KK+01ZJJbL0j0Hk0bHxf
	 KIDDTz6vWckbboJQXfQjK6lj79KcK/5x1uESff7h10B8TTTauIany2BZB5ZkTL4NJhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oVaiTo9+IO3/hvihsWHa7aaH+PZTtONZBvDfHg4EQGE=;
	b=bRIq+8C7QAvnTbeYO28QxKZvIL42Pm85bgMKxLI7EbIR723A/XVewoX12tJqkXtybAz5
	 9GA1Cu1p2VLMu3eXfo1zwj1qLkkCUaKRVwBK2jHve10N0HL0080Uc3y3JM7cIr8AvPOl5
	 Fu0FaDS1oBDRMkonqqDtJqClRWQGHMt50HX28X0SlkUmnlKVNavCAGjazSY27ApXUnMR4
	 n/n0oWPE4m9VNa1mJndum/WJK3c0FAkU4YZRHsgbSJ66WD6bvSALYJ78mswlEZ212zx8V
	 zqOq1SuwUcobtejkXrzaKBBdu6S8TSoF15ZVtBMZJoEpdaaH19NiO9HtUQwUKV3B4Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvVNUfxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F556606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvVNUfxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E631F000C7;
	Mon, 16 Nov 2026 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873004;
	bh=oVaiTo9+IO3/hvihsWHa7aaH+PZTtONZBvDfHg4EQGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvVNUfxmolKEy+QV3mShsgGqCn6NO20YWhZEjPFLLr7TOtmiS7sUjmQAYJWhtQIhK
	 uU1yoSGaR6ocIhHpoQOf30oiMJ6FOVFgW2LT7iXvWDLIul+9dfdJcDXDE3JdOEDT6l
	 UPgFa5kc7qbJHBAh5yjQw3oml7yHkjFEZMWA+yFC7QZnuIsbHwPwGnvfsllHNpuMq/
	 l8KNjF21U0zT9IXvxWPeWL5RjQNOM2MSzTVTDAIBxfTpB7qXg6nBvQ7JpkSkYp3XQv
	 1FFt/bP5ZYcNSxvHOeAaxLNSS9N3P1oAAz5fzbG2j4VJ60fQa5NTDAHPrUoUNzrre9
	 SGb3294V3UgDw==
Message-ID: <sashiko-outbox-217929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-9-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:50:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D8

