Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49A1C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 01:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF28E60F48
	for <linux-perf-users@archiver.kernel.org>; Sat, 31 Jul 2021 01:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhGaBjA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 21:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaBjA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 21:39:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32DC06175F
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 18:38:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u16so4596828ple.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jul 2021 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uuVTonTXDxyJ4QjMz6cgVCH3/BgRnNTazOR/+h+kv28=;
        b=pzaKjF0lCNmHVtmIqyMWU9hIgzpoV7qC/9cCzvbkdpE72axIv0wKrNaicxA3j7rdDP
         VwWaLPxa8UgEcHFdJA+0eiQjbvKXSefMGqVk/NWlPB35KLTM2g71W4OQELZ6YRLrpOro
         WRZjCUUxezYRwp6MGp6jpBp5YfFzNddBH6KL7Y6fShskVtn5UQucAtDUbaYuxqwRQ4io
         p1JpNrjnOAGtzq2W7fmctKg504QN2enFA/ZSaH7U+tNEfzkCQEEm9OrP5ULe1txrowPe
         r4FQPuvIDwdtKE90mDib4wIoX3OLb0QqIr2T93kXBODJK2+0Ldk9neYE+76+ORS2J/7+
         ayMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuVTonTXDxyJ4QjMz6cgVCH3/BgRnNTazOR/+h+kv28=;
        b=dcc7vrL2c9lEHaXV6Cag/eNyYFqALKRK2Ev5xizae6j8fWYRGM6c4KF1qoLWIImtsh
         EZx8zRukBZ0sBCweeQtf6UCsDg0PUHVwRhXMmDRGdXDojw7j9Bn7GjH6nhNfJWOhYJ0s
         ADQgqSD2mLv0vk5maUOTYKpPh12XHMEfsn/ubeNCxjnrSFZqU+XMGDGWkc076HfLDG8l
         +5lKORMe+5agqhUkNpbqFLbDgM6ZHqtZjWNcJN34zUrAkdaCAaJlNDN+pNHwN7/kj1Wa
         UcdiffCj0u1kLAnZM5E2HYbRXOKWLl707gRUq/5IAZGsBkLm5ikn7SLbJIHTi2OJGxyR
         iz0w==
X-Gm-Message-State: AOAM532PrPbyh5UWEb71Dbddakdb9QqKlDliNU6wpNBe0Z1S/EMyIC3N
        dmwJoGyxcBaATmMT3qixVGAqKnfd72MfX3c0
X-Google-Smtp-Source: ABdhPJzjariSTS9La8MnK9n3pnXpF0JnRXXS8TiGiqPZ2+smpdDs9yP4waNR7jj1T6/6v92dTU7DEQ==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr5866382pja.114.1627695534183;
        Fri, 30 Jul 2021 18:38:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id m7sm4118919pgl.67.2021.07.30.18.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 18:38:53 -0700 (PDT)
Date:   Sat, 31 Jul 2021 09:38:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] tools: perf: Report collisions in AUX records
Message-ID: <20210731013847.GA91194@leoy-ThinkPad-X240s>
References: <20210723124456.3828769-1-suzuki.poulose@arm.com>
 <20210728091219.527886-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728091219.527886-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 28, 2021 at 10:12:19AM +0100, Suzuki Kuruppassery Poulose wrote:
> Just like the other flags in the AUX records, report a summary
> of the Collisions if there were any.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

The change looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/events_stats.h | 1 +
>  tools/perf/util/session.c      | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
> index 3480bafd414b..1b0006092265 100644
> --- a/tools/perf/util/events_stats.h
> +++ b/tools/perf/util/events_stats.h
> @@ -30,6 +30,7 @@ struct events_stats {
>  	u64 total_lost_samples;
>  	u64 total_aux_lost;
>  	u64 total_aux_partial;
> +	u64 total_aux_collision;
>  	u64 total_invalid_chains;
>  	u32 nr_events[PERF_RECORD_HEADER_MAX];
>  	u32 nr_lost_warned;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 51f727402912..59b6c3fe0d01 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1540,6 +1540,8 @@ static int machines__deliver_event(struct machines *machines,
>  				evlist->stats.total_aux_lost += 1;
>  			if (event->aux.flags & PERF_AUX_FLAG_PARTIAL)
>  				evlist->stats.total_aux_partial += 1;
> +			if (event->aux.flags & PERF_AUX_FLAG_COLLISION)
> +				evlist->stats.total_aux_collision += 1;
>  		}
>  		return tool->aux(tool, event, sample, machine);
>  	case PERF_RECORD_ITRACE_START:
> @@ -1895,6 +1897,13 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
>  			    "");
>  	}
>  
> +	if (session->tool->aux == perf_event__process_aux &&
> +	    stats->total_aux_collision != 0) {
> +		ui__warning("AUX data detected collision  %" PRIu64 " times out of %u!\n\n",
> +			    stats->total_aux_collision,
> +			    stats->nr_events[PERF_RECORD_AUX]);
> +	}
> +
>  	if (stats->nr_unknown_events != 0) {
>  		ui__warning("Found %u unknown events!\n\n"
>  			    "Is this an older tool processing a perf.data "
> -- 
> 2.24.1
> 
