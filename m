Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03091C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAFC60FD8
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhHBPR3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbhHBPR2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 11:17:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743FC061760
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Aug 2021 08:17:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so415947pji.5
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Aug 2021 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xb8HOmuPTAxJ7T5xR6e4z7KGNGhgi+GnOoQmDeQ4d8E=;
        b=na3fYEqx7lUMrXT+mnoG9cExJCmY7bgYn1X9PTL4Z+t+jgYKxyFGxtez2PzJryo/Ju
         /d7t/KfU4tJUV0+GAyyMOtV+eLLzIbd4QQD47k//k614s6b1Kt3EYhNBACa7DtCwBCgi
         JNZzflIJlWqU/QxMO6p3psckER771ekSUWgal7glI5podLFNQCWt851uwpcsVgpQLQkn
         n6BhgaNPGOnPMj++ntzDueAEYl2ATgLFQr5leH1Y1GLcaHEwgg8QQXMIO6pK4KU7KwJx
         MBJThA7+/ff7ugTwiLkwfIm3xDRUU8HnkJJkl1Bxwjq81pvKLniFNAA+X1DdpVWegRYS
         WfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xb8HOmuPTAxJ7T5xR6e4z7KGNGhgi+GnOoQmDeQ4d8E=;
        b=cEVK4DsjCirNhXW2Klh72s7eOOk7LGMxRE3o6CW5XtaPlRHME9PsXlc7lxJhqumwsd
         NhTxJepvh0j+TrvsNdo102uNHHYSu1XMr1CsWmlyeYtMDSiBCsNyJrDUH1vcCpl+nWzY
         /2uRy0sTKGt6SvfjAuMJcxI+lTM9tkf+gq8mTjiVF0/R9sJK8/uqYhnu3TFIxvhRJb4I
         lAYgrh5Ki8xG1/W3GFm1l0wiqbebpRaZSkOEqWGBkr4rzwEZm6wU+NDjfp4PndJAUl+Y
         IG2bhBT4zw8NKs9/TKRGaNk1erfbP+y8podbsUUeG0Jj874ak9si/BFHfV+Fq+QDYJdR
         /QdQ==
X-Gm-Message-State: AOAM533UT367QxgssnpofWai0tMVtsH0fVlLnhO2VBgjeSA5gwQ3J49d
        8kfTUdgpP12tE9MO1k7Ls+pz1A==
X-Google-Smtp-Source: ABdhPJw+6FnSBQB8oQaVjz+nnBTezKYAPlod64rZDb5S+XFBEYmGXWsaE98+V1M2xlQL5POiXS+9aw==
X-Received: by 2002:a17:90a:fd10:: with SMTP id cv16mr1865144pjb.134.1627917438233;
        Mon, 02 Aug 2021 08:17:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id j19sm12306155pfr.82.2021.08.02.08.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:17:17 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:17:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 5/6] perf cs-etm: Improve Coresight zero timestamp
 warning
Message-ID: <20210802151710.GB148327@leoy-ThinkPad-X240s>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155805.2830-6-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 29, 2021 at 04:58:04PM +0100, James Clark wrote:
> Only show the warning if the user hasn't already set timeless mode and
> improve the text because there was ambiguity around the meaning of '...'
> 
> Change the warning to a UI warning instead of printing straight to
> stderr because this corrupts the UI when perf report TUI is used. The UI
> warning function also handles printing to stderr when in perf script
> mode.
> 
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 3e1a05bc82cc..5084bd2ca6eb 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -324,8 +324,11 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  		 * underflow.
>  		 */
>  		packet_queue->cs_timestamp = 0;
> -		WARN_ONCE(true, "Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> -				". Decoding may be improved with --itrace=Z...\n", indx);
> +		if (!cs_etm__etmq_is_timeless(etmq))
> +			pr_warning_once("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> +					". Decoding may be improved by prepending 'Z' to your current --itrace arguments.\n",
> +					indx);
> +
>  	} else if (packet_queue->instr_count > elem->timestamp) {
>  		/*
>  		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
> -- 
> 2.28.0
> 
