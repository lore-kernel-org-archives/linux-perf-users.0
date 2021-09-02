Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC50C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5100E61056
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 19:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347381AbhIBT0a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347345AbhIBT01 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 15:26:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA2C061757
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 12:25:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bg1so1824015plb.13
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BnVhNIbGlKGak3XUFpWItnxtP9vjaQcFKKMfs02t0ko=;
        b=NQO63Zw3lPiXaCe4+R3t5zLirkM1Q+hRzLz250CvZjgasbhHlPfVBnTfR8IrMqbtba
         YNumR4ljpgTJC1LsUDUIUE7XrkU0yRAl0RuY8IoGD+lj/mhpWayAh0CzwnPF9SOxT5wC
         0lqbw61jvC2Z2hmv5muSvQ4bk+Aw4mh2Zrq+T9Qtut+eWzNtuCuGE2ihly9IxrPhprLC
         +TLvYiyEjgtWPXAJwAtgUnz9QVAKZhn745qOkf4ZWbjs0lY2nsl9m1Z2726c6DHJprCl
         KVRUyFmYB7OHa5fyO/+nKvLXQd6Qemm8PE8DrikGiajmNSlIXYRSalErqeGjT1P/cntY
         2KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BnVhNIbGlKGak3XUFpWItnxtP9vjaQcFKKMfs02t0ko=;
        b=LAdJvkmt2quzNSsT88fg9udjSaiGcg/LX2Q5D1mp6+5m+8dSAaELBR3e/trEjHviu6
         IKbfUJ1VViDAfXaoFhxRia/IjX3bHD4WgvfYPFNQfpW5lJcvXMm/V38v1ABLhLlY5byK
         NfZVAAB3EvyS/WEypIM+68GhY3JZ1MtDDTjsHCCfALGRRsUldW53erTr3pkZ8IpIqvp5
         yKi8ON1FLHmDSFCKPFzQHTkJQtelCLbkcCy9xWanMjF45oEgEKfSFC6qLCig4LqvBmMr
         3hXmZg1N7baa054CBotcASSGpk6BYOSWJ7D3B/bq6AISWBV+bZP70kQNyPKvZJNGOc65
         ZEyw==
X-Gm-Message-State: AOAM533cnw1gCQWZK5HnjeW4qVMIKwytlMH4mI95T9eLmOndnnJkQWZj
        anQS6FR1abMQt7BoARYdysa7Xw==
X-Google-Smtp-Source: ABdhPJwnkW8PNY8V3HGOTna3CrVpQ1v3790I+xpRNH1h13oZ4nJKNCeVP71ugrCcBqT1Wu0Kg9GVyw==
X-Received: by 2002:a17:90a:284e:: with SMTP id p14mr5697668pjf.196.1630610728133;
        Thu, 02 Sep 2021 12:25:28 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j6sm2976065pfi.220.2021.09.02.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:25:22 -0700 (PDT)
Date:   Thu, 2 Sep 2021 13:25:20 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] tools: perf: Report collisions in AUX records
Message-ID: <20210902192520.GD1078000@p14s>
References: <20210723124456.3828769-1-suzuki.poulose@arm.com>
 <20210728091219.527886-1-suzuki.poulose@arm.com>
 <20210731013847.GA91194@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731013847.GA91194@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 31, 2021 at 09:38:47AM +0800, Leo Yan wrote:
> On Wed, Jul 28, 2021 at 10:12:19AM +0100, Suzuki Kuruppassery Poulose wrote:
> > Just like the other flags in the AUX records, report a summary
> > of the Collisions if there were any.
> > 
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The change looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> > ---
> >  tools/perf/util/events_stats.h | 1 +
> >  tools/perf/util/session.c      | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
> > index 3480bafd414b..1b0006092265 100644
> > --- a/tools/perf/util/events_stats.h
> > +++ b/tools/perf/util/events_stats.h
> > @@ -30,6 +30,7 @@ struct events_stats {
> >  	u64 total_lost_samples;
> >  	u64 total_aux_lost;
> >  	u64 total_aux_partial;
> > +	u64 total_aux_collision;
> >  	u64 total_invalid_chains;
> >  	u32 nr_events[PERF_RECORD_HEADER_MAX];
> >  	u32 nr_lost_warned;
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 51f727402912..59b6c3fe0d01 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1540,6 +1540,8 @@ static int machines__deliver_event(struct machines *machines,
> >  				evlist->stats.total_aux_lost += 1;
> >  			if (event->aux.flags & PERF_AUX_FLAG_PARTIAL)
> >  				evlist->stats.total_aux_partial += 1;
> > +			if (event->aux.flags & PERF_AUX_FLAG_COLLISION)
> > +				evlist->stats.total_aux_collision += 1;
> >  		}
> >  		return tool->aux(tool, event, sample, machine);
> >  	case PERF_RECORD_ITRACE_START:
> > @@ -1895,6 +1897,13 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
> >  			    "");
> >  	}
> >  
> > +	if (session->tool->aux == perf_event__process_aux &&
> > +	    stats->total_aux_collision != 0) {
> > +		ui__warning("AUX data detected collision  %" PRIu64 " times out of %u!\n\n",
> > +			    stats->total_aux_collision,
> > +			    stats->nr_events[PERF_RECORD_AUX]);
> > +	}
> > +
> >  	if (stats->nr_unknown_events != 0) {
> >  		ui__warning("Found %u unknown events!\n\n"
> >  			    "Is this an older tool processing a perf.data "
> > -- 
> > 2.24.1
> > 
