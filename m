Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0221BC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92ED64E42
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhCCFE0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:04:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:29157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572938AbhCBOH7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 09:07:59 -0500
IronPort-SDR: LVYXljfW42nhnXudPvMS3Nuff+1tgQCL+cpNvd/BbX1xsaQSo1leH4WVMeVz0cCtfSZ+YoZ82Z
 W+l8P8+S2sNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="184385851"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="184385851"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 06:03:55 -0800
IronPort-SDR: tqclDbE7bWfGn2SDDyTZQeIhvsJeBbIJrCJb/fvB99LHfwSKSLHxxLlA82UM1Fo26iBXbodJbX
 O3ilsnUoUM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="517844199"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2021 06:03:54 -0800
Received: from [10.252.140.135] (kliang2-MOBL.ccr.corp.intel.com [10.252.140.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CB9725808BA;
        Tue,  2 Mar 2021 06:03:53 -0800 (PST)
Subject: Re: [PATCH] perf test: Test case 27 fails on s390 and non-x86
 platforms
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210302133119.3325530-1-tmricht@linux.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
Date:   Tue, 2 Mar 2021 09:03:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302133119.3325530-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


+ Athira Rajeev

On 3/2/2021 8:31 AM, Thomas Richter wrote:
> Executing perf test 27 fails on s390:
>   [root@t35lp46 perf]# ./perf test -Fv 27
>   27: Sample parsing
>   --- start ---
>   ---- end ----
>   Sample parsing: FAILED!
>   [root@t35lp46 perf]#
> 
> The root cause is
> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
> but does not adjust non-x86 weak linkage functions.
> 
> The error is in test__sample_parsing() --> do_test()
> Function do_test() defines two structures of type struct perf_sample named
> sample and sample_out. The first sets member sample.ins_lat = 117
> 
> Structure sample_out is constructed dynamically using functions
> perf_event__synthesize_sample() and evsel__parse_sample().
> Both functions have an x86 specific function version which sets member
> ins_lat. The weak common functions do not set member ins_lat.
>

I don't think Power supports the instruction latency. As a request from 
Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 specific 
codes.
https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com/
https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@linux.intel.com/

I don't think we want to add the ins_lat back in the weak common functions.

Could you please update the perf test and don't apply the 
PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?


> Later in function samples_same() both data in variable sample and sample_out
> are compared. The comparison fails because sample.ins_lat is 117
> and samples_out.ins_lat is 0, the weak functions never set member ins_lat.
> 
> Output after:
>   [root@t35lp46 perf]# ./perf test -Fv 27
>   27: Sample parsing
>   --- start ---
>   ---- end ----
>   Sample parsing: Ok
> [root@t35lp46 perf]#
> 
> Fixes:
> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")

I think the regression should start from
commit fbefe9c2f87f ("perf tools: Support arch specific 
PERF_SAMPLE_WEIGHT_STRUCT processing")


Thanks,
Kan
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/util/evsel.c            | 8 +++++---
>   tools/perf/util/synthetic-events.c | 6 +++++-
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1bf76864c4f2..c9efed5c173d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2106,10 +2106,12 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
>   }
>   
>   void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> -					  const __u64 *array,
> -					  u64 type __maybe_unused)
> +					  const __u64 *array, u64 type)
>   {
> -	data->weight = *array;
> +	if (type & PERF_SAMPLE_WEIGHT)
> +		data->weight = *array & 0xffffffff;
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		data->ins_lat = (*array >> 32) & 0xffff;
>   }
>   
>   int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index b698046ec2db..af7ecbc57cbe 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1507,9 +1507,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>   }
>   
>   void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> -					       __u64 *array, u64 type __maybe_unused)
> +					       __u64 *array, u64 type)
>   {
>   	*array = data->weight;
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> +		*array &= 0xffffffff;
> +		*array |= ((u64)data->ins_lat << 32);
> +	}
>   }
>   
>   int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
> 
