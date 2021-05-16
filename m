Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E870EC433B4
	for <linux-perf-users@archiver.kernel.org>; Sun, 16 May 2021 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DDD61006
	for <linux-perf-users@archiver.kernel.org>; Sun, 16 May 2021 08:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhEPIxf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 16 May 2021 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPIxf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 16 May 2021 04:53:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD2C06174A
        for <linux-perf-users@vger.kernel.org>; Sun, 16 May 2021 01:52:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g18so1281308pfr.2
        for <linux-perf-users@vger.kernel.org>; Sun, 16 May 2021 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=my1Uzq63smYlq0aZ5BNjTy0z1PVgGz1T+UWNunjYlIE=;
        b=ywZY4TFxPyyEYUw8Wf3TDHpGejYR3Q1+B0teMp/m5zIX+Sugy5E/MSAgvfewp0mxyp
         bXlQeI2bVz+Qv240bm0vRAnAVIKRDbTU3MEfNiGBuUPjw/FJZUs/IsQ5f+wWiYHXK8j0
         1B/nvGP56clQHGt/kRlGikLNfL7W85RStvquI3z3HoPS5GKrI7OyibHp02FT/s5XF9GX
         /nlAXWRt2G3d/ior7+YG6C/sMtcsJKF0ZeqmTh0SI9xhZbt9pybgX/Y1y59bB7G/fgTa
         TYTa1OFzH1RKeq2Cy/kUmpMS/6r+Skp+NuROf7W6liDFDnhElODVR6qRrwgPL0k0cPPQ
         6Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=my1Uzq63smYlq0aZ5BNjTy0z1PVgGz1T+UWNunjYlIE=;
        b=ko9ibp1m8e78FaGh8KWULCZaajvwpyltM1WYy/GQPhjSONqLKW3bU7GE4rqrek7iFt
         cdn/1F4GsrB8EoeuGXrYfLAs91xsHQteJB7cOV/vNzeFmd4xPsSabZERBwu/qh+MoO6J
         N0/cH00mdlqPhaVL3GEdnKMsJ4D6jDvd3EzuCmNn1oQq/H05HlIbahLTV0rCOMgdUiRD
         MjwT4hGoZbl/4vIuyCTlhcH89/Kk5v+gbAKLadfZNfgtmXsKfwp0bvFwlaZZvqpgudf4
         D/mbNlfTa+8zVfeiFGs61WBMEvquCQpNJx5sU2VIKsxnZOrPdmzLl3Fehcwckk6QdwkJ
         xrOA==
X-Gm-Message-State: AOAM533zWpMTTl8EtA+Til1k8MSO0jKVmjphqInpbKpi+FsUeUxi50Fi
        TMcm7YhSzfcdzaWYyGrcsN1N1Q==
X-Google-Smtp-Source: ABdhPJyA+L+EygDbRxFYR7HmPlyf5t3xdo5Q7O0XJeOn23ry6h/2jqknueCzh/krFIRlQRo1HxIWGA==
X-Received: by 2002:a63:4706:: with SMTP id u6mr55272506pga.152.1621155140537;
        Sun, 16 May 2021 01:52:20 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id c71sm1007536pfc.148.2021.05.16.01.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 01:52:19 -0700 (PDT)
Date:   Sun, 16 May 2021 16:52:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf cs-etm: Prevent and warn on underflows
 during timestamp calculation.
Message-ID: <20210516085212.GA942578@leoy-ThinkPad-X240s>
References: <20210513143520.22694-1-james.clark@arm.com>
 <20210513143520.22694-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513143520.22694-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 13, 2021 at 05:35:20PM +0300, James Clark wrote:
> When a zero timestamp is encountered, warn once. This is to make
> hardware or configuration issues visible. Also suggest that the issue
> can be worked around with the --itrace=Z option.
> 
> When an underflow with a non-zero timestamp occurrs, warn every time.

s/occurrs/occurs

> This is an unexpected scenario, and with increasing timestamps, it's
> unlikely that it would occur more than once, therefore it should be
> ok to warn every time.
> 
> Only try to calculate the timestamp by subtracting the instruction
> count if neither of the above cases are true. This makes attempting
> to decode files with zero timestamps in non-timeless mode
> more consistent. Currently it can half work if the timestamp wraps
> around and becomes non-zero, although the behavior is undefined and
> unpredictable.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

All three patches look good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 45 ++++++++++++++-----
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b01d363b9301..3e1a05bc82cc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -6,6 +6,7 @@
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
>  
> +#include <asm/bug.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/err.h>
>  #include <linux/list.h>
> @@ -17,6 +18,7 @@
>  
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> +#include "debug.h"
>  #include "intlist.h"
>  
>  /* use raw logging */
> @@ -294,7 +296,8 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  				  const ocsd_generic_trace_elem *elem,
> -				  const uint8_t trace_chan_id)
> +				  const uint8_t trace_chan_id,
> +				  const ocsd_trc_index_t indx)
>  {
>  	struct cs_etm_packet_queue *packet_queue;
>  
> @@ -313,14 +316,33 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  		return OCSD_RESP_CONT;
>  	}
>  
> -	/*
> -	 * This is the first timestamp we've seen since the beginning of traces
> -	 * or a discontinuity.  Since timestamps packets are generated *after*
> -	 * range packets have been generated, we need to estimate the time at
> -	 * which instructions started by subtracting the number of instructions
> -	 * executed to the timestamp.
> -	 */
> -	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> +
> +	if (!elem->timestamp) {
> +		/*
> +		 * Zero timestamps can be seen due to misconfiguration or hardware bugs.
> +		 * Warn once, and don't try to subtract instr_count as it would result in an
> +		 * underflow.
> +		 */
> +		packet_queue->cs_timestamp = 0;
> +		WARN_ONCE(true, "Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> +				". Decoding may be improved with --itrace=Z...\n", indx);
> +	} else if (packet_queue->instr_count > elem->timestamp) {
> +		/*
> +		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
> +		 * result in an underflow. Warn and clamp at 0 if it would.
> +		 */
> +		packet_queue->cs_timestamp = 0;
> +		pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
> +	} else {
> +		/*
> +		 * This is the first timestamp we've seen since the beginning of traces
> +		 * or a discontinuity.  Since timestamps packets are generated *after*
> +		 * range packets have been generated, we need to estimate the time at
> +		 * which instructions started by subtracting the number of instructions
> +		 * executed to the timestamp.
> +		 */
> +		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> +	}
>  	packet_queue->next_cs_timestamp = elem->timestamp;
>  	packet_queue->instr_count = 0;
>  
> @@ -542,7 +564,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>  
>  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  				const void *context,
> -				const ocsd_trc_index_t indx __maybe_unused,
> +				const ocsd_trc_index_t indx,
>  				const u8 trace_chan_id __maybe_unused,
>  				const ocsd_generic_trace_elem *elem)
>  {
> @@ -579,7 +601,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>  		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
> -							 trace_chan_id);
> +							 trace_chan_id,
> +							 indx);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
>  		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> -- 
> 2.28.0
> 
