Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AE79F7
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17396191;
	Fri,  3 Nov 2023 03:00:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54DE02F4;
	Fri,  3 Nov 2023 03:00:43 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2FF3F64C;
	Fri,  3 Nov 2023 02:59:59 -0700 (PDT)
Message-ID: <663f6b75-4346-4007-32dc-50eca444a4ef@arm.com>
Date: Fri, 3 Nov 2023 09:59:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf test: Simplify object code reading test
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Thomas Richter <tmricht@linux.ibm.com>
References: <20231102234013.4188687-1-namhyung@kernel.org>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231102234013.4188687-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/11/2023 23:40, Namhyung Kim wrote:
> It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
> open.  But other arch on a VM can fail with the hardware event and need
> to fallback to the software event in the same way.
> 
> So let's get rid of the cpuid check and use generic fallback mechanism
> using an array of event candidates.  Now event in the odd index excludes
> the kernel so use that for the return value.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/tests/code-reading.c | 76 ++++++++++-----------------------
>   1 file changed, 23 insertions(+), 53 deletions(-)
> 

Tested-by: James Clark <james.clark@arm.com>

> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 3af81012014e..047ba297c6fa 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -511,38 +511,6 @@ static void fs_something(void)
>   	}
>   }
>   
> -#ifdef __s390x__
> -#include "header.h" // for get_cpuid()
> -#endif
> -
> -static const char *do_determine_event(bool excl_kernel)
> -{
> -	const char *event = excl_kernel ? "cycles:u" : "cycles";
> -
> -#ifdef __s390x__
> -	char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
> -	unsigned int family;
> -	int ret, cpum_cf_a;
> -
> -	if (get_cpuid(cpuid, sizeof(cpuid)))
> -		goto out_clocks;
> -	ret = sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, model_c,
> -		     model, cpum_cf_v, &cpum_cf_a);
> -	if (ret != 5)		 /* Not available */
> -		goto out_clocks;
> -	if (excl_kernel && (cpum_cf_a & 4))
> -		return event;
> -	if (!excl_kernel && (cpum_cf_a & 2))
> -		return event;
> -
> -	/* Fall through: missing authorization */
> -out_clocks:
> -	event = excl_kernel ? "cpu-clock:u" : "cpu-clock";
> -
> -#endif
> -	return event;
> -}
> -
>   static void do_something(void)
>   {
>   	fs_something();
> @@ -583,8 +551,10 @@ static int do_test_code_reading(bool try_kcore)
>   	int err = -1, ret;
>   	pid_t pid;
>   	struct map *map;
> -	bool have_vmlinux, have_kcore, excl_kernel = false;
> +	bool have_vmlinux, have_kcore;
>   	struct dso *dso;
> +	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
> +	int evidx = 0;
>   
>   	pid = getpid();
>   
> @@ -618,7 +588,7 @@ static int do_test_code_reading(bool try_kcore)
>   
>   	/* No point getting kernel events if there is no kernel object */
>   	if (!have_vmlinux && !have_kcore)
> -		excl_kernel = true;
> +		evidx++;
>   
>   	threads = thread_map__new_by_tid(pid);
>   	if (!threads) {
> @@ -646,7 +616,7 @@ static int do_test_code_reading(bool try_kcore)
>   		goto out_put;
>   	}
>   
> -	while (1) {
> +	while (events[evidx]) {
>   		const char *str;
>   
>   		evlist = evlist__new();
> @@ -657,7 +627,7 @@ static int do_test_code_reading(bool try_kcore)
>   
>   		perf_evlist__set_maps(&evlist->core, cpus, threads);
>   
> -		str = do_determine_event(excl_kernel);
> +		str = events[evidx];
>   		pr_debug("Parsing event '%s'\n", str);
>   		ret = parse_event(evlist, str);
>   		if (ret < 0) {
> @@ -675,32 +645,32 @@ static int do_test_code_reading(bool try_kcore)
>   
>   		ret = evlist__open(evlist);
>   		if (ret < 0) {
> -			if (!excl_kernel) {
> -				excl_kernel = true;
> -				/*
> -				 * Both cpus and threads are now owned by evlist
> -				 * and will be freed by following perf_evlist__set_maps
> -				 * call. Getting reference to keep them alive.
> -				 */
> -				perf_cpu_map__get(cpus);
> -				perf_thread_map__get(threads);
> -				perf_evlist__set_maps(&evlist->core, NULL, NULL);
> -				evlist__delete(evlist);
> -				evlist = NULL;
> -				continue;
> -			}
> +			evidx++;
>   
> -			if (verbose > 0) {
> +			if (events[evidx] == NULL && verbose > 0) {
>   				char errbuf[512];
>   				evlist__strerror_open(evlist, errno, errbuf, sizeof(errbuf));
>   				pr_debug("perf_evlist__open() failed!\n%s\n", errbuf);
>   			}
>   
> -			goto out_put;
> +			/*
> +			 * Both cpus and threads are now owned by evlist
> +			 * and will be freed by following perf_evlist__set_maps
> +			 * call. Getting reference to keep them alive.
> +			 */
> +			perf_cpu_map__get(cpus);
> +			perf_thread_map__get(threads);
> +			perf_evlist__set_maps(&evlist->core, NULL, NULL);
> +			evlist__delete(evlist);
> +			evlist = NULL;
> +			continue;
>   		}
>   		break;
>   	}
>   
> +	if (events[evidx] == NULL)
> +		goto out_put;
> +
>   	ret = evlist__mmap(evlist, UINT_MAX);
>   	if (ret < 0) {
>   		pr_debug("evlist__mmap failed\n");
> @@ -721,7 +691,7 @@ static int do_test_code_reading(bool try_kcore)
>   		err = TEST_CODE_READING_NO_KERNEL_OBJ;
>   	else if (!have_vmlinux && !try_kcore)
>   		err = TEST_CODE_READING_NO_VMLINUX;
> -	else if (excl_kernel)
> +	else if (evidx % 2)
>   		err = TEST_CODE_READING_NO_ACCESS;
>   	else
>   		err = TEST_CODE_READING_OK;
