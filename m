Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120D25777;
	Mon, 11 Nov 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340324; cv=none; b=XPkY0jAYcCx70k/RJTXLsk4PVLjt8C2dcxncv3p90OEgnnDAw5L3y3QsSeLhcd3VQV7hWl89GkKbL77I5yb6wG8MOevJlKnjHzt/ObTChwZ/YVtfmlQ1SkHjPQIy0e5sR4aW2QxGbS0wXbDzK/0JJKFDPlP6GpvzfzYZv79CR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340324; c=relaxed/simple;
	bh=Bk7fNC5QBsWVG5w730kOIBqCQsP6WrGkaYmNw/aVTqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2TAcSqVXj6/e2gqYybjSqRyaY+xz8cjQdYOBExmnCida9D6FXNow1hfWMbjGhBkm2Fz+mp1+dtv0X9P6RygI1Ep4/CCK5683XOLY5n5g3QGujghQPRFbUC6IlsQLXh7lk6CCE2GZH8WdQSrHi3WVc8YQGzqWzNFOPZrbuS3+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaoC2YE6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaoC2YE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731340323; x=1762876323;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Bk7fNC5QBsWVG5w730kOIBqCQsP6WrGkaYmNw/aVTqY=;
  b=AaoC2YE6vQf7eR5ufcMAlkun7WGW2ZHOffNKZl353J2nnHLT68d3/sw6
   BOg0g+xweCdBjQ/DVjwovT6dToUmhmTRqfNtuqvCiSoeOKB9Q6FTm2Qf6
   xiRD7IC9R+LlapUJ5Xcipu8yhbl6wxmegYjn1U4wJPLdBmYN7hh2ZSOSz
   YMzjFptPpE6/YyW27FNlItrb4XZ5tucOubB+HQz2RUBiySNxMv+jxPFb/
   oGyfqUJwmxTQh1GHQ43phRNkE4xcEaj4B5Q4GuDd67z5oDGY1K9ZyeQ45
   SeXy4Q1tTlQApM0ozuZZbcPI9goFmZTj4ixJXxPCmdjgrTPqhUv4F9ESl
   g==;
X-CSE-ConnectionGUID: zXivCupiRHC84rbnL6SIHg==
X-CSE-MsgGUID: o5TdqNFwQo2t3XCFpX/TIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30542918"
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="30542918"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 07:52:02 -0800
X-CSE-ConnectionGUID: KWye0nSgRMehPDqZg57X6g==
X-CSE-MsgGUID: 1hAASl0IRrC/k//f9k+zag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="90970264"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 07:52:02 -0800
Received: from [10.212.84.100] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 816F120B5703;
	Mon, 11 Nov 2024 07:52:00 -0800 (PST)
Message-ID: <bfba7266-1903-41ca-9961-aa449f982912@linux.intel.com>
Date: Mon, 11 Nov 2024 10:51:59 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Add a runs-per-test flag
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241109160219.49976-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241109160219.49976-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-09 11:02 a.m., Ian Rogers wrote:
> To detect flakes it is useful to run tests more than once. Add a
> runs-per-test flag that will run each test multiple times.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d2cabaa8ad92..574fbd5caff0 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -42,6 +42,8 @@
>  static bool dont_fork;
>  /* Fork the tests in parallel and wait for their completion. */
>  static bool sequential;
> +/* Numer of times each test is run. */
> +static unsigned int runs_per_test = 1;
>  const char *dso_to_test;
>  const char *test_objdump_path = "objdump";
>  
> @@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  				len = strlen(test_description(*t, subi));
>  				if (width < len)
>  					width = len;
> -				num_tests++;
> +				num_tests += runs_per_test;
>  			}
>  		} else {
> -			num_tests++;
> +			num_tests += runs_per_test;
>  		}
>  	}

Seems we just need to calculate the num_tests once at the end for each
loop. Something as below may works. (not tested)

@@ -482,20 +490,19 @@ static int __cmd_test(struct test_suite **suites,
int argc, const char *argv[],

        for (struct test_suite **t = suites; *t; t++) {
                int len = strlen(test_description(*t, -1));
+               int subi = 0, subn = 1;

                if (width < len)
                        width = len;

                if (has_subtests(*t)) {
-                       for (int subi = 0, subn = num_subtests(*t); subi
< subn; subi++) {
+                       for (subn = num_subtests(*t); subi < subn; subi++) {
                                len = strlen(test_description(*t, subi));
                                if (width < len)
                                        width = len;
-                               num_tests++;
                        }
-               } else {
-                       num_tests++;
                }
+               num_tests += subn * runs_per_test;
        }
        child_tests = calloc(num_tests, sizeof(*child_tests));
        if (!child_tests)




>  	child_tests = calloc(num_tests, sizeof(*child_tests));
> @@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  			}
>  
>  			if (!has_subtests(*t)) {
> -				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
> -						 width, pass);
> -				if (err)
> -					goto err_out;
> +				for (unsigned int run = 0; run < runs_per_test; run++) {
> +					err = start_test(*t, curr, -1, &child_tests[child_test_num++],
> +							width, pass);
> +					if (err)
> +						goto err_out;
> +				}
>  				continue;
>  			}
> -			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
> -				if (!perf_test__matches(test_description(*t, subi),
> -							curr, argc, argv))
> -					continue;
> -
> -				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
> -						 width, pass);
> -				if (err)
> -					goto err_out;
> +			for (unsigned int run = 0; run < runs_per_test; run++) {
> +				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
> +					if (!perf_test__matches(test_description(*t, subi),
> +									curr, argc, argv))
> +						continue;
> +
> +					err = start_test(*t, curr, subi, &child_tests[child_test_num++],
> +							width, pass);
> +					if (err)
> +						goto err_out;
> +				}

Can we add a wrapper for the start_test()? Something similar to below?
It avoids adding the loop for every places using the start_test.

+static int start_test(struct test_suite *test, int i, int subi, struct
child_test **child,
+               int width, int pass)
+{
+       for (unsigned int run = 0; run < runs_per_test; run++) {
+               __start_test();
+       }
+}

Thanks,
Kan

>  			}
>  		}
>  		if (!sequential) {
> @@ -714,6 +720,8 @@ int cmd_test(int argc, const char **argv)
>  		    "Do not fork for testcase"),
>  	OPT_BOOLEAN('S', "sequential", &sequential,
>  		    "Run the tests one after another rather than in parallel"),
> +	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
> +		     "Run each test the given number of times, default 1"),
>  	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
>  	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
>  	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),

