Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB72155736;
	Tue, 18 Jun 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715892; cv=none; b=jh7sObEgsokD+knFIIRhm8RT42f4qlPllFyEHbPUMzwJqxaCfxQvYFDng3qHd2f+ktgQlXLaPBmjlO7isTe4G/KYjORmOwrzeY1hoD8K2D4SmfBiMG2q23ef0s54gw/Ti4djdWTF9JUMDt4XIPj/KJH0a7zcSNwvFh/URo02ONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715892; c=relaxed/simple;
	bh=utGAo2ifRsMXL+0U5Vdjs3fahesCbSupcZDfbwU3OYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLGAqJbl2kSLvHj0YNVAdsumDDvWpGUkhIzH6JOu7PF61Wk8y4HW3WQpoC93CVKrA1bMEKO+tuXYWkHm9SuBGi4/j0FlErijqry3V6UbZEKL+U5ed/YliITbeSzoev5+bDySn4wM4NyOtVdI8RS5qJy2cWwFhWm9oUXuXVS3EHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E46DA7;
	Tue, 18 Jun 2024 06:05:11 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6257D3F64C;
	Tue, 18 Jun 2024 06:04:44 -0700 (PDT)
Message-ID: <f435e2d2-f864-4a34-bc38-cb06ce140a6f@arm.com>
Date: Tue, 18 Jun 2024 14:04:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched replay: Fix -r/--repeat command line option
 for infinity
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
 Fernand Sieber <sieberf@amazon.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240618112907.15131-1-vineethr@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240618112907.15131-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/06/2024 12:29, Madadi Vineeth Reddy wrote:
> Currently, the -r/--repeat option accepts values from 0 and complains
> for -1. The help section specifies:
> -r, --repeat <n>      repeat the workload replay N times (-1: infinite)
> 

I was wondering if this was a regression or was always like this but
it's at least been broken long before it becomes difficult to build
Perf for me.

> The -r -1 option raises an error because replay_repeat is defined as
> an unsigned int.
> 
> In the current implementation, the workload is repeated n times when
> -r <n> is used, except when n is 0.
> 
> When -r is set to 0, the workload is also repeated once. This happens
> because when -r=0, the run_one_test function is not called. (Note that
> mutex unlocking, which is essential for child threads spawned to emulate
> the workload, happens in run_one_test.) However, mutex unlocking is
> still performed in the destroy_tasks function. Thus, -r=0 results in the
> workload running once coincidentally.
> 

I also saw an intermittent hang waiting in destroy_tasks() which is now
fixed.
 
> To clarify and maintain the existing logic for -r >= 1 (which runs the
> workload the specified number of times) and to fix the issue with infinite
> runs, make -r=0 perform an infinite run.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt | 7 +++++++
>  tools/perf/builtin-sched.c              | 8 ++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index a216d2991b19..f1be8f0b249e 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
>  --state::
>  	Show task state when it switched out.
>  
> +OPTIONS for 'perf sched replay'
> +------------------------------
> +
> +-r::
> +--repeat <n>::
> +	repeat the workload n times (0: infinite). Default is 10.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1]
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8cdf18139a7e..2c4ed5c2d695 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3383,8 +3383,12 @@ static int perf_sched__replay(struct perf_sched *sched)
>  	sched->thread_funcs_exit = false;
>  	create_tasks(sched);
>  	printf("------------------------------------------------------------\n");
> -	for (i = 0; i < sched->replay_repeat; i++)
> +
> +	i = 0;
> +	while (sched->replay_repeat == 0 || i < sched->replay_repeat) {

Very minor nit, but you don't really need to remove the for loop, just add
the new condition to the existing one. Not sure if it's worth re-spinning
for though.

Reviewed-by: James Clark <james.clark@arm.com>

>  		run_one_test(sched);
> +		i++;
> +	}
>  
>  	sched->thread_funcs_exit = true;
>  	destroy_tasks(sched);
> @@ -3548,7 +3552,7 @@ int cmd_sched(int argc, const char **argv)
>  	};
>  	const struct option replay_options[] = {
>  	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
> -		     "repeat the workload replay N times (-1: infinite)"),
> +		     "repeat the workload replay N times (0: infinite)"),
>  	OPT_PARENT(sched_options)
>  	};
>  	const struct option map_options[] = {
