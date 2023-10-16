Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954511548F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 362AEE6;
	Mon, 16 Oct 2023 02:15:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53FAF1FB;
	Mon, 16 Oct 2023 02:15:52 -0700 (PDT)
Received: from [10.57.1.186] (unknown [10.57.1.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC2B3F762;
	Mon, 16 Oct 2023 02:15:08 -0700 (PDT)
Message-ID: <767745f1-4d79-17f1-6c5f-a4b352b8a40f@arm.com>
Date: Mon, 16 Oct 2023 10:15:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 RESEND 1/2] perf cs-etm: Validate timestamp tracing in
 per-thread mode
To: Leo Yan <leo.yan@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231014074159.1667880-1-leo.yan@linaro.org>
 <20231014074159.1667880-2-leo.yan@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231014074159.1667880-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/10/2023 08:41, Leo Yan wrote:
> So far, it's impossible to validate timestamp trace in Arm CoreSight when
> the perf is in the per-thread mode.  E.g. for the command:
> 
>    perf record -e cs_etm/timestamp/ --per-thread -- ls
> 
> The command enables config 'timestamp' for 'cs_etm' event in the
> per-thread mode.  In this case, the function cs_etm_validate_config()
> directly bails out and skips validation.
> 
> Given profiled process can be scheduled on any CPUs in the per-thread
> mode, this patch validates timestamp tracing for all CPUs when detect
> the CPU map is empty.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>

> ---
>   tools/perf/arch/arm/util/cs-etm.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b8d6a953fd74..cf9ef9ba800b 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -205,8 +205,17 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
>   	for (i = 0; i < cpu__max_cpu().cpu; i++) {
>   		struct perf_cpu cpu = { .cpu = i, };
>   
> -		if (!perf_cpu_map__has(event_cpus, cpu) ||
> -		    !perf_cpu_map__has(online_cpus, cpu))
> +		/*
> +		 * In per-cpu case, do the validation for CPUs to work with.
> +		 * In per-thread case, the CPU map is empty.  Since the traced
> +		 * program can run on any CPUs in this case, thus don't skip
> +		 * validation.
> +		 */
> +		if (!perf_cpu_map__empty(event_cpus) &&
> +		    !perf_cpu_map__has(event_cpus, cpu))
> +			continue;
> +
> +		if (!perf_cpu_map__has(online_cpus, cpu))
>   			continue;
>   

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

