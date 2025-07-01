Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1E214A6E;
	Tue,  1 Jul 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399370; cv=none; b=DuPHdZ3ZVN65h0MptV+u3yR7t45r6tz4WdVqCjZDpEsfDAWrxMwpv2N7ywFL5Um5jGTxenPR5rvaXwuUCyicP24UbvKplGAZ5cX92evvKfqcNuaMkyPs9cx6NS5Wb6U9ortcy/XvoGITU77c5DSeOnS2EZnoC0umMBuiF0X6Dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399370; c=relaxed/simple;
	bh=VNU1Y8NlHa1PiNPq/Nl5PG8fWwd13+kBJud2u+SgLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqVsZ0m12laKr7k2EvkjTVaFVQLiUcDvqOmkzIlUmMlDoElea9eulSemiqQ92Ae3ibnA48iHQ38fe28ZI7/t/Z1oQmUL5cjufVhQLwJocmHAuMAkkAI/aCru3MqRLRkywiFZWh9AoCgr1s67DvsxN8BfixMTr6ptx/XOopDACMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNgTldHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNgTldHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11678C4CEEB;
	Tue,  1 Jul 2025 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399369;
	bh=VNU1Y8NlHa1PiNPq/Nl5PG8fWwd13+kBJud2u+SgLWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNgTldHxcPk+PmyiifrYVs/2lZzxBGhsN8jC7jtMI7MO45qwCxGwfwelZ48kwUn93
	 80ZuVSQfDvAWvnfYydCvrXwQI0eus4oOyveSE+PzWBD80ZQ6XEJizuyD0oM4QTc8Y3
	 zKO60nYVfhgdOm6OwANbxT2idUKKmGcULcTZbo6cSr/FOjE78HyRBRh4N8iaEQcDPv
	 FlyHPPUl9ffiua6eenrhvigqbAsp2zq34JUF9/3K7FC+RPPqQo9mCCtWVENoJb2jJ1
	 YBesSZSN7ZHVnVGMvMg6uOGNxGlsv02GDNauoLafUamIGJex/GNarS//PRWuUXk8gw
	 1DXUWEh4iS3Zw==
Date: Tue, 1 Jul 2025 12:49:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: Check test suite description only
Message-ID: <aGQ7xzAQpRUghD35@google.com>
References: <20250630233246.1063977-1-namhyung@kernel.org>
 <CAP-5=fXFESx7_+CY-QMnaZSkPSxTGFqwr1eKhHmTbEJoYeMTvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXFESx7_+CY-QMnaZSkPSxTGFqwr1eKhHmTbEJoYeMTvQ@mail.gmail.com>

On Tue, Jul 01, 2025 at 08:51:53AM -0700, Ian Rogers wrote:
> On Mon, Jun 30, 2025 at 4:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Currently perf test checks the given string with descriptions for both
> > test suites and cases (subtests).  But sometimes it's confusing since
> > the subtests don't contain the important keyword.
> >
> > I think it's better to check the suite level and run the whole suite
> > together.
> >
> > Before:
> >   $ perf test hwmon
> >   (no output)
> >
> > After:
> >   $ perf test hwmon
> >    10: Hwmon PMU                                                       :
> >    10.1: Basic parsing test                                            : Ok
> >    10.2: Parsing without PMU name                                      : Ok
> >    10.3: Parsing with PMU name                                         : Ok
> 
> This is better, thanks!
> 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/builtin-test.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 80375ca39a37a256..dfaff4185eb05a1a 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -567,10 +567,6 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
> >
> >                         for (unsigned int run = 0; run < runs_per_test; run++) {
> >                                 test_suite__for_each_test_case(*t, curr_test_case) {
> > -                                       if (!perf_test__matches(test_description(*t, curr_test_case),
> > -                                                               curr_suite, argc, argv))
> > -                                               continue;
> > -
> 
> This will change the behavior so that if a sub-test matches but the
> test suite as a whole doesn't the whole test suite will now be run.
> For example:
> 
> ```
> $ perf test list
> ...
>  39: CPU map
> 39.1: Synthesize cpu map
> 39.2: Print cpu map
> 39.3: Merge cpu map
> 39.4: Intersect cpu map
> 39.5: Equal cpu map
> ...
> $ perf test -v "Equal cpu map"
> 39.5: Equal cpu map                                                 : Ok
> ```
> 
> whereas with this change the whole of the "CPU map" test suite will be
> run. I think the condition:
> 
> ```
> if (!perf_test__matches(test_description(*t, curr_test_case),
> curr_suite, argc, argv))
> ```
> 
> should  be:
> 
> ```
> if (!perf_test__matches(test_description(*t, curr_test_case),
> curr_suite, argc, argv) &&
>     !perf_test__matches(test_description(*t, -1), curr_suite, argc, argv))
> ```
> 
> But you could avoid computing the extra perf_test__matches with a
> boolean as that test is done immediately before.

Oh, I overlooked the condition in the loop.  Will check the both can
skip if it only matched to some subtests.

Thanks,
Namhyung

