Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16128EAC5;
	Thu,  5 Dec 2024 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733377627; cv=none; b=i+NAt13eD3/ULY0HMQToLzEm6CHpRSONWMr82WY365Yp00ABj+4eMRngNRB0V2cWCxkcJdua6EFC2CqHvCzetpLOu5Tqbgqcb6YQlpFu8JRKEEqdQ3No/TY+gOJDNlNy8suxwSYzj9vssrSXKXrTsVFhcwWWaNtLpGpsNUdVTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733377627; c=relaxed/simple;
	bh=Br/k2viK1u/+hung3i5Uw32rL4YHFiHzUgWg/j96zuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/BIslc+UuWpuMHBY7OtOe0NfKbCgOnsn1zRBI8Afaja+m1OMP9gEvB/se+bd7rL3+gBq2In6kKFExC7+O4Ddo7Lr1bTW67wWvJbHC7rHw/EiCZfjcX8eclA9GO64NjO/QMwT7xUcGu6J77Y+z9zeEoTx9ZauF3O4KHocknYQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEq2FCse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEq2FCse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9862C4CED6;
	Thu,  5 Dec 2024 05:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733377626;
	bh=Br/k2viK1u/+hung3i5Uw32rL4YHFiHzUgWg/j96zuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEq2FCseVKyNzS9AMXilL632NLi9ovlfX67rKXYMnCAhXOIQRknFKVdP+6muHjsJ3
	 QGfqQIoImkS+nNn8Yv5BFvqGXWPr3uGnW4CT7CfsBI25CVEH0xadeAMZSK05ha823e
	 9nR60DTyZW+uPLYV2qRXylQGP8UXR+zDVfzm8O+Npit9c12tGk8wLsqHNIOz8+T6Ki
	 /Y8hqzrmEOk2y0/NHTHI0sZFXI6RAX94yppUQ5+2si3msOIUtTl+c5QZ0aNSuW6tEv
	 GpqBEZ8CnbV3OLr6bDIQ8e98/b/UMFEVN7//goSsIj9VBukc/1HxJ308bHQz9FmRJh
	 tSzrXj2rViL7Q==
Date: Wed, 4 Dec 2024 21:47:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <Z1E-WHWSPAezVF4f@google.com>
References: <20241205022305.158202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205022305.158202-1-irogers@google.com>

Hi Ian,

On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> The refactoring of tool PMU events to have a PMU then adding the expr
> literals to the tool PMU made it so that the literal system_tsc_freq
> was only supported on x86. Update the test expectations to match -
> namely the parsing is x86 specific and only yields a non-zero value on
> Intel.
> 
> Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions and json descriptions")
> Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1-atrajeev@linux.vnet.ibm.com/
> Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

It failed on my VM.

  root@arm64-vm:~/build# ./perf test -v 7
  --- start ---
  test child forked, pid 2096
  Using CPUID 0x00000000000f0510
  division by zero
  syntax error
  Unrecognized literal '#system_tsc_freq'FAILED tests/expr.c:253 #system_tsc_freq == 0
  ---- end(-1) ----
    7: Simple expression parser                                        : FAILED!

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

Also Sasha reported that some (Intel?) guest machine doesn't have TSC
frequency.

Thanks,
Namhyung


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
> 
