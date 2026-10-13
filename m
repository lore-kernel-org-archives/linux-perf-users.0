Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B350276
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850136; cv=none; b=V9vQL9IQW98B9IDcDUc3j1CHmAsMAuUeQ3HNCEEqXSvkDrUoWyUE6rTk0Np0xHmSQLcGV+JY3FoKw1JCCOXMcHHM0JB9mkKf+YIFOYqR2XUyGBjxIcfpIplEvIeGAD5F0EuQrfOGnoYKsiaOhjUXWiwYD+PmRbWfntOqQbUsCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850136; c=relaxed/simple;
	bh=qSRAbtrV2DhRompV/Ss6tnE5oAQbkv1uYQX6Sh7wSis=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bH1nnbY5GJcgnI84XBiWQXNarsxAquphTFjoSjytQjgbzrxLjZCcq0C4ZOBFjjQtkE3sfM4QoSwp2G9o+OV+V+ibll/OoC0zJQ5+CuJZZYA5VHtZ3ddgSBDR4g1v5A7JqcHikXKGKvS+th6sLJriN2itAV+PfmXJQPfNCcD3L7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW9sPCRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW9sPCRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD671F0089B;
	Tue, 13 Oct 2026 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791850134;
	bh=JLXwwifOAr/Rx+FFAFM9/3lYbWkVombXcfQffP0XDB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VW9sPCRWfi7KFpGbb8qrS0/rMRnGUJ4txkbo6Lpe61aR0weS06PT744oVedUMEWqp
	 J3o3VuXb7efJ7Y0sRUexA5QYf5rtiw33ZKgNHm6YwUTUwBOJITmJbBQu0euGnR4Yw1
	 boo99cCfUHZGNeINwGqS4beyYFOCH8BTgV9oRHoND3b0zU8o7DTMWSoKpFvQ5XLbZ3
	 Nt7RUDNam0m3bpkBMDyEW3jxeeKxJnNzDeFjewjVed5/fC2GrrBfGc7Iqu3jRFKIYY
	 O44psC6tYmzeOx3rIu9Kff14PZ8iCWki3NeJyDxoNAdrZ1neiNWSaca1aiEVaicIkG
	 00bQtBZiQK9cw==
Message-ID: <sashiko-outbox-168781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf test: Update PE file test for other
 locations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012235938.87912-4-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <20261012235938.87912-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:08:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf test: unconditional leak of get_argv_exec_path() and NULL deref
--

commit 9107444f4267d3db60d0e4c357f3b28957bdb1bc
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Update PE file test for other locations

This commit updates the PE file parsing test to check multiple directory pa=
ths
for the test data. The logic is modified to try other paths similar to the
shell_tests__dir_fd() fallback mechanism.

> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 3979f38bf127c..190520ffc3ad6 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -74,17 +74,20 @@ static int test__pe_file_parsing(struct test_suite *t=
est __maybe_unused,
>  {
>  	struct stat st;
>  	char path_dir[PATH_MAX];
> -
> -	/* First try development tree tests. */
> -	if (!lstat("./tests", &st))
> -		return run_dir("./tests");
> -
> -	/* Then installed path. */
> +	const char * const tests_dirs[] =3D {
> +		"./tools/perf/tests",
> +		"./tests",
> +		"./source/tests",
> +		path_dir,
> +	};
>  	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());

[Severity: Low]
Can this code in test__pe_file_parsing() lead to a memory leak and a potent=
ial
NULL pointer dereference?

The get_argv_exec_path() function returns a dynamically allocated string th=
at
must be freed by the caller. Passing it directly to snprintf() inline causes
the pointer to be permanently lost.

Additionally, since the patch moved this snprintf() call before the directo=
ry
search loop, it now unconditionally allocates this string even if an earlier
directory in the tests_dirs array would have succeeded.

Furthermore, if get_argv_exec_path() fails under memory pressure and returns
NULL, snprintf("%s") could crash on strictly compliant libcs like musl.

> =20
> -	if (!lstat(path_dir, &st))
> -		return run_dir(path_dir);
> +	for (size_t i =3D 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> +		if (!lstat(tests_dirs[i], &st))
> +			return run_dir(tests_dirs[i]);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235938.8791=
2-1-namhyung@kernel.org?part=3D4
