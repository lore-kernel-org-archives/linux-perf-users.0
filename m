Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69478C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 19:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiDFTow (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiDFToa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 15:44:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F519BE56
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 10:11:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 66so2699156pga.12
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Apr 2022 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XD5ItTlj29WOcCS4owus3qC0hML8VkaRp6mT60P4fAs=;
        b=kPmdnsx9LLguRvYL3Ro1Z3H/hbzqUOaaHSA6QYx4TnRIxubdNkfpl5NftPa6B3A32J
         0mO2aM/7kIc7ajialM8F0oZMG/15whqn7iEi50wmKl74Rz00zFXIfOe0G6H6w7PuUxT1
         ya1QYh2tvdEW3vXVvLy65KQgfaZwXcBOQXjWisRdiZox3pfzQ80wnCGPRPODglkZeAj+
         /yegc92v07QiiihtAf04t1N+4o/gz2LOFVvZFKrnF3xashqkZofgO0c8cxzH8lb8BVIn
         Sd/MNUh2/sRTP7K5lhLD1LibPJJl898v3LOYFGmmvvq5DgiAkne83x5VDbZs+dESUcyp
         mIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XD5ItTlj29WOcCS4owus3qC0hML8VkaRp6mT60P4fAs=;
        b=m0v88GFQntTG+A6GkUMfJG/tQgzCvRWhpegG28mNW9M0ZWYIMPvOCBeXlvA3VJCX2Q
         dlUj38fFr5N3x+ma9iSVIMNIW+lXXOQLn+jaUZ7f/BEwDj3CT+wZyaYlGF5Da/l1KdO/
         B62pu0I6S+L4rZv5IsxNYpZGdOEM1GefBNLfcq2Y0yUV6BRRFVTztGoLzOfI3CpMO3Hw
         b6rcHmS56gwJVlUSMNtrFRn9Mi3TXM8dpy+RXSvplzkluDYLcUV63OsYkd6GFUFhVl3K
         WYplSnUtddbTYTT3pmk4HGwTIyDjOKYDckwKpq6T+uullrFj3g5Uv+v7YejvcVIkKHOn
         tTpg==
X-Gm-Message-State: AOAM533+Ait0wAZ1qGLGZZr1N+DBD5op4vMKshz4Z6tkPMrYyes0CW4r
        FTu+Z9v0JV/ytSuzd/uj3hCM7g==
X-Google-Smtp-Source: ABdhPJwJhqMpUBciUS7gBInD6rkTovC4c40eFaC1Tma7/9HSbIMAi+pqB0ASIGQskCxTS3WkV0FEGw==
X-Received: by 2002:a05:6a00:2304:b0:4fa:dff2:88f5 with SMTP id h4-20020a056a00230400b004fadff288f5mr9944212pfh.11.1649265095918;
        Wed, 06 Apr 2022 10:11:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 83-20020a621556000000b004fe5d8c5cf3sm1868411pfv.156.2022.04.06.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:11:34 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:11:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 06/10] coresight: perf: traceid: Add perf notifiers for
 trace ID
Message-ID: <20220406171132.GA16110@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-7-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205000.27646-7-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 08, 2022 at 08:49:56PM +0000, Mike Leach wrote:
> Adds in notifier calls to the trace ID allocator that perf
> events are starting and stopping.
> 
> This ensures that Trace IDs associated with CPUs remain the same
> throughout the perf session, and are only release when all perf
> sessions are complete.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c039b6ae206f..008f9dac429d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -22,6 +22,7 @@
>  #include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
>  #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>  
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
> @@ -223,11 +224,21 @@ static void free_event_data(struct work_struct *work)
>  		struct list_head **ppath;
>  
>  		ppath = etm_event_cpu_path_ptr(event_data, cpu);
> -		if (!(IS_ERR_OR_NULL(*ppath)))
> +		if (!(IS_ERR_OR_NULL(*ppath))) {
>  			coresight_release_path(*ppath);
> +			/*
> +			 * perf may have read a trace id for a cpu, but never actually
> +			 * executed code on that cpu - which means the trace id would
> +			 * not release on disable. Re-release here to be sure.
> +			 */
> +			coresight_trace_id_put_cpu_id(cpu, coresight_get_trace_id_map());

A CPU gets a traceID in event_etm_start() when the event is installed for
running.  Do you see a scenario where etm_free_aux() is called without
previously calling event_etm_stop()? 

> +		}
>  		*ppath = NULL;
>  	}
>  
> +	/* mark perf event as done for trace id allocator */
> +	coresight_trace_id_perf_stop();
> +
>  	free_percpu(event_data->path);
>  	kfree(event_data);
>  }
> @@ -314,6 +325,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  		sink = user_sink = coresight_get_sink_by_id(id);
>  	}
>  
> +	/* tell the trace ID allocator that a perf event is starting up */
> +	coresight_trace_id_perf_start();
> +
>  	/* check if user wants a coresight configuration selected */
>  	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
>  	if (cfg_hash) {
> -- 
> 2.17.1
> 
