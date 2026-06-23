Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C53ACF02
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249609; cv=none; b=YqdErWWswB/kn2sPMHn459pTXjs/D+OPPvvYSaGN5FOEWJ+4h8MZIXZsorDF3t8LqX7b2aWg0xa7pYvT2pIm1knPFrFUBsWzNTVG8MUSz8msNH6c7/NJs9KRI1OJSrYGHmSJAMfSquBKXWpw8Sb6Nk5ShQr0Eg1EmK1F5kjH6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249609; c=relaxed/simple;
	bh=bI7PnSjwjBzMiUTn7ki0g+UBhaDTjPeIO7PJ00UJirs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rg9FhrjNKOVwziWNm1tghIZTH2Cm1VP34LpzNahZWN3/pYA9ZwolUFcXtoISS5veMncJ4g9FsEPm2w01HF4QWNx9WTw10j4onruvZSBFFIoZe7idwpt7GMJvQAdxjNHwkk1fYw3p6W7dE7zj7K2sRMltlJclEObszixwajvoChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTRWS+Yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTRWS+Yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF11F1F00A3A;
	Tue, 23 Jun 2026 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782249608;
	bh=VFPguv+jiLfsJALcU3tz4L5Wd5SC/EjewhxyiKL5U50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTRWS+YrtWBSuVeNLL3IGmbKpJxqWb3a4Tk1zbqF2T2XBQVWU5ohOrGlkhBxo4U4w
	 tc3sLrZkj0kW6iJ/WWjLvq6aAg1tF0JzDKbrtVDAG+/+JRsLZFJE5iySBalA9UsiVj
	 H3znlEAVtqpFca2h2OAvDIaZqG58DJ0vzNqrz3WkiIortbIupQh/UZiMtwNbNZAmiO
	 bz/pxs0Q2SsjcKPSEIKJmym4y6yTPikvdBZc+ODmCUGHm6RuIRojkqq9iZy83zFfrp
	 JzSTObJhcu+hAWzP3yjg/74K6yfK0h5eLco5MXcrSQUP45bq7srHwYSvwd5AoG3Ua9
	 wd1dc/hEzLfxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] perf tests workloads: Support sub-second
 durations in noploop and thloop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-4-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:20:07 +0000
Message-Id: <20260623212007.CF11F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Conversion of an unbounded floating-point value to `unsigned int=
` invokes undefined behavior.
- [Low] Missing explicit inclusion of `<stdio.h>` for `fprintf` and `stderr=
` usage.
--

commit 7d05873e679bf07cde18f37a2d18403b7405f3c4
Author: Ian Rogers <irogers@google.com>

perf tests workloads: Support sub-second durations in noploop and thloop

This commit updates noploop and thloop workloads to support sub-second sleep
durations by switching from atoi() to atof(). It uses ualarm() for durations
under 1.0 second and falls back to alarm() for longer durations.

> diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/work=
loads/noploop.c
> index 656e472e61882..ca9f871e136f5 100644
> --- a/tools/perf/tests/workloads/noploop.c
> +++ b/tools/perf/tests/workloads/noploop.c
> @@ -15,15 +15,26 @@ static void sighandler(int sig __maybe_unused)
> =20
>  static int noploop(int argc, const char **argv)
>  {
> -	int sec =3D 1;
> +	double sec =3D 1.0;
> =20
>  	pthread_setname_np(pthread_self(), "perf-noploop");
>  	if (argc > 0)
> -		sec =3D atoi(argv[0]);
> +		sec =3D atof(argv[0]);
> +
> +	if (!(sec > 0.0)) {
> +		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);

[Severity: Low]
Does this code compile cleanly under musl libc? The perf subsystem guidelin=
es
require explicit POSIX header inclusions for all libc functions to prevent
musl compilation failures. The stdio.h header appears to be missing for this
fprintf and stderr usage.

> +		return 1;
> +	}
> =20
>  	signal(SIGINT, sighandler);
>  	signal(SIGALRM, sighandler);
> -	alarm(sec);
> +
> +	if (sec < 1.0) {
> +		useconds_t usecs =3D (useconds_t)(sec * 1000000.0);
> +
> +		ualarm(usecs > 0 ? usecs : 1, 0);
> +	} else
> +		alarm((unsigned int)sec);

[Severity: Medium]
What happens if the parsed duration exceeds UINT_MAX? Converting an unbound=
ed
floating-point value like 1e20 to an unsigned int invokes undefined behavio=
r.
Should sec be bound-checked before this cast?

[ ... ]

> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workl=
oads/thloop.c
> index bd8168f883fb6..c830d739489fe 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -31,14 +31,15 @@ static void *thfunc(void *arg)
> =20
>  static int thloop(int argc, const char **argv)
>  {
> -	int nt =3D 2, sec =3D 1, err =3D 1;
> +	int nt =3D 2, err =3D 1;
> +	double sec =3D 1.0;
>  	pthread_t *thread_list =3D NULL;
> =20
>  	if (argc > 0)
> -		sec =3D atoi(argv[0]);
> +		sec =3D atof(argv[0]);
> =20
> -	if (sec <=3D 0) {
> -		fprintf(stderr, "Error: seconds (%d) must be >=3D 1\n", sec);
> +	if (!(sec > 0.0)) {
> +		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);

[Severity: Low]
Similarly, this usage of fprintf and stderr might cause musl compilation to
fail if stdio.h is not explicitly included in this file.

[ ... ]

> @@ -67,7 +68,12 @@ static int thloop(int argc, const char **argv)
>  			goto out;
>  		}
>  	}
> -	alarm(sec);
> +	if (sec < 1.0) {
> +		useconds_t usecs =3D (useconds_t)(sec * 1000000.0);
> +
> +		ualarm(usecs > 0 ? usecs : 1, 0);
> +	} else
> +		alarm((unsigned int)sec);

[Severity: Medium]
Is this unbounded cast to unsigned int safe? Just as in noploop(), if sec is
excessively large, this cast could result in undefined behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D3
