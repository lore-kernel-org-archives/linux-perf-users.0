Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E961FC7C6
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252368; cv=none; b=bYwQ/6N0dMzTzYA318u63qqbMDdH2kHudzV7gnxb/kzItL2lVT/rvLM2Ym/EPVf6u39xuPrPUrTaUbgPP7meI3BXlyqkb/x2NIFOFPGv1gC1Kbtcslp3thz5PLp/mHSbRy8tSEq3JZ9g8SNqViIuD88K9CJ22F2ikJVBRuxdcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252368; c=relaxed/simple;
	bh=1fbTUMacT40S5XPIFq1DQejZBWsfq13vv44sCVChst0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nId/0QRzFBlopl8D4L6FHbVYuR+qpx+tiiMa7kK9PkgBmMJ+B0jjbQYzHJkVG3fqulJjxdcShW5hma+GvAEd10FyFVe1Z12RkKvCLnYx/WEzQsERNslNPwh/1nUO7anaWa/yiavHOWtiyDrS3qZzuoLlRW/QuezAN20lol/p6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLnlRltk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLnlRltk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EA3C4CECF;
	Tue,  3 Dec 2024 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252367;
	bh=1fbTUMacT40S5XPIFq1DQejZBWsfq13vv44sCVChst0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLnlRltkm9E8tH6Y78o7TT6yMaTgXm6vcGpL3J68l9JxM7Sk0FwMsO/v4dNrUSFKd
	 DwVWFEUVn6AhZvGJAxelo8OOAkGxn+Bky/o0Y0t3TCkyWMWWWkPLgNRlGLdqdRPxtQ
	 W23zCjNN/DQ0UBYMslidTfFl/ORMoVCrxGklYxSnmMatVHntRLYFH7nz3R5+PiVdA7
	 oqPIywFVxd3zwru+BRbhIviM/Co4A6mEbJBn5FXQucghacf/EQZDGSqWkbF00dLaKm
	 gA2FxE2UlwJwMlumh9qJRiNvbiSYWJw1aB3ROn/T+DIhTX9idBOZMFmPI1WSLVhFwk
	 QLXOrvPLLG4FA==
Date: Tue, 3 Dec 2024 10:59:25 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, tmricht@linux.ibm.com,
	acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test
 only for intel
Message-ID: <Z09VDXbPIgx62jJp@google.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com>
 <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
 <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
 <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>
 <20241107135606.GA47850@e132581.arm.com>
 <0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com>
 <Z09K5orKhWbeOGLV@google.com>
 <Z09RJbpmHzc4b1D6@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z09RJbpmHzc4b1D6@google.com>

On Tue, Dec 03, 2024 at 10:42:45AM -0800, Namhyung Kim wrote:
> On Tue, Dec 03, 2024 at 10:16:06AM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Nov 08, 2024 at 10:50:10AM +0530, Athira Rajeev wrote:
> > > 
> > > 
> > > > On 7 Nov 2024, at 7:26 PM, Leo Yan <leo.yan@arm.com> wrote:
> > > > 
> > > > Hi Athira,
> > > > 
> > > > On Wed, Nov 06, 2024 at 03:04:57PM +0530, Athira Rajeev wrote:
> > > > 
> > > > [...]
> > > > 
> > > >>> Hi Athira,
> > > >>> 
> > > >>> sorry for the breakage and thank you for the detailed explanation. As
> > > >>> the code will run on AMD I think your change will break that - . It is
> > > >>> probably safest to keep the ".. else { .." for this case but guard it
> > > >>> in the ifdef.
> > > >>> 
> > > >> 
> > > >> Hi Ian
> > > >> 
> > > >> Thanks for your comments. Does the below change looks good ?
> > > >> 
> > > >> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > > >> index e3aa9d4fcf3a..f5b2d96bb59b 100644
> > > >> --- a/tools/perf/tests/expr.c
> > > >> +++ b/tools/perf/tests/expr.c
> > > >> @@ -74,14 +74,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> > > >>    double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
> > > >>    int ret;
> > > >>    struct expr_parse_ctx *ctx;
> > > >> -    bool is_intel = false;
> > > >>    char strcmp_cpuid_buf[256];
> > > >>    struct perf_pmu *pmu = perf_pmus__find_core_pmu();
> > > >>    char *cpuid = perf_pmu__getcpuid(pmu);
> > > >>    char *escaped_cpuid1, *escaped_cpuid2;
> > > >> 
> > > >>    TEST_ASSERT_VAL("get_cpuid", cpuid);
> > > >> -    is_intel = strstr(cpuid, "Intel") != NULL;
> > > >> 
> > > >>    TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
> > > >> 
> > > >> @@ -244,11 +242,13 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
> > > >>    if (num_dies) // Some platforms do not have CPU die support, for example s390
> > > >>        TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > > >> 
> > > >> +#if defined(__i386__) && defined(__x86_64__)
> > > >>    TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
> > > >> -    if (is_intel)
> > > >> +    if (strstr(cpuid, "Intel") != NULL)
> > > >>        TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> > > >>    else
> > > >>        TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
> > > >> +#endif
> > > >> 
> > > >>    /*
> > > >>     * Source count returns the number of events aggregating in a leader
> > > > 
> > > > I confirmed the change above fixes the failure on Arm64.
> > > > 
> > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > Thanks Leo Yan for testing.
> > > 
> > > Hi Ian,
> > > 
> > > If the change above looks good, I will post a V2 . Please share your review comments
> > 
> > Sorry for the delay, it looks good to me.  Can you please send the v2?
> 
> After looking at another report, I think we need to check the value of
> TSC freq, not just the vendor.  Can you please test this?

Oops, nevermind.  I've realized we have two different issues at the same
time.  So !x86 archs should not use #system_tsc_freq at all, and only
*some* of (real) Intel machines have the value actually.  Hmm...

I think we need the original v2 here, and check the value even on Intel
separately.

Thanks,
Namhyung

