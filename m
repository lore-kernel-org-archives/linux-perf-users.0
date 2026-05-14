Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145E308F0A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760619; cv=none; b=bOyCHeDY/W/bEk3dEk8PbrRTV/qG7OfMHkydNv6aGoyKr/dO8sCB5S7Wmi+4cp+UTdPhvD6ai+j1/YaUuD/f/erAaY12M+lxpRK2f1ElLChdIxpp9AL4QsGvByoAE89wwoaupQbW0tqu9WVVJR51q57/4sJibK/jOgN88yjfSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760619; c=relaxed/simple;
	bh=3Fe46TKdevu2MXPWXGr7wZJ1yvLBDsbMFwzYIz080ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkS0bSKXsKkfQHifM+IqYcIHBrq8RafX6MphzEu1XQIWFOysRb5463t3vCcwuSszJPIxagofnKAZfqOFfz5a8aLGExx6LYeQHmDtXXD15ScmNZ4sKK5eaFNNVeOGd+4AwGOBQ3UfFtsL87+PQO76wXvNfUG3NxNz1T+VGSt/E0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT61Kfy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT61Kfy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC57C2BCB3;
	Thu, 14 May 2026 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778760619;
	bh=3Fe46TKdevu2MXPWXGr7wZJ1yvLBDsbMFwzYIz080ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sT61Kfy1KSXF5N9Y1KE+hWg/mo4CVLM52Ir931QRT3qajqIgZ5R4pE/pbRMEl6rOI
	 u/eG5nWIIZwCit+kfOFASNQDQLbm+xe0ZgeedDgy8HcPk0rTflDjJOS3+cabA73vwc
	 pZvmepHlIMAqfUcZlg1WsAxXNVAXoKB60dSp9DpwyHuCSOuLR9yZ3BRLzIijUyKqJm
	 Y7O7NjQxe+Ay8l+rRMG5H1zoritKrqoQLu5jQc6mBtvjFRwgR4KSGDsh3BkiX3z4DX
	 6wfu7/AaYLha0EMzA63a0Dg7MyEPMhglIshWc5I2w0XenBXIpohuBckIM1wq7FqE0f
	 zFAUrgBsk2NHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/14] perf test: Support dynamic test suites with
 setup callback and private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-5-irogers@google.com>
References: <20260513230450.529380-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:10:14 +0000
Message-Id: <20260514121018.EEC57C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check for calloc in build_suites() leads to a crash o=
n allocation failure.
- [Medium] A single test suite's setup() failure aborts the entire test fra=
mework and falsely reports -ENOMEM.
--

commit 9dbcf7d7448f74d767101a565265a0d2a73268e7
Author: Ian Rogers <irogers@google.com>

perf test: Support dynamic test suites with setup callback and private data

This commit adds a setup callback to test_suite and a private data
pointer to test_case to allow for dynamic test case generation. The
build_suites function is updated to invoke the setup callback for each
suite if it is present. Callers of build_suites are also updated to
return -ENOMEM on failure.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index e88a5f72faed3..a350db071674a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -764,8 +764,15 @@ static struct test_suite **build_suites(void)
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

If a single test suite's setup() callback returns an error code like
-EPERM or -ENOENT, does it cause build_suites() to abort entirely by
returning a NULL pointer?

> +		}
>  		num_suites++;
> +	}
> =20
>  	result =3D calloc(num_suites + 1, sizeof(struct test_suite *));

Since the callers in cmd_test() were updated to check if build_suites()
returns a NULL pointer to handle allocation failures, does the calloc()
here also need a check to prevent a NULL pointer dereference? If calloc()
fails, result[n++] =3D t will be executed unconditionally on the next pass.

[ ... ]
> @@ -830,6 +837,8 @@ int cmd_test(int argc, const char **argv)
>  	argc =3D parse_options_subcommand(argc, argv, test_options, test_subcom=
mands, test_usage, 0);
>  	if (argc >=3D 1 && !strcmp(argv[0], "list")) {
>  		suites =3D build_suites();
> +		if (!suites)
> +			return -ENOMEM;

Because build_suites() returns a NULL pointer when any test suite fails
setup(), cmd_test() will map this to -ENOMEM and abort. Could this
regression cause a localized failure in one dynamic suite to prevent all
other static test suites from running or being listed, while also masking
the actual error code from the user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D4
