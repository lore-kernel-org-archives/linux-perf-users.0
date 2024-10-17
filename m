Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02825779;
	Thu, 17 Oct 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196129; cv=none; b=G2uc+Qso+2ojETsQ03ofcz63CB5LCXCfXJKS2LscXNPUksdc6is6+hcUaxmcKtDKsePOJ64NT6z/wPh8F3Mx0usfCpaVLXkJbLovpw6SvaSMka+FlySN5maETIDQsQ++2lXNl2VE5pf6fas+6da2mRbgAg49tApJGAqZWSX4pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196129; c=relaxed/simple;
	bh=imfqAzKY4Gp9I1oyFEDFJkWnfvErNKrkiPzfYoWfrjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNMQZW5YbIJnIBE0r0SgVL56OY9/Mx8kwYAYvp53q1ByEBJUZWAthncu/3ur7jym/RYgI0VBxhmJ706CbTJ0ugL/NN1JzxY+gI+RaXxrEY5D1s8INIFksp3IyhGRE65sVqxIMYKBfKlauOGwwHrH+kqswkIBUqnyIfdEfK9EKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckKEl2cF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckKEl2cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D261CC4CEC3;
	Thu, 17 Oct 2024 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729196127;
	bh=imfqAzKY4Gp9I1oyFEDFJkWnfvErNKrkiPzfYoWfrjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckKEl2cF8/ORlnqPBL1p5ZULT8EGyiwCFQ3yQg8yztUq9uZ2CFSXVHm14z0Ny/9UW
	 qdt9/cm4XbnNpdqMxWgJykUudNsb/OFmYWJ+DNwFeoJZv8zONC9WjoHA3omp3nxNQM
	 ZgCMRKmOunqXEO5+z9t3Efge8jNKJPwC5gONlIEE4BhTve2nbFyPGBBoSKhOyd0blv
	 WMFOygMiPXwr2UjbvZQnT0uKCIYY+xhuQUPUSA0DAnOuuUkhZWIlLsF7fgx1qwNCA3
	 b2auTtHa6y7ADXWfc4aKBbtj4O9YyV5EOmM1UdeIhw5JIDWqcbLVVCNteNBwGl00aJ
	 j6tEULnA8d9+A==
Date: Thu, 17 Oct 2024 13:15:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 2/3] perf test: Introduce '-w --list' to list the
 available workloads
Message-ID: <ZxFwXdz3jotLRnSj@google.com>
References: <20241011171449.1362979-1-acme@kernel.org>
 <20241011171449.1362979-3-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011171449.1362979-3-acme@kernel.org>

Hi Arnaldo,

The commit subject line should be changed to --list-workloads too.

Thanks,
Namhyung


On Fri, Oct 11, 2024 at 02:14:48PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Using it:
> 
>   $ perf test -w noplop
>   No workload found: noplop
>   $
>   $ perf test -w
>    Error: switch `w' requires a value
>    Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]
> 
>       -w, --workload <work>
>                             workload to run for testing, use '--list-workloads' to list the available ones.
>   $
>   $ perf test --list-workloads
>   noploop
>   thloop
>   leafloop
>   sqrtloop
>   brstack
>   datasym
>   landlock
>   $
> 
> Would be good at some point to have a description in 'struct test_workload'.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 2201f7ed432ce9f2..cc43b9f366d09436 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -505,6 +505,17 @@ static int perf_test__list(int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int workloads__fprintf_list(FILE *fp)
> +{
> +	struct test_workload *twl;
> +	int printed = 0;
> +
> +	workloads__for_each(twl)
> +		printed += fprintf(fp, "%s\n", twl->name);
> +
> +	return printed;
> +}
> +
>  static int run_workload(const char *work, int argc, const char **argv)
>  {
>  	struct test_workload *twl;
> @@ -535,6 +546,7 @@ int cmd_test(int argc, const char **argv)
>  	};
>  	const char *skip = NULL;
>  	const char *workload = NULL;
> +	bool list_workloads = false;
>  	const struct option test_options[] = {
>  	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
>  	OPT_INCR('v', "verbose", &verbose,
> @@ -544,7 +556,8 @@ int cmd_test(int argc, const char **argv)
>  	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
>  	OPT_BOOLEAN('S', "sequential", &sequential,
>  		    "Run the tests one after another rather than in parallel"),
> -	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
> +	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
> +	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
>  	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>  	OPT_STRING(0, "objdump", &test_objdump_path, "path",
>  		   "objdump binary to use for disassembly and annotations"),
> @@ -570,6 +583,11 @@ int cmd_test(int argc, const char **argv)
>  	if (workload)
>  		return run_workload(workload, argc, argv);
>  
> +	if (list_workloads) {
> +		workloads__fprintf_list(stdout);
> +		return 0;
> +	}
> +
>  	if (dont_fork)
>  		sequential = true;
>  	else if (parallel)
> -- 
> 2.47.0
> 
