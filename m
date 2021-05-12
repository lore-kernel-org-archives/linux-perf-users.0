Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78BC43617
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCDC61439
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhELP61 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 May 2021 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhELPvG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 May 2021 11:51:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23BC0610F1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 08:23:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k15so5663985pgb.10
        for <linux-perf-users@vger.kernel.org>; Wed, 12 May 2021 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WmCdrS1TMn2hGqp3nbYKTeNACXqD6MvKMsrI4Gekn0=;
        b=ByPtxvKS8saS9qVWc0y5uY71My/u0HVJpMZCgL608n9bGPKRUYdqAbwEkPBzAc7uwM
         fBi0WhHoWYUwqA/au/wpGSRUtAhP1jQtA8bu8YFZg5D/OUWsbZQtYZ/uvmpSIut+WDLb
         bv1/OWBmIlGFZAFLXnxwkdLQ+uxtVnSGBvaF4x5UwgIbL7npedNrw39k+qTJxPXu0I5J
         gvS+f3WD2j3/ko6dWje+/9NNLpWRWrRnaKiCVip0yXo6f3l4dVoptqbOlzxRcZH6OK0J
         S5T8nNXXKurgnm38yzt6GCCs6gMGFkFuxsx9j5r+A06BjrCgPjRubBUU+SlJhSincUMu
         vozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WmCdrS1TMn2hGqp3nbYKTeNACXqD6MvKMsrI4Gekn0=;
        b=cGLRJ/z82ZxrNabjnsUNoUVWUDcbz0b3byOHArHluNqNPUBwCdlVkiGr3CQtZ3y0/1
         g4jHcP7J7BlDUiTx7NukX1dM/KP2oNwVCt0XWWTW27IqOL5DiigLsbgtpscUiGZvubDY
         atuh+0nzZeIxqgwTxN9RSeZ9V/D7Etv/8ralnDXA0aM+YuFs/RDD/HbEbQV/m2NO+ff0
         5+OzR5d8jSWLgfRXgCneu8XGcUcFI9j6QCWCISiBm+hnhSIBNK3pH3G3kjNIQdSJjlcc
         FsDMqmuDaRTEc9KaZZFXCoDKfEP6sCjTn5GYglW5z0Vr4ho11ikp3VjAMlm30DjR5ETs
         a82w==
X-Gm-Message-State: AOAM5335zap2B4bQe+LqUJd/xtqxADveadeh6dGKLsnARPlEB+lUG0ys
        PAW7h5s3cCfSJCy1uuR9fRIUWjZOhfqqVJpr
X-Google-Smtp-Source: ABdhPJwLY9XaqFKgJYjrtqEiHAdJ+BCmFC6M2x0Zd5NgpwhcCAVsHQlmHoBmG8QVDwp0HmaHYuKyyA==
X-Received: by 2002:a63:8f15:: with SMTP id n21mr35823079pgd.366.1620833017838;
        Wed, 12 May 2021 08:23:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1207-178.members.linode.com. [45.79.108.178])
        by smtp.gmail.com with ESMTPSA id u15sm4893693pju.44.2021.05.12.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:23:37 -0700 (PDT)
Date:   Wed, 12 May 2021 23:23:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210512152330.GA121227@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 12, 2021 at 05:39:56PM +0300, James Clark wrote:
> 
> 
> On 29/04/2021 18:00, Leo Yan wrote:
> > The dummy event is mainly used for mmap, the TIME sample is only needed
> > for per-cpu case so that the perf tool can rely on the correct timing
> > for parsing symbols.  And the CPU sample is useless for mmap.
> > 
> > This patch enables TIME sample for per-cpu mmap and doesn't enable CPU
> > sample.  For later extension (e.g. support multiple AUX events), it sets
> > the dummy event when the condition "opts->full_auxtrace" is true.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/arm64/util/arm-spe.c | 30 ++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index 902e73a64184..f6eec0900604 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -70,7 +70,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  	struct evsel *evsel, *arm_spe_evsel = NULL;
> >  	struct perf_cpu_map *cpus = evlist->core.cpus;
> >  	bool privileged = perf_event_paranoid_check(-1);
> > -	struct evsel *tracking_evsel;
> >  	int err;
> >  
> >  	sper->evlist = evlist;
> > @@ -126,18 +125,23 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  		evsel__set_sample_bit(arm_spe_evsel, CPU);
> >  
> >  	/* Add dummy event to keep tracking */
> > -	err = parse_events(evlist, "dummy:u", NULL);
> > -	if (err)
> > -		return err;
> > -
> > -	tracking_evsel = evlist__last(evlist);
> > -	evlist__set_tracking_event(evlist, tracking_evsel);
> > -
> > -	tracking_evsel->core.attr.freq = 0;
> > -	tracking_evsel->core.attr.sample_period = 1;
> > -	evsel__set_sample_bit(tracking_evsel, TIME);
> > -	evsel__set_sample_bit(tracking_evsel, CPU);
> > -	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
> > +	if (opts->full_auxtrace) {
> > +		struct evsel *tracking_evsel;
> 
> Hi Leo,
> 
> I know the "if (opts->full_auxtrace)" pattern is copied from other auxtrace
> files, but I don't think it does anything because there is this at the top
> of the function:
> 
>    	if (!opts->full_auxtrace)
> 		return 0;
> 
> The same applies for other usages of "full_auxtrace" in the same function.
> They are all always true. I'm also not sure if it's ever defined what
> full_auxtrace means.

Good pointing.  TBH, I also stuggled for handling "opts->full_auxtrace"
when wrote the patch; IIUC, "opts->full_auxtrace" is also used in
builtin-record.c to indicate if the recording contains AUX tracing.

Will follow your suggestion to respin the patch (and refine the code)
to remove the redundant condition checking for "opts->full_auxtrace".

Thanks,
Leo
