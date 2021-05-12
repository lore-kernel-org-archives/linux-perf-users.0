Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0096AC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2573613E9
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 14:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELOlI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 May 2021 10:41:08 -0400
Received: from foss.arm.com ([217.140.110.172]:40616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhELOlH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 May 2021 10:41:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700561FB;
        Wed, 12 May 2021 07:39:59 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584EF3F718;
        Wed, 12 May 2021 07:39:57 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
Date:   Wed, 12 May 2021 17:39:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429150100.282180-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 29/04/2021 18:00, Leo Yan wrote:
> The dummy event is mainly used for mmap, the TIME sample is only needed
> for per-cpu case so that the perf tool can rely on the correct timing
> for parsing symbols.  And the CPU sample is useless for mmap.
> 
> This patch enables TIME sample for per-cpu mmap and doesn't enable CPU
> sample.  For later extension (e.g. support multiple AUX events), it sets
> the dummy event when the condition "opts->full_auxtrace" is true.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 30 ++++++++++++++++------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 902e73a64184..f6eec0900604 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -70,7 +70,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	struct evsel *evsel, *arm_spe_evsel = NULL;
>  	struct perf_cpu_map *cpus = evlist->core.cpus;
>  	bool privileged = perf_event_paranoid_check(-1);
> -	struct evsel *tracking_evsel;
>  	int err;
>  
>  	sper->evlist = evlist;
> @@ -126,18 +125,23 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  		evsel__set_sample_bit(arm_spe_evsel, CPU);
>  
>  	/* Add dummy event to keep tracking */
> -	err = parse_events(evlist, "dummy:u", NULL);
> -	if (err)
> -		return err;
> -
> -	tracking_evsel = evlist__last(evlist);
> -	evlist__set_tracking_event(evlist, tracking_evsel);
> -
> -	tracking_evsel->core.attr.freq = 0;
> -	tracking_evsel->core.attr.sample_period = 1;
> -	evsel__set_sample_bit(tracking_evsel, TIME);
> -	evsel__set_sample_bit(tracking_evsel, CPU);
> -	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
> +	if (opts->full_auxtrace) {
> +		struct evsel *tracking_evsel;

Hi Leo,

I know the "if (opts->full_auxtrace)" pattern is copied from other auxtrace
files, but I don't think it does anything because there is this at the top
of the function:

   	if (!opts->full_auxtrace)
		return 0;

The same applies for other usages of "full_auxtrace" in the same function.
They are all always true. I'm also not sure if it's ever defined what
full_auxtrace means.

James

> +
> +		err = parse_events(evlist, "dummy:u", NULL);
> +		if (err)
> +			return err;
> +
> +		tracking_evsel = evlist__last(evlist);
> +		evlist__set_tracking_event(evlist, tracking_evsel);
> +
> +		tracking_evsel->core.attr.freq = 0;
> +		tracking_evsel->core.attr.sample_period = 1;
> +
> +		/* In per-cpu case, always need the time of mmap events etc */
> +		if (!perf_cpu_map__empty(cpus))
> +			evsel__set_sample_bit(tracking_evsel, TIME);
> +	}
>  
>  	return 0;
>  }
> 
