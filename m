Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E6C433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8146044F
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDOMay (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOMay (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Apr 2021 08:30:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E6C061756
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 05:30:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so14314491pjb.4
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5XyW6c0nj1LTK1cGyNlupGJV32J66cs3TPcbFBh3pgM=;
        b=qEvSZSXY5kP38+23FroIqLisVVrnScuxWSOmSyq7j7sTGDDOhlp/jBadqv5DChvcfT
         XiW4w0Dzt3Hmsh1BPaRfSYo0jzG3z5Y4aOJtETxd0qr8jJoHNBpJWemRBmGjyW33SOj+
         xBEDhmSrF2YsxIF6hnQqOgvBUJgOhQ0SppiJRqe+jTOoaqTb3wsvAhJ8d0BML5tZY1o0
         wiP7M1nZ5pcTSjpenJGb7cSzHbbXQc7s3QGPeucunqNWfsBdO+9eQTFnkB81kXAD6e48
         j6bf0q663NSB9tPF+hbefkFx1ogx74lVaJ9kITaxfq4mJODoTpLuDorsJBbUubE5xRkD
         jG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XyW6c0nj1LTK1cGyNlupGJV32J66cs3TPcbFBh3pgM=;
        b=h78P74M9cnYCWlxHYRyMkjbqILEcpnicyOkECD1KWF+3eoLsul7i+Et6pYyAL8AJsz
         3WkjLl2t7nwWU0EAWTQsF9QOTImdKH28z1O0s/z83XohCWfMRm+1s35iCdyfiHzUbzan
         mJjysJPwKw4k9cHDIhK1XQ6389a4M5JfV1skUg2FGj5IXly2LCudp7Bzx1xVJxiDkOH0
         hjASpBBVNIDL94VivjwND8arS3K2wD/Plk93K6S2S5lJeWz0pIbnjkqmJwPEKONqG+HZ
         6AqpFOKibMay9ePYCTZLf/oSRklbwGiDnUT1uRtuWcNNuZYfHqzVsFC6mxeq9Hn5yPhP
         bhWA==
X-Gm-Message-State: AOAM530grbkTmcd322y4vvTrMklRyswVP4+qJnwXXss8nFikCHdWO/HB
        yOJN4OfvV4mfo/p8Go7Cg4f8pA==
X-Google-Smtp-Source: ABdhPJwTihxl8OfzQjZbqtclr0zxCRFFYbodeyffLoetQtLiglgg+QCNKkQlydCohq73v5b1Jvgszg==
X-Received: by 2002:a17:90a:4e0b:: with SMTP id n11mr3707422pjh.108.1618489830531;
        Thu, 15 Apr 2021 05:30:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id s21sm2385931pjr.52.2021.04.15.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 05:30:29 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:30:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210415123023.GA1011890@leoy-ThinkPad-X240s>
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414143919.12605-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Wed, Apr 14, 2021 at 05:39:19PM +0300, James Clark wrote:
> The following attribute is set when synthesising samples in
> timed decoding mode:
> 
>     attr.sample_type |= PERF_SAMPLE_TIME;
> 
> This results in new samples that appear to have timestamps but
> because we don't assign any timestamps to the samples, when the
> resulting inject file is opened again, the synthesised samples
> will be on the wrong side of the MMAP or COMM events.
> 
> For example this results in the samples being associated with
> the perf binary, rather than the target of the record:
> 
>     perf record -e cs_etm/@tmc_etr0/u top
>     perf inject -i perf.data -o perf.inject --itrace=i100il
>     perf report -i perf.inject
> 
> Where 'Command' == perf should show as 'top':
> 
>     # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
>     # ........  .......  ....................  ......................  ......................  ..................
>     #
>         31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -
> 
> If the perf.data file is opened directly with perf, without the
> inject step, then this already works correctly because the
> events are synthesised after the COMM and MMAP events and
> no second sorting happens. Re-sorting only happens when opening
> the perf.inject file for the second time so timestamps are
> needed.
> 
> Using the timestamp from the AUX record mirrors the current
> behaviour when opening directly with perf, because the events
> are generated on the call to cs_etm__process_queues().
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Co-developed-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Al Grant <al.grant@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index c25da2ffa8f3..d0fa9dce47f1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
>  	u8 sample_instructions;
>  
>  	int num_cpu;
> +	u64 latest_kernel_timestamp;
>  	u32 auxtrace_type;
>  	u64 branches_sample_type;
>  	u64 branches_id;
> @@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
> +	if (!etm->timeless_decoding)
> +		sample.time = etm->latest_kernel_timestamp;
>  	sample.ip = addr;
>  	sample.pid = tidq->pid;
>  	sample.tid = tidq->tid;
> @@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
> +	if (!etm->timeless_decoding)
> +		sample.time = etm->latest_kernel_timestamp;
>  	sample.ip = ip;
>  	sample.pid = tidq->pid;
>  	sample.tid = tidq->tid;
> @@ -2412,9 +2417,10 @@ static int cs_etm__process_event(struct perf_session *session,
>  	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>  		return cs_etm__process_switch_cpu_wide(etm, event);
>  
> -	if (!etm->timeless_decoding &&
> -	    event->header.type == PERF_RECORD_AUX)
> +	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
> +		etm->latest_kernel_timestamp = sample_kernel_timestamp;
>  		return cs_etm__process_queues(etm);
> +	}

The change looks good to me, I went through these two patches for at
least twice, and didn't find issue.

And given the trace data might be overflow and overwritten, it's
reasonable for me to use the PERF_RECORD_AUX timestamp from the tail of
trace data.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  	return 0;
>  }
> -- 
> 2.28.0
> 
