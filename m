Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48F1A0BFA
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203006; cv=none; b=SL3tvDCQvSqKXXrEOLYJi6+p+F37buB4tm/jBSv6jkXzr83x/hDWPZuFUHoTxlMo89CycWyq3+icrCijidgSOCbiIzEUIbsq2NL/pkrKrXV/XN0kVJaBAjNr845ICDHaoGNLDSxA6SPtGGrehBtNva1xy3PDZe/zAeWzpsUUdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203006; c=relaxed/simple;
	bh=ZobPmOUZU8ExKgCDse1yAOzwgR+hdb1Uqj8OkEFsQY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td33O5xAbycw6jdIMOJEPLUIdQfvSVI5G4ey5lPRAzvulSOdJE0RkMhs4VDRJCS5rnuiaTsrd6ybZlfTD+wTPjQSa8ldl0a8P1EvnR3zgxY0Ym7vBuDkF9900H/OhDNTQNcXTcz85zgqXD42L5enjzFQiearvr+NWIFoKGrS95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5+xUXvp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5+xUXvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3A6C4CEED;
	Thu, 14 Aug 2025 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755203006;
	bh=ZobPmOUZU8ExKgCDse1yAOzwgR+hdb1Uqj8OkEFsQY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5+xUXvpOhSAUIm+VKg+3SuC5orRAUERbeAyjBxmZmamdQhYPo0XoCzDseJTxctCD
	 0aqjBxV3hvBCJLxm6znpiRwbv2r9vsrN9ka9Gg5Gq4WDnJOB/7eAIrpaVZEP6j00bY
	 BM1IsyOZOgkfZkc9tqIwFnrXv4YWWTEjcirAtJY1fNSFu25YTlrighDUvj2yVJuqBt
	 ndZz9mmJzQOqxTh1Z7HJeNsj3phreFzKE29SpwYRuIncFfBoj6lOoqfmlE5kkHHRTl
	 5swO8v85DH6fACCxu+RA6XeARTWCTby948pUSTxeRsThkJyQL1v0hYS9zFiNjikFSU
	 w6m8ITkkcLHBQ==
Date: Thu, 14 Aug 2025 13:23:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
	Tejas Manhas <tejas05@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
Message-ID: <aJ5FvBa4LPhMO0u-@google.com>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814114908.45648-1-atrajeev@linux.ibm.com>

Hello,

On Thu, Aug 14, 2025 at 05:19:08PM +0530, Athira Rajeev wrote:
> The perf record testcase fails on systems with more than 1K CPUs.
> 
> Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"
> 
>   PERF_RECORD_* events & perf_sample fields                       :
>   --- start ---
>   test child forked, pid 272482
>   sched_getaffinity: Invalid argument
>   sched__get_first_possible_cpu: Invalid argument
>   test child finished with -1
>   ---- end ----
>   PERF_RECORD_* events & perf_sample fields: FAILED!
> 
> sched__get_first_possible_cpu uses "sched_getaffinity" to get the
> cpumask and this call is returning EINVAL (Invalid argument).
> This happens because the default mask size in glibc is 1024.  To
> overcome this 1024 CPUs mask size limitation of cpu_set_t, change the
> mask size using the CPU_*_S macros ie, use CPU_ALLOC to allocate
> cpumask, CPU_ALLOC_SIZE for size. Same fix needed for mask which is
> used to setaffinity so that mask size is large enough to represent
> number of possible CPU's in the system.
> 
> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/perf-record.c | 36 ++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 0b3c37e66871..d895df037707 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -13,15 +13,19 @@
>  #include "tests.h"
>  #include "util/mmap.h"
>  #include "util/sample.h"
> +#include "util/cpumap.h"
>  
>  static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
>  {
> -	int i, cpu = -1, nrcpus = 1024;
> +	int i, cpu = -1;
> +	int nrcpus = cpu__max_cpu().cpu;
> +	size_t size = CPU_ALLOC_SIZE(nrcpus);
> +
>  realloc:
> -	CPU_ZERO(maskp);
> +	CPU_ZERO_S(size, maskp);
>  
> -	if (sched_getaffinity(pid, sizeof(*maskp), maskp) == -1) {
> -		if (errno == EINVAL && nrcpus < (1024 << 8)) {
> +	if (sched_getaffinity(pid, size, maskp) == -1) {
> +		if (errno == EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
>  			nrcpus = nrcpus << 2;
>  			goto realloc;
>  		}
> @@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
>  	}
>  
>  	for (i = 0; i < nrcpus; i++) {
> -		if (CPU_ISSET(i, maskp)) {
> +		if (CPU_ISSET_S(i, size, maskp)) {
>  			if (cpu == -1)
>  				cpu = i;
>  			else
> -				CPU_CLR(i, maskp);
> +				CPU_CLR_S(i, size, maskp);
>  		}
>  	}
>  
> @@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  		.no_buffering = true,
>  		.mmap_pages   = 256,
>  	};
> -	cpu_set_t cpu_mask;
> -	size_t cpu_mask_size = sizeof(cpu_mask);
> +	int nrcpus = cpu__max_cpu().cpu;
> +	cpu_set_t *cpu_mask;
> +	size_t cpu_mask_size;
>  	struct evlist *evlist = evlist__new_dummy();
>  	struct evsel *evsel;
>  	struct perf_sample sample;
> @@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	int total_events = 0, nr_events[PERF_RECORD_MAX] = { 0, };
>  	char sbuf[STRERR_BUFSIZE];
>  
> +	cpu_mask = CPU_ALLOC(nrcpus);
> +	if (!cpu_mask) {
> +		pr_debug("failed to create cpumask\n");
> +		goto out;
> +	}
> +
> +	cpu_mask_size = CPU_ALLOC_SIZE(nrcpus);
> +	CPU_ZERO_S(cpu_mask_size, cpu_mask);
> +
>  	perf_sample__init(&sample, /*all=*/false);
>  	if (evlist == NULL) /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
>  		evlist = evlist__new_default();
>  
>  	if (evlist == NULL) {
>  		pr_debug("Not enough memory to create evlist\n");
> +		CPU_FREE(cpu_mask);
>  		goto out;
>  	}
>  
> @@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	evsel__set_sample_bit(evsel, TIME);
>  	evlist__config(evlist, &opts, NULL);
>  
> -	err = sched__get_first_possible_cpu(evlist->workload.pid, &cpu_mask);
> +	err = sched__get_first_possible_cpu(evlist->workload.pid, cpu_mask);
>  	if (err < 0) {
>  		pr_debug("sched__get_first_possible_cpu: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> @@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	/*
>  	 * So that we can check perf_sample.cpu on all the samples.
>  	 */
> -	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
> +	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) < 0) {
>  		pr_debug("sched_setaffinity: %s\n",
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
>  		goto out_delete_evlist;
> @@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  		++errs;
>  	}
>  out_delete_evlist:
> +	CPU_FREE(cpu_mask);
>  	evlist__delete(evlist);
>  out:
>  	perf_sample__exit(&sample);
> -- 
> 2.43.7
> 
