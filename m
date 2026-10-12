Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6984AA569;
	Mon, 12 Oct 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834131; cv=none; b=Hfk7jcW9TpV0feZNPtjV526r15bBP8Enmsuz6eA+ohH0D5ijJUuEyXz7AxMG0oB8vnJlArQJH5P5yW4OoBZGpyhjf52OQIgiygQ31LP1oIi2mFTIfiyKUs06VsOl6mNu+BeKm9/lv3gDSBVEJnqY1FAGpNr+WJMIT51PTkOz6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834131; c=relaxed/simple;
	bh=lo+oooFfKEwwi2TaHOjLowc+eTLNXhWaHdptjf0oTuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLprwUxuej0q0qZXvPdkGepsisFaCzcoSMBUd+Z0sFv4sQr6lqpTzEumebnnmSxFQM/aYATdHNKRDs29jrl4w98JzmM00Agur+EuzzgG1i0LthyWq0hbwctP5VDeyzIujwYnm6iU6NceBAZ7dj7YTGlabdChp7UWQt2ZZTLw/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl75Wkgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl75Wkgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB21F0089B;
	Mon, 12 Oct 2026 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791834130;
	bh=eZQ8ofdGsyb9hnx0qVN5nZjUqiG+7cuj6OfwN/jr6M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dl75Wkgi4gU7wVxcWCh9/AKJtsLoPzFuKUKg4kNF1iErj5h8eq8p9zYR1l8CBoQ0L
	 KTz+ei74SXZzAEozVgWcwVKw0ByrqSittjFYqA6MtVhACzX5m2b3D050NCKkV2KQQ/
	 bUBsLc9WAwV/XJgWuwMEAEnHlcr1ZBR72v09HwH2WO+6IvgFrm6UcDs+ccOhHrp01k
	 hggOl28Uf7/cx/m9pBqYYqNp/v0PGixn61CENdUHpzGWUqOK3bBjYW4Lq8qOMowGMx
	 ktWB+Faf5DGISNlmKwQutf+trKlVN8gymPI5WouRzZBjmOFfAhYerjxbmy49uJXLp1
	 SgtTi9LJTebcw==
Date: Mon, 12 Oct 2026 12:42:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other locations
Message-ID: <as04EIj_QLOpjZoW@google.com>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-4-namhyung@kernel.org>
 <sashiko-outbox-167679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167679@kernel.org>

On Mon, Oct 12, 2026 at 05:38:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/tests: spurious test failure due to brittle directory checking
> --
> 
> commit 073d3f0f55cefe06ae3b0caf163e2a6505e656b3
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf test: Update PE file test for other locations
> 
> This updates test__pe_file_parsing() to search multiple directories to
> find the tests directory, similar to shell_tests__dir_fd(), and adds
> debug messages when skipped.
> 
> > diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> > index 3979f38bf127c..78dae7e43603b 100644
> > --- a/tools/perf/tests/pe-file-parsing.c
> > +++ b/tools/perf/tests/pe-file-parsing.c
> > @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >  {
> >  	struct stat st;
> >  	char path_dir[PATH_MAX];
> > +	static const char * const tests_dirs[] = {
> > +		"./tools/perf/tests",
> > +		"./tests",
> > +		"./source/tests"
> > +	};
> >  
> >  	/* First try development tree tests. */
> > -	if (!lstat("./tests", &st))
> > -		return run_dir("./tests");
> > +	for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> > +		if (!lstat(tests_dirs[i], &st))
> > +			return run_dir(tests_dirs[i]);
> 
> [Severity: Medium]
> Will this cause a spurious test failure if a matching directory exists but
> doesn't contain pe-file.exe?
> 
> The new loop eagerly calls run_dir() upon finding a matching directory
> name instead of verifying the actual test file exists.
> 
> If pe-file.exe is missing from the matched directory, run_dir() calls
> filename__read_build_id() which returns an error. This causes
> TEST_ASSERT_VAL to immediately return TEST_FAIL, breaking the test suite
> instead of falling back to the installed path.
> 
> The commit message notes this logic tries other paths like
> shell_tests__dir_fd(), but shell_tests__dir_fd() merely returns a directory
> descriptor and gracefully continues with zero shell tests if the directory
> is empty. By contrast, run_dir() explicitly asserts file validity and
> aborts the suite with a hard TEST_FAIL.
> 
> Should this verify pe-file.exe actually exists before committing to a
> directory and calling run_dir()?

It's expected to point to the tests directory in the source tree, so it
would contain the file.  But in a rare case where it runs on a directory
which happens to have a "tests", the test will fail on reading build-id.

I think it's a minor pre-existing issue and maybe we can just ignore it.

Thanks,
Namhyung

