Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C3AC2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 12:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B646128D
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 12:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhEYMF2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 08:05:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhEYMF1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 08:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3117CD6E;
        Tue, 25 May 2021 05:03:58 -0700 (PDT)
Received: from [10.57.0.178] (unknown [10.57.0.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317913F719;
        Tue, 25 May 2021 05:03:55 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] perf arm-spe: Remove redundant checking for
 "full_auxtrace"
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
        Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519041546.1574961-1-leo.yan@linaro.org>
 <20210519041546.1574961-5-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <326bfc02-e02d-997b-2f7f-1c0565f4d5cc@arm.com>
Date:   Tue, 25 May 2021 15:03:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519041546.1574961-5-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 19/05/2021 07:15, Leo Yan wrote:
> The option "opts->full_auxtrace" is checked at the earlier place, if it
> is false the function will directly bail out.  So remove the redundant
> checking for "opts->full_auxtrace".
> 
> Suggested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index bacdf366040d..a4420d4df503 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -116,7 +116,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  		return 0;
>  
>  	/* We are in full trace mode but '-m,xyz' wasn't specified */
> -	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> +	if (!opts->auxtrace_mmap_pages) {
>  		if (privileged) {
>  			opts->auxtrace_mmap_pages = MiB(4) / page_size;
>  		} else {
> 

Reviewed-by: James Clark <james.clark@arm.com>

Thanks
James
