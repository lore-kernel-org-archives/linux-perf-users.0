Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B43CF673
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590969; cv=none; b=XBK7YwVz3AnrcqH+HolbBQcepnNhBWa3Gjdji5yaPA3TimW7lhow/RQ7xCVhlVdRO0bYr7c+guBzBw+6ZAH4Ux24adDvCDSaNgY/syyJ/6F4cKVi5VkrwOAzRaho6cFYMxuTUWd/pltkcss0Vp4Gw3ukLjm4i3FXFYjiB/U2TVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590969; c=relaxed/simple;
	bh=+shJJWSvtxMLRkd9bxAm/ggIpRQfwhoeDzIF7b+c3rM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkBfd154P7QF1krX+y63UQk/wsLQrkpCWXWEthqU9e4qF8NAhzUfkqkrdJn42S3ySSXI5bxR3kUt75oTJ55Sv8lJtOBNPHt5EKbCAfphzqmBHQ/Of1MivJxPwVTS5VXxAqC7Lt+CSZxlu/3Inm1jILZi3/+8adO0Qqq+VDZe7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVpN7P/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVpN7P/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA0D1F00A3A;
	Tue, 16 Jun 2026 06:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590967;
	bh=T0mquLOuiQG4eYFlmADq99wLepqOebvwbyxgRaUqyEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVpN7P/0mw9A3pLtW+MNWRpXsHqVwUB2PWxEp569kWWJjSlsfnesGQW4kWOIG98U7
	 XigvnHKbn3hbvasAxI6mFnGRo60OVKbj3kQgdwnpOWQqKT7nzlByWdHjKPW0l4LfDn
	 r4vC98wTu5pVqsl8TSM/8G+F4FjA18biixoRlgiDX0CbRNdcz1EnDcY6vdpmTHN9pB
	 YOjR48dCuTyL6eZ7aMAENDmVgTNWfKKGOTdewDBQdsanUVPKxvOT3jfkOsZ/ajSif9
	 IIcoLl1Ny8sWYyq1mR9oygCautRecSB/WIkYyJgZuXi117y/507SEkWHSSvMObOBsl
	 lzHjot/dvkL4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] perf tests workloads: Support sub-second
 durations in noploop and thloop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-4-irogers@google.com>
References: <20260616061404.41929-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:22:47 +0000
Message-Id: <20260616062247.8BA0D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Floating-point parsing fails to reject NaN and excessively large=
 inputs, leading to undefined behavior and an infinite loop.
--

commit 27288129892e9ee8db8d116f0ab2af7cffc87383
Author: Ian Rogers <irogers@google.com>

perf tests workloads: Support sub-second durations in noploop and thloop

This commit modifies the noploop and thloop workloads to support sub-second
sleep durations. It changes the duration argument parsing from atoi() to
atof() and adds a fallback to ualarm() for fractional durations less than
1.0 second.

> diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/work=
loads/noploop.c
> --- a/tools/perf/tests/workloads/noploop.c
> +++ b/tools/perf/tests/workloads/noploop.c
[ ... ]
> @@ -15,15 +15,26 @@ static void sighandler(int sig __maybe_unused)
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
> +	if (sec < 1.0) {
> +		useconds_t usecs =3D (useconds_t)(sec * 1000000.0);
> +
> +		ualarm(usecs > 0 ? usecs : 1, 0);
> +	} else
> +		alarm((unsigned int)sec);

[Severity: Medium]
Could this lead to an infinite loop if a user provides an invalid value
like "NaN"?

The atof() function can parse strings like "NaN", which evaluates to false
for both the sec <=3D 0.0 validation check and the sec < 1.0 branch.

This would cause execution to fall through to the alarm((unsigned int)sec)
call. Casting NaN to an unsigned int is undefined behavior, which on common
architectures evaluates to 0. Since alarm(0) cancels any pending alarms
instead of setting one, will the test suite hang indefinitely in the
subsequent while (!done) loop?

> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workl=
oads/thloop.c
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
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
Does this have the same NaN handling issue as noploop()?

Bypassing the check allows an invalid timer value which disables the alarm
when cast to unsigned int, causing the thread pool workload to run forever
when it reaches test_loop().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D3
