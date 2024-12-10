Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101323ED63;
	Tue, 10 Dec 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858461; cv=none; b=ssBCReF5z3nY6UTCToJ7OX5l/7wPRrUwwd0qtXSlpgwX0gzkL6RFBOs6ZqEwkV5skRgsOPDywSTNh/87rZSB5QJdU0dD02pUS/eEu/kzJPID4yo5Gkp4IUxFvbeAaDSYKXcomoVrmCA3tAn6WsIpl5M5HBHWMeh/q+uszdPGhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858461; c=relaxed/simple;
	bh=ceTCYU0kBIVgKxl1o4KF3bKYCGW8KWEqpbWay4XK5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2WxGldF6oalfVlYSR9B/z6qwn7XOgOZfhKqosGwqMVAT5vncQJ08vtkrchA2a6+2CzGruwuSH3zm4bQxfXEgC9GvFN4nro4V35k/Djd7MFN/TigItO/KqjD/FijPKvFH/RDKVNa7sef90MaauDJRRts9OxEKBRPi8T5Ly9TluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5LbnbRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5LbnbRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9BAC4CED6;
	Tue, 10 Dec 2024 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858460;
	bh=ceTCYU0kBIVgKxl1o4KF3bKYCGW8KWEqpbWay4XK5P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5LbnbRfaM9/8HSf00ueRdr6DpSL8qtb3PYCZOXM6uxSYHL8VqeAaihNUNbOO9WcX
	 HGqe0/3oCog/anrDPUdqic7WW+5Te/4+1STSvrz2BZRbaJhG+SO3I+aYdS+Ubp0ovh
	 qcfoY9QiY7OzGLJPDyGohszKVdr66rLMXRwZzNDC7jqWjptyL2Gn3RUSrWEI6MWA2/
	 idz0xNaabatpRf7zfj81IEpvSm7yXcJiLFMOTiektrmyR/beylDcGLM8or+n/fkmaj
	 yaqC0ICDwXZn0H+9Or6Q7EyenaVCjcbM5Kp2OiqX9tdUboYOFrYCsQP11EwoAR0MAK
	 PAZxZnBf30UsA==
Date: Tue, 10 Dec 2024 16:20:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
Message-ID: <Z1iUmVRzN0V3vMpG@x1>
References: <20241205022305.158202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205022305.158202-1-irogers@google.com>

On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> The refactoring of tool PMU events to have a PMU then adding the expr
> literals to the tool PMU made it so that the literal system_tsc_freq
> was only supported on x86. Update the test expectations to match -
> namely the parsing is x86 specific and only yields a non-zero value on
> Intel.

Namhyung,

	Since you see no more problems and Athira tested it, I think
this should go via perf-tools, right?

- Arnaldo
 
> Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions and json descriptions")
> Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1-atrajeev@linux.vnet.ibm.com/
> Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 41ff1affdfcd..726cf8d4da28 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -75,14 +75,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
>  	int ret;
>  	struct expr_parse_ctx *ctx;
> -	bool is_intel = false;
>  	char strcmp_cpuid_buf[256];
>  	struct perf_cpu cpu = {-1};
>  	char *cpuid = get_cpuid_allow_env_override(cpu);
>  	char *escaped_cpuid1, *escaped_cpuid2;
>  
>  	TEST_ASSERT_VAL("get_cpuid", cpuid);
> -	is_intel = strstr(cpuid, "Intel") != NULL;
>  
>  	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
>  
> @@ -245,12 +243,19 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	if (num_dies) // Some platforms do not have CPU die support, for example s390
>  		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
>  
> -	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
> -	if (is_intel)
> -		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> -	else
> -		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
>  
> +	if (expr__parse(&val, ctx, "#system_tsc_freq") == 0) {
> +		bool is_intel = strstr(cpuid, "Intel") != NULL;
> +
> +		if (is_intel)
> +			TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> +		else
> +			TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
> +	} else {
> +#if defined(__i386__) || defined(__x86_64__)
> +		TEST_ASSERT_VAL("#system_tsc_freq unsupported", 0);
> +#endif
> +	}
>  	/*
>  	 * Source count returns the number of events aggregating in a leader
>  	 * event including the leader. Check parsing yields an id.
> -- 
> 2.47.0.338.g60cca15819-goog
