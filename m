Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A20485518;
	Tue, 13 Oct 2026 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872739; cv=none; b=oafCnu936hNeHhj2JmeN7a/Wo5ebZV6vsJQIgUmNy1PFBxpMCcqByHf2FrRCmK/OcKvF5AdEK5M9eZw0PMbFOqJ3oeFBbgZhmSxKmJwPiX78AGoWK8vd/AWFJgj7X1FrhmAF5OexNbzVjV8oFf6yGtJP1kzTIDluNiAPe0llwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872739; c=relaxed/simple;
	bh=qrZLh87ur3FkaGxrB3RPum5lo1hDfJXAhMC/MOhTpRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELtx7bgWVH8IR6dOYYHWcqqPMRGBr/47++M1JZ9GDHqmlMbW8Y/771eX987qaXOMtJS0e/dHh22QqwcqR8oyWtm/9r25FT5P2vVCpLvQ3SQat9PbGhUj+s7wLlJ7oU6uFN5kscBbEPmzBinJhHGNpU8J3SZO5/CXKSYPq9X30oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf9pupUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf9pupUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB91F000FF;
	Tue, 13 Oct 2026 06:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872738;
	bh=SgEkBOwLkQS74ZX4hqcdr3y7JHHJf27TkH4XNjPv/y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vf9pupUxXxYpnDEGYIKlhLZ5i1E8RK9junDrzRnJnsJ26/XHYgQ8+N88MiIbFg7Bh
	 SXMaadFd/kAhZ8BhlKzNpk8+fiPNRxwudxHpQNYaMhbHUcEO7F4g7Up6KoqhsNSeny
	 8hPNfK8Wwk1YFIaZ3i72JNItD3kUeLAUbWnMFKsOg9puBd4V9LflQ1HpiTDKsnSWog
	 B4EbcpBIwoHzOPLkksqi4I8zxR0pnM6vFRxdDYKaZqgJrpiZ/v3oPOG0nP5cA1ev3x
	 6LwvUiWl+CPpdSZy3JihZcAd7Vx8tw0pSxIK3+S6+LIsFSLsxgpQcbmEpXaSBxnUhm
	 AB5mqIJgciuiA==
Date: Mon, 12 Oct 2026 23:25:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 4/4] perf test: Update PE file test for other locations
Message-ID: <as3O4IjPoB9v_Srl@z2>
References: <20261012235938.87912-1-namhyung@kernel.org>
 <20261012235938.87912-4-namhyung@kernel.org>
 <sashiko-outbox-168781@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-168781@kernel.org>

On Tue, Oct 13, 2026 at 12:08:54AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] perf test: unconditional leak of get_argv_exec_path() and NULL deref
> --
> 
> commit 9107444f4267d3db60d0e4c357f3b28957bdb1bc
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf test: Update PE file test for other locations
> 
> This commit updates the PE file parsing test to check multiple directory paths
> for the test data. The logic is modified to try other paths similar to the
> shell_tests__dir_fd() fallback mechanism.
> 
> > diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> > index 3979f38bf127c..190520ffc3ad6 100644
> > --- a/tools/perf/tests/pe-file-parsing.c
> > +++ b/tools/perf/tests/pe-file-parsing.c
> > @@ -74,17 +74,20 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >  {
> >  	struct stat st;
> >  	char path_dir[PATH_MAX];
> > -
> > -	/* First try development tree tests. */
> > -	if (!lstat("./tests", &st))
> > -		return run_dir("./tests");
> > -
> > -	/* Then installed path. */
> > +	const char * const tests_dirs[] = {
> > +		"./tools/perf/tests",
> > +		"./tests",
> > +		"./source/tests",
> > +		path_dir,
> > +	};
> >  	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
> 
> [Severity: Low]
> Can this code in test__pe_file_parsing() lead to a memory leak and a potential
> NULL pointer dereference?
> 
> The get_argv_exec_path() function returns a dynamically allocated string that
> must be freed by the caller. Passing it directly to snprintf() inline causes
> the pointer to be permanently lost.
> 
> Additionally, since the patch moved this snprintf() call before the directory
> search loop, it now unconditionally allocates this string even if an earlier
> directory in the tests_dirs array would have succeeded.
> 
> Furthermore, if get_argv_exec_path() fails under memory pressure and returns
> NULL, snprintf("%s") could crash on strictly compliant libcs like musl.

These are pre-existing issues, will fix separately.

Thanks,
Namhyung

> 
> >  
> > -	if (!lstat(path_dir, &st))
> > -		return run_dir(path_dir);
> > +	for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> > +		if (!lstat(tests_dirs[i], &st))
> > +			return run_dir(tests_dirs[i]);
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012235938.87912-1-namhyung@kernel.org?part=4
