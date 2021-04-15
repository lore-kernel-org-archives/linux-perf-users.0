Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD8C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FFE6109D
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Apr 2021 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhDOTyo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDOTyn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Apr 2021 15:54:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521ACC061756
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 12:54:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b17so17637828pgh.7
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Apr 2021 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ij4LykCj/Hdbgw3UoGr4uR4CU6tTNOA2JBdD93B4Vhg=;
        b=mNNHqFpw6Q5WBUl3HalbanadWH0VG5i3svHssyBSgbYV4s+bf13OcziE4QxwumM/pK
         Q96+ltcCmAiZuozf5MWOOccAFQlEpYUYvbY35KS2LhkllDwBOcYFXypOy/rl6lzdqD4X
         srZsxXvVuOBgs9Tk2kkGslZ7syTXvLNc9UmIXiil6HOJxsfnxIThyjrBgQRuvqvXjdl/
         hTlwyBfA2JWEAyyXECAhurQvP5hoayZYnyh61t+yIxc+54W3KL7yJle9CogIaQM+ReQE
         Ak3tkghuot/qxiVdKZSf2zP9MLMYrzJ8fY4fMbwObJK0zRqHgcSJBZGbQ7ZKYLYw+SQ5
         khHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ij4LykCj/Hdbgw3UoGr4uR4CU6tTNOA2JBdD93B4Vhg=;
        b=O0H6JRdgNPCKlX5hXFNLArEbX7HZaE+Ind/Idwxnajm5ABIJ0rjscc+23rTd5hBfQf
         yTkiy7y83hrosjUnMjbJNUtglTLGQRSAQao4cl5RfRLeE573r9J7ABje1kmzkysQp+2F
         Inq8qsIpsVp87HE9T24Ar3NR/bZ/QgGlaS1DrHJo5ijCa8siT/DdnhA+gTgJqXZl9v7f
         1pvplTOQyCiKLb8cwkmzAGG/DM/5MD9Wa/W+jks9jWDBEOpS9e+j37zhTCUzUU0BC8Wz
         JU3vRY3t3pT+uCLh+sl0ZIsBOmbyUTu/h1oZsQWV3zOUqlv9vOdBDn/q8azAZVEhhfAT
         arHA==
X-Gm-Message-State: AOAM530Mj72sUmvxpNGQLsSYsImhQcIbm6NCBVDEcC9sdPygmtDotqHP
        tTSkGK3nZXKKUYJj282F/dY7/w==
X-Google-Smtp-Source: ABdhPJzViyaV5qxofFa2dUKQ4VsMWPme8ePOriFDTuMDh8Ji/pPihe30gP3m8Kj2emLOVPwxrZv/7A==
X-Received: by 2002:a62:4e96:0:b029:248:effc:9a4d with SMTP id c144-20020a624e960000b0290248effc9a4dmr4659860pfb.71.1618516459693;
        Thu, 15 Apr 2021 12:54:19 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d6sm2778016pfn.197.2021.04.15.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:54:18 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:54:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210415195416.GB937505@xps15>
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414143919.12605-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

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

I understand the problem.  Once again an issue caused by CS and the kernel
having a different view of time. 

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

Suzuki is correct, your name has to appear after Al's.

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

It will be fun to fix this when 8.4 comes out but for now it's the best we've
got.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		return cs_etm__process_queues(etm);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.28.0
> 
