Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D11A2642;
	Tue, 10 Dec 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839050; cv=none; b=HuoDbOJwgnxW3KjhU7V4lM15ONRjA/XU1wYeIoS0615mhqCEjwV8+DBtMyfyNFQFJyg/0ys3yhsLkunWJNLh3xnw17huBauq3XB05ZMqemjjkLzgZm+MfA6oG2yWwCplcvy9cJ74FLOgwx7KKov4PlUj/t+KpG6vJx8a+nMpxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839050; c=relaxed/simple;
	bh=MSxBXwJAL0qIt+Lr1xgjzlvI6sRABebUlCU615fINUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVMKvL9BEdwV/Ux/rshgP8bp+v6kg3f+/Mo4ZO0YpWytlVbO+hQ0HKwevf2cUd0fTlhyBbdh3qidMQBrvvPvIk325YWnfpViSkMYgsONApcT0CN9ZQux8/QtHKDdagsUr7Exz0GVpUR+7bdR/Gdp+/oe8DyqseEXptxKibttvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuPALOcA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuPALOcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E693EC4CED6;
	Tue, 10 Dec 2024 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839049;
	bh=MSxBXwJAL0qIt+Lr1xgjzlvI6sRABebUlCU615fINUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuPALOcAidsiCpj3DNKr7AW3OvrdDPCgNSM8WJ1t1+9d69zcLjztt4oRJENj938k/
	 LCzuT48a3e+EQMzYqic378yIS+cP03FreQ1GKMJ0WjNaDFYCT74/fm1/yBxFLctuUN
	 ue1VixCp21vuOVE30QgmHaIGvgnXDQiIdr4gsC/RlfTfArfYq6RMeABcm9a8Yvshs0
	 ul7UIhx4Ft93icuM+kvsc+LNPaJYGmpJDsLr8kXVJ6eIEcgCCSvrOtgccuULb/A8PI
	 wwXYH5BlcreYqfgLRHIWUj3aULfLmDWInB041e6S9D6mZu/3IIp6Ac3W5kitTTIVSt
	 c+jPcfPzI+p3g==
Date: Tue, 10 Dec 2024 10:57:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test hwmon_pmu: Fix event file location
Message-ID: <Z1hIxPCxBg8wEUWd@x1>
References: <20241206042306.1055913-1-irogers@google.com>
 <20241206042306.1055913-2-irogers@google.com>
 <Z1deN2EUjwsRokn9@x1>
 <CAM9d7chdJyXyCw0MTj=AkF9GL4U6scMtO2a2GMwAAFGUW8kL=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chdJyXyCw0MTj=AkF9GL4U6scMtO2a2GMwAAFGUW8kL=Q@mail.gmail.com>

On Mon, Dec 09, 2024 at 01:47:01PM -0800, Namhyung Kim wrote:
> On Mon, Dec 9, 2024 at 1:16 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Thu, Dec 05, 2024 at 08:23:06PM -0800, Ian Rogers wrote:
> > > The temp directory is made and a known fake hwmon PMU created within
> > > it. Prior to this fix the events were being incorrectly written to the
> > > temp directory rather than the fake PMU directory. This didn't impact
> > > the test as the directory fd matched the wrong location, but it
> > > doesn't mirror what a hwmon PMU would actually look like.
> >
> > With these two files the 'perf test 11' for hwmon is successfully
> > completed on my system where I previously reported failures.
> >
> > Thanks, applied,
> 
> I think it can go to perf-tools.

Please do so and also add:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/hwmon_pmu.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> > > index f8bcee9660d5..d2b066a2b557 100644
> > > --- a/tools/perf/tests/hwmon_pmu.c
> > > +++ b/tools/perf/tests/hwmon_pmu.c
> > > @@ -65,7 +65,7 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
> > >               { "temp2_label", "test hwmon event2\n", },
> > >               { "temp2_input", "50000\n", },
> > >       };
> > > -     int dirfd, file;
> > > +     int hwmon_dirfd = -1, test_dirfd = -1, file;
> > >       struct perf_pmu *hwm = NULL;
> > >       ssize_t len;
> > >
> > > @@ -76,19 +76,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
> > >               dir[0] = '\0';
> > >               return NULL;
> > >       }
> > > -     dirfd = open(dir, O_DIRECTORY);
> > > -     if (dirfd < 0) {
> > > +     test_dirfd = open(dir, O_PATH|O_DIRECTORY);
> > > +     if (test_dirfd < 0) {
> > >               pr_err("Failed to open test directory \"%s\"\n", dir);
> > >               goto err_out;
> > >       }
> > >
> > >       /* Create the test hwmon directory and give it a name. */
> > > -     if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
> > > +     if (mkdirat(test_dirfd, "hwmon1234", 0755) < 0) {
> > >               pr_err("Failed to mkdir hwmon directory\n");
> > >               goto err_out;
> > >       }
> > > -     file = openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600);
> > > -     if (!file) {
> > > +     hwmon_dirfd = openat(test_dirfd, "hwmon1234", O_DIRECTORY);
> > > +     if (hwmon_dirfd < 0) {
> > > +             pr_err("Failed to open test hwmon directory \"%s/hwmon1234\"\n", dir);
> > > +             goto err_out;
> > > +     }
> > > +     file = openat(hwmon_dirfd, "name", O_WRONLY | O_CREAT, 0600);
> > > +     if (file < 0) {
> > >               pr_err("Failed to open for writing file \"name\"\n");
> > >               goto err_out;
> > >       }
> > > @@ -104,8 +109,8 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
> > >       for (size_t i = 0; i < ARRAY_SIZE(test_items); i++) {
> > >               const struct test_item *item = &test_items[i];
> > >
> > > -             file = openat(dirfd, item->name, O_WRONLY | O_CREAT, 0600);
> > > -             if (!file) {
> > > +             file = openat(hwmon_dirfd, item->name, O_WRONLY | O_CREAT, 0600);
> > > +             if (file < 0) {
> > >                       pr_err("Failed to open for writing file \"%s\"\n", item->name);
> > >                       goto err_out;
> > >               }
> > > @@ -119,16 +124,18 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
> > >       }
> > >
> > >       /* Make the PMU reading the files created above. */
> > > -     hwm = perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hwmon_name);
> > > +     hwm = perf_pmus__add_test_hwmon_pmu(hwmon_dirfd, "hwmon1234", test_hwmon_name);
> > >       if (!hwm)
> > >               pr_err("Test hwmon creation failed\n");
> > >
> > >  err_out:
> > >       if (!hwm) {
> > >               test_pmu_put(dir, hwm);
> > > -             if (dirfd >= 0)
> > > -                     close(dirfd);
> > > +             if (hwmon_dirfd >= 0)
> > > +                     close(hwmon_dirfd);
> > >       }
> > > +     if (test_dirfd >= 0)
> > > +             close(test_dirfd);
> > >       return hwm;
> > >  }
> > >
> > > --
> > > 2.47.0.338.g60cca15819-goog
