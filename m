Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607305;
	b=2XXMFnsO0rTwLrqVNaEGbKl/qX7OyxEPsNeycoLrEmwpsyVazc3ro/fJXsZ5FzZsV4a7
	 5WELa0fNpT8pvHjcb7wzrjF/9DD1kZCOZYMBDyykcRpyIHE/IDbJAHc9S5CBR1zLUFUGR
	 q437nUFrq8/DGjXZlZpuFOFWQcBS+kZI/0lFAlP8tmdIW3LEqZ5nwPxz0yJHhS7OPLxWE
	 NNzM4SMmQlAwHNwORDsWq4iVLjuFuFnml0XKHszTb/dYtwT9BZjwK6xppajOK2tOthn1u
	 p1KBw+1AC76R01Grr6jyzaRX2yYGNRlFI8kGTYvSz7G8UjYozh7EVA2NnLrQFD9x73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e4M3kqE4LL09shjeE0NLyBUUtU3nd/GDZdAxiKl6kK0=;
	b=tSGpFyuoPDuyUzXrAmQQSjFsCf+ZOY12V6223XcJ6ZcvLbXFVkIXbATIfo9FALlRqwjU
	 y0rlfZpxsNQXJRj01Vli1Eyf4Mq6SoDKJ1h2k0qBucEBrYw4ITbx57lpqgmajXkhgeWuC
	 SATVT9RvyeN4gmBr6Qp7IEUmtR/zVqWBM+4Op/0u39z4oiWCby1xyfN7zWmeDkcYtPnza
	 jxt0pD3bxwmrMsMjWhMOXnphesYM79T1l03GwOmdlWR3t0KRD6AFZ1K50SQCu9YLJGn92
	 zucTEMs0AjhiGJrJ7ePkVOazgzetGxGbR+2f45hbnvTFhzzWSDfn2wJeRjqIUwyoGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjX3dc3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368B606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjX3dc3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6228A1F000C4;
	Fri, 13 Nov 2026 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607305;
	bh=e4M3kqE4LL09shjeE0NLyBUUtU3nd/GDZdAxiKl6kK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjX3dc3MLTpNbsp6RqooSPOBkiYBy7IFkG+YWPUpPLOZQznbkcfTeJvLM2eJYALUA
	 vlLJ218jWZ7UkIIvp8S47w0N76f5tOfFHL2GYoGzuTybMNjK+yCwDsLwQnBMQa9/jO
	 KGRF2pkFVaHsG8xCqugiNCX/hv90MGzxG4fxXfVnH0Dx+YKAKW8+zcHtnhGbQfN8HC
	 +D31x8bZ+7Z7/RUGsR09ImB9Sg7RwjY6Bwzfuh8gFZNTwYklk51tiYKzEn8nq8mUBy
	 raoxYqnQYv2ZUIAFKT5YjihLbZOR5wygt46sZ04t+eZVP/0jYPQJn3lKT/I1GNICfA
	 Lz3f6+L96+fVQ==
Message-ID: <sashiko-outbox-213767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/26] perf hashmap: Remove errptr usage from hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-8-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:01:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The hashmap implementation in tools/perf/util was using ERR_PTR to
> return errors from hashmap__new(). This is non-standard for most of
> the perf codebase which prefers NULL on error and setting errno. As
> such it was a frequent source of bugs:
> commit d05073adda0f ("perf trace: Avoid an ERR_PTR in syscall_stats")
> commit 96f202eab813 ("perf trace: Fix IS_ERR() vs NULL check bug")
> commit 9f3c16a430e8 ("perf expr: Fix return value of ids__new()")
> commit 4d4d00dd321f ("perf tools: Update copy of libbpf's hashmap.c")
>=20
> Remove the dependency on linux/err.h in hashmap.c. Update
> __hashmap__new() to set errno =3D ENOMEM and return NULL on failure, and
> update __hashmap__free() to check for NULL instead of using
> IS_ERR_OR_NULL().
>=20
> Update all callers of hashmap__new() to check for NULL (including
> missing failure checks in fncache and
> perf_pmu__create_placeholder_core_pmu()), and switch IS_ERR_OR_NULL()
> checks on hashmap pointers to regular NULL checks.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D7

