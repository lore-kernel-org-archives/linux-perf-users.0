Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAA29AF
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125687; cv=none; b=Bj0ZXR648C3XrvyvA4GoAFRpCTMmHNTjobJ+EfDTyqIy5Nqmr1d/WM8BMaFko7jwdB5YJEC1geKIj+QDfwuS7IpdKfzML5rDTIcItyI+QjoAACZkiiRPYHwG8g3DEE9EYnR0Jdj6i2Q/o3UPgK+88E2cPBZtJ3IY3HWSWe3EdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125687; c=relaxed/simple;
	bh=b3BWpaPbrAdjFYcK0agAd52SMUVvtu9/q7i6ykmTr0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkJ/xPf4J7DHXIkFgUTe3cSE+d5n6oEkkkeoyT7udPgJcDQ/2AXeAoYvfw+su+za45BS2mrc7nk6pO1GaEdj0PZQNfTnJg/sC1DJtJAWSFmETyiZi3re6dArWcbp8ZR8r2forpHKsGqd4gGBHzoafEOlJSkcaGAR06oitH7MvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1xQEYMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1xQEYMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44210C32782;
	Thu,  8 Aug 2024 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723125687;
	bh=b3BWpaPbrAdjFYcK0agAd52SMUVvtu9/q7i6ykmTr0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1xQEYMiqnSMUgptmjjOsnWF9T1Of7CljknXlTcUXREUr5MXJYcXyCCVFbEn/TbUU
	 a4okBDUlekzBILvgx8jUMyWPesoFqioCUAPo1d3ed9zJTSfx6O7iUVIG4JOUcGAJhO
	 kM9bEu8ss55V2rB5fbPiskxOSAw0pbzeqt9Zs6fH1X70xK7Xuu9fbZJifsZhg1N4sr
	 LlDYVxtoNkVU5ZBadwefUhtopf8DSOoVnifbJZ89Czq9LtWhDTcOomHPoO4Jij1ijq
	 w64myT5EaB+s2qH6c89NRtPLVuhV1S8cqGC9rv4gOilEH5YsHqJy/mzokDhfzvxlEy
	 R2TU1mP6daiHA==
Date: Thu, 8 Aug 2024 11:01:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
	james.clark@arm.com, rstoyano@redhat.com
Subject: Re: [PATCH] perf test pmu: Set uninitialized PMU alias to null
Message-ID: <ZrTPqy3omGsTTati@x1>
References: <20240808103749.9356-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808103749.9356-1-vmolnaro@redhat.com>

On Thu, Aug 08, 2024 at 12:37:49PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Commit 3e0bf9 ("perf pmu: Restore full PMU name wildcard support") adds
> a test case "PMU cmdline match" that covers PMU name wildcard support
> provided by function perf_pmu__match(). The test works with a wide
> range of supported combinations of PMU name matching but omits the case
> that if the perf_pmu__match() cannot match the PMU name to the wildcard,
> it tries to match its alias. However, this variable is not set up,
> causing the test case to fail when run with subprocesses or to segfault
> if run as a single process.
> 
> ./perf test -vv 9
>   9: Sysfs PMU tests                                                 :
>   9.1: Parsing with PMU format directory                             : Ok
>   9.2: Parsing with PMU event                                        : Ok
>   9.3: PMU event names                                               : Ok
>   9.4: PMU name combining                                            : Ok
>   9.5: PMU name comparison                                           : Ok
>   9.6: PMU cmdline match                                             : FAILED!
> 
> ./perf test -F 9
>   9.1: Parsing with PMU format directory                             : Ok
>   9.2: Parsing with PMU event                                        : Ok
>   9.3: PMU event names                                               : Ok
>   9.4: PMU name combining                                            : Ok
>   9.5: PMU name comparison                                           : Ok
> Segmentation fault (core dumped)
> 
> Initialize the PMU alias to null for all tests of perf_pmu__match()
> as this functionality is not being tested and the alias matching works
> exactly the same as the matching of the PMU name.
> 
> ./perf test -F 9
>   9.1: Parsing with PMU format directory                             : Ok
>   9.2: Parsing with PMU event                                        : Ok
>   9.3: PMU event names                                               : Ok
>   9.4: PMU name combining                                            : Ok
>   9.5: PMU name comparison                                           : Ok
>   9.6: PMU cmdline match                                             : Ok
> 
> Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 0b2f04a55d7b..a4730b5dc0d9 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -453,11 +453,13 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
>  /**
>   * Test perf_pmu__match() that's used to search for a PMU given a name passed
>   * on the command line. The name that's passed may also be a filename type glob
> - * match.
> + * match. If the name does not match, perf_pmu__match() attempts to match the
> + * alias of the PMU, if provided.
>   */
>  static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	struct perf_pmu test_pmu;
> +	test_pmu.alias_name = NULL;

We can do a bit more future proofing by instead doing:

	struct perf_pmu test_pmu = {
		.name = "pmuname",
	};

So that all the other fields are initialized to zero, ok? I'll do this
change and make a note in the commit, lemme know if you disagree.

- Arnaldo
  
>  	test_pmu.name = "pmuname";
>  	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
> -- 
> 2.43.0
> 
