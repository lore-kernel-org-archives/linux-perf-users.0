Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D83D300F;
	Mon, 12 Oct 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846387; cv=none; b=SIb6oSgBqYVmMxMBLkvYdeP7otaScms0GjXjJDSV3SYImwaOPaZhNhJPehLj0fLG6XgMuwPGb8eVO6FRXKE3uYVEVe+0vY+l9kni+EOud6FcjrhTT6rf2d6Z1YdfgUp+uyubJq/9e9owsD94tBojF5oecY6VnX7vxyKFe8/r20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846387; c=relaxed/simple;
	bh=GLWIbQ5bPoV4kYK8C9UYxGMFAJsWI1WARc7rT00e+po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeD+odu1Hz5BonVBqoVpXRe0ndAMcvEWJeB4x+dq4/vKfLJUJ5l/EnxUQISJHeKzFF0v9vVrEIcSHysmbbmFEjed2IlzoDXlex5xkf7v0LUMsKePHMiZOY2gQf0X2tehmQy3fylo16uhkx+TTxiUVF4AAJBn+I+Ejj3xQLcPg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt/XbpPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt/XbpPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F8E1F0089B;
	Mon, 12 Oct 2026 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846386;
	bh=aGHtMG7P+FTcvM+u9dIXK3Nys1a1lvjG6I1iLcqRdKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dt/XbpPeKlyXiqwu04/UYhQVLalMB04J3dr+f6cbWKYiTgWIb+36+x988bz26g8hT
	 l24PUGvnhQmVyUMO6Wrpfk6zIYOPHNzkIsFVwKB2wP4+7CkXhR1RJLOBrdj5r4b0JG
	 a9JaBwENvqo7/Am6c0hiuvaVGg0Qem+Q2c0FwI3oLXUkHB9ExHb0cPTnJ8efMOrXV+
	 NXhLnP1ub0wLMnmbSFqsRk6RO4+W5d6smInLsKST8JH9Z27LgIoHQD4ERsRNxG+l79
	 wwP4LYxej1Jt/jV7vW9+9Dxu6/UKefZlKZGUhjhk6mUrDBgG+MJU3fd88bHQUt1zsj
	 4wtUG9liSvCxw==
Date: Mon, 12 Oct 2026 16:06:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other locations
Message-ID: <as1n8CgDZxYlQkSK@google.com>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-4-namhyung@kernel.org>
 <CAP-5=fW1SSoyGKjaujZewF=b3rJ-0vp4kJ-friWNzOQWk+ki5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW1SSoyGKjaujZewF=b3rJ-0vp4kJ-friWNzOQWk+ki5A@mail.gmail.com>

On Mon, Oct 12, 2026 at 02:51:52PM -0700, Ian Rogers wrote:
> On Sun, Oct 11, 2026 at 10:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The test__pe_file_parsing() expects the test is in the tools/perf
> > directory, but it could be root or a separate build directory.  Let's
> > update the logic to try other paths like in the shell_tests__dir_fd().
> >
> > Also add some debug messages to inform users why it's skipped.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/pe-file-parsing.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> > index 3979f38bf127c218..78dae7e43603b9f8 100644
> > --- a/tools/perf/tests/pe-file-parsing.c
> > +++ b/tools/perf/tests/pe-file-parsing.c
> > @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >  {
> >         struct stat st;
> >         char path_dir[PATH_MAX];
> > +       static const char * const tests_dirs[] = {
> > +               "./tools/perf/tests",
> > +               "./tests",
> > +               "./source/tests"
> 
> I'm not sure where "source/tests" comes from?

AFAIK it's set when you pass O=$(DIR) option when you build perf and it
points the source tree.

> nit: could we add the exec_path case to the list?

It's checked right after. :)

Thanks,
Namhyung

> 
> Thanks,
> Ian
> 
> > +       };
> >
> >         /* First try development tree tests. */
> > -       if (!lstat("./tests", &st))
> > -               return run_dir("./tests");
> > +       for (size_t i = 0; i < ARRAY_SIZE(tests_dirs); ++i) {
> > +               if (!lstat(tests_dirs[i], &st))
> > +                       return run_dir(tests_dirs[i]);
> > +       }
> >
> >         /* Then installed path. */
> >         snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
> > @@ -85,6 +92,7 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >         if (!lstat(path_dir, &st))
> >                 return run_dir(path_dir);
> >
> > +       pr_debug("cannot find the tests directory\n");
> >         return TEST_SKIP;
> >  }
> >
> > @@ -93,6 +101,7 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >  static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> >                           int subtest __maybe_unused)
> >  {
> > +       pr_debug("libbfd is not available\n");
> >         return TEST_SKIP;
> >  }
> >
> > --
> > 2.55.0
> >
