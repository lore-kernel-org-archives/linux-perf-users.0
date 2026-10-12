Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BB30ACF1
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783502; cv=none; b=lsgxbm5SDjZvRZBHo9UU7eAfHiaceIhuDkTBhzZdtV+km2bTQMWX2XCwXAk2Kcs9lxxRUvRlDR+W5bsO3YlLiTRWhru8bbemoPRbvZMEN/g8tIACOnl0kzgM6PSTGpKXbOar+aK9HirxoPBJ5bzTcj1qwEgrhKE95qcCP2+dZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783502; c=relaxed/simple;
	bh=YJ+lwKKJq1fOCxxwmibuTzUgYqbLI0orCYRD5b4J1YU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AaOK8mfyDrLL8K6e7EReln5UjJCaeu/FA2r0V143wQS+lEVs0NLlJX+8tBS64KRTNkLZq7o/iCqFvLyMxCezA/5I7MG5da3OupYRAH9NI70ax2mFZNks8CnrPzjc+HYYk+RTL/XeMPvk+xprGoJigOZsAyHtaQUL5U4A8cVd2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpHW3r2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpHW3r2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158071F0089B;
	Mon, 12 Oct 2026 05:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783501;
	bh=7JA8wxadnAmBj/FtD1WkNRBPRQyrietB6kn3G33Skc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IpHW3r2X0PIE8hnA0YpSuGxkJT54FufJ1Uj13qPzV3OeiV5FWotwoWpWyEP0mdC83
	 pYGKtsAt3RqdNsFeRDvK5PurGS1Ybt/Mn/84Nl5Dc0Kwc0SIjYa+fZ4K2uy3YLqjvr
	 GZkLSew9Yhv/D1gmtRbYVlgzq3CDj89Xkobx0iIlHZqv60Of6SK0wpThCCpXQJeKMs
	 07OGHQERI3sHmfJdnt9c1t25rKwZNu1qEAKe6aMpv3cigEOpofW62eF0E77wsHmeuv
	 jkDr/2jsm8WzSseYz+L6QwOhYYd6EB5SVJXT51KmYWpIMXf/+Exw4X8jbpKRFLjITX
	 XuNiHGrcD3mlQ==
Message-ID: <sashiko-outbox-167679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other
 locations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012053013.14378-4-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:38:20 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: spurious test failure due to brittle directory check=
ing
--

commit 073d3f0f55cefe06ae3b0caf163e2a6505e656b3
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Update PE file test for other locations

This updates test__pe_file_parsing() to search multiple directories to
find the tests directory, similar to shell_tests__dir_fd(), and adds
debug messages when skipped.

> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 3979f38bf127c..78dae7e43603b 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *t=
est __maybe_unused,
>  {
>  	struct stat st;
>  	char path_dir[PATH_MAX];
> +	static const char * const tests_dirs[] =3D {
> +		"./tools/perf/tests",
> +		"./tests",
> +		"./source/tests"
> +	};
> =20
>  	/* First try development tree tests. */
> -	if (!lstat("./tests", &st))
> -		return run_dir("./tests");
> +	for (size_t i =3D 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> +		if (!lstat(tests_dirs[i], &st))
> +			return run_dir(tests_dirs[i]);

[Severity: Medium]
Will this cause a spurious test failure if a matching directory exists but
doesn't contain pe-file.exe?

The new loop eagerly calls run_dir() upon finding a matching directory
name instead of verifying the actual test file exists.

If pe-file.exe is missing from the matched directory, run_dir() calls
filename__read_build_id() which returns an error. This causes
TEST_ASSERT_VAL to immediately return TEST_FAIL, breaking the test suite
instead of falling back to the installed path.

The commit message notes this logic tries other paths like
shell_tests__dir_fd(), but shell_tests__dir_fd() merely returns a directory
descriptor and gracefully continues with zero shell tests if the directory
is empty. By contrast, run_dir() explicitly asserts file validity and
aborts the suite with a hard TEST_FAIL.

Should this verify pe-file.exe actually exists before committing to a
directory and calling run_dir()?

> +	}
> =20
>  	/* Then installed path. */
>  	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012053013.1437=
8-1-namhyung@kernel.org?part=3D4
