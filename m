Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418E187555;
	Fri, 13 Dec 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119269; cv=none; b=K8Pkm2621dgmlo2/HvJU/VV/7qoq1i1KMIA0OTdDR6s5WXoRyxv9UccCV033oWdaRWWjI5cApH/TdR/sxhqvtYWzNym/7rfwbF5XShSG7HOlE1h/RXCHH1SDrqjRtg6SEDQu/t4LIYDxgT7cI+oIISrVqdTyIQO0VnkwbSo+MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119269; c=relaxed/simple;
	bh=b7MjwmDslvQUgvJRafTt4c52KGWnMHGO53zWlaU0WlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naeDc89jhst3a3aYXucw/rMQNNCB9fEYyZNAkpu2w5ytjG206Bnobsn+peqnzmc1ElzBYmwtKEyAgYQgvLwD0aIQbnNhz+e9ioXKcLFHG+RN2ayS3K77zqz2qcmhw+ie7xz4TQHIxvFxJhNTzyy/51HT+GR2aykV4pVT01havyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IexHdLgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IexHdLgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE0CC4CED0;
	Fri, 13 Dec 2024 19:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119269;
	bh=b7MjwmDslvQUgvJRafTt4c52KGWnMHGO53zWlaU0WlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IexHdLgAF4ubCSFiFOXoJmacAx2k6Ho9g6NR8vX1f9f8OC24t0NaGDPMVjbv7Xtxk
	 A77wGRYCpTQ/Tc7CYuXDMnHsmiqXfyGx+OcZzEZB9BTBxire/xaaFqfQkDhs6Gs2aP
	 1p1vr56gQE7KAgZXO6Bmx3KhGI8RUMamW/YOLKC7ZB6TWcbsmanIpyHY59ikW0z5ju
	 kTZ+ae4T3mIXOfDwz1uZCs7fnTlbNXsyui13VMnnlg0i1h5sK2A5xFTJwlQqEVTb+O
	 PnobD6JdYXvY3ZRRNzXwR3hJFV6ATBBipnQtIAK08HIizCDqCLR/E/llUbT5p+PuOq
	 ROj4xSDTi8y8Q==
Date: Fri, 13 Dec 2024 16:47:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 next] perf tests switch-tracking: Set this test to
 run exclusively
Message-ID: <Z1yPYqYYs_isO1PJ@x1>
References: <Z1x3o0YoeZS2kQzr@x1>
 <CAP-5=fVBrssdqwz0YiJ9snKgEJSiAhMVpZcP=sNr6gGEwhMUsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBrssdqwz0YiJ9snKgEJSiAhMVpZcP=sNr6gGEwhMUsA@mail.gmail.com>

On Fri, Dec 13, 2024 at 10:10:32AM -0800, Ian Rogers wrote:
> On Fri, Dec 13, 2024 at 10:06 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > This test was failing when run with the default 'perf test' mode, which
> > is to run multiple regression tests in parallel.
> >
> > Since it checks system_wide mode, set it to run in exclusive mode.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/tests/switch-tracking.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> > index 5cab17a1942e67d7..88a03bcbecb2b11f 100644
> > --- a/tools/perf/tests/switch-tracking.c
> > +++ b/tools/perf/tests/switch-tracking.c
> > @@ -583,4 +583,11 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
> >         goto out;
> >  }
> >
> > -DEFINE_SUITE("Track with sched_switch", switch_tracking);
> > +struct test_case tests__switch_tracking[] = {
> > +        TEST_CASE_EXCLUSIVE("Track with sched_switch", switch_tracking),
> > +        {       .name = NULL, }
> > +};
> > +struct test_suite suite__switch_tracking = {
> > +        .desc = "Track with sched_switch",
> > +        .test_cases = tests__switch_tracking,
> > +};
> 
> With Ravi's change:
> https://lore.kernel.org/lkml/20241210093449.1662-10-ravi.bangoria@amd.com/
> This could be s/DEFINE_SUITE/DEFINE_SUITE_EXCLUSIVE/ , wdyt?

Sure, I saw that, forgot about it, then when looking for
DEFINE_SUITE_EXCLUSIVE and not finding it, I just copy'n'pasted from
what was in some other test.

I'll backtrack, add Ravi's patch, then resubmit.

Thanks!	

- Arnaldo
