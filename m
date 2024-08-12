Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182F17B511
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467389; cv=none; b=lqsnWNp7ohwDd4HgAGlY6S7MPcXlKel23vRjLFJRDjpNa/5ckKesDhFFJ8XuzFvI284AyoxaFNVurAIjMfUp36oiv0BAXvdzT01AJFHWTw66goz30yHx1EOl5zfSWQGPPgT42YaWz9JA/vikoUeoZ5owxPyAZL0mqMF9hYK5MVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467389; c=relaxed/simple;
	bh=aSkcJ4ECRllbIitgwLvE8jHpGCYEFdX03fywowYQHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqBHSF2HJHXDeryAU91p/Re/RJhzITP2dZqhzvXIor8phGQIil8SMzMxUnkgPmYV5GEuZEsRhKZT7hbeZIijmpTjbOSkkC4zTuydUr8k4njM04gILU7cWS3Kgo1d4BrlyL43d7i/2qEdfntWx70MneXeFrJ/sCAZTBx/1WUNgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLMJr+9Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLMJr+9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCE0C32782;
	Mon, 12 Aug 2024 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723467388;
	bh=aSkcJ4ECRllbIitgwLvE8jHpGCYEFdX03fywowYQHT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLMJr+9QjvAVqiHFYpbSwA+H5LoNs/9WzwIu99mTkLWfXk1Bc0kLiElMp/XI4iYXb
	 OXentcFTObf5gezg+2pJbbFXZoyJrvLHcga13+q4LIBk1CaJKxnywvCIHlt2wwPuMC
	 ERKmjr6jn5M4AfKXV45YcNtcv9mGCOM48FM4TAzPj5l86L5pKJ7C4JUelwTCMmSpb/
	 hAXjElAz76iNBA+aqrct0SPcyRpKbapqzEh7Ga7zk1acNr/uWiix49Wvk/PDILUfnn
	 vmOReEBKf9S3DS82RM0eUMGZxOz+oQx491jgEeAun4+xRK2hpACGuj3jbufiA5HkNs
	 9BN4geBpHE89w==
Date: Mon, 12 Aug 2024 09:56:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	james.clark@arm.com, rstoyano@redhat.com
Subject: Re: [PATCH] perf test pmu: Set uninitialized PMU alias to null
Message-ID: <ZroGeHn3M7kbm48A@x1>
References: <20240808103749.9356-1-vmolnaro@redhat.com>
 <ZrTPqy3omGsTTati@x1>
 <ZrTSWvyox2ET1eNm@x1>
 <40af7af7-598b-41aa-8a2f-119f5d3fb034@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40af7af7-598b-41aa-8a2f-119f5d3fb034@redhat.com>

