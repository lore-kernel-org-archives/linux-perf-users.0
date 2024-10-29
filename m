Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F9190665
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246395; cv=none; b=thydHE50Ok8gUtCUnPWebpS/4yDUdvplhxgSQShwVyN8rb4bfX9cZZzAxWhFgIdi7lRZEyebaBsIQJqzzDKcEEsxi28dpJQ0s8ZhPwAmMia4h8saRLYbbY+/SOaF2vO59IKZQBpozgPPwk/sl46ZqskxmtXbvER10NnIY6Nfxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246395; c=relaxed/simple;
	bh=3PGjG05cL0ib9NjJ+m7Zaogil8o/zoAM1qJXs34+Osw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaafA0MD57trDr2gBIYufwnv4321NQn3drinh+HCZV3REa4aeA7RqUy4FfinIX4PKEP9vqXcrYk/aMtPfj23SUCOth2d3EeL0w0SOXmmgrXWZtzJfwkX2SxvV4lRFEFIcmGViToFHn73TVV07BVK8+HBXiF8VtVLcNMew1/vmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQlFkpVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQlFkpVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2253C4CEE3;
	Tue, 29 Oct 2024 23:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246395;
	bh=3PGjG05cL0ib9NjJ+m7Zaogil8o/zoAM1qJXs34+Osw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQlFkpVL86I8W/Qkkhs89NgOwBqRFkbkYxuZ2284KfOH+pIyfrLm7MEyh+tojwlZ5
	 jSkCVNeVDDv4KV6VA0Edpi3esGjjos0qicuIWlhKsQd8hP5PyLCfhREv1LTLRjrAJ9
	 u8KKrCqsOaYSUcm55ifenkmlf17Dvpk9lTXHhNo599Jm/zFfIQcXQtl2AFcAsYKj+N
	 ZdPfQcjg8XUlXDtm8/2McpxeYfSJuM3Dj7uLraIxC9tFFE9Br+ThX7waHLqb65YH3l
	 Ci7d9pJ4yu7Lmb9lYhlUH20vEEWk+DokQsQWVoKtUV2m62HnVhf4IG4LCbhixL7mgZ
	 SO01mdlmm5luw==
Date: Tue, 29 Oct 2024 16:59:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, irogers@google.com
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test
 only for intel
Message-ID: <ZyF2-XNUh38p_5Gg@google.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>

Hello,

On Tue, Oct 22, 2024 at 07:31:56PM +0530, Athira Rajeev wrote:
> The "Simple expression parser" test fails on powerpc
> as below:
> 
>  parsing metric: #system_tsc_freq
>  Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq = nan
>  syntax error
>  FAILED tests/expr.c:247 #system_tsc_freq
>  ---- end(-1) ----
>  7: Simple expression parser  : FAILED!
> 
> In the test, system_tsc_freq is checked as below:
> 
>  if (is_intel)
>     TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>  else
> 
> But commit 609aa2667f67 ("perf tool_pmu: Switch to standard
> pmu functions and json descriptions")' changed condition in

Probably need to put it as Fixes: tag.


> tool_pmu__skip_event so that system_tsc_freq event should
> only appear on x86
> 
>  +#if !defined(__i386__) && !defined(__x86_64__)
>  +       /* The system_tsc_freq event should only appear on x86. */
>  +       if (strcasecmp(name, "system_tsc_freq") == 0)
>  +               return true;
>  +#endif
> 
> After this commit, the testcase breaks for expr__parse of
> system_tsc_freq in powerpc case. Fix the testcase to have
> complete system_tsc_freq test within "is_intel" check.

Ian, are you ok with this?

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/expr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index e3aa9d4fcf3a..eb3bd68fc4ce 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -244,11 +244,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	if (num_dies) // Some platforms do not have CPU die support, for example s390
>  		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
>  
> -	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
> -	if (is_intel)
> +	if (is_intel) {
> +		TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
>  		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> -	else
> -		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
> +	}
>  
>  	/*
>  	 * Source count returns the number of events aggregating in a leader
> -- 
> 2.43.5
> 
