Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25754C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADAF60F24
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 08:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhINIZl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 04:25:41 -0400
Received: from foss.arm.com ([217.140.110.172]:40964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhINIZk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 04:25:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E0A61FB;
        Tue, 14 Sep 2021 01:24:23 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617863F719;
        Tue, 14 Sep 2021 01:24:19 -0700 (PDT)
Subject: Re: [PATCH v5 3/9] coresight: tmc-etf: Add comment for store ordering
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-4-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <60c20d8e-4386-5c54-4607-d9399713d2ef@arm.com>
Date:   Tue, 14 Sep 2021 09:24:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210809111407.596077-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 09/08/2021 12:14, Leo Yan wrote:
> Since the function CS_LOCK() has contained memory barrier mb(), it
> ensures the visibility of the AUX trace data before updating the
> aux_head, thus it's needless to add any explicit barrier anymore.
> 
> Add comment to make clear for the barrier usage for ETF.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index cd0fb7bfba68..8debd4f40f06 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -553,6 +553,11 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>   	if (buf->snapshot)
>   		handle->head += to_read;
>   
> +	/*
> +	 * CS_LOCK() contains mb() so it can ensure visibility of the AUX trace
> +	 * data before the aux_head is updated via perf_aux_output_end(), which
> +	 * is expected by the perf ring buffer.
> +	 */
>   	CS_LOCK(drvdata->base);
>   out:
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> 

I will queue this.

Thanks
Suzuki
