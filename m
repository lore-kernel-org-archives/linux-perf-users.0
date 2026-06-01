Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88107344DB9
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295229; cv=none; b=WkoHRlnWYlpa9Ulw2l7n3rzBt/zAAeo8Yd3wBwQvC6WA4EBgM3SI3eqD1v9ffMB7UyBigJ8emjBBuul4za4K8wMrmW/F/yW/U4HM9zw3/0uyhiEEr+2CD+INOjOz+7ZXzzammxEnufslrNgyTcHOdhq6BMdVx4HwCYvE8Agi/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295229; c=relaxed/simple;
	bh=nch12tBN35tq8dNQsipxuCroF3ryI1RxclM7JHKOPJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uKXI4h8z9Lo1HRnKEzyT2g5uU4JcbKboGqSJHulRc3bgTdFFuG6QL0G3ze/Tf1Gl8XS+6/0Pj5fGqtRhrithwgMa64C2SVMLu8HcU8D9VIIzV4PVIn3Nsyls5qSB+Ne3/xMFTIrPaE/bWNG5WR9vDmQnvy0t3/eVTyvQTeDC/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVXsrB0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVXsrB0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132501F00893;
	Mon,  1 Jun 2026 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295228;
	bh=yxOZYQzpaC/A2D0Fwezvg/TENRG1dC6gpr8q7pUzSoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVXsrB0V9S8u4al5rO6nF7lzcZahI5ZSNlpjmZc22ZYGLoxtZpgr8eE1+VLoiw4g5
	 TuunoyK1n12FFRGb+smjNYw9FRubHJnval7oPT3E+J7fl17qhojo6ac+LrfKhJEkWD
	 pLrKym6NGhDJPcW8gxZUUEvXD4iLqoyusIBPuS4iI1GfZD0/1NGPoL2Q5Lf0ouAALz
	 XkqaiJ0gMm2iQGgZFGgwYzH0xWDILYlrx3aZfbo8byMKoeTiF6IEI81OIk3rR4XWA0
	 B+GHef8+NyrBrV9URbpFUicmaeh6grE+Y/NFHIHMzV10Zf8/wQuSEObOk6f1ELfrOw
	 0GE/eOBGbpOSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] perf test: Support dynamic test suites with setup
 callback and private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-5-irogers@google.com>
References: <20260601061401.1541457-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:27:07 +0000
Message-Id: <20260601062708.132501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Error codes from a test suite's `setup` callback are discarded a=
nd inappropriately masked as `-ENOMEM`.
--

commit c7d93025e2f0a3cec27f26f22c031872262cee36
Author: Ian Rogers <irogers@google.com>

perf test: Support dynamic test suites with setup callback and private data

This commit adds a void pointer and a setup callback to test suites to allow
for dynamic generation of test cases. The setup callback is invoked during
suite initialization to ensure cases are available before listing or runnin=
g.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -765,10 +765,19 @@ static struct test_suite **build_suites(void)
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
Is it intentional to discard the specific error code returned by t->setup()?

When t->setup() returns a negative error code (like -EINVAL), build_suites(=
)=20
returns NULL, which drops the original error context.

> +		}
>  		num_suites++;
> +	}
> =20
>  	result =3D calloc(num_suites + 1, sizeof(struct test_suite *));
[ ... ]
> @@ -831,6 +840,8 @@ int cmd_test(int argc, const char **argv)
>  	argc =3D parse_options_subcommand(argc, argv, test_options, test_subcom=
mands, test_usage, 0);
>  	if (argc >=3D 1 && !strcmp(argv[0], "list")) {
>  		suites =3D build_suites();
> +		if (!suites)
> +			return -ENOMEM;

Because build_suites() returns NULL on any setup error, the callers in
cmd_test() unconditionally return -ENOMEM. Would it be better for
build_suites() to return the actual error code (perhaps via an
ERR_PTR) so that tools report the correct failure reason instead
of always failing with out-of-memory?

>  		ret =3D perf_test__list(stdout, suites, argc - 1, argv + 1);
>  		free(suites);
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D4
