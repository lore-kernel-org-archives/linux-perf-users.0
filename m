Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5661A6803
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573758; cv=none; b=Fp5aTWcFrZYaAiN2KSpCPGeEjvKpASYTprBnzdGkss7FeljIRux1E2/1iGCdU8hzDU2Eyp9ExBFx4+GWmbIPJfogTCNGINtuz4Ckco1ExOioTuBCqLxySY3p7wFYYSDm6peE1d1uZKv/iRxmUmGr56xkdzRT46KNYrSeVymZDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573758; c=relaxed/simple;
	bh=YWBhVOqAL4Fv99AKBlk6hvORV+5Mpn64oJqLnL64Axs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sp4vfuPZAWMQ3dM+TcpPxZly0TjMNJZB/jJrVZZR5I1jWHHUqwKNuDBuQvCkuUsUHBBHOE+bynF5PPRbHWTF8uDUMhGx7BQbD/M/FZ1Xr2MBDkgTOYy+O68EKhLQceN3YXqY9wQC0jPng+BTKCVJqyPjvy5cvhHPuzjSzdGG0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ1MKykK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ1MKykK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0389E1F00A3A;
	Tue, 16 Jun 2026 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573757;
	bh=ObqKyqdkzY2y529f9j1UQLuXOgJPgdLKlcKkC4uJ76o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJ1MKykKU1cJPuB6CU16+4BKkMTTPNRx0j0w6lAk/Rnk3WV7NO599R1GKXe0uaGJd
	 apUZk/Yr43ueln2nnN3y0DOeGaqJwtrEMiYUh9iIIfpo7kry2lPGFa/gQyoXY2CiAp
	 MekofCIIAA3A74PXb4ooSwWGfs1YxN3/72oSMuzaTExSG9EThOuAw16PYOHeuAr0gT
	 uK37aU35/LU0qakrEykKf07KWhSXOoZJKnz5Ank77YBWByOQpJ9ZwiwIAA4jknkeAL
	 6ctgY8EGQ9w7kj5unIG5Vu5or0xKAg+aGZsiwovNsVETc2kbxzyGSdK7BzOW7D1ZCE
	 rJrYy2YoITfxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/12] perf tests workloads: Support sub-second
 durations in noploop and thloop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-4-irogers@google.com>
References: <20260616012744.4049193-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:35:56 +0000
Message-Id: <20260616013557.0389E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Small sub-second durations or non-finite inputs (NaN/Infinity) t=
runcate to zero and cancel the alarm, resulting in an infinite loop.
--

commit 00c5973576e890f274ed5c092471d3ff5f7e1ded
Author: Ian Rogers <irogers@google.com>

perf tests workloads: Support sub-second durations in noploop and thloop

This commit updates the noploop and thloop workloads to use atof() for
parsing the duration argument, allowing sub-second execution times. It uses
ualarm() for fractional durations under 1.0 second and falls back to
alarm() otherwise.

> diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/work=
loads/noploop.c
> --- a/tools/perf/tests/workloads/noploop.c
> +++ b/tools/perf/tests/workloads/noploop.c
[ ... ]
> @@ -15,15 +15,24 @@ static void sighandler(int sig __maybe_unused)
> =20
>  static int noploop(int argc, const char **argv)
>  {
[ ... ]
> +	if (sec <=3D 0.0) {
> +		fprintf(stderr, "Error: seconds (%f) must be > 0\n", sec);
> +		return 1;
> +	}
> =20
>  	signal(SIGINT, sighandler);
>  	signal(SIGALRM, sighandler);
> -	alarm(sec);
> +
> +	if (sec < 1.0)
> +		ualarm((useconds_t)(sec * 1000000.0), 0);
> +	else
> +		alarm((unsigned int)sec);

[Severity: Medium]
Could very small sub-second values or NaN inputs cause this to spin
infinitely?

If sec is NaN, the relational check sec <=3D 0.0 evaluates to false. Execut=
ion
falls through to the else block, casting NaN to unsigned int, which typical=
ly
results in 0 being passed to alarm().

Similarly, if sec is a very small positive value like 1e-7, it passes the
sec <=3D 0.0 error check. The calculation sec * 1000000.0 evaluates to 0.1,
which truncates to 0 when cast to useconds_t for ualarm().

Passing 0 to either alarm() or ualarm() cancels the timer entirely. Because
the timer is disabled, the signal handler is never invoked to set the done
flag, resulting in an infinite loop.

>  	while (!done)
>  		continue;
[ ... ]
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workl=
oads/thloop.c
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
[ ... ]
> @@ -67,7 +68,10 @@ static int thloop(int argc, const char **argv)
>  			goto out;
>  		}
>  	}
> -	alarm(sec);
> +	if (sec < 1.0)
> +		ualarm((useconds_t)(sec * 1000000.0), 0);
> +	else
> +		alarm((unsigned int)sec);

[Severity: Medium]
Does this exhibit the same truncation to zero behavior with NaN or very sma=
ll
sub-second inputs as the noploop workload?

>  	test_loop();
>  	err =3D 0;
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D3
