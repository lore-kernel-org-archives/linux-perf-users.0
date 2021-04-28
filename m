Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AECDC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 14:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419FB6142A
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 14:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhD1Ooc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:44:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:33468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhD1Oob (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 10:44:31 -0400
IronPort-SDR: Mm8aRCZtX70Jc1TSjDIpvByiiEq3eB9V+iSfmlqBIBU4PdqsTfbFnXUkJV6igxWtYFaFsw97y3
 AoKtQAKoDxJg==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="184237617"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="184237617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 07:43:44 -0700
IronPort-SDR: b7uKiVxVknF+8d26WD+yE9imKNdvKyl+lzqKz5e9V0A4mTOry4fCj0gYRMecFWDjVHRBVwNyQW
 lUN9L/5MYQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="403702585"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2021 07:43:35 -0700
Subject: Re: [PATCH v3 3/4] perf session: Add swap operation for event
 TIME_CONV
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210428120915.7123-1-leo.yan@linaro.org>
 <20210428120915.7123-4-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1c9e61e7-0171-0deb-c167-f1b30995a3f9@intel.com>
Date:   Wed, 28 Apr 2021 17:43:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428120915.7123-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/04/21 3:09 pm, Leo Yan wrote:
> Since commit d110162cafc8 ("perf tsc: Support cap_user_time_short for
> event TIME_CONV"), the event PERF_RECORD_TIME_CONV has extended the data
> structure for clock parameters.
> 
> To be backwards-compatible, this patch adds a dedicated swap operation
> for the event PERF_RECORD_TIME_CONV, based on checking if the event
> contains field "time_cycles", it can support both for the old and new
> event formats.
> 
> Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/session.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index eba3769be3f1..1e3cab92042d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -949,6 +949,19 @@ static void perf_event__stat_round_swap(union perf_event *event,
>  	event->stat_round.time = bswap_64(event->stat_round.time);
>  }
>  
> +static void perf_event__time_conv_swap(union perf_event *event,
> +				       bool sample_id_all __maybe_unused)
> +{
> +	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
> +	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
> +	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
> +
> +	if (event_contains(event->time_conv, time_cycles)) {
> +		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
> +		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
> +	}
> +}
> +
>  typedef void (*perf_event__swap_op)(union perf_event *event,
>  				    bool sample_id_all);
>  
> @@ -985,7 +998,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_STAT]		  = perf_event__stat_swap,
>  	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
>  	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
> -	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
> +	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
>  	[PERF_RECORD_HEADER_MAX]	  = NULL,
>  };
>  
> 

