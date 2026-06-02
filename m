Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC91D5CC9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386048; cv=none; b=t9cJMuZqcHkILwLuqLQ0bBzCDj5cHYsXSXtcq7C4v9m6I08YydYg2toc10M5045wWrsmLWqY3nMxMeDsu2p2S+P8psPXsEZU5sgFj0WwScmuCMvMHLUXc1pd+qizTRRO2BDYBMjoDht4O+fVx+6tU7KFL3AEXs4pYeRbON1GOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386048; c=relaxed/simple;
	bh=YEHlWw4KDcI4rihmuZVT26aPdWQcsU3Jk0is/URp80I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhDu6KiE6MQiYLYbwadIKYRXARVrwbQSeIfyMNV3YwBKqudLjYsWGQdMjrZWzLUTq1ZzDEaXc7E0OJew/vx5Fj8e6pXfbRKUA8A8oDUXgrDk2UQmgRQ+oxYudDSqdrOfC5LhmQi333A5W9uOeZffk4amQzLo0Rwdb5BNAuFAFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGacG9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGacG9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8A1F00893;
	Tue,  2 Jun 2026 07:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386046;
	bh=CN59jSaFR/IPkuMLOWrAXrO69stN6MKsdL4szh2Iu5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkGacG9thWzbG8vHYXHNyKy9TrCKKb3iOjDkOejNlSPlabqTM1GHxO5IMkC+ypX4H
	 P6y8QDHFCPh0f+r9xDz/oNviRrg23d+dscnyiVGqWh3rxpPOFKnLhzY0Sd2XV/cXZg
	 DXcerXs5Jg+ix08JCY8xDSPHSvVtELvpKV2MQ2C0Sj6oFzdvW/+UO/bPJRsx7fpR4j
	 Dhen6Uw72WofQsqzVlYvy0FlMDb5N4fNjSPnJ2nk7zmHeX/ae+8vxttq29Wm4dvs1B
	 0RiAE8vy0Zaw9na8mJDKneTB0zyVsyFPZus+qRE3DDHwP6yUqPrAnATSM5irqTkbRO
	 hc4px7lMY65rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test: Support dynamic test suites with setup
 callback and private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-6-irogers@google.com>
References: <20260602073132.2653307-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:40:46 +0000
Message-Id: <20260602074046.70B8A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `setup()` callback's error code is silently discarded, causi=
ng all setup failures to manifest as Out of Memory (-ENOMEM) errors and abo=
rting the test execution.
--

commit 5b9d9f1dd51254019eca7f68d6ecad751bf0c2ba
Author: Ian Rogers <irogers@google.com>

perf test: Support dynamic test suites with setup callback and private data

This commit adds a setup callback and private data pointer to the test
structures to support dynamically generating test suites. It updates
build_suites() to invoke this setup callback prior to test execution or
listing.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -754,10 +754,19 @@ static struct test_suite **build_suites(void)
>  	for (size_t i =3D 0, j =3D 0; i < ARRAY_SIZE(suites); i++, j =3D 0)	\
>  		while ((suite =3D suites[i][j++]) !=3D NULL)
> =20
> -	for_each_suite(t)
> +	for_each_suite(t) {
> +		if (t->setup) {
> +			int ret =3D t->setup(t);
> +
> +			if (ret < 0)
> +				return NULL;

[Severity: Medium]
When a setup callback fails and returns an error code like -EPERM or -EINVA=
L,
returning NULL here drops the actual error code. Should build_suites() eith=
er
propagate the exact error, or perhaps just skip the unsupported suite inste=
ad
of aborting the entire test run?

> +		}
>  		num_suites++;
> +	}
> =20
>  	result =3D calloc(num_suites + 1, sizeof(struct test_suite *));
> +	if (!result)
> +		return NULL;

[ ... ]

> @@ -820,6 +829,8 @@ int cmd_test(int argc, const char **argv)
>  	argc =3D parse_options_subcommand(argc, argv, test_options, test_subcom=
mands, test_usage, 0);
>  	if (argc >=3D 1 && !strcmp(argv[0], "list")) {
>  		suites =3D build_suites();
> +		if (!suites)
> +			return -ENOMEM;

[Severity: Medium]
Since build_suites() can now return NULL due to a setup callback failing,
does converting the NULL return to -ENOMEM mask the real reason the tests
failed to build? This might make debugging setup failures difficult for use=
rs.

[ ... ]

> @@ -852,6 +863,8 @@ int cmd_test(int argc, const char **argv)
>  	rlimit__bump_memlock();
> =20
>  	suites =3D build_suites();
> +	if (!suites)
> +		return -ENOMEM;
>  	ret =3D __cmd_test(suites, argc, argv, skiplist);
>  	free(suites);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-6-irogers@google.com?part=3D1
