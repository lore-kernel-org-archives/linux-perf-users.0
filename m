Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB31E515;
	Wed,  8 Jan 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363373; cv=none; b=bwAtq2TMrAUXNUcqICxcHN4hrTBfSHaYLIhohv/5Wj333aP5tjagkO/jtlRcnD2PsuDxb7k5LhEgXhQala8JlSKvGH2UKcgWUZ9Z68+lRISmdOXaYypei1gTKl4ZiHloaKR/CNlPJiObjWUcqQvXoMXvw3PElkFz2QByvxEUDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363373; c=relaxed/simple;
	bh=rSZBRYj039b8RQwyEHU9xxgGpy1/IO64Deu7DzE7F0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBeonjyOEM19cgNr+3pwBY66chYdIhHfHFsej+ZzvJWtptwnWdirZbaNMeNolJvWoJEYOgFwbQIJwGUQRWTJUxtaddrISfbEQE4yuQ9jQ+wJV7AOCZyyJR9hIJWDHzfAcsOR2zQYlE2WDuK2LhDWfHCZIQ72KnYT2SA3f5kdgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkC+NOdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkC+NOdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5F3C4CED3;
	Wed,  8 Jan 2025 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736363372;
	bh=rSZBRYj039b8RQwyEHU9xxgGpy1/IO64Deu7DzE7F0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkC+NOdOljWt2FW2pJzuvP7Gl2zCyasUsvWHfs//j70lBv6HTgSz+FwZM7ird1DPx
	 YxeFJsoH5j1epD4KWOiiMGAOUL5b6rsrj5Le8Sq/L5epjeUD2uTvba6aTf1gi5+0gv
	 UJhVpr2Nu00TaLgDApAqh8sXW2Mg28IGpEdDZGs11TJUYq2l/OXZHw2XtyJp5SZfip
	 EzrvFK7yyYf97PKNQuDjZvxogS3SDRJxRxk5neF6xc0JSIfvx5pD74fkF2pOXutEpZ
	 la3253kd0+iA8ssVEA6dYS4WBtizrFNQp4bz/yn/BrmP5pQlL72gxBknWyp0r3E/4M
	 kHz+tGSy3qygQ==
Date: Wed, 8 Jan 2025 11:09:30 -0800
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
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf test: Add a runs-per-test flag
Message-ID: <Z37NaqivQSrclaTd@google.com>
References: <20250107220152.1213959-1-irogers@google.com>
 <20250107220152.1213959-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107220152.1213959-4-irogers@google.com>

On Tue, Jan 07, 2025 at 02:01:52PM -0800, Ian Rogers wrote:
> To detect flakes it is useful to run tests more than once. Add a
> runs-per-test flag that will run each test multiple times.

Does it change the output?  What if it sometimes succeeds and fails?
It'd be nice if you can add an example output in the commit log.

Also please update the documentation.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 887f735da900..729740c1e5e5 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -42,6 +42,8 @@
>  static bool dont_fork;
>  /* Fork the tests in parallel and wait for their completion. */
>  static bool sequential;
> +/* Number of times each test is run. */
> +static unsigned int runs_per_test = 1;
>  const char *dso_to_test;
>  const char *test_objdump_path = "objdump";
>  
> @@ -485,7 +487,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  			len = strlen(test_description(*t, i));
>  			if (width < len)
>  				width = len;
> -			num_tests++;
> +			num_tests += runs_per_test;
>  		}
>  	}
>  	child_tests = calloc(num_tests, sizeof(*child_tests));
> @@ -549,16 +551,18 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  				continue;
>  			}
>  
> -			test_suite__for_each_test_case(*t, curr_test_case) {
> -				if (!perf_test__matches(test_description(*t, curr_test_case),
> -							curr_suite, argc, argv))
> -					continue;
> -
> -				err = start_test(*t, curr_suite, curr_test_case,
> -						 &child_tests[child_test_num++],
> -						 width, pass);
> -				if (err)
> -					goto err_out;
> +			for (unsigned int run = 0; run < runs_per_test; run++) {
> +				test_suite__for_each_test_case(*t, curr_test_case) {
> +					if (!perf_test__matches(test_description(*t, curr_test_case),
> +								curr_suite, argc, argv))
> +						continue;
> +
> +					err = start_test(*t, curr_suite, curr_test_case,
> +							 &child_tests[child_test_num++],
> +							 width, pass);
> +					if (err)
> +						goto err_out;
> +				}
>  			}
>  		}
>  		if (!sequential) {
> @@ -698,6 +702,8 @@ int cmd_test(int argc, const char **argv)
>  		    "Do not fork for testcase"),
>  	OPT_BOOLEAN('S', "sequential", &sequential,
>  		    "Run the tests one after another rather than in parallel"),
> +	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
> +		     "Run each test the given number of times, default 1"),
>  	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
>  	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
>  	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