On Thu, Aug 08, 2024 at 04:42:30PM +0200, Veronika Molnarova wrote:
> On 8/8/24 16:12, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 08, 2024 at 11:01:28AM -0300, Arnaldo Carvalho de Melo wrote:
> >> On Thu, Aug 08, 2024 at 12:37:49PM +0200, vmolnaro@redhat.com wrote:
> >>> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>>
> >>> Commit 3e0bf9 ("perf pmu: Restore full PMU name wildcard support") adds
> >>> a test case "PMU cmdline match" that covers PMU name wildcard support
> >>> provided by function perf_pmu__match(). The test works with a wide
> >>> range of supported combinations of PMU name matching but omits the case
> >>> that if the perf_pmu__match() cannot match the PMU name to the wildcard,
> >>> it tries to match its alias. However, this variable is not set up,
> >>> causing the test case to fail when run with subprocesses or to segfault
> >>> if run as a single process.
> >>>
> >>> ./perf test -vv 9
> >>>   9: Sysfs PMU tests                                                 :
> >>>   9.1: Parsing with PMU format directory                             : Ok
> >>>   9.2: Parsing with PMU event                                        : Ok
> >>>   9.3: PMU event names                                               : Ok
> >>>   9.4: PMU name combining                                            : Ok
> >>>   9.5: PMU name comparison                                           : Ok
> >>>   9.6: PMU cmdline match                                             : FAILED!
> >>>
> >>> ./perf test -F 9
> >>>   9.1: Parsing with PMU format directory                             : Ok
> >>>   9.2: Parsing with PMU event                                        : Ok
> >>>   9.3: PMU event names                                               : Ok
> >>>   9.4: PMU name combining                                            : Ok
> >>>   9.5: PMU name comparison                                           : Ok
> >>> Segmentation fault (core dumped)
> >>>
> >>> Initialize the PMU alias to null for all tests of perf_pmu__match()
> >>> as this functionality is not being tested and the alias matching works
> >>> exactly the same as the matching of the PMU name.
> >>>
> >>> ./perf test -F 9
> >>>   9.1: Parsing with PMU format directory                             : Ok
> >>>   9.2: Parsing with PMU event                                        : Ok
> >>>   9.3: PMU event names                                               : Ok
> >>>   9.4: PMU name combining                                            : Ok
> >>>   9.5: PMU name comparison                                           : Ok
> >>>   9.6: PMU cmdline match                                             : Ok
> >>>
> >>> Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
> >>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> >>> ---
> >>>  tools/perf/tests/pmu.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> >>> index 0b2f04a55d7b..a4730b5dc0d9 100644
> >>> --- a/tools/perf/tests/pmu.c
> >>> +++ b/tools/perf/tests/pmu.c
> >>> @@ -453,11 +453,13 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
> >>>  /**
> >>>   * Test perf_pmu__match() that's used to search for a PMU given a name passed
> >>>   * on the command line. The name that's passed may also be a filename type glob
> >>> - * match.
> >>> + * match. If the name does not match, perf_pmu__match() attempts to match the
> >>> + * alias of the PMU, if provided.
> >>>   */
> >>>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> >>>  {
> >>>  	struct perf_pmu test_pmu;
> >>> +	test_pmu.alias_name = NULL;
> >>
> >> We can do a bit more future proofing by instead doing:
> >>
> >> 	struct perf_pmu test_pmu = {
> >> 		.name = "pmuname",
> >> 	};
> >>
> >> So that all the other fields are initialized to zero, ok? I'll do this
> >> change and make a note in the commit, lemme know if you disagree.
> > 
> > Nah, tried with:
> > 
> > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > index a4730b5dc0d9259d..c9d4ed6d684551c1 100644
> > --- a/tools/perf/tests/pmu.c
> > +++ b/tools/perf/tests/pmu.c
> > @@ -457,11 +457,11 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
> >   * alias of the PMU, if provided.
> >   */
> >  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> > -{
> > -	struct perf_pmu test_pmu;
> > -	test_pmu.alias_name = NULL;
> >  
> > -	test_pmu.name = "pmuname";
> > +	struct perf_pmu test_pmu = {
> > +		.name = "pmuname",
> > +	};
> > +
> >  	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
> >  	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
> >  	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);
> > 
> Isn't the error caused by a missing curly bracket at the start of the function?
> Tried it and works just fine for me.

Right, well spotted! My bad :-\

Anyway, it is already in perf-tools-next, so I can't change it anymore,
so I'll add a patch on top of it doing this more future-proof approach.

Thanks for finding my mistake!

- Arnaldo
 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index a4730b5dc0d9..be18506f6a24 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -458,10 +458,10 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
>   */
>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -       struct perf_pmu test_pmu;
> -       test_pmu.alias_name = NULL;
> +       struct perf_pmu test_pmu = {
> +               .name = "pmuname",
> +       };
>  
> -       test_pmu.name = "pmuname";
>         TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),      true);
>         TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
>         TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),        false);
> 
> ./perf test -F 9
>   9.1: Parsing with PMU format directory                             : Ok
>   9.2: Parsing with PMU event                                        : Ok
>   9.3: PMU event names                                               : Ok
>   9.4: PMU name combining                                            : Ok
>   9.5: PMU name comparison                                           : Ok
>   9.6: PMU cmdline match                                             : Ok
> 
> > But those macros are not liking it:
> > 
> > tests/pmu.c: In function ‘test__pmu_match’:
> > tests/pmu.c:461:16: error: parameter ‘test_pmu’ is initialized
> >   461 |         struct perf_pmu test_pmu = {
> >       |                ^~~~~~~~
> > In file included from tests/pmu.c:7:
> > tests/tests.h:22:1: error: expected declaration specifiers before ‘do’
> >    22 | do {                                                                     \
> >       | ^~
> > tests/pmu.c:465:9: note: in expansion of macro ‘TEST_ASSERT_EQUAL’
> >   465 |         TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),      true);
> >       |         ^~~~~~~~~~~~~~~~~
> > tests/tests.h:28:3: error: expected declaration specifiers before ‘while’
> >    28 | } while (0)
> >       |   ^~~~~
> > 
> > So I'll not spend more time here, I'm keeping your patch as-is.
> > 
> > Thanks and sorry for the noise :-)
> > 
> > - Arnaldo
> > 
> 
