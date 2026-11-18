Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039244;
	b=yOkpCR0pNAA+TCH/l3/RjftgZ5vslgcdXRSZxKgbelHMKZmYo5zJEf5xBUzmxZyQDLPX
	 vOzqW9ZxW5YLkt8uIiRVgQZZhN7F12pYj70sudtVHjrZ4IxbQXr3ngrmLuXQcl0X/zfkS
	 fzf4L4yNpntHMuSJ4Ii6nf16pr98WN1qela1LailTpPw450Qe8UKBrLoKCMA8l61CtHZk
	 URY47zgaKcKk2fnS/ZYILdqXEEFoGh0RjNbqYJl8FenVRMn6A92F4QuT9q5H25kkycJ6E
	 XrYSKk3JpmFCojONWXGzuAZubHzido2Fqp0L0bN63ndIao1RQFW//yJT+IHbGuLrY1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZSdly1oJl857nbbcNurCStzW0SmVLdlzppLd/oaX6s4=;
	b=1A2l8IjQEQadcX+OdgdyEILk55q9NIl3Xr8zinA0zLo41UtmA1CC8jaqFqFiISnw6AS8
	 W+HP/nYRJgLuYIWjUDKnCWjPdvucctA5rHJGQit5ElwpLPPXgcd6XQXnRYFiMAM5/d7Ge
	 tGPkMCSgfvWbvpfxK4aJCi+kuddMxgvbWniBH3Mb4T2OFrmjk30oGCjfxJv7MlvoQMsAF
	 FyhnRGEEhrRKNORfbx/MIHtSdPGIKdlePYdM7hwbT0mTGjRrZ0YWzvC6GMJEE00nBnm66
	 dDdzw+NSV34hoIqvC11nu7CyReb0upyhKMiFr5Ich7NJ8V9uRNtnfWdlX3VrbLLLBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNMTBgwK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAC606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNMTBgwK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A0C1F000C7;
	Wed, 18 Nov 2026 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039244;
	bh=ZSdly1oJl857nbbcNurCStzW0SmVLdlzppLd/oaX6s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNMTBgwKe1FSVBKRQL/3ckKQFJZCQmGMGvImGRCmd50B6kGN12NAgLGhvVyHx6gM3
	 OyDyWMKXzAqUOmlUGDPJsRpU9ZNiOtXYDnfgqb7qTBTSvAeOFt3buTrsjFlSGwjHMx
	 90sOhCcwolX9WxDWM97BgVr0+MS3LoGP/j8eqgVqecq4W0jnmJIGJ3WTks/eVF4ZMH
	 ki+00N7mc0ULsoxBWkzWjKDpQBmAwv27IbBzKoRc7ia0Dc/i96bs4vNajS6baceDRb
	 gyOsYz1DZXK92GfiN+6k/wTnrBjhq9qOiF/F95qEBv0HamOwmfOX+7pJ3M8vMORkKi
	 xuHTbNsKPOI1g==
Message-ID: <sashiko-outbox-222064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/13] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118215716.114868-10-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
 <20261118215716.114868-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:00:43 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118215716.1148=
68-1-acme@kernel.org?part=3D9

