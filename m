Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751510;
	b=q/jZcrpntupJungx7Qg0nOovQ/M3OWRCxdew0oakqUs4CgV4p/celavhQE9ceNLiPrXC
	 XNIfC94MmMR3iZrudEOk7JmnW97auiE9lS0bPNU6Sj0e17EFXwksWjbOwxfZsVLrCsWEN
	 oglTcZvfvH8JPOz4zr3XFM1m/jGxwqJj14Jrf/z0LGWUd4LsEbmKEkRcQwqRFuxog6V7U
	 QV88JWnMhMIF+L5UslxInL13vItnCxHNeIqnEgQKWHtoh1QRakivGFCXEZiOcQoQNAPVT
	 xgXdBvB2SQa+DT/JcmupjIMAXnfn7cIqpm01B4XXtKfEh3yBTB7cuTbEdFNVUHRuoNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C1oDoBmtxPlvpZsnA9NcDVGAL/IzU77bhFzpWIs9tsA=;
	b=owdFQMr/cDCp1erIUGXsj/gpzQ/Mlbb5t4HiGba6SdaZDNBlBNLbkFZ69z89CNRHwy4o
	 TH2y9tUMZlUTluYT5UurE9JZ5JvdSfMe/oCLMssTdFyrMJUwgNZ5hF8QDboYa2IyEv9ld
	 HW9f2afcwl/taJ2I9fH0eXvIUOUg9ww8BJd3LTYd3a09nMmwx2tCuWtBkXr9T08MI/bYK
	 hKcinAg1JKJTbqP+6YKi5YjaAyn0cxJY/JXXmbyFseQ4zQf2aKrBW5/9YMbN5EdrbP8W1
	 2AGANZy3wGZxEJI5LbUhSUdDHC+SpND0814ZsrqfdRNge42FXYRClQ2DxaArVT3+7zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyXER8o3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FC606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyXER8o3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF381F000C1;
	Wed,  4 Nov 2026 00:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751509;
	bh=C1oDoBmtxPlvpZsnA9NcDVGAL/IzU77bhFzpWIs9tsA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DyXER8o3KGy8dcD5y0/2+ybSaHBsaC13c8EB05ua3qdgG/jMTMRXCjuZY5pfpsdW6
	 NGxWleydzmY0ggFvKJr7j6n+AzxWzbCFIA/kJ8VOraEH31FL/1O6ML1CJPABX8/8q5
	 uG2KXmmcnQojcUgMExrvbCyi7whtyFKiUufMWJ0yCNygZGbmYWkDyJeTNftEkz40EL
	 6JuBT1owaUZ4NejmBZV+ertNlR7fDq8CmrajpoFs/Y/MsgfftHQt0q7IEClPXH9O4F
	 QGO4qhr95NPFhslTpWbDKBu6TXhDrhEux3vhQWMjnr2aDcr5SL6M42jrlENjdDXNyH
	 yPoUKEJ3K6SMg==
Message-ID: <sashiko-outbox-196300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/41] perf env: Add host_env() singleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-3-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:18:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf tests: unupdated machine__new_live() calls in maps.c break =
build
--

commit 7d73aaa1c355418d0246becdd2de8785036ea900
Author: Ian Rogers <irogers@google.com>

perf env: Add host_env() singleton

This commit adds a host_env() singleton representing the live host
environment and drops the struct perf_env * parameter from
machine__new_host(), machine__new_kallsyms(), machine__new_live(), and
__perf_session__new().

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 076d167380f20..7fae861dc6463 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c

[ ... ]

> -struct machine *machine__new_live(struct perf_env *host_env, bool kernel=
_maps, pid_t pid)
> +struct machine *machine__new_live(bool kernel_maps, pid_t pid)
>  {
> -	struct machine *machine =3D __machine__new_host(host_env, kernel_maps);
> +	struct machine *machine =3D __machine__new_host(kernel_maps);

[Severity: Medium]
Does changing the signature of machine__new_live() break the build in
tools/perf/tests/maps.c?

Both test__maps__merge_in() and test__maps__fixup_overlap_and_insert() in
tools/perf/tests/maps.c still pass &host_env as the first argument to
machine__new_live():

	perf_env__init(&host_env);
	machine =3D machine__new_live(&host_env, /*kernel_maps=3D*/false, getpid()=
);
	maps =3D maps__new(machine);

Should those two callers also be updated to drop their local host_env and c=
all
machine__new_live(/*kernel_maps=3D*/false, getpid())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D2
