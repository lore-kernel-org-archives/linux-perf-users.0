Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884200;
	b=PeScTW8edB+USVwiZ1E2FT2JB1rO44du+m8puczd8nhe0zDJRT2+0D6jlnxYaYii2/6i
	 JpwWICVzkkG59StiNh7fdG13EZQgr6eTk+ljVJ6tjJ6OVvVvRJm30a4MHS1OUzDfo3MeX
	 XnB/9wz0P8zBjKcXCYjNUFBrEV4jq/D4hzvJpvp2bVn+Jiy94OgqJhd3KM8P3f/1TzzWy
	 L1N4wJTSOrvqttwwdZNzYoj1pbqysWOTulUZwXCKLkUzRdQqcBfeFjxzajQj5BfGTMmoN
	 LHFmYCrWVMERdlj8bKG5oplasQXTYq59A668972hIO7NsrPg+C1zcsnhN7J3ahJYQbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iwQZXw0Eeivn9I0makKg3kvByXmII5T9QaR0c/EIbIQ=;
	b=gkVUuKwr6uGkiVEoKyMWuJkU8emvNJPLrMBFEirvgNvvOsN09jg3RHCUefMTNIi1DjVY
	 CEjqT0DSshdrRjiAaTgzpZSsMLzKE2jy2XimHmvDlGIGnMGgSwC8hKN40lN6wN6+L3pIX
	 EK3My1FSimU1LaZxjc9X63KIsCZ0EcMbKN/8H8zF+64OMzhJsbriYpvuljwJ200I7dS+j
	 CMnBcYQi4Eup8HJsUuMh+TxDkIa0OQ/czWd0ao/GgfhfiCD9gm8B5VJB709IR+96zgyN8
	 XvyEnL2c7LI9H2hf26HTnhd4N7tloa+modC0o4uCt+qQOYlJe3hk5NP3B8OEBz3pgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khY2DOxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB7606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khY2DOxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AB11F000C4;
	Tue, 17 Nov 2026 02:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884200;
	bh=iwQZXw0Eeivn9I0makKg3kvByXmII5T9QaR0c/EIbIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khY2DOxtQcLtbqzYxmroBCG+05EtcNc/vYaGS18MvILzQEEhcsPaEeB9g/T1k0FVp
	 WH9rp3VnNALuw3K7/vVudnS/h02Bls3satJWvc1Sshn7+Sm5ZOFZsIPhEIbAHssjod
	 bAwso3tp7NkhqSg/sYy7zvWw7V5Sz9PleGd7lb88shq+Ku6BTtryPBHC1Zds5jozU3
	 slqTtke2FLqqpCbUAwypU+iiuGTx7DEmrbnyY9XR8p9G2RxJNIXD4r8U+28FSjAGlX
	 vT6nZs/2E6MtQAWvmLmX/QOIIDqkB9ePok+R5FWIT7N95Ykr+BNSnf+clVD4Fc8v8X
	 prENUnUqkPKeQ==
Message-ID: <sashiko-outbox-218101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-9-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:56:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D8

