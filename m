Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC39C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 01:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B5A6191C
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 01:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhELBVb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELBVb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 21:21:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC7C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 18:20:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c21so17024956pgg.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79mmyyvcgcm5MQgz71z5Pm9TCwtYlH2PZdifJeM9Fa8=;
        b=SAN11rMlBumG1qxEo4NmJa0HRO2H8tusyjexJOC2ygvp2TJX7//flaz//BM7aNI34O
         VBxb+1On7YL9KDpL04FabUztLx2OYSL58e9ncagxcEHjFehUpQttshysy+19Es1xfX9u
         cr50nu7Q7P0GvmYohdxflObi/rhdXS7OlX+Mx9frFOHziTHWgUA5uyd4x5I9aFAQsLLH
         a5i38drQOH6a+j6YSR9Be1O9e9Fa6DHNLNmU/QK8dICJIvD/0Kzhsft9vQK1T75fBpge
         i9nQtLAaqoD0tBoitsEbMC5BdWpC9Qb/gMY/Rje2yaCsnUP9M9gr0u6nMkWvloCy76Pn
         +AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79mmyyvcgcm5MQgz71z5Pm9TCwtYlH2PZdifJeM9Fa8=;
        b=isYJZ0JVZo8rjXiQLWwUGAhlhRk1Mn8NcIqi/vNMfidRsNwyPJuWizbMtoEYahmM39
         WbomjdOtEnf9eTmci0esWG29VfX711dzNvV36airrsgInpFphhntnSYZ0fJDttAjMKfF
         puK6YPyCCaj79ahuoCjumNvfOVUHLu9Kyqhsuo2VnqRJLegoslN0u0/2bEkpcqWhutw3
         GG4UD+7ynh/pDk+HqFX/80sLjj2anoAVdp2rVQ5oC9TqfjfrXkUPOwTj3IXVIlTLZi7K
         LKJd8tC94zlde6GOcUezOKMnW3xfqEStCiIsM2T0JxHlunw1o3yH7LwLp8L2lT2iCVgI
         DvSA==
X-Gm-Message-State: AOAM530KaXaWzWOM/tglRI+beZHvvsOJj593B0HyMrLdNyFg91eYTeGt
        ou7DkcWyOBzolGXAqYyNMYjW4A==
X-Google-Smtp-Source: ABdhPJyQiUJ/cl1vIeqZ0Zg48J4pJ5SxGJqZRQGpQ8ghq2el+0yZtCPrNyM8IfpDjJIXUSh5wDeKiQ==
X-Received: by 2002:a62:1a4b:0:b029:24e:ba53:aaa4 with SMTP id a72-20020a621a4b0000b029024eba53aaa4mr33902608pfa.63.1620782423521;
        Tue, 11 May 2021 18:20:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id v18sm15102644pff.90.2021.05.11.18.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:20:23 -0700 (PDT)
Date:   Wed, 12 May 2021 09:20:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <20210512012002.GB249068@leoy-ThinkPad-X240s>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
 <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 11, 2021 at 04:53:35PM +0300, James Clark wrote:

[...]

> Do you have any idea about what to do in the overflow case?

A quick thinking is to connect the kernel timestamp and correlate the
overflow case for CoreSight's timestamp, but this approach will cause
complexity.  And considering if the overflow occurs for not only once
before the new kernel timestamp is updated, it's hard to handle for
this case.  So seems to me, printing warning is a better choice.

> I think I will submit a
> new patchset that makes the new 'Z' timeless --itrace option work, because that also
> fixes this issue, without having to do the original workaround change in this RFC.

Good finding for these options for zero timestamps!

> But I'd also like to fix this overflow because it masks the issue by making non-zero
> timestamps appear even though they aren't valid ones.
> 
> I was thinking that printing a warning in the overflow case would work, but then I would
> also print a warning for the zero timestamps, and that would make just a single case,
> rather than two. Unless we just have slightly different warning text?

Printing two different warnings is okay for me, which is more clear
for users.

> Something like this? Without the zero timestamp issue, the underflow issue probably wouldn't
> be encountered. But at least there would be some visibility if it did:
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 059bcec3f651..5d8abccd34ab 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -17,6 +17,7 @@
>  
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> +#include "debug.h"
>  #include "intlist.h"
>  
>  /* use raw logging */
> @@ -294,9 +295,11 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>                                   const ocsd_generic_trace_elem *elem,
> -                                 const uint8_t trace_chan_id)
> +                                 const uint8_t trace_chan_id,
> +                                 const ocsd_trc_index_t indx)

Do we really need the new argument "indx"?  If print "trace_chan_id",
can it give the info that the timestamp is attached to which tracer?

>  {
>         struct cs_etm_packet_queue *packet_queue;
> +       static bool warned_timestamp_zero = false;
>  
>         /* First get the packet queue for this traceID */
>         packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
> @@ -320,7 +323,20 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>          * which instructions started by subtracting the number of instructions
>          * executed to the timestamp.
>          */
> -       packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
> +       if (!elem->timestamp) {
> +               packet_queue->timestamp = 0;
> +               if (!warned_timestamp_zero) {
> +                       pr_err("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> +                               ". Decoding may be improved with --itrace=Z...\n", indx);
> +                       warned_timestamp_zero = true;
> +               }

I think this warning and the next warning for overflow, both can use
the macro WARN_ONCE(), so you can avoid to add new variable
"warned_timestamp_zero".

Thanks,
Leo

> +       }
> +       else if (packet_queue->instr_count >= elem->timestamp) {
> +               packet_queue->timestamp = 0;
> +               pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
> +       }
> +       else
> +               packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
>         packet_queue->next_timestamp = elem->timestamp;
>         packet_queue->instr_count = 0;
>  
> @@ -542,7 +558,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>  
>  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>                                 const void *context,
> -                               const ocsd_trc_index_t indx __maybe_unused,
> +                               const ocsd_trc_index_t indx,
>                                 const u8 trace_chan_id __maybe_unused,
>                                 const ocsd_generic_trace_elem *elem)
>  {
> @@ -579,7 +595,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>                 break;
>         case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>                 resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
> -                                                        trace_chan_id);
> +                                                        trace_chan_id,
> +                                                         indx);
>                 break;
>         case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
>                 resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> 
> 
> James
> 
> > 
> > Thanks,
> > Leo
> > 
